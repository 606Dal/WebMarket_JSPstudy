<%@page import="java.sql.*"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="dto.Product"%>
<%@page import="dao.ProductRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="dbconn.jsp" %>

<%
	request.setCharacterEncoding("utf-8");
	//addProduct.jsp에서 사용자가 업로드한 이미지 부분을 받아서 저장 중
	String filename = "";
	/* String realFolder = "c:\\upload"; // 웹 어플리케이션에서 절대경로
	String realFolder = request.getContextPath() + "/WebContent/resources/images/"; //상대경로*/
	/* --중요함--
	사용자가 추가한 상품들의 이미지를 현재 프로젝트의 images폴더로 잡아서 저장을 해야지
	진정한 서버의 역할을 함과 동시에 아울러 이미지를 뿌려줄 때 이미지를 가지고 오는데 문제가 없다. */
	String realFolder = "D:/workspace/jsp_workspace/WebMarket/WebContent/resources/images";
	//System.out.println(realFolder);
	int maxSize = 10 * 1024 * 1024;	//최대 업로드 크기 (10M)
	String encType = "utf-8"; //인코딩 유형
	
	MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize,
									encType, new DefaultFileRenamePolicy());


	//addProduct.jsp에서 사용자가 입력한 부분을 받아서 저장 중	
	//String productId = request.getParameter("productId"); 파일 업로드 때문에 바꿔줘야 함
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
	
	System.out.println("add");
	
	Enumeration files = multi.getFileNames();
	String fname = (String)files.nextElement();
	String fileName = multi.getFilesystemName(fname);
	
/* 	System.out.println("요청 들어온 파라메터 이름 : " + fname);
	System.out.println("저장 파일 이름 : " + fileName); 이상없음 */
	
	PreparedStatement pstmt = null;
	String sql = "insert into product values(?,?,?,?,?,?,?,?,?)";
	pstmt = conn.prepareStatement(sql);
	
	pstmt.setString(1, productId);
	pstmt.setString(2, name);
	pstmt.setInt(3, price);
	pstmt.setString(4, description);
	pstmt.setString(5, manufacturer);
	pstmt.setString(6, category);
	pstmt.setLong(7, stock);
	pstmt.setString(8, condition);
	pstmt.setString(9, fileName);
	pstmt.executeUpdate();
	System.out.println("상품 등록 완료");
	
	//자원 해제
	if(pstmt != null) pstmt.close();
	if(conn != null) conn.close();
	
	/* 아래 내용은 위의 DB삽입 내용으로 대체함 */
	/* ProductRepository dao = ProductRepository.getInstance();
	Product newProduct = new Product(); */
	
	//Product 객체에 사용자가 입력한 내용을 저장하고 있음
	/* newProduct.setProductId(productId);
	newProduct.setPname(name);
	newProduct.setUnitPrice(price); //위에서 따로 만든 price
	newProduct.setDescription(description);
	newProduct.setManufacturer(manufacturer);
	newProduct.setCategory(category);
	newProduct.setUnitsInStock(stock); //stock도
	newProduct.setCondition(condition);
	newProduct.setFilename(fileName); */ // 이미지 저장 부분
	
	//ArrayList에 새 상품을 추가하고 있음
	/* dao.addProduct(newProduct); */
	//강제로 페이지 이동 중
	response.sendRedirect("products.jsp");
	
%>