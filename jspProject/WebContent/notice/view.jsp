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
	comment_list();
	$("#Savebtn").click(function(){
		comment_add();
	});
	$("#btnList").click(function(){
		location.href="${path}/notiec_servlet/list.do";
	});
	$("#btnReply").click(function(){
		document.form1.action="${path}/notiec_servlet/reply.do";
		document.form1.submit();
	});
	$("#btnEdit").click(function(){
		document.form1.action="${path}/notiec_servlet/pass_check.do";
		document.form1.submit();
	});
});

function comment_add(){
	var param="notiec_num=${dto.num}&writer="+$("#writer").val()
	+"&content="+$("#content").val();
	$.ajax({
		type: "post",
		url: "${path}/notiec_servlet/comment_add.do",
		data: param,
		success: function(){
			$("#writer").val("");
			$("#content").val("");
			comment_list();
		}
  });
}


function comment_list(){
	$.ajax({
		type: "post",
		url: "${path}/notiec_servlet/commentList.do",
		data: "num=${dto.num}",
		success: function(result){
			$("#commentList").html(result);
		}
	});
}

$(function(){
	$("#save").click(function(){
		location.href="${path}/log/login.jsp";
	});
});

$(function(){
	$("#log").click(function(){
		location.href="${path}/log/log.jsp";
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
        <li><a href="#" id="log"><span class="glyphicon glyphicon-log-in"></span> 로그인</a></li>
        <li><a href="#" id="save"><span></span>회원가입</a></li>
      </ul>
    </div>
  </div>
</nav>

<form name="form1" method="post">
<table class="table">
  <tr>
    <td>날짜</td>
    <td>${dto.reg_date}</td>
    <td>조회수</td>
    <td>${dto.readcount}</td>
  </tr>
  <tr>
    <td>이름</td>
    <td colspan="3">${dto.writer}</td>
  </tr>
  <tr>
    <td>제목</td>
    <td colspan="3">${dto.subject}</td>
  </tr>
  <tr>
    <td>본문</td>
    <td colspan="3">${dto.content}</td>
  </tr>
  <tr>
    <td>비밀번호</td>
    <td colspan="3">
      <input type="password" name="passwd" id="passwd">
        <c:if test="${param.message == 'error'}">
          <span style="color: red">
           비밀번호가 일치하지 않습니다.
          </span>
        </c:if>
    </td>
  </tr>
<%--   <tr>
    <td>첨부파일</td>
    <td colspan="3">
      <c:if test="${dto.filesize > 0}">
        ${dto.filename}( ${dto.filesize} bytes )
        <a href="${path}/board_servlet/download.do?num=${dto.num}">
        [다운로드]</a>
      </c:if>
    </td>
  </tr> --%>
  <tr>
    <td colspan="4" align="center">
      <input type="hidden" name="num" value="${dto.num}">
      <input type="button" value="수정/삭제" id="btnEdit" class="btn btn-info">
      <input type="button" value="답변" id="btnReply" class="btn btn-primary">
      <input type="button" value="목록" id="btnList" class="btn btn-warning">
    </td>  
  </tr>
</table>
</form>

<!--댓글 쓰기 폼 -->
<!-- <table width="700px">
  <tr>
   <td><input id="writer" placeholder="이름"></td>
   <td rowspan="2">
    <button id="btnSave" type="button">확인</button>
   </td>
  </tr>
 <tr>
  <td><textarea rows="5" cols="80" placeholder="내용을 입력하세요" id="content"></textarea></td>
 </tr>
</table> -->

  <form role="form">
       <input id="writer" placeholder="이름">
       <button id="Savebtn" type="button" class="btn btn-success">확인</button>
    <div class="form-group">
       <textarea class="form-control" required rows="5" cols="80" placeholder="내용을 입력하세요" id="content"></textarea>
    </div>
<div id="commentList"></div><br>
   </form>

<!-- 댓글 목록을 출력할 영역 -->
<!-- <div id="commentList"></div> -->

</body>
</html>