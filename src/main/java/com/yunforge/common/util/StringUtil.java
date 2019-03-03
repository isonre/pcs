package com.yunforge.common.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.net.URL;
import java.sql.Blob;
import java.sql.Clob;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.StringTokenizer;

import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;
//import oracle.sql.BLOB;
//import oracle.sql.CLOB;



import org.springframework.data.domain.Page;
import org.springframework.data.domain.Sort;

import com.yunforge.common.bean.GridBean;

public class StringUtil {
	
	public static double add(Object ob1,Object ob2) {
		try {
			
			return Double.parseDouble(ob1.toString()) + Double.parseDouble(ob2.toString());
		} catch(Exception e) {
			
		}
		return 0;
	}
	
	public static boolean isNum(Object ob) {
		if(ob == null) {
			return false;
		}
		try {
			Double.parseDouble(ob.toString());
		} catch(Exception e) {
			return false;
		}
		return true;
	}
	/**
	 * 获取年份下拉框
	 * 
	 * @return
	 */
	public static List<String> getYear() {
		Calendar c = Calendar.getInstance();
		int year = c.get(Calendar.YEAR);

		List<String> yearList = new ArrayList<String>();
		for (int i = year - 15; i <= year + 1; i++) {
			yearList.add(i + "");
		}
		return yearList;
	}

	/**
	 * 获取月份下拉框
	 * 
	 * @return
	 */
	public static List<String> getMonth() {
		List<String> monthList = new ArrayList<String>();
		for (int i = 1; i <= 12; i++) {
			monthList.add(i + "");
		}
		return monthList;
	}

	public static void setCode(HttpServletRequest request,
			HttpServletResponse response) {
		try {

			String Agent = request.getHeader("User-Agent");
			StringTokenizer st = new StringTokenizer(Agent, ";");
			st.nextToken();
			String userbrowser = st.nextToken();

			if (userbrowser.indexOf("MSIE") != -1) {
				response.setCharacterEncoding("gbk");
			} else {
				response.setCharacterEncoding("utf-8");
			}
		} catch (Exception e) {

		}
	}

	public static String getString(HttpServletRequest request, String str) {
		try {

			String Agent = request.getHeader("User-Agent");
			StringTokenizer st = new StringTokenizer(Agent, ";");
			st.nextToken();
			String userbrowser = st.nextToken();
			// System.out.println("==========="+userbrowser+"==============");
			if (userbrowser.indexOf("MSIE") != -1
					|| Agent.indexOf("rv:11") != -1) {
				return new String(str.getBytes("iso-8859-1"), "gbk");
			} else {
				return new String(str.getBytes("iso-8859-1"), "utf-8");
			}
		} catch (Exception e) {

		}
		return "";
	}

	/**
	 * 封装分页数据
	 * 
	 * @param page
	 * @param p
	 * @return
	 */
	public static GridBean pageToGrid(Page page, Integer p) {

		List noticeList = page.getContent();
		Integer records = (int) page.getTotalElements();
		Integer totalPages = page.getTotalPages();
		Integer currPage = Math.min(totalPages, p);

		GridBean grid = new GridBean();
		grid.setRecords(records);
		grid.setTotal(totalPages);
		grid.setPage(currPage);
		grid.setRows(noticeList);

		return grid;
	}

	/**
	 * 封装排序方法
	 * 
	 * @param sidx
	 * @param sord
	 * @param defaultOrderCol
	 * @return
	 */
	public static Sort createSort(String sidx, String sord,
			String defaultOrderCol) {

		Sort sort = null;
		if (StringUtil.notEmpty(sidx)) {
			if (sord.equals("asc")) {
				sort = new Sort(new Sort.Order(Sort.Direction.ASC, sidx));
			} else {
				sort = new Sort(new Sort.Order(Sort.Direction.DESC, sidx));
			}
		} else {
			sort = new Sort(
					new Sort.Order(Sort.Direction.DESC, defaultOrderCol));
		}
		return sort;
	}

	/**
	 * 获取上传路径
	 * 
	 * @param request
	 * @return
	 */
	public static String getUploadPath(HttpServletRequest request) {

		String uploadPath = null;
		try {

			String filePath = request.getServletContext().getRealPath("/");
			FileInputStream fis = new FileInputStream(filePath
					+ "/WEB-INF/classes/upload.properties");

			Properties p = new Properties();
			p.load(fis);
			uploadPath = p.getProperty("upload.filepath");

			fis.close();
		} catch (Exception e) {

		}
		return uploadPath;
	}
	
	public static void write(HttpServletResponse response,JSONObject jsonObject) {

		PrintWriter write = null;  
	    try {  
			PrintWriter pw = response.getWriter();
	        //response.setContentType("application/text;charset=UTF-8");  
		    response.setContentType("text/html;charset=UTF-8");  
		    response.setHeader("Pragma", "No-cache");  
		    response.setHeader("Cache-Control", "no-cache");  
		    response.setDateHeader("Expires", 0);  
	        write = response.getWriter();  
	        write.write(jsonObject.toString());
//	        write.write("{\"success\":\"true\",\"message\":\"true\"}");  
	        write.flush();  
	    } catch (Exception e) {  
//	        throw new Exception("ajax write error" + e.getMessage());  
	    	e.printStackTrace();
	    } finally {  
	        response = null;  
	        if (write != null)  
	            write.close();  
	            write = null;  
	    }
	}

	/**
	 * 下载文件
	 * 
	 * @param response
	 * @param path
	 * @param filename
	 */
	public static void downloadFile(HttpServletResponse response, String path,
			String filename) {
		try {

			byte[] b = new byte[1024];
			int i = -1;

			response.setContentType("application/octet-stream; charset=GBK");
			response.addHeader("Content-Disposition", "attachment; filename=\""
					+ new String(filename.getBytes("gb2312"), "iso8859-1")
					+ "\"");

			OutputStream os = response.getOutputStream();
			FileInputStream fis = new FileInputStream(path);
			while ((i = fis.read(b, 0, 1024)) != -1) {
				os.write(b, 0, i);
			}
			fis.close();
			os.close();

		} catch (Exception e) {

		}
	}

	/**
	 * 保存文件
	 * 
	 * @param request
	 * @param filepath
	 * @param name
	 * @param bytes
	 */
	public void saveFile(HttpServletRequest request, String filepath,
			String name, byte[] bytes) {
		try {

			String uploadPath = StringUtil.getUploadPath(request);
			File file = new File(uploadPath + filepath);
			if (!file.isDirectory()) {
				file.mkdirs();
			}

			String str = uploadPath + filepath + "/" + name;
			FileOutputStream fos = new FileOutputStream(str);
			fos.write(bytes);
			fos.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 截取字符串
	 * 
	 * @param str
	 * @param begin
	 * @param end
	 * @return
	 */
	public static String subStr(Object str, int begin, int end) {
		try {
			return str.toString().substring(begin, end);
		} catch (Exception e) {

		}
		return str.toString();
	}

	/**
	 * 获取字符串
	 * 
	 * @param ob
	 * @return
	 */
	public static String getString(Object ob) {
		if (ob == null) {
			return null;
		}
		return ob.toString();
	}

	/**
	 * 获取BigDecimal
	 * 
	 * @param ob
	 * @param failValue
	 * @return
	 */
	public static BigDecimal getDecimal(Object ob, double failValue) {
		try {
			double d = Double.parseDouble(ob.toString());
			return new BigDecimal(d);
		} catch (Exception e) {

		}
		return new BigDecimal(failValue);
	}

	/**
	 * 获取BigDecimal
	 * 
	 * @param ob
	 * @param failValue
	 * @return
	 */
	public static BigDecimal getDecimal(Object ob, double failValue,int point) {
		try {
			double d = Double.parseDouble(ob.toString());
			BigDecimal result = new BigDecimal(d);
			result = result.setScale(point,BigDecimal.ROUND_HALF_UP);
			return result;
		} catch (Exception e) {

		}
		return new BigDecimal(failValue);
	}
	
	/**
	 * 获取blob
	 * 
	 * @param ob
	 * @return
	 */
	public static Blob getStrByBlob(Object ob) {
		if (ob == null) {
			return null;
		}
		return (Blob) ob;
	}

	/**
	 * 获取clob
	 * 
	 * @param ob
	 * @return
	 */
	public static Clob getStrByClob(Object ob) {
		if (ob == null) {
			return null;
		}
		return (Clob) ob;
	}

	public static boolean isInt(Object ob) {
		try {
			Integer.parseInt(ob.toString());
			return true;
		} catch (Exception e) {

		}
		return false;
	}

	/**
	 * 获取int
	 * 
	 * @param ob
	 * @param failValue
	 * @return
	 */
	public static int getInt(Object ob, int failValue) {
		try {
			return Integer.parseInt(ob.toString());
		} catch (Exception e) {

		}
		return failValue;
	}

	/**
	 * 获取日期
	 * 
	 * @param ob
	 * @return
	 */
	public static String getYMD(Date ob) {
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			return sdf.format(ob);
		} catch (Exception e) {

		}
		return null;
	}

	public static String getTaskNoByDate(Date date) {
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			return sdf.format(date);
		} catch (Exception e) {

		}
		return null;
	}

	/**
	 * 获取日期
	 * 
	 * @param ob
	 * @return
	 */
	public static String getYMDHMS(Date ob) {
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			return sdf.format(ob);
		} catch (Exception e) {

		}
		return null;
	}

	/**
	 * 获取日期
	 * 
	 * @param ob
	 * @return
	 */
	public static Date getYMD(Object ob) {
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			return sdf.parse(ob.toString());
		} catch (Exception e) {

		}
		return null;
	}

	public static String getPrevDate(String str) {
		try {

			Date date = getDate(str);
			date.setDate(date.getDate() - 1);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			return sdf.format(date);
		} catch (Exception e) {

		}
		return str;
	}

	public static Date getPrevYear(String str) {
		Date endDate = StringUtil.getDate(str);
		Calendar c = Calendar.getInstance();
		c.setTime(endDate);
		c.set(Calendar.YEAR, c.get(Calendar.YEAR) - 1);
		return c.getTime();
	}

	public static Date getDate(String dateStr) {
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			return sdf.parse(dateStr);
		} catch (Exception e) {

		}

		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			return sdf.parse(dateStr);
		} catch (Exception e) {

		}

		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH");
			return sdf.parse(dateStr);
		} catch (Exception e) {

		}

		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			return sdf.parse(dateStr);
		} catch (Exception e) {

		}

		return null;
	}

	public static String getYYYYMMDD() {
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			return sdf.format(new Date());
		} catch (Exception e) {

		}
		return null;
	}

	/**
	 * 获取日期
	 */
	public static Timestamp getTimestap(Date date) {
		try {
			return new Timestamp(date.getTime());
		} catch (Exception e) {

		}
		return null;
	}

	/**
	 * 获取日期
	 * 
	 * @param ob
	 * @return
	 */
	public static Date getYMDHMS(Object ob) {
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			return sdf.parse(ob.toString());
		} catch (Exception e) {

		}
		return null;
	}
	
	/**
	 * 数组转List
	 * @param array
	 * @return
	 */
	public static List<String> array2List(String[] array) {
		List<String> list = new ArrayList();
		for(int i = 0;i < array.length;i++) {
			list.add(array[i]);
		}
		return list;
	}

	/**
	 * 获取数组中到一个
	 * 
	 * @param values
	 * @param index
	 * @return
	 */
	public static String getStr(String[] values, int index) {
		try {
			return values[index];
		} catch (Exception e) {

		}
		return null;
	}

	/**
	 * 是否为空
	 * 
	 * @param str
	 * @return
	 */
	public static boolean isEmpty(Object str) {
		if (str == null || "".equals(str.toString())) {
			return true;
		}
		return false;
	}

	/**
	 * 判断非空
	 * 
	 * @param str
	 * @return
	 */
	public static boolean notEmpty(Object str) {
		return !isEmpty(str);
	}

	public static int getCount(List list) {
		int count = 0;
		if (list.size() != 0) {
			Object ob = list.get(0);
			if (ob instanceof Long) {
				Long l = (Long) ob;
				return l.intValue();
			}
			BigDecimal gd = (BigDecimal) ob;
			count = gd.intValue();
		}
		return count;
	}

	/**
	 * 去掉末尾到0
	 * 
	 * @param str
	 * @return
	 */
	public static String replaceEnd0(String str) {
		while (str.endsWith("0")) {
			str = str.substring(0, str.length() - 1);
		}

		// 百色451000，截取后应该是4510，而不是451
		if (str.length() == 3) {
			str += "0";
		}
		return str;
	}

	public static boolean isCity(String code) {
		int count = 0;
		while (code.endsWith("0")) {
			code = code.substring(0, code.length() - 1);
			count++;
		}
		if (count != 2 && count != 3) {
			return false;
		}
		return true;
	}

	public static boolean isCounty(String code) {
		int count = 0;
		while (code.endsWith("0")) {
			code = code.substring(0, code.length() - 1);
			count++;
		}
		if (count > 1) {
			return false;
		}
		return true;
	}

	public static boolean isArea(String code) {
		int count = 0;
		while (code.endsWith("0")) {
			code = code.substring(0, code.length() - 1);
			count++;
		}
		if (count != 4) {
			return false;
		}
		return true;
	}

	/**
	 * 根据数组拼接字符串，用于in语句
	 */
	public static String getStr(String[] array) {
		StringBuffer str = new StringBuffer();
		for (int i = 0; i < array.length; i++) {
			str.append("'").append(array[i]).append("',");
		}
		String str1 = str.toString();
		return str1.substring(0, str1.length() - 1);
	}

	// public Connection getCon() {
	// getCurrentClassPath();
	// }

	public static void test() throws Exception {

		// int i = 2;
		// int j = -3;
		// System.out.println(i+j);

		// String cityNum = "";
		// String cityName = "";
		// String areaNum = "";
		// String areaName = "";
		// Class.forName("oracle.jdbc.OracleDriver");
		// Connection con =
		// DriverManager.getConnection("jdbc:oracle:thin:@127.0.0.1:1521:orcl",
		// "agrims", "agrims");
		//
		// InputStreamReader isr = new InputStreamReader(new
		// FileInputStream("C:/Users/Administrator/Desktop/ddd.txt"),"gbk");
		// // FileReader fr = new
		// FileReader("C:/Users/Administrator/Desktop/ddd.txt");
		// BufferedReader br = new BufferedReader(isr);
		// String str = null;
		// while((str = br.readLine()) != null) {
		// // System.out.println(str);
		//
		// if(str.indexOf("=") != -1) {
		// cityNum = str.split("=")[0];
		// cityName = str.split("=")[1];
		//
		// Statement st = con.createStatement();
		// ResultSet rs =
		// st.executeQuery(" select div_code from sys_division where div_name like '%"
		// +cityName+ "%' ");
		// if(rs.next()) {
		// String div_code = rs.getString(1);
		// System.out.println("update sys_division set wordnum = '" + cityNum +
		// "-" + "' where div_code = '" +div_code+ "';");
		// } else {
		// System.out.println(cityName);
		// }
		// rs.close();
		//
		// } else {
		//
		// areaNum = str.split("\\.")[0];
		// areaName = str.split("\\.")[1];
		//
		// Statement st = con.createStatement();
		// ResultSet rs =
		// st.executeQuery(" select div_code from sys_division where div_name like '%"
		// +areaName+ "%' ");
		// if(rs.next()) {
		// String div_code = rs.getString(1);
		// // System.out.println(cityNum + areaNum + div_code);
		// System.out.println("update sys_division set wordnum = '" + cityNum +
		// "-" + areaNum + "-" + "' where div_code = '" +div_code+ "';");
		// } else {
		// System.out.println(areaName);
		// }
		// rs.close();
		//
		// }
		// // Statement st = con.createStatement();
		// // System.out.println(cityNum + "-" + areaNum);
		// }
		// br.close();
		// isr.close();
		// // fr.close();
		//
		// // st.executeQuery("select * from dual");
		//
		//
		//
		// con.close();

		// System.out.println(StringUtil.replaceEnd0("450100d20"));

		// Calendar c = Calendar.getInstance();
		// c.set(Calendar.YEAR, 2014);
		// c.set(Calendar.MONTH, 0);
		// c.set(Calendar.DAY_OF_MONTH, 1);
		// System.out.println(c.getTime());

		// System.out.println(isCity("451400"));

		// System.out.println(getPrevYearNo("2015xyzsfa"));

		java.net.URL url = new java.net.URL(
				"http://localhost:8080/agrims/office/task/saveTaskByEthink?reportNum=j");
		java.net.HttpURLConnection urlConnection = (java.net.HttpURLConnection) url
				.openConnection();
		urlConnection.setRequestMethod("GET");
		urlConnection.connect();

		java.io.InputStream inputStream = urlConnection.getInputStream();
		inputStream.close();
		urlConnection.disconnect();
	}
	
	public static void test1() throws Exception {
		
		/*
		450903  福绵县
		451124  平桂区
		451281  宜州市
		*/
		Class.forName("oracle.jdbc.OracleDriver");
		Connection con = DriverManager.getConnection("jdbc:oracle:thin:@192.168.50.30:1521:orcl", "agrims", "agrims1qazxsw2");
		Statement st = con.createStatement();
		
		String file = "f:/a.txt";
		InputStreamReader isr = new InputStreamReader(new FileInputStream(file),"gbk");
		BufferedReader br = new BufferedReader(isr);
		String str = null;
		while((str = br.readLine()) != null) {
			
			ResultSet rs = st.executeQuery(" select div_code from sys_division where div_name like '%" +str+ "%' ");
			if(rs.next()) {
				String div_code = rs.getString("div_code");
				System.out.println(div_code);
			} else {
				System.out.println(str);
			}
			rs.close();
		}
		br.close();
		isr.close();
	}
	

	public static String getPrevYearNo(String no) {
		try {

			String year = no.substring(0, 4);
			String last = no.substring(4, no.length());
			return (Integer.parseInt(year) - 1) + last;
		} catch (Exception e) {

		}
		return no;
	}

	public String getCurrentClassPath() {
		String classname = this.getClass().getName();

		// get class
		String classname_resource = "/" + classname.replace('.', '/')
				+ ".class";

		// get class URL
		URL url = this.getClass().getResource(classname_resource);
		String urlPath = url.getPath();
		File classFile = new File(urlPath);
		String classPath = classFile.getPath();
		// System.out.println (classname + "'s path is " + classPath);
		return classPath;
	}

	public static String getInStr(String str) {
		if (notEmpty(str)) {
			StringBuffer sb = new StringBuffer();
			String[] array = str.split(",");
			for (int i = 0; i < array.length; i++) {
				sb.append("'").append(array[i]).append("',");
			}
			if (sb.length() != 0) {
				String s = sb.toString();
				s = s.substring(0, s.length() - 1);
				return s;
			}
		}
		return null;
	}

	public static List<String> split(String str) {
		if (notEmpty(str)) {
			String[] array = str.split(",");
			List<String> list = new ArrayList<String>();

			for (int i = 0; i < array.length; i++) {

				if (StringUtil.notEmpty(array[i])) {
					list.add(array[i]);
				}
			}
			return list;

		}
		return null;
	}

	public static int length(String str) {
		if (notEmpty(str)) {
			return str.length();
		}
		return 0;
	}

	public static Date getBeginDate(String dateStr) {
		Calendar date = Calendar.getInstance();
		if (length(dateStr) == 4) {
			date.set(Calendar.YEAR, getInt(dateStr, 1900));
			date.set(Calendar.MONTH, 0);
			date.set(Calendar.DAY_OF_MONTH, 1);
		}
		if (length(dateStr) == 6) {
			String y = subStr(dateStr, 0, 4);
			String m = subStr(dateStr, 4, 6);

			date.set(Calendar.YEAR, getInt(y, 1900));
			date.set(Calendar.MONTH, getInt(m, 1) - 1);
			date.set(Calendar.DAY_OF_MONTH, 1);
		}
		if (length(dateStr) == 8) {
			String y = subStr(dateStr, 0, 4);
			String m = subStr(dateStr, 4, 6);
			String d = subStr(dateStr, 6, 8);

			date.set(Calendar.YEAR, getInt(y, 1900));
			date.set(Calendar.MONTH, getInt(m, 1) - 1);
			date.set(Calendar.DAY_OF_MONTH, getInt(d, 1));
		}

		date.set(Calendar.HOUR_OF_DAY, 0);
		date.set(Calendar.MINUTE, 0);
		date.set(Calendar.SECOND, 0);

		return date.getTime();
	}

	public static Date getEndDate(String dateStr) {
		Calendar date = Calendar.getInstance();
		if (length(dateStr) == 4) {
			date.set(Calendar.YEAR, getInt(dateStr, 1900));
			date.set(Calendar.MONTH, 11);
			date.set(Calendar.DAY_OF_MONTH, 31);
		}
		if (length(dateStr) == 6) {
			String y = subStr(dateStr, 0, 4);
			String m = subStr(dateStr, 4, 6);

			int year = getInt(y, 1900);
			int month = getInt(m, 1);

			date.set(Calendar.YEAR, getInt(y, 1900));
			date.set(Calendar.MONTH, getInt(m, 1) - 1);

			if (month == 1 || month == 3 || month == 5 || month == 7
					|| month == 8 || month == 10 || month == 12) {
				date.set(Calendar.DAY_OF_MONTH, 31);
			}
			if (month == 4 || month == 6 || month == 9 || month == 11) {
				date.set(Calendar.DAY_OF_MONTH, 30);
			}
			if (month == 2) {
				if (year % 4 == 0) {
					date.set(Calendar.DAY_OF_MONTH, 29);
				} else {
					date.set(Calendar.DAY_OF_MONTH, 28);
				}
			}

		}
		if (length(dateStr) == 8) {
			String y = subStr(dateStr, 0, 4);
			String m = subStr(dateStr, 4, 6);
			String d = subStr(dateStr, 6, 8);

			date.set(Calendar.YEAR, getInt(y, 1900));
			date.set(Calendar.MONTH, getInt(m, 1) - 1);
			date.set(Calendar.DAY_OF_MONTH, getInt(d, 1));
		}

		date.set(Calendar.HOUR_OF_DAY, 23);
		date.set(Calendar.MINUTE, 59);
		date.set(Calendar.SECOND, 59);

		return date.getTime();
	}

	
	public static String getStrByTimestamp(Timestamp t) {
		if (t == null) {
			return "";
		}

		Date date = new Date(t.getTime());
		return StringUtil.getYMDHMS(date);
	}

	public static Date getPrevYearByReportNo(String taskNo) {
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			Date date = sdf.parse(taskNo);
			Calendar c = Calendar.getInstance();
			c.setTime(date);
			c.set(Calendar.YEAR, c.get(Calendar.YEAR) - 1);
			return c.getTime();
		} catch (Exception e) {

		}
		return null;
	}
	
	
	public static long reportNumToLong(String reportNum,long failValue) {
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			Date date = sdf.parse(reportNum);
			return date.getTime();
		} catch (Exception e) {

		}
		return failValue;
	}
	
	public static Date getReportNumDate(String reportNum) {
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			Date date = sdf.parse(reportNum);
			Calendar c = Calendar.getInstance();
			c.setTime(date);
			return c.getTime();
		} catch (Exception e) {

		}
		return null;
	}
	
	public static boolean canUpload(int status) {
		//未上报   需重报  以保存
		if(status == 9 || status == 12 || status == 2) {
			return true;
		}
		return false;
	}
	
	public static String calc(String str,int precision,String failValue) {
		
		try {
			ScriptEngineManager manager = new ScriptEngineManager();
	        ScriptEngine se = manager.getEngineByName("js");
	        Double result = (Double) se.eval(str);
	        
	        BigDecimal bd = new BigDecimal(result);
	        bd = bd.setScale(precision,BigDecimal.ROUND_HALF_UP);
	        result = bd.doubleValue();
	        
	        return result.toString();
		} catch(Exception e) {
			
		}
		return failValue;
	}

	public static String calc(String str,String failValue) {
		
		try {
			ScriptEngineManager manager = new ScriptEngineManager();
	        ScriptEngine se = manager.getEngineByName("js");
	        Double result = (Double) se.eval(str);

	        return result.toString();
		} catch(Exception e) {
			
		}
		return failValue;
	}
	
	public static String toDivCodeString(List<String> list) {
		if(list.size() == 0) {
			return "''";
		}
		
		StringBuffer sb = new StringBuffer();
		for(int i = 0;i < list.size();i++) {
			sb.append("'").append(list.get(i)).append("',");
		}
		String str = sb.toString();
		return str.substring(0,str.length() - 1);
	}
	
	public static String minus(String left,String right,int precision,String failValue) {
		try {
			double d = Double.parseDouble(left) - Double.parseDouble(right);
			BigDecimal bd = new BigDecimal(d);
	        bd = bd.setScale(precision,BigDecimal.ROUND_HALF_UP);
	        return bd.doubleValue() + "";
		} catch(Exception e) {
			return failValue;
		}
	}
	
	public static void test2() throws Exception {
		
		Class.forName("oracle.jdbc.OracleDriver");
//		Connection con = DriverManager.getConnection("jdbc:oracle:thin:@10.45.232.120:1521:orcl", "agrims", "agrims1qazxsw2");
		Connection con = DriverManager.getConnection("jdbc:oracle:thin:@192.168.50.30:1521:orcl", "agrims_new", "agrims1qazxsw2");
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(" select id,org_code,org_name from sys_org where org_code = '450705' ");
		while(rs.next()) {
			
			String orgid = rs.getString(1);
			String org_code = rs.getString(2);
			String orgname = rs.getString(3);
//			orgname = orgname.replaceAll("农业局", "");
//			orgname = orgname.replaceAll("农业所", "");
			
			String[][] array = {{"粮油处","A001","4a502656-fc6d-48a8-a888-165470e7a870","8e4f5ce5-df07-43aa-b9a4-0d577af12ed4"},
				{"经作处","B001","71b219b1-01ed-451d-8eb5-e225022b030f","215eb7ae-9a78-46e7-a815-0120f2619e0d"},
				{"糖料处","C001","29c49257-aa08-44d3-bf46-ffe81db9323b","7b46689b-300d-41e4-97cb-148dbca89085"},
					{"蚕业总站","D001","c6c02b9c-fa60-4305-a064-fd834eb29ec3","42756056-3a39-4702-92fd-b9b3cb2c06b8"},
					{"水果总站","E001","c184ef8f-7659-4a60-b832-73f09235ea18","d5ee8893-5ed1-4833-975f-1507d308e6f8"},
						{"推广总站","F001","394d547f-f32d-4da7-b316-2ac33b32d6cb","5266a25b-7994-4ced-ab1a-8ed2bcb3850a"},
						{"绿色办公室","G001","275db44a-60a5-4adb-b17a-e72d57992b3f","bfac8bf0-784d-45f2-9313-7d0d1d251780"},
							{"科教处","H001","0f2dea01-1ee3-4b9a-8189-b92ffa8a9553","14c90791-0f8e-4a4b-bf7c-14d1bf333d1e"},
							{"种子局","I001","3b9edb69-74cd-45f2-91e3-0d40a631de51","6e47578c-3d78-4c44-9caa-83351c36159d"},
								{"土肥站","J001","6902d28e-6bf7-4269-bb1c-90b3daec20e0","b4acf42c-1c5c-4039-a631-e92e95212880"},
								{"植保站","K001","d2cb3fec-35dc-4e6a-b8d5-921fc8f4e8f2","df55c498-70d5-49b8-a7a3-6bac71abaf29"},
									{"市场处","L001","5b177f4b-c85d-464c-9a3a-a3892bf28e89","080d1c49-7883-4ede-b135-517ef475740e"},
									{"经管处","M001","74e61b75-b47b-4252-ae44-56e2cf763802","190344ca-35ee-4ccc-a70e-b6e0f114f4e0"},
										{"经管站","N001","49f3fd3b-9350-4754-911e-4e0aa1dfc042","0c47a030-8484-466f-a716-27261a61ec43"},
										{"安监处","O001","d3612617-0406-42f0-9532-827baf3f878a","0dc82454-512d-44f5-805a-f32929689598"},
											{"农机局","P001","fbef3f5c-742a-45c7-903f-b0de74a569cd","888ae29b-2c7c-4353-b32e-8e0e8890874c"}};
			
			for(int i = 0;i < array.length;i++) {
				Statement st1 = con.createStatement();
				String username = org_code + array[i][1];
				st1.executeUpdate("insert into sys_user(id,account_locked,admin,credentials_expired,enabled,password,username) values(sys_guid(),0,0,0,1,'$shiro1$MD5$1$$gdyb21LQTcIANtvYMT7QVQ==','"+username+"')");
				st1.close();
				
				Statement st3 = con.createStatement();
				ResultSet rs3 = st3.executeQuery(" select id from sys_user where username = '" +username+ "'");
				rs3.next();
				String userId = rs3.getString(1);
				rs3.close();
				st3.close();
				
				Statement st2 = con.createStatement();
				st2.executeUpdate("insert into sys_person(id,gender,pers_name,user_id,org_id) values(sys_guid(),1,'"+orgname+array[i][0]+"','"+userId+"','"+orgid+"')");
				st2.close();
				
				Statement st4 = con.createStatement();
				st4.executeUpdate(" delete from sys_user_role where role_id = '" +array[i][2]+ "' and user_id = '" +userId+ "' ");
				st4.close();

				Statement st5 = con.createStatement();
				st5.executeUpdate(" insert into sys_user_role values('"+array[i][2]+"','"+userId+"')");
				st5.close();
				
				

				Statement st6 = con.createStatement();
				st6.executeUpdate(" delete from sys_user_group where group_id = '" +array[i][3]+ "' and user_id = '" +userId+ "' ");
				st6.close();

				Statement st7 = con.createStatement();
				st7.executeUpdate(" insert into sys_user_group values('"+array[i][3]+"','"+userId+"')");
				st7.close();
				
			}
		}
		rs.close();
		st.close();
		con.close();
	}
	

	public static void test3() throws Exception {
		
		int col = 0;
		Class.forName("oracle.jdbc.OracleDriver");
		Connection con = DriverManager.getConnection("jdbc:oracle:thin:@10.45.232.120:1521:orcl", "agrims", "agrims1qazxsw2");
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(" select id,rowspan,colspan,cellvalue from t_tablehead where dicreportreportnumid = '3cd55aee-65c2-4819-a08a-ae9714284d97' and row_ = 0 order by col");
		System.out.println("<table border='1'>");
		System.out.println("<tr>");
		while(rs.next()) {
			String id = rs.getString(1);
			String rowspan = rs.getString(2);
			String colspan = rs.getString(3);
			String cellvalue = rs.getString(4);

			colspan = (Integer.parseInt(colspan)*3) + "";
			col += Integer.parseInt(colspan);
			
			System.out.print("<td rowspan='"+rowspan+"' colspan='"+colspan+"'>"+cellvalue+"</td>");
		}
		System.out.println("</tr>");
		rs.close();
		st.close();
		
		st = con.createStatement();
		rs = st.executeQuery(" select id,rowspan,colspan,cellvalue from t_tablehead where dicreportreportnumid = '3cd55aee-65c2-4819-a08a-ae9714284d97' and row_ = 1  order by col");
		System.out.println("<tr>");
		while(rs.next()) {
			String id = rs.getString(1);
			String rowspan = rs.getString(2);
			String colspan = rs.getString(3);
			String cellvalue = rs.getString(4);

			colspan = (Integer.parseInt(colspan)*3) + "";
			
			System.out.print("<td rowspan='"+rowspan+"' colspan='"+colspan+"'>"+cellvalue+"</td>");
		}
		System.out.println("</tr>");
		rs.close();
		st.close();
		
		System.out.println("<tr>");
		for(int i = 0;i < col;i++) {
			if(i == 0) {
				System.out.print("<td colspan='3'>顶顶顶顶</td>");
			} else if(i > 2) {
				System.out.print("<td>顶顶顶顶</td>");
			}
//			System.out.print("<td>顶顶顶顶</td>");
		}
		System.out.println("</tr>");
		
		System.out.println("</table>");
		
		
		
		con.close();
	}
	
	public static void test4() throws Exception {
		
		Class.forName("oracle.jdbc.OracleDriver");
		Connection con5030 = DriverManager.getConnection("jdbc:oracle:thin:@192.168.50.30:1521:orcl", "agrims", "agrims1qazxsw2");
		Connection con120 = DriverManager.getConnection("jdbc:oracle:thin:@10.45.232.120:1521:orcl", "agrims", "agrims1qazxsw2");
		
		Statement st5030 = con5030.createStatement();
		ResultSet rs5030 = st5030.executeQuery(" select id, task_id, task_div_id, task_report_id, task_item_id, div_code, score_operate, score_val, score_time, status from task_score_log ");
		while(rs5030.next()) {
			String id = rs5030.getString(1);
			String task_id = rs5030.getString(2);
			String task_div_id = rs5030.getString(3);
			String task_report_id = rs5030.getString(4);
			String task_item_id = rs5030.getString(5);
			String div_code = rs5030.getString(6);
			String score_operate = rs5030.getString(7);
			String score_val = rs5030.getString(8);
			String score_time = rs5030.getString(9);
			String status = rs5030.getString(10);
			
			Statement st50301 = con5030.createStatement();
			st50301.executeQuery(" select task_no from task where id = '"+id+"' ");
		}
		
		st5030.close();
		con5030.close();
	}
	
	public static void test5() throws Exception {
		
		Class.forName("oracle.jdbc.OracleDriver");
		Connection con_new = DriverManager.getConnection("jdbc:oracle:thin:@192.168.50.30:1521:orcl", "agrims_new", "agrims1qazxsw2");
		Connection con = DriverManager.getConnection("jdbc:oracle:thin:@192.168.50.30:1521:orcl", "agrims", "agrims1qazxsw2");
		
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery("select username,password from sys_user where password  != '$shiro1$MD5$1$$gdyb21LQTcIANtvYMT7QVQ==' ");
		while(rs.next()) {
			String username = rs.getString(1);
			String password = rs.getString(2);
			
			String str = "update sys_user set password = '" +password+ "' where username = '" +username+ "'";
			System.out.println(str + ";");
//			Statement st1 = con_new.createStatement();
//			st1.executeUpdate("update sys_user set password = '" +password+ " where username = '" +username+ "'");
//			st1.close();
		}
		rs.close();
		st.close();
		con_new.close();
		con.close();
	}
	public static void main(String[] args) throws Exception {
		
		test2();
//		System.out.println(calc("1+2*(3+6)-5/2",""));x
		
//		Date date = new Date();
//		Date date1 = new Date();
//		date1.setDate(date1.getDate() - 1);
//		System.out.println(date + "==" + date1 + "==" + (date.getTime() - date1.getTime()));
		
//		Class.forName("oracle.jdbc.OracleDriver");
//		Connection con = DriverManager.getConnection("jdbc:oracle:thin:@127.0.0.1:1521:orcl", "agrims120", "agrims1qazxsw2");
//		Statement st = con.createStatement();
//		ResultSet rs = st.executeQuery(" select id,unit from t_index ");
//		while(rs.next()) {
//			
//			String id = rs.getString(1);
//			String unit = rs.getString(2);
//			
//			Statement st1 = con.createStatement();
//			ResultSet rs1 = st1.executeQuery(" select unitcode from cs0990002v1 where unitname = '" + unit + "'");
//			if(rs1.next()) {
//				
//				String unitcode = rs1.getString(1);
////				System.out.println(" update t_index set unit = '" +unitcode+ "' where id = '" +id+ "'");
//				Statement st2 = con.createStatement();
//				st2.executeUpdate(" update t_index set unit = '" +unitcode+ "' where id = '" +id+ "'");
//				st2.close();
//			}
//			rs1.close();
//			st1.close();
//		}
//		rs.close();
//		st.close();
//		con.close();
	}
}
