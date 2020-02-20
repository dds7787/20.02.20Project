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
  <link type="text/css" rel="stylesheet" href="../media/movie.css">
  
<script type="text/javascript">
//글쓰기
$(function(){
	$("#btnWrite").click(function(){
		location.href="${path}/media/write.jsp";
	});
});
//클릭한 페이지 이동
function list(page){
	location.href="${path}/media_servlet/listlog.do?curPage="+page;
}
//로그아웃
$(function(){
	$("#btnLogout").click(function(){
		location.href="${path}/log_servlet/logout.do";
	});
});

$(function(){
	$("#medialog").click(function(){
		location.href="${path}/media_servlet/listlog.do";
	});
});

$(function(){
	$("#drama").click(function(){
		location.href="${path}/drama_servlet/listlog.do";
	});
});

$(function(){
	$("#enter").click(function(){
		location.href="${path}/enter_servlet/listlog.do";
	});
});

$(function(){
	$("#culture").click(function(){
		location.href="${path}/culture_servlet/listlog.do";
	});
});

$(function(){
	$("#notiec").click(function(){
		location.href="${path}/notiec_servlet/list.do";
	});
});

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

//댓글
$(function(){
	comment_list();
	$("#Savebtn").click(function(){
		comment_add();
	});
	$("#btnList").click(function(){
		location.href="${path}/culture_servlet/listlog.do";
	});
	$("#btnReply").click(function(){
		document.form1.action="${path}/culture_servlet/reply.do";//답글쓰기
		document.form1.submit();
	});
	$("#btnEdit").click(function(){
		document.form1.action="${path}/culture_servlet/pass_check.do";//비밀번호체크
		document.form1.submit();
	});
});

function comment_add(){//뎃글추가
	var param="culture_num=${dto.num}&writer="+$("#writer").val()
	+"&content="+$("#content").val();
	$.ajax({
		type: "post",
		url: "${path}/culture_servlet/comment_add.do",
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
		url: "${path}/culture_servlet/commentList.do",
		data: "num=${dto.num}",
		success: function(result){
			$("#commentList").html(result);
		}
	});
}
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
        <li><a href="#" id="medialog">영화</a></li>
        <li><a href="#" id="drama">드라마</a></li>
        <li><a href="#" id="enter">예능</a></li>
        <li><a href="#" id="culture">시사교양</a></li>
        <li><a href="#" id="notiec">공지사항</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <%-- <li><a href="../log/log.jsp"><span class="glyphicon glyphicon-log-in"></span>${sessionScope.userid}님</a></li> --%>
        <li><a href="#"><span class="glyphicon glyphicon-user"></span>${sessionScope.userid}님</a></li>
        <li><a href="#" id="btnLogout"><span class="glyphicon glyphicon-log-in"></span> 로그아웃</a></li>
        <!-- <li><a href="#"><span class="glyphicon glyphicon-log-in"></span>회원가입</a></li> -->
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
     <source src="../culture/images/생생정보통.mp4">
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

  <tr>
    <td>첨부파일</td>
    <td colspan="3">
      <c:if test="${dto.filesize > 0}">
        ${dto.filename}( ${dto.filesize} bytes )
        <a href="${path}/culture_servlet/download.do?num=${dto.num}">
        [다운로드]</a>
      </c:if>
    </td>
    <td>
  </tr>
</table>
  
      <div class="container">
     <b>시청률:</b><span class="badge">13.0</span>
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
      <h2>시사교육소개</h2>
      <h5><span class="glyphicon glyphicon-time"></span>방영일자 2010-05-10 ~ 방영종료 1021부작</h5>
      <p>
          공영방송 KBS가 저녁 시간대 교양정보프로그램의 전형을 보여드립니다. 
          생생하게 살아 움직이는, 생생한 대한민국의, 생생한 정보프로그램을 목표로 합니다.
          대한민국의 구석구석의 현장을 실시간으로 전달하는 프로그램
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