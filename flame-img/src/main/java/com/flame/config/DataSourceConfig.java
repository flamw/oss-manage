package com.flame.config;

import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.embedded.FilterRegistrationBean;
import org.springframework.boot.context.embedded.ServletRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.alibaba.druid.pool.DruidDataSource;
import com.alibaba.druid.support.http.StatViewServlet;
import com.alibaba.druid.support.http.WebStatFilter;

/**
 * 数据库配置
 */
@Configuration
public class DataSourceConfig {

	@Bean
	public ServletRegistrationBean druidServlet() {
		return new ServletRegistrationBean(new StatViewServlet(), "/druid/*");
	}

	/** 默认数据源配置 **/
	@Bean(name = "dataSource")
	@Qualifier("dataSource")
	public DataSource dataSource(@Value("${spring.datasource.driverClassName}") String driver,
			@Value("${spring.datasource.url}") String url, @Value("${spring.datasource.username}") String username,
			@Value("${spring.datasource.password}") String password,
			@Value("${spring.datasource.initialSize}") Integer initialSize,
			@Value("${spring.datasource.minIdle}") Integer minIdle,
			@Value("${spring.datasource.maxActive}") Integer maxActive) {
		DruidDataSource druidDataSource = new DruidDataSource();
		druidDataSource.setDriverClassName(driver);
		druidDataSource.setUrl(url);
		druidDataSource.setUsername(username);
		druidDataSource.setPassword(password);
		druidDataSource.setTestOnBorrow(true);
		druidDataSource.setMaxActive(maxActive);
		druidDataSource.setMinIdle(minIdle);
		druidDataSource.setInitialSize(initialSize);
		druidDataSource.setValidationQuery("select 1");
		try {
			druidDataSource.setFilters("stat, wall");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return druidDataSource;
	}

	@Bean
	public FilterRegistrationBean filterRegistrationBean() {
		FilterRegistrationBean filterRegistrationBean = new FilterRegistrationBean();
		filterRegistrationBean.setFilter(new WebStatFilter());
		filterRegistrationBean.addUrlPatterns("/*");
		filterRegistrationBean.addInitParameter("exclusions", "*.js,*.gif,*.jpg,*.png,*.css,*.ico,/druid/*");
		return filterRegistrationBean;
	}

}
