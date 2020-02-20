<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<%@ include file="../include/header.jsp" %>

<script src="../include/jquery-3.4.1.min.js"></script>

 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link type="text/css" rel="stylesheet" href="../project/index.css">

<script type="text/javascript">
function view(userid){
	document.form1.userid.value = userid;
	document.form1.submit();
}

$(function(){
	$("#btnLogout").click(function(){
		location.href="${path}/log_servlet/logout.do";
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

/* $(function(){
	$("#view").click(function(){
		var param="userid="+$("#userid").val()
		+"&passwd="+$("#passwd").val();
		$.ajax({
			type: "post",
			url: "${path}/log_servlet/view.do",//아직미정
			data: param,
			success: function(result){
				 $("#result").html(result);
			}
		});
	}); */

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


<div id="myCarousel" class="carousel slide" data-ride="carousel">
    <ol class="carousel-indicators">
      <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
      <li data-target="#myCarousel" data-slide-to="1"></li>
    </ol>

    
    <div class="carousel-inner" role="listbox"> <!-- .carousel-inner img -->
      <div class="item active">
        <a href="../media_servlet/viewlog6.do?num=6"><img src="../drama/images/터미.jpg" alt="Image"></a>
        <div class="carousel-caption">
          <h3></h3>
          <p></p>
        </div>      
      </div>

      <div class="item">
        <a href="../media_servlet/viewlog7.do?num=7"><img src="../drama/images/백두.jpg" alt="Image"></a>
        <div class="carousel-caption">
          <h3></h3>
          <p></p>
        </div>      
      </div>
    </div>

    
    <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
      <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
      <span class="sr-only">이전</span>
    </a>
    <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
      <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
      <span class="sr-only">다음</span>
    </a>
</div>
  
<div class="container text-center">    
  <div class="well">
      <h3>공지사항</h3>
       <ul id="a1">
        <li><a href="../notiec_servlet/view.do?num=1">미디어vod공지</a></li>
        <li><a href="#">커뮤니티공지</a></li>
        <li><a href="../notiec_servlet/view.do?num=3">공지1</a></li>
       </ul>
      </div>
  <div class="row">
    <div class="col-sm-4">
   <h3>방송</h3><br>
      <a href="../drama_servlet/viewlog2.do?num=2"><img src="../drama/images/김사부메인.jpg" class="img-responsive" style="width:100%" alt="Image">
      <p>낭만닥터 김사부2</p></a><br>
      <a href="../drama_servlet/viewlog4.do?num=4"><img src="../drama/images/포레스트메인.jpg" class="img-responsive" style="width:100%" alt="Image">
      <p>포레스트</p></a>
    </div>
    
    <div class="col-sm-4">
    <h3>영화</h3><br> 
     <a href="../media_servlet/viewlog6.do?num=6"><img src="../drama/images/터미네이터메인.jpg" class="img-responsive" style="width:100%" alt="Image">
      <p>터미네이터</p></a><br>    
     <a href="../media_servlet/viewlog2.do?num=2"><img src="../drama/images/시동메인.jpg" class="img-responsive" style="width:100%" alt="Image">
      <p>시동</p></a>
    </div>
    
   <div class="col-sm-4">
   <br><br><br><br><br><br>
   <h3>인기</h3>
      <div class="well">
      <h3>방영중인드라마</h3>
       <ul id="a2">
        <li><a href="#">스토브리그</a></li>
        <li><a href="#">사랑의불시착</a></li>
        <li><a href="#">낭만닥터김사부2</a></li>
       </ul>
       <h3>상영중인영화</h3>
        <ul id="a3">
        <li><a href="#">남산의부장들</a></li>
        <li><a href="#">히트맨</a></li>
        <li><a href="#">미스터주 : 사라진vip</a></li>
       </ul>
      </div>
    </div>

  </div>
</div><br>

 <div class="container text-center">    
  <div class="col-sm-4">
    <h3>예능</h3><br> 
     <a href="../enter_servlet/viewlog7.do?num=7"><img src="../drama/images/미스터트톳메인.jpg" class="img-responsive" style="width:100%" alt="Image">
      <p>미스터트롯</p></a><br>    
     <a href="../enter_servlet/viewlog5.do?num=5"><img src="../drama/images/런닝맨메인.jpg" class="img-responsive" style="width:100%" alt="Image">
      <p>런닝맨</p></a>
    </div>
 
   <div class="col-sm-4">
    <h3>시사교양</h3><br> 
     <a href="../culture_servlet/viewlog7.do?num=7"><img src="../drama/images/도전골든벨.jpg" class="img-responsive" style="width:100%" alt="Image">
      <p>도전골든벨</p></a><br>    
     <a href="../culture_servlet/viewlog8.do?num=8"><img src="../drama/images/인간극장.jpg" class="img-responsive" style="width:100%" alt="Image">
      <p>인간극장</p></a>
    </div>
    
     <div class="col-sm-4">
     <br><br><br><br><br><br>
     <h3>인기</h3>
      <div class="well">
       <h3>방영중인예능</h3>
       <ul id="a4">
        <li><a href="#">동상이몽2</a></li>
        <li><a href="#">미스터트롯</a></li>
        <li><a href="#">슈퍼맨이돌아왔다</a></li>
       </ul>
       <h3>방영중인시사교양</h3>
       <ul id="a5">
        <li><a href="#">생생정보통</a></li>
        <li><a href="#">모닝와일드</a></li>
        <li><a href="#">아침이좋다</a></li>
        <li><a href="#">맨인블랙박스</a></li>
       </ul>
      </div>
    </div>
    
</div><br>


<footer class="container-fluid text-center">
  <p>Copyright &copy; All rights reserved.</p>
</footer>


<%-- 등록된 회원수 : ${map.count}명
<table border="1" width="100%">
  <tr>
    <th>이름</th>
    <th>아이디</th>
    <th>가입일자</th>
    <th>이메일</th>
    <th>핸드폰</th>
  </tr>
  <c:forEach var="dto" items="${map.list}">
  <tr>
    <td>
    <!-- ${dto.userid} 에서 dto에 있는 userid라는 private
    멤버변수를 호출하는게 아니라 내부적으로 getter메소드인
    getUserid()가 자동으로 호출되는 메카니즘이 되어있다. -->
      <a href="#" onclick="view('${dto.userid}')">${dto.name}</a>
    </td>
    <td>${dto.userid}</td>
    <td>${dto.join_date}</td>
    <td>${dto.email}</td>
    <td>${dto.hp}</td>
  </tr>
  </c:forEach>
</table> --%>

 <form name="form1" method="post" 
action="/jspProject/log_servlet/view.do">
  <input type="hidden" name="userid">
</form> 

</body>
</html>