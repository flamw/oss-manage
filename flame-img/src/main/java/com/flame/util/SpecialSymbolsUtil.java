package com.flame.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import tk.mybatis.mapper.util.StringUtil;


public class SpecialSymbolsUtil {
	public static final String DEFAULT_QUERY_REGEX = "[!$^&*+=|{}';'\",<>/?~！#￥%……&*——|{}【】‘；：”“'。，、？]";

	/**
	 * 判断查询参数中是否以特殊字符开头，如果以特殊字符开头则返回true，否则返回false
	 * 
	 * @param value
	 * @return
	 * @see {@link #getQueryRegex()}
	 * @see {@link #DEFAULT_QUERY_REGEX}
	 */
	public static boolean specialSymbols(String value) {
		if (StringUtil.isEmpty(value)) {
			return false;
		}
		Pattern pattern = Pattern.compile(getQueryRegex());
		Matcher matcher = pattern.matcher(value);

		char[] specialSymbols = getQueryRegex().toCharArray();

		boolean isStartWithSpecialSymbol = false; // 是否以特殊字符开头
		for (int i = 0; i < specialSymbols.length; i++) {
			char c = specialSymbols[i];
			if (value.indexOf(c) == 0) {
				isStartWithSpecialSymbol = true;
				break;
			}
		}

		return matcher.find() && isStartWithSpecialSymbol;
	}

	/**
	 * 获取查询过滤的非法字符
	 * 
	 * @return
	 */
	protected static String getQueryRegex() {
		return DEFAULT_QUERY_REGEX;
	}
}
