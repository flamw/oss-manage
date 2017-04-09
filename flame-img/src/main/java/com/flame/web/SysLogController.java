package com.flame.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.flame.model.ResponseBean;
import com.flame.model.SysLog;
import com.flame.service.SysLogService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * 
 * 日志控制器
 *
 */
@Controller
@RequestMapping("/sysLog/")
public class SysLogController {

	@Autowired
	SysLogService sysLogService;
	
	/**
	 * 默认加载菜单页
	 * 
	 * @return
	 */
	@RequestMapping("")
	public String menu() {
		return "platform/sysLogList";
	}

	/**
	 * 获取日志列表
	 * 
	 * @param page
	 * @param pageSize
	 * @return
	 */
	@RequestMapping("list")
	public @ResponseBody ResponseBean list(@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(name = "pageSize", defaultValue = "10") int pageSize) {

		ResponseBean rb = new ResponseBean();
		PageHelper.orderBy("ctime desc ");

		PageHelper.startPage(page, pageSize);
		List<SysLog> list = sysLogService.list();
		PageInfo<SysLog> pageInfo = new PageInfo<SysLog>(list);

		Map<String, Object> returnMap = new HashMap<String, Object>();

		returnMap.put("pages", pageInfo.getPages());
		returnMap.put("total", pageInfo.getTotal());
		returnMap.put("datas", list);
		returnMap.put("pageSize", pageInfo.getPageSize());
		returnMap.put("size", pageInfo.getSize());
		rb.setResults(returnMap);
		return rb;
	}

}
