/**
 * 
 */
package com.flame.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.ConnectException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import tk.mybatis.mapper.util.StringUtil;

/**
 *
 */
public class NetworkUtil {
	/**
	 * Logger for this class
	 */
	private static Logger logger = Logger.getLogger(NetworkUtil.class);

	public final static String GET = "GET";
	public final static String POST = "POST";
	public final static String PUT = "PUT";
	private static final String[] HEADERS_TO_TRY = { "X-Forwarded-For", "Proxy-Client-IP", "WL-Proxy-Client-IP",
			"HTTP_X_FORWARDED_FOR", "HTTP_X_FORWARDED", "HTTP_X_CLUSTER_CLIENT_IP", "HTTP_CLIENT_IP",
			"HTTP_FORWARDED_FOR", "HTTP_FORWARDED", "HTTP_VIA", "REMOTE_ADDR" };

	/**
	 * 获取请求主机IP地址,如果通过代理进来，则透过防火墙获取真实IP地址;
	 * 
	 * @param request
	 * @return
	 * @throws IOException
	 */
	public final static String getIpAddress(HttpServletRequest request) throws IOException {
		// 获取请求主机IP地址,如果通过代理进来，则透过防火墙获取真实IP地址

		String ip = request.getHeader("X-Forwarded-For");
		if (logger.isInfoEnabled()) {
			logger.debug("getIpAddress(HttpServletRequest) - X-Forwarded-For - String ip=" + ip);
		}

		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
				ip = request.getHeader("Proxy-Client-IP");
				if (logger.isInfoEnabled()) {
					logger.debug("getIpAddress(HttpServletRequest) - Proxy-Client-IP - String ip=" + ip);
				}
			}
			if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
				ip = request.getHeader("WL-Proxy-Client-IP");
				if (logger.isInfoEnabled()) {
					logger.debug("getIpAddress(HttpServletRequest) - WL-Proxy-Client-IP - String ip=" + ip);
				}
			}
			if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
				ip = request.getHeader("HTTP_CLIENT_IP");
				if (logger.isInfoEnabled()) {
					logger.debug("getIpAddress(HttpServletRequest) - HTTP_CLIENT_IP - String ip=" + ip);
				}
			}
			if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
				ip = request.getHeader("HTTP_X_FORWARDED_FOR");
				if (logger.isInfoEnabled()) {
					logger.debug("getIpAddress(HttpServletRequest) - HTTP_X_FORWARDED_FOR - String ip=" + ip);
				}
			}
			if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
				ip = request.getRemoteAddr();
				if (logger.isInfoEnabled()) {
					logger.debug("getIpAddress(HttpServletRequest) - getRemoteAddr - String ip=" + ip);
				}
			}
		} else if (ip.length() > 15) {
			String[] ips = ip.split(",");
			for (int index = 0; index < ips.length; index++) {
				String strIp = (String) ips[index];
				if (!("unknown".equalsIgnoreCase(strIp))) {
					ip = strIp;
					break;
				}
			}
		}
		return ip;
	}

	/**
	 * 
	 * @param url
	 *            调用的url
	 * @param data
	 *            传递的参数
	 * @param charset
	 *            转换的字符集
	 * @return
	 */
	public static Map<String, String> URLConnection(String url, Map<String, String> data, String charset) {
		Map<String, String> retMap = new HashMap<String, String>();
		try {
			if (null != data) {
				StringBuilder pStr = new StringBuilder();
				Iterator iterator = data.entrySet().iterator();
				for (Map.Entry<String, String> m : data.entrySet()) {
					if (null != m.getValue()) {
						pStr.append(m.getKey()).append("=").append(java.net.URLEncoder.encode(m.getValue(), charset))
								.append("&");
					}
				}
				pStr.replace(pStr.lastIndexOf("&"), pStr.lastIndexOf("&") + 1, "");
				url = url + "?" + pStr.toString();
			} else {

			}
			retMap.put("url", url);

			String rtn = retry(url, 3);
			retMap.put("retStr", rtn);
		} catch(ConnectException e) {
			retMap.put("retStr", e.getLocalizedMessage());
		} catch (Exception e) {
			retMap.put("retStr", e.getLocalizedMessage());
		}

		return retMap;
	}
	
	private static String retry(String url, int retry_times) throws MalformedURLException, IOException{
		String result = null;
		for(int i=retry_times; i>=0; i--){
			try {
				result = send(url);
				break;
			} catch (ConnectException e) {
				logger.warn(String.format("url[%s] has exception %s, retrying...", url, e.getMessage()));
				if(i==0){
					throw e;
				}
				continue;
			}
		}
		return result;
	}

	private static String send(String url)
			throws MalformedURLException, IOException {
	
		StringBuffer result = new StringBuffer();
		URL getUrl = new URL(url);

		// 根据拼凑的URL，打开连接，URL.openConnection函数会根据URL的类型，
		// 返回不同的URLConnection子类的对象，这里URL是一个http，因此实际返回的是HttpURLConnection
		HttpURLConnection connection = (HttpURLConnection) getUrl.openConnection();
		// 进行连接，但是实际上get request要在下一句的connection.getInputStream()函数中才会真正发到
		// 服务器
		connection.connect();
		// 取得输入流，并使用Reader读取
		BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));

		while (reader.ready()) {
			result.append(reader.readLine());
		}
		// result = reader.readLine();
		reader.close();
		// 断开连接
		connection.disconnect();
		return result.toString();
	
	}

	/**
	 * 
	 * @param url
	 *            调用的url
	 * @param data
	 *            传递的参数
	 * @return
	 */
	public static String easyURLConnection(String url, Map<String, String> data) {
		if (null != data) {
			StringBuilder pStr = new StringBuilder();
			Iterator iterator = data.entrySet().iterator();
			for (Map.Entry<String, String> m : data.entrySet()) {
				if (null != m.getValue()) {
					pStr.append(m.getKey()).append("=").append(m.getValue()).append("&");
				}
			}
			pStr.replace(pStr.lastIndexOf("&"), pStr.lastIndexOf("&") + 1, "");
			url = url + "?" + pStr.toString();
		} else {

		}

		StringBuffer result = new StringBuffer();
		try {
			URL getUrl = new URL(url);

			// 根据拼凑的URL，打开连接，URL.openConnection函数会根据URL的类型，
			// 返回不同的URLConnection子类的对象，这里URL是一个http，因此实际返回的是HttpURLConnection
			HttpURLConnection connection = (HttpURLConnection) getUrl.openConnection();
			// 进行连接，但是实际上get request要在下一句的connection.getInputStream()函数中才会真正发到
			// 服务器
			connection.connect();
			// 取得输入流，并使用Reader读取
			BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));

			while (reader.ready()) {
				result.append(reader.readLine());
			}
			// result = reader.readLine();
			reader.close();
			// 断开连接
			connection.disconnect();

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result.toString();
	}

	/**
	 * 
	 * @param serviceUrl
	 *            调用的url
	 * @param parameter
	 *            参数
	 * @param restMethod
	 *            {@link NetworkUtil.POST} {@link NetworkUtil.PUT}
	 *            {@link NetworkUtil.GET}
	 * @return
	 */
	public static HashMap<String, String> URLConnectionWithMethod(String serviceUrl, String parameter, String restMethod) {
		try {
			URL url = new URL(serviceUrl);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod(restMethod);
			con.setConnectTimeout(300000);
			con.addRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=UTF-8");
			con.setDoOutput(true);
			OutputStream os = con.getOutputStream();
			os.write(parameter.getBytes("UTF-8"));
			os.close();

			HashMap<String, String> result = new HashMap<String, String>();
			result.put("code", String.valueOf(con.getResponseCode()));
			result.put("msg", con.getResponseMessage());

			// 读取返回信息
			InputStream inputStream = con.getInputStream();
			BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream, "UTF-8"));
			String strMessage;
			StringBuffer buffer = new StringBuffer();
			while ((strMessage = reader.readLine()) != null) {
				buffer.append(strMessage);
			}
			result.put("result", buffer.toString());
			return result;
		} catch (Exception e) {
			HashMap<String, String> result = new HashMap<String, String>();
			result.put("code", "0");
			result.put("msg", e.getMessage());
			result.put("result", "Failed,Pls Check your url to verify it right");
			return result;
		}
	}

	
	
	/**
	 * 
	 * @param serviceUrl
	 *            调用的url
	 * @param parameter
	 *            参数
	 * @param restMethod
	 *            {@link NetworkUtil.POST} {@link NetworkUtil.PUT}
	 *            {@link NetworkUtil.GET}
	 * @return
	 */
	public static HashMap<String, String> connectionWithMethodForFomat(String serviceUrl, Map<String,Object> parameter, String restMethod) {
		try {
			URL url = new URL(serviceUrl);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod(restMethod);
			con.setConnectTimeout(300000);
			con.addRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=UTF-8");
			con.setDoOutput(true);
			//OutputStream os = con.getOutputStream();
			//os.write(parameter.getBytes("UTF-8"));
			//os.close();

			//把建立的http的连接流返回给PrintWriter
			try (PrintWriter out = new PrintWriter(con.getOutputStream())) {
			
				boolean first = true;
				for (Map.Entry<String, Object> pair : parameter.entrySet()) {
					if (first)
						first = false;
					else
						out.print('&');
					String name = pair.getKey().toString();
					String value = pair.getValue().toString();
					out.print(name);
					out.print('=');
					out.print(URLEncoder.encode(value, "UTF-8"));
				}
				
			}
			
			HashMap<String, String> result = new HashMap<String, String>();
			result.put("code", String.valueOf(con.getResponseCode()));
			result.put("msg", con.getResponseMessage());

			// 读取返回信息
			InputStream inputStream = con.getInputStream();
			BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream, "UTF-8"));
			String strMessage;
			StringBuffer buffer = new StringBuffer();
			while ((strMessage = reader.readLine()) != null) {
				buffer.append(strMessage);
			}
			result.put("result", buffer.toString());
			return result;
		} catch (Exception e) {
			HashMap<String, String> result = new HashMap<String, String>();
			result.put("code", "0");
			result.put("msg", e.getMessage());
			result.put("result", "Failed,Pls Check your url to verify it right");
			return result;
		}
	}
	
	
	
	/**
	 * 获取ip地址
	 */
	public static String getClientIpAddress(HttpServletRequest request) {
		for (String header : HEADERS_TO_TRY) {
			String ip = request.getHeader(header);
			if (ip != null && ip.length() != 0 && !"unknown".equalsIgnoreCase(ip)) {
				return ip;
			}
		}
		return request.getRemoteAddr();
	}
	
	/**
	 * 获取
	 * @param request
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public static HashMap<String, Object> getParameterNames(HttpServletRequest request) throws UnsupportedEncodingException {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		Enumeration enums = request.getParameterNames();
		while (enums.hasMoreElements()) {
			String pName = (String) enums.nextElement();
			String pValue = request.getParameter(pName);
			pValue = URLDecoder.decode(pValue, "UTF-8");
			paramMap.put(pName, pValue);
		}
		return paramMap;
	}
	
    /**
* 将url参数转换成map
* @param param aa=11&bb=22&cc=33
* @return
*/
public static Map<String, Object> getUrlParams(String param) {
	Map<String, Object> map = new HashMap<String, Object>(0);
	if (StringUtil.isEmpty(param)) {
		return map;
	}
	String[] params = param.split("&");
	for (int i = 0; i < params.length; i++) {
		String[] p = params[i].split("=");
		if (p.length == 2) {
			map.put(p[0], p[1]);
		}
	}
	return map;
}

/**
* 将map转换成url
* @param map
* @return
*/
public static String getUrlParamsByMap(Map<String, Object> map) {
	if (map == null) {
		return "";
	}
	StringBuffer sb = new StringBuffer();
	for (Map.Entry<String, Object> entry : map.entrySet()) {
		sb.append(entry.getKey() + "=" + entry.getValue());
		sb.append("&");
	}
	String s = sb.toString();
	return s;
}
}
