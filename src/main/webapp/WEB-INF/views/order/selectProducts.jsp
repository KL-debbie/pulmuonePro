<%@page import="auth.AuthInfo"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.Iterator"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="jdbc.JdbcUtil"%>
<%@page import="jdbc.connection.ConnectionProvider"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String sql = " SELECT p.products_no, products_name, products_size, price, img_path, system_name, COUNT(p.products_no) OVER() total_count "
				+ " FROM products p LEFT JOIN products_img i ON p.products_no = i.products_no "
	            	+ " JOIN products_pct c ON p.category_no = c.category_no "
	            + " WHERE c.category_no IN (1, 4, 31, 60, 62, 64) AND origin_name != 'View.png' "
				+ " ORDER BY p.products_no ";
	
	JSONObject jsonData = new JSONObject();
	
	try {
		conn = ConnectionProvider.getConnection();
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
	
		JSONArray jsonPrd = new JSONArray();
		JSONObject jsonObj = new JSONObject();
	
		String productsNo, productsName, produtsSize, imgPath, systemName;
		int price, totalCount;
		
		while (rs.next()) {
			productsNo = rs.getString("products_no");
			productsName = rs.getString("products_name");
			produtsSize = rs.getString("products_size");
			price = rs.getInt("price");
			imgPath = rs.getString("img_path");
			systemName = rs.getString("system_name");
			totalCount = rs.getInt("total_count");
	
			jsonObj.put("productsNo", productsNo);
			jsonObj.put("productsName", productsName);
			jsonObj.put("produtsSize", produtsSize);
			jsonObj.put("price", price);
			jsonObj.put("imgPath", imgPath);
			jsonObj.put("systemName", systemName);
			jsonObj.put("totalCount", totalCount);
			
			jsonPrd.add(jsonObj);
		} // while
	
		// 주소록 데이터를 페이지에 따라 반환
		int pageNo = Integer.parseInt(request.getParameter("pageNo"));
		int pageSize = 8; // 페이지당 항목 수
		int startIndex = pageNo * pageSize;
		int endIndex = Math.min(startIndex + pageSize, jsonPrd.size());
	
		JSONArray pagedPrd = new JSONArray();
		
		for(int i = startIndex; i < endIndex; i++) {
			pagedPrd.add(jsonPrd.get(i));
		} // for
	
		jsonData.put("prdArr", pagedPrd);
	} catch (Exception e) {
		System.out.println("selectProducts.jsp error");
		e.printStackTrace();
	} finally {
		JdbcUtil.close(rs);
		JdbcUtil.close(pstmt);
		JdbcUtil.close(conn);
	} // try
%>
<%=jsonData%>