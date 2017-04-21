package com.flame.web;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
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
import com.flame.service.AliyunOssService;
import com.flame.service.FolderService;
import com.flame.service.OssFileService;
import com.flame.service.SysLogService;
import com.flame.util.SpecialSymbolsUtil;

/**
 * 共享文件控制器
 */
@Controller
@RequestMapping("/shareFile/")
public class ShareFileConroller {

	private String ACTION_PATH = "/filemanage/";

	@Autowired
	FolderService folderService;
	@Autowired
	OssFileService ossFileService;
	@Autowired
	AliyunOssService aliyunOssService;
	@Autowired
	SysLogService sysLogService;
	
	/**
	 * 跳转图片管理
	 * 
	 * @param request
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "")
	public String fileManage() {
		return ACTION_PATH + "sharefile";
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
			folder.setPermission(1);
			folder.setUserId(null);
			return folderService.queryFolderByPid(folder);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	/**
	 * 共享文件夹
	 */
	@RequestMapping(value = "/public/shareFolder", method = RequestMethod.POST)
	public @ResponseBody String shareFolder(String bucket, Integer folderId, Integer userId,Integer permission) {
		try {
			folderService.shareFolder(folderId,permission);
		} catch (Exception e) {
			e.printStackTrace();
			return Constant.FAIL_CODE;
		}
		return Constant.SUCCESS_CODE;
	}
	/**
	 * 文件搜索 模糊匹配
	 */
	@RequestMapping(value = "/public/searchFile", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> searchFile(@RequestParam(value = "bucket",required=false)String bucket, 
			@RequestParam(value = "folderId",required=false )Integer folderId, Integer userId,String fileName) {
		Map<String, Object> reMap = new HashMap<String, Object>();
		try {
				reMap.put("folders", folderService.queryByFolderName(bucket, null,null, fileName,1));
		        reMap.put("files", ossFileService.searchFile(bucket, userId, null, fileName));
			 return reMap;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * 文件查询
	 * 
	 */
	@RequestMapping(value = "/public/objects")
	public @ResponseBody Map<String, Object> listObjects(@ModelAttribute("preloadEntity") Folder folder) {
		try {
			folder.setPermission(1);
			folder.setUserId(null);
			return folderService.queryFolderAndFile(folder);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
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
		sysLogService.addSysLog(userId, "文件下载",ossFile.getFileName());
		return ResponseEntity.ok().headers(headers).contentLength(ossFile.getFileSize())
				.contentType(MediaType.parseMediaType("application/octet-stream"))
				.body(new InputStreamResource(SSObject.getObjectContent()));

	}
}
