package com.flame.web;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.imageio.stream.FileImageInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.aliyun.oss.model.Bucket;
import com.aliyun.oss.model.OSSObject;
import com.flame.constant.Constant;
import com.flame.model.File;
import com.flame.model.Folder;
import com.flame.model.OssFile;
import com.flame.model.User;
import com.flame.service.AliyunOssService;
import com.flame.service.FileService;
import com.flame.service.FolderService;
import com.flame.service.OssFileService;

/**
 * 文件管理控制器
 */
@Controller
@RequestMapping("/file/")
public class FileConroller {

	private String ACTION_PATH = "/filemanage/";

	@Autowired
	FileService fileService;
	@Autowired
	FolderService folderService;
	@Autowired
	OssFileService ossFileService;
	@Autowired
	AliyunOssService aliyunOssService;

	/**
	 * 跳转图片管理
	 * 
	 * @param request
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "manage")
	public String fileManage() {
		return ACTION_PATH + "filemanage";
	}

	/**
	 * @return
	 */
	@RequestMapping(value = "/public/buckets")
	public @ResponseBody Map<String, Object> buckets() {
		List<Bucket> listBuckets = aliyunOssService.listBuckets();
		List<Map<String, Object>> listNew = new ArrayList<Map<String, Object>>();
		for (Bucket b : listBuckets) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("Name", b.getName());
			map.put("Addition", new HashMap<String, Object>().put("Endpoint", ""));
			listNew.add(map);
		}
		Map<String, Object> reMap = new HashMap<String, Object>();
		reMap.put("buckets", listNew);
		reMap.put("count", listNew.size());
		return reMap;
	}

	/**
	 * 文件查询
	 */
	@RequestMapping(value = "/public/folders")
	public @ResponseBody Map<String, Object> listFolders(HttpServletRequest request,
			@ModelAttribute("preloadEntity") Folder folder) throws UnsupportedEncodingException {
		try {
			return folderService.queryFolderByPid(folder);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * 新增文件夹
	 */
	@RequestMapping(value = "/public/createFolder")
	public @ResponseBody Map<String, Object> createFolder(@ModelAttribute("preloadEntity") Folder folder) {
		Map<String, Object> reMap = new HashMap<String, Object>();
		try {
			int key = folderService.add(folder);
			reMap.put("newFOlderKey", key);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return reMap;
	}
	/**
	 * 共享文件夹
	 */
	@RequestMapping(value = "/public/shareFolder")
	public @ResponseBody String shareFolder(String bucket, Integer folderId, Integer userId) {
		try {
			
			folderService.shareFolder(folderId);
		} catch (Exception e) {
			e.printStackTrace();
			return Constant.FAIL_CODE;
		}
		return Constant.SUCCESS_CODE;
	}

	/**
	 * 文件查询
	 * 
	 */
	@RequestMapping(value = "/public/objects")
	public @ResponseBody Map<String, Object> listObjects(@ModelAttribute("preloadEntity") Folder folder) {
		try {
			return folderService.queryFolderAndFile(folder);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * 文件上传
	 * 
	 * @ModelAttribute("preloadEntity") File file
	 */
	@RequestMapping(value = "/public/upload", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> upload(String bucket, Integer folderId, Integer userId,
			@RequestParam("file") MultipartFile uploadfile) {

		Map<String, Object> reMap = new HashMap<String, Object>();
		try {
			// 阿里云上传
			String originalFilename = uploadfile.getOriginalFilename();
			String ossKey = UUID.randomUUID().toString();
			aliyunOssService.upload(bucket, uploadfile.getInputStream(), ossKey);
			// 保存文件信息
			OssFile ossFile = new OssFile();
			ossFile.setBucket(bucket);
			ossFile.setFileName(originalFilename);
			ossFile.setFileSize((int) uploadfile.getSize());
			ossFile.setUrl(aliyunOssService.getUrl(bucket, ossKey));
			ossFile.setFileType(uploadfile.getContentType());
			ossFile.setFolderId(folderId);
			ossFile.setOssKey(ossKey);
			ossFile.setFileSize((int) uploadfile.getSize());
			int id = ossFileService.add(ossFile);
			reMap.put("newFileKey", id);
		} catch (Exception e) {
			e.printStackTrace();
			return reMap;
		}
		return reMap;
	}

	/**
	 * 文件/文件夹 删除
	 * 
	 */
	@RequestMapping(value = "/public/deleteObject")
	public @ResponseBody String deleteObject(String bucket, Integer id, Integer userId) {
		try {
			ossFileService.delete(id);
			folderService.deleteFolder(id);
		} catch (Exception e) {
			e.printStackTrace();
			return "no";
		}
		return "ok";
	}

	/**
	 * 
	 * 文件下载
	 * @return 
	 * @throws UnsupportedEncodingException 
	 * 
	 */
	@RequestMapping(value = "/public/download", method = RequestMethod.GET)
	public ResponseEntity<InputStreamResource> download(String bucket, Integer ossFileId, Integer userId, HttpServletResponse response) throws UnsupportedEncodingException {

		OssFile ossFile = ossFileService.findById(ossFileId);
		OSSObject SSObject = aliyunOssService.downLoad(ossFile.getBucket(), ossFile.getOssKey());

		// 设置response的Header
		/*try {
			response.setContentType("application/octet-stream");
			// InputStream in =new
			// FileInputStream("/download/"+ossFile.getFileName());
			response.addHeader("Content-Disposition",
					"attachment;filename=" + URLEncoder.encode(ossFile.getFileName(), "utf-8"));
			response.addHeader("Content-Length", "" + ossFile.getFileSize());
			// response.addHeader("Content-Type:", "" +
			// SSObject.getObjectMetadata().getContentType());
			FileCopyUtils.copy(SSObject.getObjectContent(), response.getOutputStream());
			// FileCopyUtils.copy(in, response.getOutputStream());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/

		HttpHeaders headers = new HttpHeaders();
		headers.add("Cache-Control", "no-cache, no-store, must-revalidate");
		headers.add("Content-Disposition", String.format("attachment; filename=\"%s\"", URLEncoder.encode(ossFile.getFileName(), "utf-8")));
		headers.add("Pragma", "no-cache");
		headers.add("Expires", "0");

		return ResponseEntity.ok().headers(headers).contentLength(ossFile.getFileSize())
				.contentType(MediaType.parseMediaType("application/octet-stream"))
				.body(new InputStreamResource(SSObject.getObjectContent()));

	}

	/**
	 * 文件改名
	 * 
	 */
	@RequestMapping(value = "/public/reNameObject")
	public @ResponseBody Map<String, Object> reNameObject(@ModelAttribute("preloadEntity") File file) {
		Map<String, Object> reMap = new HashMap<String, Object>();
		try {
			String newKey = file.getRelativePath() + "/" + file.getToName();
			fileService.reNameObject(file);
			reMap.put("newKey", newKey);
		} catch (Exception e) {
			e.printStackTrace();
			return reMap;
		}
		return reMap;
	}

	/**
	 * 文件移动
	 * 
	 * @return@ModelAttribute("preloadEntity") File file, ,String fileName
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/public/mvObject")
	public @ResponseBody String mvObject(HttpServletRequest request, @RequestBody String body)
			throws UnsupportedEncodingException {
		// TODO
		return Constant.SUCCESS_CODE;
	}

	/**
	 * 校验用户是否登陆
	 * 
	 * @param file
	 * @return
	 */
	public boolean validate(File file) {
		if (file != null && file.getUserId() != null) {
			return true;
		} else
			return false;
	}

	public User getUser(HttpServletRequest request) {
		HttpSession session = request.getSession();
		User userInfo = (User) session.getAttribute("user");
		return userInfo;
	}
}
