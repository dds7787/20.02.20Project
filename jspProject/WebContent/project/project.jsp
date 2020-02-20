<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>

<%@ include file="../include/header.jsp" %>

<script src="../include/jquery-3.4.1.min.js"></script>

<link type="text/css" rel="stylesheet" href="../project/project.css">
<script type="text/javascript">
$(function(){
  	var menu1=$('#menu1');
  	    menu=$('nav ul');
  	    menuHeight=menu.height();   	      
  $(menu1).on('click', function(e){
  	e.preventDefault();
  	menu.slideToggle();   	      	
  });
/*   $(window).resize(function(){
  	var w=$(window).width();
  	if(w>500 && menu.is(':hidden'))
  		{menu.removeAttr('style');}
    	carousel_setImgPosition();
  }); */
});


var time;
var $slude1;
var slude2;
var index;
var slude3;

var imgs;
$(document).ready(function(){

carouselInit(300,5000);
});

$(window).resize(function(){
carousel_setImgPosition();
});

function carouselInit( height, t ){
time = t;
$("#slude").height(height);
$slude1 = $("#slude > ul >li");
slude2 = $slude1.length;
index = 0;
carousel_setImgPosition();
carousel();
}


function carousel_setImgPosition(){
imgs = $slude1.width();
for(var i = 0; i < slude2; i++)
{
	if( i == index)
	{
		$slude1.eq(i).css("left", 0);
	}
	else
	{
		$slude1.eq(i).css("left", imgs);
	}
}
}

function carousel(){
slude3 = setInterval(function(){
	var left = "-" + imgs;

	$slude1.eq(index).animate( { left: left }, function(){
		$slude1.eq(index).css("left", imgs);

		if( index == ( slude2 - 1 ) )
		{
			index = 0;
		}
		else
		{
			index ++;
		}
	} );
	if( index == ( slude2 - 1 ) )
	{
		$slude1.eq(0).animate( { left: 0 } );
	}
	else
	{
		$slude1.eq(index + 1).animate( { left: 0 } );
	}
}, time);
}

</script>

</head>
<body>

<div id="container">
   	   <nav class="a1">
   	      <a id="menu1" href="#">Menu</a>
   	   <ul>
   	        <li><a href="../project/index.jsp">미디어vod</a></li>
   	         <li><a href="#">공지사항</a></li>
   	         <li><a href="../media_servlet/list.do">영화소식</a></li>
   	         <li><a href="#">드라마소식</a></li>
   	         <li><a href="#">미드소식</a></li>
            <li><a href="#">로그인</a></li>
   	   </ul>
   	      <ul class="b1">
   	      </ul>
   	  </nav><br>
   	  
<header>
<div id="slude">
 <ul>
  <li><img src="images/김사부6.jpg"></li>
  <li><img src="images/스토브6.jpg"></li>
  <li><img src="images/김사부6.jpg"></li>
  <li><img src="images/스토브6.jpg"></li>
 </ul>
</div>
 </header>
   	  
 <article>
  <section>
    <h2>영화</h2>
    <div>
     <img alt="content사진" src="">
    <ul>
     <li>멜로</li>
     <li>스릴러</li>
     <li>SF</li>
    </ul>
    </div>
  </section>
 </article>
 
 <div id="sidebar"><!--오른쪽알림메뉴  -->
  <h3>공지사항</h3>
  <ul>
    <li>공지사항</li>
    <li>공지사항1</li>
  </ul>
  <img alt="" src="">
  <img alt="" src="">
 </div>
 
 <footer><!--마지막  -->
  <p>주소입력란</p>
  <address>
   전화번호이메일등등쓰기
   <a href="#">test@gmail.com</a>
  </address>
  <p>Copyright &copy; All rights reserved.</p>
 </footer>
</div>

</body>
</html>