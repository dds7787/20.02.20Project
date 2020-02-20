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

</head>
<body>
<%-- <c:redirect url="/media_servlet/list.do"></c:redirect> --%>
<nav class="navbar navbar-inverse"> <!--.navbar  -->
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="../project/index.jsp">미디어vod</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
        <li class="active"><a href="../project/index.jsp">홈</a></li>
        <li><a href="../media_servlet/list.do">영화</a></li>
        <li><a href="../media/drama.jsp">드라마</a></li>
        <li><a href="../media/entertainment.jsp">예능</a></li>
        <li><a href="../media/currentaffairs.jsp">시사교양</a></li>
        <li><a href="../project/project.jsp">커뮤니티</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <li><a href="#"><span class="glyphicon glyphicon-log-in"></span> 로그인</a></li>
        <li><a href="#"><span></span>회원가입</a></li>
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
        <a href="../media_servlet/view6.do?num=6"><img src="images/터미.jpg" alt="Image"></a>
        <div class="carousel-caption">
          <h3></h3>
          <p></p>
        </div>      
      </div>

      <div class="item">
        <a href="#"><img src="images/백두.jpg" alt="Image"></a>
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
        <li><a href="#">미디어vod공지</a></li>
        <li><a href="#">커뮤니티공지</a></li>
        <li><a href="#">공지1</a></li>
       </ul>
      </div>
  <div class="row">
    <div class="col-sm-4">
   <h3>방송</h3><br>
      <a href="#"><img src="images/김사부메인.jpg" class="img-responsive" style="width:100%" alt="Image">
      <p>낭만닥터 김사부2</p></a><br>
      <a href="#"><img src="images/포레스트메인.jpg" class="img-responsive" style="width:100%" alt="Image">
      <p>포레스트</p></a>
    </div>
    
    <div class="col-sm-4">
    <h3>영화</h3><br> 
     <a href="../media_servlet/view6.do?num=6"><img src="images/터미네이터메인.jpg" class="img-responsive" style="width:100%" alt="Image">
      <p>터미네이터</p></a><br>    
     <a href="../media_servlet/view2.do?num=2"><img src="images/시동메인.jpg" class="img-responsive" style="width:100%" alt="Image">
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
     <a href="#"><img src="images/미스터트톳메인.jpg" class="img-responsive" style="width:100%" alt="Image">
      <p>미스터트롯</p></a><br>    
     <a href="#"><img src="images/런닝맨메인.jpg" class="img-responsive" style="width:100%" alt="Image">
      <p>런닝맨</p></a>
    </div>
 
   <div class="col-sm-4">
    <h3>시사교양</h3><br> 
     <a href="#"><img src="images/도전골든벨.jpg" class="img-responsive" style="width:100%" alt="Image">
      <p>도전골든벨</p></a><br>    
     <a href="#"><img src="images/인간극장.jpg" class="img-responsive" style="width:100%" alt="Image">
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

</body>
</html>