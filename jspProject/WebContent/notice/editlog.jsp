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

//삭제
$(function(){
	$("#btnUpdate").click(function(){
		document.form1.action="${path}/notiec_servlet/updatelog.do";
		document.form1.submit();
	});
	$("#btnDelete").click(function(){
		document.form1.action="${path}/notiec_servlet/deletelog.do";
		document.form1.submit();
	});
});

//로그아웃
$(function(){
	$("#btnLogout").click(function(){
		location.href="${path}/log_servlet/logout.do";
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

<form name="form1" method="post" enctype="multipart/form-data">
<table class="table">
  <tr>
    <td>이름</td>
    <td><input name="writer" id="writer" value="${dto.writer}"></td>
  </tr>
  <tr>
    <td>제목</td>
    <td><input name="subject" id="subject" size="60"
    value="${dto.subject}"></td>
  </tr>
  <tr>
    <td>본문</td>
    <td><textarea rows="5" cols="60" 
    name="content" id="content">${dto.content}</textarea></td>
  </tr>
<%--   <tr>
    <td>첨부파일</td>
    <td>
    <c:if test="${dto.filesize > 0}">
    ${dto.filename} ( ${dto.filesize / 1024 } KB)
    <input type="checkbox" name="fileDel">첨부파일 삭제<br>    
    </c:if>
    <input type="file" name="file1"></td>
  </tr> --%>
  <tr>
    <td>비밀번호</td>
    <td><input type="password" name="passwd" id="passwd"></td>
  </tr>
  <tr>
    <td colspan="2" align="center">
      <!--수정,삭제를 위한 처리 -->
      <input type="hidden" name="num" value="${dto.num}">
      <input type="button" value="수정" id="btnUpdate" class="btn btn-info">
      <input type="button" value="삭제" id="btnDelete" class="btn btn-danger">
    </td>
  </tr>
</table>
</form>

</body>
</html>