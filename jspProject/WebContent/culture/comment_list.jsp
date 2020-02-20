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

<table class="table table-bordered table-striped">
<c:forEach var="row" items="${list}">
	<tr>
		<td>
			${row.writer}
			( <fmt:formatDate value="${row.reg_date}"
				pattern="yyyy-MM-dd hh:mm:ss" /> )<br>
			${row.content}
		</td>
		      <td><input type="hidden" name="num" value="${dto.num}">
      <input type="button" value="수정" id="btnUpdate" class="btn btn-info">
      <input type="button" value="삭제" id="btnDelete" class="btn btn-danger"></td>
	</tr>
</c:forEach>
</table>

</body>
</html>