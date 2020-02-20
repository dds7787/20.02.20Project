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
     <source src="../media/images/블랙머니.mp4">
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
      <b>평점:</b><span class="badge">8.75</span> 
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
      <h5><span class="glyphicon glyphicon-time"></span>개봉일자 2019-11-13</h5>
      <p>
        고발은 의무! 수사는 직진!
        할말은 하고 깔 건 깐다!
        일명 서울지검 ‘막프로’!
        검찰 내에서 거침없이 막 나가는
        문제적 검사로 이름을 날리는 
     ‘양민혁’은 자신이 조사를 담당한 
        피의자가 자살하는 사건으로 인해 하루 아침에 벼랑 끝에 내몰린다. 
        억울한 누명을 벗기 위해 내막을 파헤치던 
        그는 피의자가 대한은행 헐값 매각사건의 중요 증인이었음을 알게 된다. 근거는 의문의 팩스 5장!
        자산가치 70조 은행이 1조 7천억원에 넘어간 희대의 사건 앞에서
     ‘양민혁’ 검사는 금융감독원, 대형 로펌, 해외펀드 회사가 뒤얽힌 거대한 금융 비리의 실체와 마주하게 되는데... 
        대한민국 최대의 금융스캔들, 사건은 아직 끝나지 않았다!
      </p>
</form>
<!--댓글 쓰기 폼 -->
 <h2>리뷰</h2>
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