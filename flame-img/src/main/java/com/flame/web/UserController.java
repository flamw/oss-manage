package com.flame.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.flame.constant.Constant;
import com.flame.model.ResponseBean;
import com.flame.model.User;
import com.flame.service.RoleService;
import com.flame.service.UserService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * 用户管理控制类
 *
 */
@Controller
@RequestMapping("/user/")
public class UserController {
	public String ACTION_PATH = "/user/";

	@Autowired
	private UserService userService;
	@Autowired
	private RoleService roleService;

	
	/**
	 * 默认加载菜单页
	 * 
	 * @return
	 */
	@RequestMapping("menu")
	public String menu() {
		return "menu/main";
	}

	/**
	 * 默认返回用户列表
	 * 
	 * @return
	 */
	@RequestMapping("")
	public String index() {

		return ACTION_PATH + "userList";
	}

	/**
	 * 跳转到编辑页面
	 * 
	 * @return
	 */
	@RequestMapping("edit/{id}")
	public String userEdit(@PathVariable("id") Integer id, Model model) {
		model.addAttribute("user", userService.find(id));
		model.addAttribute("roles", roleService.list());
		return ACTION_PATH + "userEdit";
	}

	/**
	 * 跳转到编辑页面
	 * 
	 * @return
	 */
	@RequestMapping("add")
	public String userAdd(Model model) {
		model.addAttribute("roles", roleService.list());
		return ACTION_PATH + "userAdd";
	}

	/**
	 * 获取用户列表
	 * 
	 * @param page
	 * @param pageSize
	 * @return
	 */
	@RequestMapping("list")
	public @ResponseBody ResponseBean list(@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(name = "pageSize", defaultValue = "10") int pageSize) {

		ResponseBean rb = new ResponseBean();
		PageHelper.orderBy("user_id ");

		PageHelper.startPage(page, pageSize);
		List<User> list = userService.list();
		PageInfo<User> pageInfo = new PageInfo<User>(list);
		Map<String, Object> returnMap = new HashMap<String, Object>();

		returnMap.put("pages", pageInfo.getPages());
		returnMap.put("total", pageInfo.getTotal());
		returnMap.put("datas", list);
		returnMap.put("pageSize", pageInfo.getPageSize());
		returnMap.put("size", pageInfo.getSize());
		rb.setResults(returnMap);
		return rb;
	}

	/**
	 * 保存／更新
	 * 
	 * @param user
	 * @return
	 */
	@RequestMapping(value = { "save", "update" }, method = RequestMethod.POST)
	public String saveAndUpdate(@ModelAttribute("preloadEntity") User user, RedirectAttributes redirectAttributes) {
		String message = "保存成功！";
		if (ObjectUtils.isEmpty(user.getUserId())) {
			boolean f = userService.add(user);
			if (!f) {
				message = "用户名已存在！";
				redirectAttributes.addFlashAttribute("operate-flag", "false");
				return "redirect:/user/add";
			}
		} else {
			userService.update(user);
		}
		redirectAttributes.addFlashAttribute("message", message);
		return "redirect:/user/";
	}


	/**
	 * 用户删除
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping("delete/{id}")
	public @ResponseBody ResponseBean delete(@PathVariable("id") Integer id) {
		userService.delete(id);
		ResponseBean rb = new ResponseBean();
		rb.setRetnCode(Constant.SUCCESS_CODE);
		return rb;
	}
	
}
