package com.flame.service;

import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.flame.dao.SysLogMapper;
import com.flame.model.SysLog;
import com.flame.model.User;

@Service
public class SysLogService {

	@Autowired
	SysLogMapper sysLogMapper;
	@Autowired
	UserService userService;

	/**
	 * 新增日志
	 * 
	 * @param userId
	 * @param operationTye
	 */
	public void addSysLog(Integer userId, String operationType) {
		User user = userService.find(userId);
		SysLog sysLog = new SysLog();
		if (user != null) {
			sysLog.setUserId(userId);
		}
		operationType=strToUtf8(operationType);
		sysLog.setUserName(user.getUserName());
		sysLog.setOperationType(operationType);
		sysLog.setCtime(new Date());
		sysLogMapper.insert(sysLog);
	}

	/**
	 * 新增日志
	 * 
	 * @param userId
	 * @param operationTye
	 * @param desc
	 */
	public void addSysLog(Integer userId, String operationType,String desc) {
		User user = userService.find(userId);
		operationType=strToUtf8(operationType);
		desc=strToUtf8(desc);
		SysLog sysLog = new SysLog();
		if (user != null) {
			sysLog.setUserId(userId);
			sysLog.setUserName(user.getUserName());
		}
		sysLog.setOperationType(operationType);
		sysLog.setDescription(desc);
		sysLog.setCtime(new Date());
		sysLogMapper.insert(sysLog);
	}

		/**
		 * 新增日志
		 * 
		 * @param request
		 * @param operationTye
		 */
		public void addSysLog(HttpServletRequest request, String operationType) {
			operationType=strToUtf8(operationType);
				HttpSession session = request.getSession();
				User user = (User) session.getAttribute("user");
				SysLog sysLog = new SysLog();
				if (user != null) {
					sysLog.setUserName(user.getUserName());
					sysLog.setUserId(user.getUserId());
				}
				sysLog.setOperationType(operationType);
				sysLog.setCtime(new Date());
				sysLogMapper.insert(sysLog);
			}

	/**
	 * 日志列表
	 * 
	 * @return
	 */
	public List<SysLog> list() {
		return sysLogMapper.queryForList();
	}
	
	
	/**
	 * @param str
	 * @return
	 */
	public String strToUtf8(String str){
		try {
			return new String(str.getBytes("UTF-8"));
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return str;
		}
	}
}
