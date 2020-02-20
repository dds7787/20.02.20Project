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
		location.href="${path}/media_servlet/list.do";
	});
	$("#btnReply").click(function(){
		document.form1.action="${path}/media_servlet/reply.do";//답글쓰기
		document.form1.submit();
	});
	$("#btnEdit").click(function(){
		document.form1.action="${path}/media_servlet/pass_check.do";//비밀번호체크
		document.form1.submit();
	});
});

function comment_add(){//뎃글추가
	var param="media_num=${dto.num}&writer="+$("#writer").val()
	+"&content="+$("#content").val();
	$.ajax({
		type: "post",
		url: "${path}/media_servlet/comment_add.do",
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
		url: "${path}/media_servlet/commentList.do",
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
     <source src="../media/images/백두산.mp4">
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

<%--   <tr>
    <td>첨부파일</td>
    <td colspan="3">
      <c:if test="${dto.filesize > 0}">
        ${dto.filename}( ${dto.filesize} bytes )
        <a href="${path}/media_servlet/download.do?num=${dto.num}">
        [다운로드]</a>
      </c:if>
    </td>
    <td>
  </tr> --%>
</table>
  
      <div class="container">
            
      <div class="container">
      <b>평점:</b><span class="badge">7.47</span>
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
      <h2>영화줄거리</h2>
      <h5><span class="glyphicon glyphicon-time"></span>개봉일자 2019-12-19</h5>
      <p>
        대한민국 관측 역사상 최대 규모의 백두산 폭발 발생.
        갑작스러운 재난에 한반도는 순식간에 아비규환이 되고,
        남과 북 모두를 집어삼킬 추가 폭발이 예측된다.
        사상 초유의 재난을 막기 위해 ‘전유경’(전혜진)은
        백두산 폭발을 연구해 온 지질학 교수 ‘강봉래’(마동석)의 이론에 따른 작전을 계획하고,
        전역을 앞둔 특전사 EOD 대위 ‘조인창’(하정우)이 남과 북의 운명이 걸린 비밀 작전에 투입된다.
        작전의 키를 쥔 북한 무력부 소속 일급 자원 ‘리준평’(이병헌)과 접선에 성공한 ‘인창’.
        하지만 ‘준평’은 속을 알 수 없는 행동으로 ‘인창’을 곤란하게 만든다.
        한편, ‘인창’이 북한에서 펼쳐지는 작전에 투입된 사실도 모른 채
        서울에 홀로 남은 ‘최지영’(배수지)은 재난에 맞서 살아남기 위해 고군분투하고
        그 사이, 백두산 마지막 폭발까지의 시간은 점점 가까워 가는데…!
      </p>
</form>
<!--댓글 쓰기 폼 -->
 <h2>리뷰</h2>
  <form role="form">
       <input id="writer" placeholder="이름">
       <input id="pwd" placeholder="비번">
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