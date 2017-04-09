package com.flame.filter;

/*
 * 使用注解标注过滤器
 * 
 * @WebFilter将一个实现了javax.servlet.Filter接口的类定义为过滤器 属性filterName声明过滤器的名称,可选
 *                                                属性urlPatterns指定要过滤
 *                                                的URL模式,也可使用属性value来声明.(指定要过滤的URL模式是必选属性) 
 */
import java.io.IOException;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;

import tk.mybatis.mapper.util.StringUtil;

/**
 * 权限过滤。
 * 登陆页面不过滤
 */
@WebFilter(filterName = "FameFilter", urlPatterns ={"/user/*","/file/manage/*"}, initParams = {
		@WebInitParam(name = "EXCLUDED_PAGE", value = "login,register")
		,@WebInitParam(name = "EXCLUDED_EXT", value = "jpeg;jpg;png;pdf;css;js") 
		})
public class FlameFilter implements Filter {
	private static final Logger logger = LoggerFactory.getLogger(FlameFilter.class);

	private static Set<String> excludedPage;
	private static Set<String> excludedExt;

	@Override
	public void init(FilterConfig config) throws ServletException {
		logger.info("PassportFilter过滤器初始化");
		
		excludedPage = assemblExcludeSet(config.getInitParameter("EXCLUDED_PAGE"));
		excludedExt = assemblExcludeSet(config.getInitParameter("EXCLUDED_EXT"));
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;
		HttpSession session = req.getSession();
		// 判断这个访问是否需要被拦截 或者 这个会话是否已经登陆 
		
		 String isLogin=String.valueOf(session.getAttribute("isLogin"));
		 if("true".equals(isLogin)){
			  chain.doFilter(request, response);
			 //没有登陆，调转到登陆页面
		 }else{
			 resp.sendRedirect("/login/");
			 return;
		 }
		
		/*if (isExcluded(req.getServletPath().substring(1))&&flag) {
		  chain.doFilter(request, response);
			return;
		}*/
		/*String para;
		if(null != req.getQueryString()) {
			para = "?" + req.getQueryString();
		} else {
			para = "";
		}*/
	}

	@Override
	public void destroy() {
		excludedPage = null;
		excludedExt = null;
	}
	
	/**
	 * 组装不需要被过滤的页面或者文件	
	 * @param excludedString
	 * @param excludeSet
	 */
	private Set<String> assemblExcludeSet(String excludedString) {
		Set<String> excludeSet = null;
		if (StringUtil.isNotEmpty(excludedString)) {
			excludeSet = Collections.unmodifiableSet(new HashSet<>(Arrays.asList(excludedString.split(";", 0))));
		} else {
			excludeSet = Collections.<String>emptySet();
		}
		return excludeSet;
	}	

	/**
	 * 判断这个访问路径和文件是否不需要拦截
	 * @param path
	 * @return
	 */
	private boolean isExcluded(String path) {
		String extension = StringUtil.isNotEmpty(path) ? path.substring(path.indexOf('.', path.lastIndexOf('/')) + 1).toLowerCase() : "";
		// 判断当前扩展是否与例外扩展相同
		if (excludedExt.contains(extension)) {
			logger.info("{}, it's excluded by PassportFilter.", extension);
			return true;
		}
		// 判断当前URL是否与例外页面相同
		if (excludedPage.contains(path)) { // 从第2个字符开始取（把前面的/去掉）
			logger.info("{}, it's excluded by PassportFilter.", path);
			return true;
		}
		return false;
	}
	
}
