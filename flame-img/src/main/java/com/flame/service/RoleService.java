package com.flame.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.flame.dao.RoleMapper;
import com.flame.model.Role;

@Service
public class RoleService {

	@Autowired
	RoleMapper roleMapper;

	public void add(Role record) {
		record.setCtime(new Date());
		roleMapper.insert(record);
	}

	public void Update(Role record) {
		Role role=findById(record.getRoleId());
		role.setMtime(new Date());
		roleMapper.insert(role);
	}

	public Role findById(Integer roleId) {
		return roleMapper.selectByPrimaryKey(roleId);
	}
	
	public List<Role> list() {
		return roleMapper.queryForList();
	}

}
