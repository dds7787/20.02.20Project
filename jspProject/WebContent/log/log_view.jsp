<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%@ page import="log.dto.LoginDTO" %>  
<%
LoginDTO dto = (LoginDTO)request.getAttribute("dto");
%>
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

<!-- <script type="text/javascript">
$(function(){
	$("#btnUpdate").click(function(){//수정
		//폼 데이터 제출할 주소
		document.form1.action="/log_servlet/update.do";
		document.form1.submit();
	});
	$("#btnDelete").click(function(){
		if(confirm("삭제하시겠습니까?")){
			document.form1.action="/log_servlet/delete.do";
			document.form1.submit();
		}
	});
});

</script> -->

<script type="text/javascript">
  $(function(){
	$("#btnUpdate").click(function(){//수정
		//폼 데이터 제출할 주소
		if(confirm("수정하시겠습니까?")){
		document.form1.action="jspProject/log_servlet/update.do";
		document.form1.submit();
		}
	}); 
	
	
 	$("#btnDelete").click(function(){
		if(confirm("삭제하시겠습니까?")){
			document.form1.action="jspProject/log_servlet/delete.do";
			document.form1.submit();
		}
	});
});

</script>

</head>
<body>

 <form name="form1" method="post">
 <div class="form-group">
      <label>아이디:</label><!--for="userid"  -->
      <input value="<%=dto.getUserid() %>" class="form-control" placeholder="아이디">
    </div>
    <div class="form-group">
      <label>비밀번호:</label><!--for="passwd"  -->
      <input type="password" class="form-control"  placeholder="비밀번호">
    </div>
    
    <div class="form-group">
      <label>이름:</label>
      <input value="<%=dto.getName() %>" class="form-control" placeholder="이름">
    </div>
    <div class="form-group">
      <label>이메일:</label>
      <input value="<%=dto.getEmail() %>" class="form-control" placeholder="이메일">
    </div>
    <div class="form-group">
      <label>핸드폰:</label>
      <input value="<%=dto.getHp() %>" class="form-control" placeholder="전화번호">
    </div>
   <%--  <input type="hidden" name="userid" value="<%=dto.getUserid()%>"> --%>
 
     <input type="hidden" name="userid" value="<%=dto.getName()%>">
    <button id="btnUpdate" class="btn btn-default">회원정보수정</button>
    <button id="btnDelete" class="btn btn-default">회원탈퇴</button>
</form>



</body>
</html>