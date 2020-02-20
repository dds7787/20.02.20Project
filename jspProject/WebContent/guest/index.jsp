<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<%@ include file="../include/header.jsp" %>

<script src="../include/jquery-3.4.1.min.js"></script>

</head>
<body>
<%-- <%
String context=request.getContextPath();
response.sendRedirect(context+"/guest_servlet/list.do");
%> --%>

<c:redirect url="/guest_servlet/list.do"></c:redirect>
</body>
</html>