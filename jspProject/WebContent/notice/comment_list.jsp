<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<%@ include file="../include/header.jsp" %>

<script src="../include/jquery-3.4.1.min.js"></script>

<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<script type="text/javascript">
$(function(){
	$("#btnUpdate").click(function(){
		location.href="${path}/notiec_servlet/update2.do";
	});
	$("#btnDelete").click(function(){
		location.href="${path}/notiec_servlet/delete2.do";
	});
});

</script>

</head>
<body>

<form>
<!-- <table>
  <tr>
    <td>비밀번호</td>
    <td><input type="password" name="passwd" id="passwd"></td>
  </tr>
  </table> -->
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
</form>

</body>
</html>