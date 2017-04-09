package com.flame.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.flame.dao.FolderMapper;
import com.flame.dao.OssFileMapper;
import com.flame.model.Folder;

/**
 *文件夹服务类
 */
@Service
public class FolderService {
	
	@Autowired
	FolderMapper folderMapper;
	
	@Autowired
	OssFileMapper ossFileMapper;
	
	/**
	 * 新增文件夹
	 * @param folder
	 * @return
	 */
	public Integer add(Folder folder){
		folder.setPermission(0);
		folder.setCtime(new Date());
		folder.setMtime(new Date());
		folderMapper.insert(folder);
		return folder.getId();
	};
	
	/**
	 * 修改文件夹名称
	 * @param id
	 * @param newFolderName
	 */
	public void editName(Integer id,String newFolderName){
		Folder folder=findById(id);
		folder.setFolderName(newFolderName);
		folder.setMtime(new Date());
		folderMapper.updateByPrimaryKey(folder);
	};
	/**
	 * 共享文件夹
	 * @param id
	 * @param newFolderName
	 */
	public void shareFolder(Integer id){
		Folder folder=findById(id);
		folder.setPermission(1);
		folder.setMtime(new Date());
		folderMapper.updateByPrimaryKey(folder);
	};
	
	/**
	 *  删除文件夹以及文件夹下的所有文件
	 * @param id
	 * @param newFolderName
	 */
	public void deleteFolder(Integer id){
		
		//删除文件夹
		folderMapper.deleteByPrimaryKey(id);
//		删除文件
		ossFileMapper.deleteByFolderId(id);
		
		Folder folder=new Folder();
		folder.setPid(id);
		List<Map<String, Object>> list = folderMapper.queryFolderByPid(folder);
		
		if(list!=null&&list.size()>0){
			for(Map<String, Object> map:list){
				deleteFolder(Integer.valueOf(map.get("id")+""));
			}
		}
		
	};
	
	
	
	/**
	 * 查询子文件夹
	 * @param folder
	 * @return
	 */
	public Map<String, Object> queryFolderByPid(Folder folder){
		Map<String, Object> reMap = new HashMap<String, Object>();
		List<Map<String, Object>> list = folderMapper.queryFolderByPid(folder);
		reMap.put("folders", list);
		reMap.put("count", list == null ? 0 : list.size());
		return reMap;
	};
	
	/**
	 * 查询文件夹 以及文件下的所有文件
	 * @param folder
	 * @return
	 */
	
	public Map<String, Object> queryFolderAndFile(Folder folder){
		
		Map<String, Object> reMap = new HashMap<String, Object>();
		//查询文件夹
		List<Map<String, Object>> folders = folderMapper.queryFolderByPid(folder);
		//查询文件夹下的所有文件
		List<Map<String, Object>> files=new ArrayList<Map<String, Object>>();
		
		files.addAll((ossFileMapper.queryByFolderId(folder.getPid())));
		if(folders!=null&&folders.size()>0){
			for(Map<String, Object> map:folders){
				files.addAll((ossFileMapper.queryByFolderId(Integer.valueOf(map.get("id")+""))));
			}
		}
		
		reMap.put("folders", folders);
		reMap.put("files", files);
		return reMap;
	};
	
	
	/**
	 * 根据id查找文件夹信息
	 * @param id
	 * @return
	 */
	public Folder findById(Integer id){
		return folderMapper.selectByPrimaryKey(id);
	};
	
	

}
