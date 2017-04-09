package com.flame.web;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.flame.dao.DemoMapper;
import com.flame.dao.UserMapper;
import com.flame.dao.UserQuestionMapper;
import com.flame.model.DemoExample;
import com.flame.model.User;
import com.flame.model.UserQuestion;
import com.flame.service.UserService;

/**
 * 
 * 登陆控制器
 *
 */
@Controller
@RequestMapping("/login/")
public class LoginController {

	@Autowired
	private UserMapper userMapper;

	@Autowired
	private UserService userService;
	@Autowired
	private UserQuestionMapper userQuestionMapper;

	/**
	 * 用户登陆
	 * 
	 * @return
	 */
	@RequestMapping("")
	public String index() {
		return "platform/login";
	}

	/**
	 * 用户登陆
	 * 
	 * @return
	 */
	@RequestMapping(value = "userLogin", method = RequestMethod.POST)
	public String userLogin(@ModelAttribute("preloadEntity") User user, HttpServletRequest request,
			RedirectAttributes redirectAttributes) {
		String retPage = "/user/menu";
		boolean flag = userService.verifyPassword(user.getUserName(), user.getPassword());
		// 登陆成功
		if (flag) {
			// 保存用户信息到session
			User userInfo = userService.findUserByuserName(user.getUserName());
			HttpSession session = request.getSession();
			session.setAttribute("user", userInfo);
			session.setAttribute("isLogin", "true");
			session.setAttribute("menus", userMapper.queryMenuByRoleId(userInfo.getRoleId()));
			redirectAttributes.addFlashAttribute("message", "登陆成功！");
		} else {
			redirectAttributes.addFlashAttribute("message", "登录失败，用户名或密码不对，请重试！");
			retPage = "/login/";
		}

		return "redirect:" + retPage;
	}

	/**
	 * 用户注册页面
	 * 
	 * @return
	 */
	@RequestMapping("register")
	public String register(Model model) {
		model.addAttribute("questions", userMapper.queryQuestionList());
		return "platform/register";
	}

	/**
	 * 用户注册保存
	 * 
	 * @param user
	 * @return
	 */
	@RequestMapping(value = { "register" }, method = RequestMethod.POST)
	public String register(@ModelAttribute("preloadEntity") User user,
			@RequestParam(value = "questionId1") Integer questionId1,
			@RequestParam(value = "questionId2") Integer questionId2,
			@RequestParam(value = "questionId3") Integer questionId3, @RequestParam(value = "answer1") String answer1,
			@RequestParam(value = "answer2") String answer2, @RequestParam(value = "answer3") String answer3,
			RedirectAttributes redirectAttributes) {

		// 保存用户信息
		if (!ObjectUtils.isEmpty(user)) {
			boolean f = userService.add(user);
			if (!f) {
				redirectAttributes.addFlashAttribute("message", "用户名已存在！");
				redirectAttributes.addFlashAttribute("operate-flag", f);
				return "redirect:/login/register";
			}
		}
		// 保存密保问题
		Integer userId = user.getUserId();
		List<UserQuestion> userQuestions = new ArrayList<UserQuestion>();
		UserQuestion uq1 = new UserQuestion();
		uq1.setUserId(userId);
		uq1.setQuestionId(questionId1);
		uq1.setAnswer(answer1);
		UserQuestion uq2 = new UserQuestion();
		uq2.setUserId(userId);
		uq2.setQuestionId(questionId2);
		uq2.setAnswer(answer2);
		UserQuestion uq3 = new UserQuestion();
		uq3.setUserId(userId);
		uq3.setQuestionId(questionId3);
		uq3.setAnswer(answer3);

		userQuestions.add(uq1);
		userQuestions.add(uq2);
		userQuestions.add(uq3);
		userService.saveQuestion(userQuestions);

		return "redirect:/login/";
	}

	/**
	 * 用户注销
	 * 
	 * @return
	 */
	@RequestMapping(value = "logout")
	public String logout(HttpServletRequest request, RedirectAttributes redirectAttributes) {
		// 解绑用户信息
		HttpSession session = request.getSession();
		session.invalidate();
		return "redirect:" + "";
	}

	/**
	 * 忘记密码
	 * 
	 * @param request
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "forgetPassword")
	public String forgetPassword(Model model) {
		model.addAttribute("questions", userMapper.queryQuestionList());
		return "platform/forgetPassword";
	}

	/**
	 * 忘记密码提交
	 * 
	 * @param user
	 * @return
	 */
	@RequestMapping(value = { "forgetPassword" }, method = RequestMethod.POST)
	public String forgetPassword(@ModelAttribute("preloadEntity") User user,
			@RequestParam(value = "questionId1") Integer questionId1,
			@RequestParam(value = "questionId2") Integer questionId2,
			@RequestParam(value = "questionId3") Integer questionId3, @RequestParam(value = "answer1") String answer1,
			@RequestParam(value = "answer2") String answer2, @RequestParam(value = "answer3") String answer3,
			RedirectAttributes redirectAttributes, HttpServletRequest request) {

		// 回答问题是否正确，默认否
		boolean isCorrect1 = false;
		boolean isCorrect2 = false;
		boolean isCorrect3 = false;
		// 保存用户信息
		User fuse = userService.findUserByuserName(user.getUserName());
		if (fuse == null) {
			redirectAttributes.addFlashAttribute("message", "用户名不存在！");
			redirectAttributes.addFlashAttribute("operate-flag", "false");
			return "redirect:/login/forgetPassword";
		}
		// 校验用户回答问题是否正确
		else {
			Integer userId = fuse.getUserId();
			// 校验问题1
			UserQuestion uq1 = new UserQuestion();
			uq1.setUserId(userId);
			uq1.setQuestionId(questionId1);
			UserQuestion fuq1 = userQuestionMapper.findUserQuestion(uq1);
			if (fuq1 != null && fuq1.getAnswer().equals(answer1)) {
				isCorrect1 = true;
			}
			// 校验问题2
			UserQuestion uq2 = new UserQuestion();
			uq2.setUserId(userId);
			uq2.setQuestionId(questionId2);
			UserQuestion fuq2 = userQuestionMapper.findUserQuestion(uq2);
			if (fuq2 != null && fuq2.getAnswer().equals(answer2)) {
				isCorrect2 = true;
			}
			// 校验问题3
			UserQuestion uq3 = new UserQuestion();
			uq3.setUserId(userId);
			uq3.setQuestionId(questionId3);
			UserQuestion fuq3 = userQuestionMapper.findUserQuestion(uq3);
			if (fuq3 != null && fuq3.getAnswer().equals(answer3)) {
				isCorrect3 = true;
			}

		}

		// 三个问题回答正确 跳转到密码重置页面
		if (isCorrect1 && isCorrect2 && isCorrect3) {
			// 标记从找回密码页面跳转，防止直接跳转到密码重置页面
			HttpSession session = request.getSession();
			session.setAttribute("forgetPasswordFlag", "yes");
			redirectAttributes.addFlashAttribute("user", fuse);
			return "redirect:/login/resetPassword";
			// 跳回找回密码页面
		} else {
			redirectAttributes.addFlashAttribute("message", "答案错误！");
			redirectAttributes.addFlashAttribute("operate-flag", "false");
			return "redirect:/login/forgetPassword";
		}

	}

	/**
	 * 忘记密码
	 * 
	 * @param request
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "resetPassword")
	public String resetPassword() {
		return "platform/resetPassword";
	}

	/**
	 * 忘记密码
	 * 
	 * @param request
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "resetPassword", method = RequestMethod.POST)
	public String resetPassword(@ModelAttribute("preloadEntity") User user, RedirectAttributes redirectAttributes,
			HttpServletRequest request) {

		HttpSession session = request.getSession();
		String forgetPasswordFlag = (String) session.getAttribute("forgetPasswordFlag");

		//如果不是从忘记密码页面跳转过来，则跳转
		if (!"yes".equals(forgetPasswordFlag)) {
			return "redirect:/login/forgetPassword";
		}else{
			session.removeAttribute("forgetPasswordFlag");
		}

		userService.updatePassowrd(user);
		redirectAttributes.addFlashAttribute("message", "重置密码成功！");
		redirectAttributes.addFlashAttribute("operate-flag", "ture");
		 return "redirect:" + "";
	}
}