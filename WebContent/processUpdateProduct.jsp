<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="com.oreilly.servlet.multipart.*"%>
<%@page import="com.oreilly.servlet.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="dbconn.jsp" %>

<% 
	request.setCharacterEncoding("utf-8");
	//updateProduct.jsp에서 사용자가 업로드한 이미지 부분을 받아서 저장 중
	String filename = "";
	String realFolder = "D:/workspace/jsp_workspace/WebMarket/WebContent/resources/images";
	int maxSize = 10 * 1024 * 1024;	//최대 업로드 크기 (10M)
	String encType = "utf-8";
	
	MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize,
			encType, new DefaultFileRenamePolicy());


	//updateProduct.jsp에서 사용자가 입력한 부분을 받아서 저장 중
	String productId = multi.getParameter("productId");
	String name = multi.getParameter("name");
	String unitPrice = multi.getParameter("unitPrice"); //단가
	String description = multi.getParameter("description"); //제품 상세 요약
	String manufacturer = multi.getParameter("manufacturer"); //제조사
	String category = multi.getParameter("category");
	String unitsInStock = multi.getParameter("unitsInStock"); //재고
	String condition = multi.getParameter("condition"); //제품 상태
	
	Integer price;
	long stock;
	
	//단가 입력창에 미 입력시
	if(unitPrice.isEmpty()){
	price = 0; //자동 박싱
	} else{
	//String을 숫자로 변환 하고 있음
	price = Integer.valueOf(unitPrice);
	}
	//재고 수량 미 입력시 /* 나중에 유효성 검사 필요함. (,넣어도 오류생김) */
	if(unitsInStock.isEmpty()){
	stock = 0; //자동 박싱
	} else{
	//String을 숫자로 변환 하고 있음
	stock = Long.valueOf(unitsInStock);
	}
	
	System.out.println("update");
	
	Enumeration files = multi.getFileNames();
	String fname = (String)files.nextElement();
	String fileName = multi.getFilesystemName(fname);
	
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String sql = "select * from product where p_id = ?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, productId);
	rs = pstmt.executeQuery();
	
	if(rs.next()){
		if(fileName != null){
			sql = "update product set p_name=?, p_unitPrice=?, p_description=?, p_manufacturer=? "
				+ " , p_category=?, p_unitsInStock=?, p_condition=?, p_filename=? where p_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setInt(2, price);
			pstmt.setString(3, description);
			pstmt.setString(4, manufacturer);
			pstmt.setString(5, category);
			pstmt.setLong(6, stock);
			pstmt.setString(7, condition);
			pstmt.setString(8, fileName);
			pstmt.setString(9, productId);
			
			pstmt.executeUpdate();
			//이미지의 변경이 없다면
		} else {
				sql = "update product set p_name=?, p_unitPrice=?, p_description=?, p_manufacturer=? "
					+ " , p_category=?, p_unitsInStock=?, p_condition=? where p_id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, name);
				pstmt.setInt(2, price);
				pstmt.setString(3, description);
				pstmt.setString(4, manufacturer);
				pstmt.setString(5, category);
				pstmt.setLong(6, stock);
				pstmt.setString(7, condition);
				pstmt.setString(8, productId);
				
				pstmt.executeUpdate();
		}
	}
	
	if(rs != null) rs.close();
	if(pstmt != null) pstmt.close();
	if(conn != null) conn.close();
	
	response.sendRedirect("editProduct.jsp?edit=update");

%>