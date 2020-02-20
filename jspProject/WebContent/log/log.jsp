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

<c:if test="${param.message == 'error' }">
  <script>
    alert("아이디 또는 비밀번호가 일치하지 않습니다.");
  </script>
</c:if>
<%-- <c:if test="${param.message == 'logout' }">
  <script>
    alert("로그아웃되었습니다.")
  </script>
</c:if> --%>

<!-- <script type="text/javascript">
$(function(){
	$("#btnLogin").click(function(){
		var param="userid="+$("#userid").val()
		+"&passwd="+$("#passwd").val();
		$.ajax({
			type: "post",
			url: "${path}/log_servlet/log_bcrypt.do",
			data: param,
			success: function(result){
				 $("#result").html(result);
			}
		});
	});
});
</script> -->

<script type="text/javascript">
$(function(){
	$("#save").click(function(){
		location.href="${path}/log/login.jsp";
	});
});
$(function(){
	$("#btnLogin").click(function(){
		location.href="${path}/log_servlet/list.do";
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
      <a class="navbar-brand" href="../drama_servlet/list.do">미디어vod</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
        <li class="active"><a href="../drama_servlet/list.do">홈</a></li>
        <li><a href="../media_servlet/list.do">영화</a></li>
        <li><a href="../drama_servlet/list1.do">드라마</a></li>
        <li><a href="../enter_servlet/list.do">예능</a></li>
        <li><a href="../culture_servlet/list.do">시사교양</a></li>
        <li><a href="../notiec_servlet/list.do">공지사항</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <li><a href="#" id="btnLogin"><span class="glyphicon glyphicon-log-in"></span> 로그인</a></li>
        <li><a href="#" id="save"><span></span>회원가입</a></li>
      </ul>
    </div>
  </div>
</nav>

<div class="container">
  <h2>로그인</h2>
  <form action="${path}/log_servlet/log_bcrypt.do"> <!-- action="../log_servlet/log_bcrypt.do" -->
    <div class="form-group">
      <label>아이디:</label><!--for="userid"  -->
      <input id="userid" class="form-control" placeholder="아이디" name="userid">
    </div>
    <div class="form-group">
      <label>비밀번호:</label><!--for="passwd"  -->
      <input type="password" class="form-control" id="passwd" placeholder="비밀번호" name="passwd">
    </div>
  <!--   <div class="checkbox">
      <label><input type="checkbox" name="remember"> 아이디저장</label>
    </div> -->
    <button id="btnLogin" class="btn btn-primary btn-lg btn-block">로그인</button><br>
    <button type="button" class="btn btn-default btn-block">아이디찾기</button>
    <button type="button" class="btn btn-default btn-block">비밀번호재설정</button>
    <a href="../log/login.jsp"><button type="button" class="btn btn-default btn-block">회원가입</button></a>
    <!-- class="btn btn-default"  -->
         <!-- <div id="result"></div> -->
  </form>
</div>

</body>
</html>