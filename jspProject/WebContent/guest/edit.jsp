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
function gb_update(){
	var form1 = $("#form1");
	var name = $("#name");
	var email = $("#email");
	var passwd = $("#passwd");
	var content = $("#content");
	if(name.val()==""){
		alert("이름을 입력하세요");
		name.focus();
		return;
	}
	if(email.val()==""){
		alert("이메일을 입력하세요");
		email.focus();
		return;
	}
	if(passwd.val()==""){
		alert("비밀번호를 입력하세요");
		passwd.focus();
		return;
	}
	if(content.val()==""){
		alert("내용을 입력하세요");
		content.focus();
		return;
	}
	document.form1.action="${path}/guest_servlet/update.do";
	document.form1.submit();
}

function gb_delete(){
	if(confirm("삭제하시겠습니까?")){
		document.form1.action="${path}/guest_servlet/delete.do";
		document.form1.submit();
	}
}
//로그아웃
$(function(){
	$("#btnLogout").click(function(){
		location.href="${path}/log_servlet/logout.do";
	});
});

//홈
$(function(){
	$("#hoaimages").click(function(){
		location.href="${path}/log/index.jsp";
	});
});

$(function(){
	$("#hom").click(function(){
		location.href="${path}/log/index.jsp";
	});
});

</script>

</head>
<body>

<nav class="navbar navbar-inverse"> <!--.navbar  -->
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="#" id="hoaimages">미디어vod</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
        <li class="active"><a href="#" id="hom">홈</a></li>
        <li><a href="../media_servlet/listlog.do">영화</a></li>
        <li><a href="../drama_servlet/listlog.do">드라마</a></li>
        <li><a href="../enter_servlet/listlog.do">예능</a></li>
        <li><a href="../culture_servlet/listlog.do">시사교양</a></li>
        <li><a href="../notiec_servlet/listlog.do">공지사항</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <li><a href="#"><span class="glyphicon glyphicon-user"></span>${sessionScope.userid}님</a></li>
      <%--<c:forEach var="dto" items="${map.list}">items="${map.list}"
        <li><a href="#" onclick="view('${dto.userid}')"><span class="glyphicon glyphicon-user"></span>${dto.userid}내정보</a></li>
        </c:forEach> --%>
        <li><a href="#" id="btnLogout"><span class="glyphicon glyphicon-log-in"></span> 로그아웃</a></li>
        <!-- <li><a href="#"><span class="glyphicon glyphicon-log-in"></span>회원가입</a></li> -->
      </ul>
    </div>
  </div>
</nav>

<form name="form1" id="form1" method="post">
<table class="table table-bordered table-striped">
 <tr>
  <td>이름</td>
  <td><input name="name" id="name" size="40" 
  value="${dto.name}"></td>
 </tr>
 <tr>
  <td>이메일</td>
  <td><input name="email" id="email" size="40" 
  value="${dto.email}"></td>
 </tr>
 <tr>
  <td>비밀번호</td>
  <td><input type="password" name="passwd" id="passwd" 
  size="40"></td>
 </tr>
 <tr align="center">
  <td colspan="2"><textarea class="form-control" rows="3" required 
  name="content" id="content">${dto.content}</textarea></td>
 </tr>
 <tr align="center">
  <td colspan="2">
  <!-- 수정,삭제를 위한 처리 -->
    <input type="hidden" name="idx" value="${dto.idx}">
    <input type="button" value="수정" onclick="gb_update()" class="btn btn-primary">
    <input type="button" value="삭제" onclick="gb_delete()" class="btn btn-danger">
    <input type="button" value="목록" 
    onclick="location.href='${path}/guest_servlet/list.do'" class="btn btn-warning">
  </td>
 </tr>
</table>
</form>

</body>
</html>