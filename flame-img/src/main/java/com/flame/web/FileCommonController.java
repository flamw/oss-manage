package com.flame.web;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.flame.constant.Constant;
import com.flame.constant.FileType;
import com.flame.model.Comment;
import com.flame.model.Note;
import com.flame.model.User;
import com.flame.service.CommentService;
import com.flame.service.FolderService;
import com.flame.service.NoteService;
import com.flame.service.OssFileService;
import com.flame.service.UserService;
import com.github.pagehelper.StringUtil;

/**
 * 文档、图片、视频 音乐 控制器
 */
@Controller
@RequestMapping("/fileCommon/")
public class FileCommonController {

	private String ACTION_PATH = "/filemanage/";

	@Autowired
	FolderService folderService;
	@Autowired
	UserService userService;
	@Autowired
	OssFileService ossFileService;
	@Autowired
	NoteService noteService;
	@Autowired
	CommentService commentService;

	/**
	 * 
	 * @param request
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "")
	public String fileManage() {
		return ACTION_PATH + "filecommon";
	}

	@RequestMapping(value = "note")
	public String note() {
		return ACTION_PATH + "note";
	}

	/**
	 * 文件查询
	 * 
	 * @param fileType
	 * @param userId
	 * @param fileName
	 * @return
	 */
	@RequestMapping(value = "/public/objects")
	public @ResponseBody List<Map<String, Object>> listObjects(String fileType, Integer userId, String fileName) {
		try {
			if (StringUtil.isEmpty(fileName)) {
				fileName = null;
			}
			String[] fileTypes = FileType.getFileType(fileType);

			return ossFileService.searchFile(null, userId, null, fileName, fileTypes);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@RequestMapping(value = "/note/save")
	public @ResponseBody Note noteSave(HttpServletRequest request, Integer noteId, String content) {
		Integer userId = userService.getLoginUserId(request);
		return noteService.save(noteId, content.trim(), userId);
	}

	@RequestMapping(value = "/note/delete")
	public @ResponseBody String noteDelete(Integer noteId) {
		noteService.delete(noteId);
		return Constant.SUCCESS_CODE;
	}

	@RequestMapping(value = "/note/list")
	public @ResponseBody List<Note> noteList(HttpServletRequest request) {
		Integer userId = userService.getLoginUserId(request);
		return noteService.queryForListByUserId(userId);
	}
	
	@RequestMapping(value = "/note/id")
	public @ResponseBody Note getOne(Integer noteId) {
		return noteService.findById(noteId);
	}
	
	@RequestMapping(value = "/comment/save")
	public @ResponseBody String commentSave(HttpServletRequest request,String content,Integer fileId) {
		User user = userService.getLoginUser(request);
		Integer userId =user.getUserId();
		commentService.save(content, userId,user.getUserName(), fileId);
		return Constant.SUCCESS_CODE;
	}
	
	@RequestMapping(value = "/comment/list")
	public @ResponseBody List<Comment> list(Integer fileId) {
		return commentService.list( fileId);
	}

}
