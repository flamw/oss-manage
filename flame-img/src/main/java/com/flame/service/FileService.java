package com.flame.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.flame.constant.Constant;
import com.flame.dao.FileMapper;
import com.flame.dao.UserFileMapper;
import com.flame.model.File;
import com.flame.model.UserFile;

@Service
public class FileService {

	@Autowired
	FileMapper fileMapper;
	@Autowired
	UserFileMapper userFileMapper;

	public void add(File file) {
		file.setAtime(new Date());
		file.setMtime(new Date());
		fileMapper.insert(file);

		UserFile uf = new UserFile();
		uf.setFileId(file.getId());
		uf.setUserId(file.getUserId());
		uf.setPermission(0);
		userFileMapper.insert(uf);
	}

	/**
	 * 文件删除
	 * 
	 * @param file
	 * @return
	 */
	public String deleteObject(File file) {
		// 先查出要删除文件的id
		List<String> ids = fileMapper.listUserFileIds(file);
		file.setFileIds(ids);
		// 删除关系表
		fileMapper.deleteUserFile(file);
		// 删除实体表
		fileMapper.deleteFile(file);
		return Constant.SUCCESS_CODE;
	}

	/**
	 * 文件夹查询
	 * 
	 */
	public Map<String, Object> listFolders(File file) {
		Map<String, Object> reMap = new HashMap<String, Object>();
		List<Map<String, Object>> list = fileMapper.listFolders(file);
		reMap.put("folders", list);
		reMap.put("count", list == null ? 0 : list.size());
		return reMap;
	}
	/**
	 * 文件查询
	 */
	public Map<String, Object>  listObjects(File file) {
		Map<String, Object> reMap = new HashMap<String, Object>();
		List<Map<String, Object>> listFolders = fileMapper.listFolders(file);
		List<Map<String, Object>> listFiles = fileMapper.listFiles(file);
//		List<Map<String, Object>> listFilesNew = new ArrayList<Map<String, Object>>();
//		if(listFiles!=null){
//		for(Map<String, Object> map:listFiles){
//			String address="";
//			address="/api/"+String.valueOf(map.get("domain"))+"/object?bucket="+String.valueOf(map.get("bucket"))+"&key="+String.valueOf(map.get("KEY"))+String.valueOf(map.get("NAME"));
//			map.put("address", address);
//			listFilesNew.add(map);
//		}}
		reMap.put("folders", listFolders);
		reMap.put("files", listFiles);
		return reMap;
	}

	/**
	 * 文件改名
	 * 
	 */
	public String reNameObject(File file){
		fileMapper.reNameObject(file);
		return Constant.SUCCESS_CODE;
	}

	/**
	 * 文件移动
	 */
	public  String mvObject(File file){
		//TODO
		return Constant.SUCCESS_CODE;
	}
}
