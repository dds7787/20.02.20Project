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
function gb_search(){
	document.form1.action="${path}/guest_sevlet/searchto.do";
	document.form1.submit();
}


//검색
$(document).ready(function(){
  $("#myInput").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#myTable tr").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
    });
  });
});

function list(page){//페이지
	location.href="${path}/guest_servlet/list.do?curPage="+page;
}
//로그아웃
$(function(){
	$("#btnLogout").click(function(){
		location.href="${path}/log_servlet/logout.do";
	});
});

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

<%-- <form name="form1" id="form1" method="post">
 <select name="searchkey" id="searchkey">
<c:choose>
	<c:when test="${searchkey == 'name' }">
		<option value="name" selected>이름</option>
		<option value="content">내용</option>
		<option value="name_content">이름+내용</option>
	</c:when>
	<c:when test="${searchkey == 'content' }">
		<option value="name">이름</option>
		<option value="content" selected>내용</option>
		<option value="name_content">이름+내용</option>
	</c:when>
	<c:when test="${searchkey == 'name_content' }">
		<option value="name">이름</option>
		<option value="content">내용</option>
		<option value="name_content" selected>이름+내용</option>
	</c:when>
</c:choose>

</select>
<input name="search" id="search" value="${search}">
<input type="button" value="조회" onclick="gb_search()">
</form> --%>

<input type="button" value="글쓰기" 
onclick="location.href='${path}/guest/write.jsp'" class="btn btn-primary btn-block">
<br>

<c:forEach var="dto" items="${list}"> 
<form method="post" action="${path}/guest_servlet/passwd_check.do">
<!-- 편집을 위해서는 게시물 번호가 필요함 -->
<input type="hidden" name="idx" value="${dto.idx}">

<table class="table table-bordered table-striped">
<tbody id="myTable">
  <tr>
    <td>이름</td>
    <td>${dto.name}</td>
    <td>날짜</td>
    <td>${dto.post_date}</td>
  </tr>
  <tr>
    <td>이메일</td>
    <td colspan="3">${dto.email}</td>
  </tr>
  <tr>
    <td colspan="4">${dto.content}</td>
  </tr>
  <tr>
    <td colspan="4">
      비밀번호 <input type="password" name="passwd">
      <input type="submit" value="수정/삭제" class="btn btn-info">
    </td>
  </tr>
</c:forEach>
</tbody>
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
</form>


</body>
</html>