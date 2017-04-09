package com.flame.service;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.flame.dao.OssFileMapper;
import com.flame.model.OssFile;


@Service
public class OssFileService {
	
	@Autowired
	OssFileMapper ossFileMapper;
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
	
	public OssFile findById(Integer id){
		return ossFileMapper.selectByPrimaryKey(id);
	}

}
