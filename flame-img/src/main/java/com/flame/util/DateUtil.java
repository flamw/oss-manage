package com.flame.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * 日期工具类
 * @version 1.0
 * 
 */
public class DateUtil   {
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		System.out.println(DateUtil.dateFormat(new Date(), DateUtil.DF_YYMMDDHHMISS));
	}
	
	  public static final String DF_MM_DD = "MM月dd日";
	  public static final String DF_YYYY_MM = "yyyy-MM";
	  public static final String DF_YYYY_MM_DD = "yyyy-MM-dd";
	  public static final String DF_YYYY_MM_DD2 = "yyyyMMdd";
	  public static final String DF_HH_MM = "HH:mm";
	  public static final String DF_HH = "HH";
	  public static final String DF_YYYYMM = "yyyyMM";
	  public static final String DF_YYYYMMDD = "yyyyMMdd";
	  public static final String DF_YYYY = "yyyy";
	  public static final String DF_MM = "MM";
	  public static final String DF_DD = "dd";
	  public static final String DF_YY_MM_DD_HH_MI = "yyyy-MM-dd HH:mm";
	  public static final String DF_YY_MM_DD_HH_MI_SS = "yyyy-MM-dd HH:mm:ss";
	  public static final String DF_YYMMDDHHMISS = "yyyyMMddHHmmss";
	  public static final String DF_YYMMDDHH = "yyyyMMddHH";
	  public static SimpleDateFormat DATE_FORMAT_MM_DD = new SimpleDateFormat("MM月dd日");
	  public static SimpleDateFormat DATE_FORMAT_YYYY_MM = new SimpleDateFormat("yyyy-MM");
	  public static SimpleDateFormat DATE_FORMAT_YYYY_MM_DD = new SimpleDateFormat("yyyy-MM-dd");
	  public static SimpleDateFormat DATE_FORMAT_YYYY_MM_DD2 = new SimpleDateFormat("yyyyMMdd");
	  public static SimpleDateFormat DATE_FORMAT_HH_MM = new SimpleDateFormat("HH:mm");
	  public static SimpleDateFormat DATE_FORMAT_HH = new SimpleDateFormat("HH");
	  public static SimpleDateFormat DATE_FORMAT_YYYYMM = new SimpleDateFormat("yyyyMM");
	  public static SimpleDateFormat DATE_FORMAT_YYYYMMDD = new SimpleDateFormat("yyyyMMdd");
	  public static SimpleDateFormat DATE_FORMAT_YYYY = new SimpleDateFormat("yyyy");
	  public static SimpleDateFormat DATE_FORMAT_MM = new SimpleDateFormat("MM");
	  public static SimpleDateFormat DATE_FORMAT_DD = new SimpleDateFormat("dd");
	  public static SimpleDateFormat DATE_FORMAT_YY_MM_DD_HH_MI = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	  public static SimpleDateFormat DATE_FORMAT_YY_MM_DD_HH_MI_SS = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	  public static java.sql.Date parseDate(String dateStr, String format)
	  {
	    if (dateStr == null)
	      return null;
	    try
	    {
	      SimpleDateFormat dateFormat = new SimpleDateFormat(format);
	      return new java.sql.Date(dateFormat.parse(dateStr).getTime());
	    } catch (Exception e) {
	      e.printStackTrace();
	    }return null;
	  }

	  public static java.sql.Date parseDate(String dateStr)
	  {
	    if (dateStr == null)
	      return null;
	    try
	    {
	      SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	      return new java.sql.Date(dateFormat.parse(dateStr).getTime());
	    } catch (Exception e) {
	      e.printStackTrace();
	    }return null;
	  }

	  public static java.sql.Date parseDate(java.util.Date date)
	  {
	    try
	    {
	      return new java.sql.Date(date.getTime());
	    } catch (Exception e) {
	      e.printStackTrace();
	    }return null;
	  }

	  public static java.util.Date parseUtilDate(String dateStr, String format)
	  {
	    try {
	      SimpleDateFormat dateFormat = new SimpleDateFormat(format);
	      return new java.util.Date(dateFormat.parse(dateStr).getTime());
	    } catch (Exception e) {
	      e.printStackTrace();
	    }return null;
	  }

	  public static java.util.Date parseUtilDate(Integer dateId)
	  {
	    try {
	      String dateStr = String.valueOf(dateId);
	      String format = "yyyyMMdd".substring(0, String.valueOf(dateId).length());
	      SimpleDateFormat dateFormat = new SimpleDateFormat(format);
	      return new java.util.Date(dateFormat.parse(dateStr).getTime());
	    } catch (Exception e) {
	      e.printStackTrace();
	    }return null;
	  }

	  public static java.sql.Date parseDate(Integer dateId)
	  {
	    try {
	      String dateStr = String.valueOf(dateId);
	      String format = "yyyyMMdd".substring(0, String.valueOf(dateId).length());
	      SimpleDateFormat dateFormat = new SimpleDateFormat(format);
	      return new java.sql.Date(dateFormat.parse(dateStr).getTime());
	    } catch (Exception e) {
	      e.printStackTrace();
	    }return null;
	  }

	  public static java.util.Date sqlDate2UtilDate(java.sql.Date sqlDate)
	  {
	    try
	    {
	      return new java.util.Date(sqlDate.getTime());
	    } catch (Exception e) {
	      e.printStackTrace();
	    }
	    return null;
	  }

	  public static String utilDate2Str(java.util.Date date) {
	    return dateFormatYYMMDD(date);
	  }

	  public static String sqlDate2str(java.sql.Date sqlDate) {
	    return dateFormatYYMMDD(sqlDate2UtilDate(sqlDate));
	  }

	  public static java.sql.Date trunc(java.util.Date date, String format)
	  {
	    SimpleDateFormat dateFormat = new SimpleDateFormat(format);
	    return parseDate(dateFormat.format(date), format);
	  }

	  public static java.util.Date getCurrentTime()
	  {
	    return parseDate(DATE_FORMAT_YY_MM_DD_HH_MI_SS.format(
	      new java.util.Date()), "yyyy-MM-dd HH:mm:ss");
	  }

	  public static java.util.Date getCurrentDay()
	  {
	    return parseDate(DATE_FORMAT_YYYY_MM_DD.format(
	      new java.util.Date()), "yyyy-MM-dd");
	  }

	  public static java.util.Date getCurrentMonth()
	  {
	    return parseDate(DATE_FORMAT_YYYY_MM.format(
	      new java.util.Date()), "yyyy-MM");
	  }

	  public static java.sql.Date getLastYear(Integer lastN)
	  {
	    int year = Calendar.getInstance().get(1);
	    year -= lastN.intValue();
	    return parseDate(String.valueOf(year), "yyyy");
	  }

	  public static java.sql.Date getLastYear(java.util.Date date, Integer lastN)
	  {
	    Calendar c = Calendar.getInstance();
	    c.setTime(date);
	    c.add(1, -lastN.intValue());
	    return parseDate(c.getTime());
	  }



	  public static String getWeekByDate(java.util.Date date)
	  {
	    String week = "";

	    Calendar cal = Calendar.getInstance();
	    cal.setTime(date);
	    int dayOfWeek = cal.get(7);

	    switch (dayOfWeek) {
	    case 1:
	      week = "星期日";
	      break;
	    case 2:
	      week = "星期一";
	      break;
	    case 3:
	      week = "星期二";
	      break;
	    case 4:
	      week = "星期三";
	      break;
	    case 5:
	      week = "星期四";
	      break;
	    case 6:
	      week = "星期五";
	      break;
	    case 7:
	      week = "星期六";
	    }

	    return week;
	  }


	  public static java.util.Date getNow()
	  {
	    java.util.Date now = new java.util.Date();
	    return new java.util.Date(now.getTime());
	  }

	  public static String toString(java.util.Date d, String format)
	  {
	    return dateFormat(d, format);
	  }

	  public static String toString(java.util.Date d)
	  {
	    return dateFormat(d, "yyyy-MM-dd");
	  }

	  public static String dateFormat(java.util.Date date, String format)
	  {
	    SimpleDateFormat dateFormat = new SimpleDateFormat(format);
	    return dateFormat.format(date);
	  }

	  public static String dateFormatMMDD(java.util.Date date)
	  {
	    return DATE_FORMAT_MM_DD.format(date);
	  }


	  public static String dateFormatYYMM(java.util.Date date)
	  {
	    if (date == null) return "";
	    return DATE_FORMAT_YYYY_MM.format(date);
	  }

	  public static String dateFormatYYMMDD(java.util.Date date)
	  {
	    if (date == null) return "";
	    return DATE_FORMAT_YYYY_MM_DD.format(date);
	  }

	  public static String dateFormatHHMM(java.util.Date date)
	  {
	    return DATE_FORMAT_HH_MM.format(date);
	  }

	  public static String dateFormatHH(java.util.Date date)
	  {
	    return DATE_FORMAT_HH.format(date);
	  }

	  public static String dateFormatDD(java.util.Date date)
	  {
	    return Integer.valueOf(DATE_FORMAT_DD.format(date)).toString();
	  }

	  public static String dateFormatQua(java.util.Date date)
	  {
	    Calendar calendar = Calendar.getInstance();
	    calendar.setTime(date);
	    int month = calendar.get(2) + 1;
	    String reString = "";
	    if (month <= 3)
	      reString = "第一季度";
	    else if (month <= 6)
	      reString = "第二季度";
	    else if (month <= 9)
	      reString = "第三季度";
	    else if (month <= 12) {
	      reString = calendar.get(0) + "年第四季度";
	    }
	    return reString;
	  }

	  public static String translateFormat(String s)
	  {
	    return translateFormat(s, "yyyy-MM-dd");
	  }

	  public static String translateFormat(String s, String format)
	  {
	    return DATE_FORMAT_YYYY_MM_DD2.format(parseDate(s, format));
	  }

	  public static String getYear(java.util.Date date)
	  {
	    return DATE_FORMAT_YYYY.format(date);
	  }

	  public static String getYearMonth(java.util.Date date)
	  {
	    return DATE_FORMAT_YYYYMM.format(date);
	  }

	  public static String getYearMonthDay(java.util.Date date)
	  {
	    return DATE_FORMAT_YYYYMMDD.format(date);
	  }

	  public static String getMonth(java.util.Date date)
	  {
	    return Integer.valueOf(DATE_FORMAT_MM.format(date)).toString();
	  }

	  public static String getMonth2(java.util.Date date) {
	    return DATE_FORMAT_MM.format(date);
	  }

	  public static String getDay(java.util.Date date)
	  {
	    return Integer.valueOf(DATE_FORMAT_DD.format(date)).toString();
	  }

	  public static String getCurrentYear()
	  {
	    return DATE_FORMAT_YYYY.format(new java.util.Date());
	  }

	  public static Integer getCurrentYearId()
	  {
	    Calendar calendar = Calendar.getInstance();
	    return Integer.valueOf(calendar.get(1));
	  }

	  public static Integer getCurrentMonthId()
	  {
	    Calendar calendar = Calendar.getInstance();
	    return Integer.valueOf(calendar.get(2) + 1);
	  }

	  public static Integer getCurrentDateId()
	  {
	    Calendar calendar = Calendar.getInstance();
	    return Integer.valueOf(calendar.get(5));
	  }
	  
	  /**
		 * 计算 second 秒后的时间
		 * 
		 * @param date
		 * @param second
		 * @return
		 */
		public static java.util.Date addSecond(java.util.Date date, int second) {
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(date);
			;
			calendar.add(Calendar.SECOND, second);
			return calendar.getTime();
		}

		/**
		 * 计算 minute 分钟后的时间
		 * 
		 * @param date
		 * @param minute
		 * @return
		 */
		public static java.util.Date addMinute(java.util.Date date, int minute) {
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(date);
			calendar.add(Calendar.MINUTE, minute);
			return calendar.getTime();
		}

		/**
		 * 计算 hour 小时后的时间
		 * 
		 * @param date
		 * @param hour
		 * @return
		 */
		public static java.util.Date addHour(java.util.Date date, int hour) {
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(date);
			calendar.add(Calendar.HOUR, hour);
			return calendar.getTime();
		}
		
		/**
		 * 判断日期格式，并转化为时间
		 * 
		 * @param dateStr
		 * 		带时分秒 不带时分秒
		 * @return
		 */
	public static java.util.Date parseUtilDateByString(String dateStr) {
		try {
			SimpleDateFormat dateFormat = new SimpleDateFormat(DF_YY_MM_DD_HH_MI_SS);
			return new java.util.Date(dateFormat.parse(dateStr).getTime());
		} catch (Exception e) {
			try {
				SimpleDateFormat dateFormat2 = new SimpleDateFormat(DF_YYYY_MM_DD);
				return new java.util.Date(dateFormat2.parse(dateStr).getTime());
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return null;
	}
}
