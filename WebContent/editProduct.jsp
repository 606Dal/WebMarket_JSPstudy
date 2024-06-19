<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8"); 
	//넘어오는 edit 값을 받고 있음. (여기서 수정과 삭제 둘 중 하나로 넘어가기 때문에)
	String edit = request.getParameter("edit");
	DecimalFormat dFormat = new DecimalFormat("###,###");
%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>상품 수정, 삭제</title>

<%-- 삭제 버튼을 눌렀을 때, 자바 스크립트로 재차 확인하는 코드 --%>
<script type="text/javascript">
	function deleteConfirm(id) {
		if(confirm("해당 상품을 삭제합니다.") == true)
			location.href = "./deleteProduct.jsp?id=" + id;
		else
			return;
	}
</script>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<%-- jumbotron (B5에서는 더 이상 지원되지 않음) --%>
	<div class="mt-4 p-5 bg-secondary text-white rounded">
		<div class="container">
			<h1 class="display-4">상품 목록</h1>
		</div>
	</div>
	<div class="container">
		<div class="row" align="center">
			<%@ include file="dbconn.jsp" %>
			<%
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				
				String sql = "select * from product";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
			%>
			<div class="col-md-4 mt-4">
				<div class="container" style="text-align: center; height: 270px; max-width: 300px;">
					<img src="${pageContext.request.contextPath }/resources/images/<%=rs.getString("p_filename") %>"
						class="img-fluid rounded m-auto d-block" style="max-height: 90%; max-width: 100%">
				</div>
				<h3><%=rs.getString("p_name") %> </h3>
				<p> <%=rs.getString("p_description") %></p>
				<p> <%= dFormat.format(Integer.parseInt(rs.getString("p_unitPrice"))) %>원</p>
				<p>	<% 
						if(edit.equals("update")) {
					%>
						<a href="./updateProduct.jsp?id=<%=rs.getString("p_id") %>"
						class="btn btn-success" role="button">수정 &raquo;</a>
					<%  
						} else if(edit.equals("delete")){
					%>	
						<a class="btn btn-danger" href="#" onclick="deleteConfirm('<%=rs.getString("p_id") %>')"
						 role="button">삭제 &raquo;</a>
					<%  
						}
					%>
			</div>
				<%
					}
				
					if(rs != null) rs.close();
					if(pstmt != null) pstmt.close();
					if(conn != null) conn.close();
				%>
		</div>
		<hr>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>