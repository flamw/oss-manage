package com.flame.config;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;
import org.springframework.boot.context.embedded.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

@Configuration
public class WebConfig extends WebMvcConfigurerAdapter {
	/**
	 * 装饰器
	 * 
	 */
	@Bean
	public FilterRegistrationBean siteMeshFilter() {
		FilterRegistrationBean fitler = new FilterRegistrationBean();
		WebSiteMeshFilter siteMeshFilter = new WebSiteMeshFilter();
		fitler.setFilter(siteMeshFilter);
		return fitler;
	}

	public class WebSiteMeshFilter extends ConfigurableSiteMeshFilter {

		@Override
		protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
//			addExcludedPath("/login/").addExcludedPath("/login/index")
			builder.addDecoratorPath("*", "/user/menu").addExcludedPath("/login/*").addExcludedPath("*/platform/*")
			.addExcludedPath("*/static/*").addExcludedPath("*/public/*").addExcludedPath("*/file/public/*").addExcludedPath("/user/menu");
		}
	}
}