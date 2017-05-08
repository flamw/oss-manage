package com.flame.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.flame.dao.NoteMapper;
import com.flame.model.Note;

@Service
public class NoteService {

	@Autowired
	NoteMapper noteMapper;

	public Note save(Integer noteId, String content, Integer userId) {
		if (noteId == null || noteId <= 0) {
			return add(content, userId);
		} else {
			update(noteId, content);
		}
		return null;
	}

	public Note add(String content, Integer userId) {
		String str=StripHT(content);
		String noteTitle = str.substring(0,str.length()>10?10:str.length());
		Note note = new Note();
		note.setNoteTitle(noteTitle);
		note.setUserId(userId);
		note.setContent(content);
		note.setCtime(new Date());
		note.setMtime(new Date());
		noteMapper.insert(note);
		return note;

	}

	public void update(Integer noteId, String content) {
		Note note = findById(noteId);
		String str=StripHT(content);
		String noteTitle = str.substring(0,str.length()>10?10:str.length());
		note.setNoteTitle(noteTitle);
		note.setContent(content);
		note.setMtime(new Date());
		noteMapper.updateByPrimaryKeySelective(note);
	}

	public void delete(Integer noteId) {
		noteMapper.deleteByPrimaryKey(noteId);
	}

	public List<Note> queryForListByUserId(Integer userId) {
		return noteMapper.selectForListByUserId(userId);
	}

	public Note findById(Integer noteId) {
		return noteMapper.selectByPrimaryKey(noteId);
	}
	
	public  String StripHT(String strHtml) {  
	     String txtcontent = strHtml.replaceAll("</?[^>]+>", ""); //剔出<html>的标签    
	        txtcontent = txtcontent.replaceAll("<a>\\s*|\t|\r|\n</a>", "");//去除字符串中的空格,回车,换行符,制表符    
	        return txtcontent;  
	   } 

}
