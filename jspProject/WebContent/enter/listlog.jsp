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
		location.href="${path}/enter/write.jsp";
	});
});
//클릭한 페이지 이동
function list(page){
	location.href="${path}/enter_servlet/listlog.do?curPage="+page;
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
        <li><a href="#" id="medialog">영화</a></li>
        <li><a href="#" id="drama">드라마</a></li>
        <li><a href="#" id="enter">예능</a></li>
        <li><a href="#" id="culture">시사교양</a></li>
        <li><a href="../notiec_servlet/listlog.do">공지사항</a></li>
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
  <div class="row">
    <div class="col-sm-4">
      <div class="panel panel-primary">
        <div class="panel-heading">예능</div>
        <div class="panel-body"><a href="viewlog1.do?num=1">
        <img src="../enter/images/슈퍼맨이돌아왔다.jpg" class="img-responsive" style="width:100%" alt="Image"></a></div>
        <div class="panel-footer">슈퍼맨이돌아왔다</div> 
      </div>
    </div>
    <div class="col-sm-4"> 
      <div class="panel panel-danger">
        <div class="panel-heading">예능</div>
        <div class="panel-body"><a href="viewlog2.do?num=2">
        <img src="../enter/images/복면가왕.jpg" class="img-responsive" style="width:100%" alt="Image"></a></div>
        <div class="panel-footer">복면가왕</div>
      </div>
    </div>
    <div class="col-sm-4"> 
      <div class="panel panel-success">
        <div class="panel-heading">예능</div>
        <div class="panel-body"><a href="viewlog3.do?num=3">
        <img src="../enter/images/시즌41박2일.jpg" class="img-responsive" style="width:100%" alt="Image"></a></div>
        <div class="panel-footer">시즌41박2일</div>
      </div>
    </div>
  </div>
</div><br>

<div class="container">    
  <div class="row">
    <div class="col-sm-4">
      <div class="panel panel-primary">
        <div class="panel-heading">예능</div>
        <div class="panel-body"><a href="viewlog4.do?num=4">
        <img src="../enter/images/미운우리새끼.jpg" class="img-responsive" style="width:100%" alt="Image"></a></div>
        <div class="panel-footer">미운우리새끼</div>
      </div>
    </div>
    <div class="col-sm-4"> 
      <div class="panel panel-primary">
        <div class="panel-heading">예능</div>
        <div class="panel-body"><a href="viewlog5.do?num=5">
        <img src="../enter/images/런닝맨.jpg" class="img-responsive" style="width:100%" alt="Image"></a></div>
        <div class="panel-footer">런닝맨</div>
      </div>
    </div>
    <div class="col-sm-4"> 
      <div class="panel panel-primary">
        <div class="panel-heading">예능</div>
        <div class="panel-body"><a href="viewlog6.do?num=6">
        <img src="../enter/images/신비한TV서프라이즈.jpg" class="img-responsive" style="width:100%" alt="Image"></a></div>
        <div class="panel-footer">신비한TV서프라이즈</div>
      </div>
    </div>
  </div>
</div><br><br>
   <!--  -->
   
        
<form name="form1" method="post" action="${path}/enter_servlet/searchlog.do">
 <select name="search_option">
  <option value="writer">장르</option>
  <option value="subject">제목</option>
  <option value="content">내용</option>
  <option value="all">이름+제목+내용</option>
 </select>
 <input name="keyword">
 <button id="btnSearch">검색</button>
<!--  <button id="btnWrite">글쓰기</button> -->
 <!--button 태그는 기본값이 type="submit"이다 
 type="button"하면 js를 써야한다.-->
</form>


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
    <a href="${path}/enter_servlet/viewlog${dto.num}.do?num=${dto.num}">
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
       <a href="${path}/enter_servlet/download.do?num=${dto.num}">
        <img src="../images/file.gif">
       </a> 
<!-- 			 <script>
       setTimeout('location.reload()',1000);//다운로드 횟수를 1초마다 새로고침
       </script> -->
      </c:if>
    </td>
   <%--  <td>${dto.filename}</td> --%>
    
    <%-- <td id="reload">${dto.down}</td> --%>
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
 <!-- 페이지 네비게이션 출력 -->
 <tr>
   <td colspan="7" align="center">
     <c:if test="${page.curBlock > 1 }">
       <a href="#" onclick="list('1')">[처음]</a>
     </c:if>
     <c:if test="${page.curBlock > 1 }">
       <a href="#" onclick="list('${page.prevPage}')">[이전]</a>
     </c:if>
     <c:forEach var="num" begin="${page.blockStart}" 
     end="${page.blockEnd}">
       <c:choose>
         <c:when test="${num == page.curPage}">
           <span style="color: red">${num}</span>
         </c:when>
         <c:otherwise>
           <a href="#" onclick="list('${num}')">${num}</a>
         </c:otherwise>
       </c:choose>
     </c:forEach>
     <c:if test="${page.curBlock < page.totBlock}">
       <a href="#" onclick="list('${page.nextPage}')">[다음]</a>
     </c:if>
     <c:if test="${page.curBlock < page.totBlock}">
       <a href="#" onclick="list('${page.totPage}')">[끝]</a>
     </c:if>
 </tr>
</table>

<footer class="container-fluid text-center">
  <p>Copyright &copy; All rights reserved.</p>
</footer>

</body>
</html>