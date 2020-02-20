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
      </ul>
    </div>
  </div>
</nav>

<h2>검색</h2>
<form name="form1" method="post" action="${path}/drama_servlet/search.do">
 <select name="search_option">
 <c:choose>
   <c:when test="${search_option == 'writer'}">
    <option value="writer" selected>장르</option>
    <option value="subject">제목</option>
    <option value="all">장르+제목</option>
   </c:when>
   
   <c:when test="${search_option == 'subject'}">
    <option value="writer">장르</option>
    <option value="subject" selected>제목</option>
    <option value="all">장르+제목+</option>
   </c:when>
   
   <c:when test="${search_option == 'all'}">
    <option value="writer">장르</option>
    <option value="subject">제목</option>
    <option value="all" selected>장르+제목</option>
   </c:when>   
  </c:choose>
 </select>
 <input name="keyword" value="${keyword}">
 <button id="btnSearch">검색</button>
</form>

<!-- <button id="btnWrite">글쓰기</button> -->
<table class="table table-condensed">
  <tr>
    <th>번호</th>
    <th>장르</th>
    <th>제목</th>
    <th>날짜</th>
    <th>조회수</th>
    <th>다운로드</th>
  </tr>
 <c:forEach var="dto" items="${list}">
    <c:choose>
      <c:when test="${dto.show == 'y'}">
  <tr>
    <td>${dto.num}</td>
    <td>${dto.writer}</td>
    <td>
       <!-- 답글 들여쓰기 -->
       <c:forEach var="i" begin="1" end="${dto.re_level}">
         &nbsp;&nbsp;
       </c:forEach>
    <a href="${path}/media_servlet/view.do?num=${dto.num}">
    ${dto.subject}</a>
    <!--댓글갯수 표시  -->
    <c:if test="${dto.comment_count > 0}">
    <span style="color: red;">(${dto.comment_count})</span>
    </c:if>
    </td>
    <td>${dto.reg_date}</td>
    <td>${dto.readcount}</td>
    <td id="reload">${dto.down}</td>
    <td align="center">
      <c:if test="${dto.filesize > 0}">
       <a href="${path}/media_servlet/download.do?num=${dto.num}">
        <img src="../images/file.gif">
       </a> 
<!-- 			 <script>
       setTimeout('location.reload()',1000);//다운로드 횟수를 1초마다 새로고침
       </script> -->
      </c:if>
    </td>
   <%--  <td>${dto.filename}</td> --%>
    
  </tr>
   </c:when>
   <c:otherwise><!--게시물이삭제되었을때  -->
     <tr>
      <td>${dto.num}</td>
      <td colspan="6" align="center">삭제된 게시물입니다.</td>
     </tr>
   </c:otherwise>
  </c:choose>
 </c:forEach> 
</table>

</body>
</html>