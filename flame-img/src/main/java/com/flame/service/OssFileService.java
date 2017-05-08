package com.flame.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.flame.dao.FolderMapper;
import com.flame.dao.OssFileMapper;
import com.flame.model.OssFile;


@Service
public class OssFileService {
	
	@Autowired
	OssFileMapper ossFileMapper;
	@Autowired
	FolderMapper folderMapper;
	@Autowired
	AliyunOssService aliyunOssService;
	
	public Integer add(OssFile ossFile){
		ossFile.setAtime(new Date());
		ossFile.setMtime(new Date());
		ossFileMapper.insert(ossFile);
		return ossFile.getId();
	}
	
	public void delete(Integer id){
		OssFile ossFile=findById(id);
		if(ossFile!=null){
		//本地删除
		ossFileMapper.deleteByPrimaryKey(id);
//		阿里云删除
		aliyunOssService.delete(ossFile.getBucket(), ossFile.getOssKey());
		}
	}
	
	/**
	 * 文件搜索
	 * @param bucket
	 * @param userId 用户id
	 * @param folderId 文件夹id
	 * @param fileName 文件名称
	 * @return
	 */
	public List<Map<String, Object>> searchFile(String bucket,  Integer userId,Integer folderId,String fileName,String[] fileType){
//		Map<String, Object> reMap = new HashMap<String, Object>();
		
//		设置参数
		Map<String,Object> param = new HashMap<String, Object>();
		param.put("bucket", bucket);
		param.put("userId", userId);
		param.put("folderId", folderId);
		param.put("fileName", fileName);
		param.put("fileType", fileType);
		
//		List<Map<String, Object>> files=ossFileMapper.queryByFileName(param);
//		reMap.put("files", files);
		return ossFileMapper.queryByFileName(param);
	}
	/**
	 * @param id
	 * @return
	 */
	public OssFile findById(Integer id){
		return ossFileMapper.selectByPrimaryKey(id);
	}

}
