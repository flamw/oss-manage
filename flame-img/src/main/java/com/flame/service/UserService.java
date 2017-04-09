package com.flame.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.flame.dao.RoleMapper;
import com.flame.dao.UserMapper;
import com.flame.dao.UserQuestionMapper;
import com.flame.dao.UserRoleMapper;
import com.flame.model.Role;
import com.flame.model.User;
import com.flame.model.UserQuestion;
import com.flame.util.Md5Util;

/**
 * 用户服务类
 *
 */
@Service
public class UserService {
	@Autowired
	private UserMapper userMapper;
	@Autowired
	private UserRoleMapper userRoleMapper;
	@Autowired
	private RoleMapper roleMapper;
	@Autowired
	private UserQuestionMapper userQuestionMapper;

	/**
	 * @param user
	 *            保存密码问题
	 */
	public void saveQuestion(List<UserQuestion> userQuestion) {
		for (UserQuestion uq : userQuestion) {
			userQuestionMapper.insert(uq);
		}
	}

	/**
	 * @param user
	 *            新增用户
	 * @return
	 */
	public boolean add(User user) {
		User fuser=findUserByuserName(user.getUserName());
		if(fuser==null){
		// 密码md5加密
		user.setPassword(Md5Util.getMd5(user.getPassword()));
		user.setCtime(new Date());
		user.setMtime(new Date());
		userMapper.insert(user);
		return true;
		}else{
			return false;
		}
		
	}

	/**
	 * @param user
	 *            修改
	 */
	public void update(User user) {
		userMapper.updateByPrimaryKeySelective(user);
	}

	/**
	 * @param user
	 *            用户删除
	 */
	public void delete(Integer userId) {
		userMapper.deleteByPrimaryKey(userId);
	}

	/**
	 * @param user
	 *            修改密码
	 */
	public void updatePassowrd(User user) {
		User userOld = find(user.getUserId());
		// 密码md5加密
		userOld.setPassword(Md5Util.getMd5(user.getPassword()));
		userOld.setMtime(new Date());
		userMapper.updateByPrimaryKeySelective(userOld);
	}

	/**
	 * @param userId
	 *            查询用户
	 */
	public User find(Integer userId) {
		return userMapper.selectByPrimaryKey(userId);
	}

	/**
	 * 查询用户列表
	 */
	public List<User> list() {

		// 获取用户列表
		List<User> list = userMapper.queryForList();
		List<User> listNew = new ArrayList<User>();
		// 查询角色
		for (User u : list) {

			Role role = roleMapper.selectByPrimaryKey(u.getRoleId());
			if (role != null) {
				u.setRoleName(role.getRoleName());
			}
			listNew.add(u);
		}

		return listNew;
	}

	/**
	 * @param userId
	 *            查询用户角色
	 */
	public String getRoleByUserId(Integer userId) {
		String rolesStr = "";
		List<Map> roles = userMapper.queryRoleByUserId(userId);
		if (roles != null) {
			for (Map m : roles) {
				rolesStr += m.get("role_name") + ",";
			}

			if (rolesStr.contains(",")) {
				rolesStr = rolesStr.substring(0, rolesStr.lastIndexOf(","));
			}
		}

		return rolesStr;
	}

	/**
	 * 查询用户信息
	 * 
	 * @param userName
	 * @return
	 */
	public User findUserByuserName(String userName) {
		return userMapper.findUserByUserName(userName);
	}

	/**
	 * 判断输入密码是否正确
	 * @param userName
	 * @param passwrod
	 */
	public boolean verifyPassword(String userName,String passwrod){
	    User user=findUserByuserName(userName);
	    if(user!=null&&user.getPassword().equals(Md5Util.getMd5(passwrod))){
	    	return true;
	    }else{
	    	return false;
	    }
	}
	
}
