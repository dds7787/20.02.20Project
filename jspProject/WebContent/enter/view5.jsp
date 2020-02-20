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
  <link type="text/css" rel="stylesheet" href="../media/mo1.css">


<script type="text/javascript">

$(function(){
	comment_list();
	$("#Savebtn").click(function(){
		comment_add();
	});
	$("#btnList").click(function(){
		location.href="${path}/enter_servlet/list.do";
	});
	$("#btnReply").click(function(){
		document.form1.action="${path}/enter_servlet/reply.do";//답글쓰기
		document.form1.submit();
	});
	$("#btnEdit").click(function(){
		document.form1.action="${path}/enter_servlet/pass_check.do";//비밀번호체크
		document.form1.submit();
	});
});

function comment_add(){//뎃글추가
	var param="enter_num=${dto.num}&writer="+$("#writer").val()
	+"&content="+$("#content").val();
	$.ajax({
		type: "post",
		url: "${path}/enter_servlet/comment_add.do",
		data: param,
		success: function(){
			$("#writer").val("");
			$("#content").val("");
			comment_list();
		}
  });
}


function comment_list(){//뎃글목록
	$.ajax({
		type: "post",
		url: "${path}/enter_servlet/commentList.do",
		data: "num=${dto.num}",
		success: function(result){
			$("#commentList").html(result);
		}
	});
}

//로그인회원가입
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

<div class="container">
<form name="form1" method="post">
 <table class="table table-hover">
<%--   <tr>   
   <td>장르</td>
    <td colspan="3">${dto.writer}</td>
    <td>제목</td>
    <td colspan="3">${dto.subject}</td>
    <td>조회수</td>
    <td>${dto.readcount}</td>
  </tr> --%><br><br><br>
  
  <tr>
   <td>
     <video autoplay="autoplay" controls="controls" width="640px;"height="360px;">
     <source src="../enter/images/런닝맨.mp4">
            브라우저에서 비디오 파일을 지원하지 않습니다.</video>
   </td>
  </tr>
  
  
<%--   <tr>
    <td>비밀번호</td>
    <td colspan="3">
      <input type="password" name="passwd" id="passwd">
        <c:if test="${param.message == 'error'}">
          <span style="color: red">
           비밀번호가 일치하지 않습니다.
          </span>
        </c:if>
    </td>
  </tr> --%>

</table>
  
      <div class="container">
      
      <div class="container">
      <b>평점:</b><span class="badge">6.9</span>
      <input type="button" class="btn btn-primary" value="목록" id="btnList">
  <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#myModal">스트리밍이용권</button>

  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog modal-sm">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title"></h4>
        </div>
        <div class="modal-body">
          <a href=""><button type="button" class="btn btn-default btn-lg btn-block">구매일로부터48시간 2,750원</button></a>
          <a href=""><button type="button" class="btn btn-default btn-lg btn-block">영구이용권 10,000원</button></a>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
        </div>
      </div>
    </div>
  </div>
</div>
      
         
     </div>
      <h2>예능소개</h2>
      <h5><span class="glyphicon glyphicon-time"></span>방영일자 2010-07-11 ~ 방영중</h5>
      <p>
          누구도 상상하지 못했던 예측불허 빅웃음!! 
          대한민국을 대표하는 랜드마크, 얼마나 알고 계십니까? 
          런닝맨이 몸으로 직접 알려드리는 대한민국 대표 랜드마크! 
          대한민국 최고의 연예인들이 그곳에 모였다! 
          곳곳에 있는 미션을 해결하는 예능 프로그램
      </p>
</form>

 <h2>댓글</h2>
  <form role="form">
       <input id="writer" placeholder="이름">
       <button id="Savebtn" type="button" class="btn btn-success">확인</button>
    <div class="form-group">
       <textarea class="form-control" required rows="5" cols="80" placeholder="내용을 입력하세요" id="content"></textarea>
    </div>
<div id="commentList"></div><br>
   </form>
</div>

<footer class="container-fluid">
  <p>Footer Text</p>
</footer>

</body>
</html>