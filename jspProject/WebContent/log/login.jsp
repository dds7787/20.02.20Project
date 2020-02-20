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
	$("#btnSave").click(function(){
		var param="userid="+$("#userid").val()
		+"&passwd="+$("#passwd").val()
		+"&name="+$("#name").val()
		+"&resident="+$("#resident").val()
		+"&email="+$("#email").val()
		+"&hp="+$("#hp").val();
		$.ajax({
			type: "post",
			url: "${path}/log_servlet/join.do",
			data: param,
			success: function(result){
				alert("추가되었습니다.");
			}
		});
	});
});

  $(function(){
	$("#no").click(function(){
		$ajax({
			type: "post",
			url: "${path}/drama_servlet/list.do",
			data: param,
			success: function(result){
				alert("취소되었습니다.");
			}
		});
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
        <li><a href="../log/log.jsp"><span class="glyphicon glyphicon-log-in"></span> 로그인</a></li>
        <li><a href="#"><span></span>회원가입</a></li>
      </ul>
    </div>
  </div>
</nav>

<div class="container">
  <h2>이용약관동의</h2>
  <form>
    <div class="form-group">
      <label for="comment">개인정보 수집 및 이용에 대한 안내:</label>
      <textarea class="form-control" rows="5" id="comment">
      정보통신망법 규정에 따라 미디어vod에 회원가입 
	신청하시는 분께 수집하는 개인정보의 항목, 개인정보의 수집 및 이용목적, 개인정보의 
      보유 및 이용기간을 안내 드리오니 자세히 읽은 후 동의하여 주시기 바랍니다.
     1. 수집하는 개인정보
      이용자는 회원가입을 하지 않아도 검색,미리 보기 등 
      대부분의 미디어vod 서비스를 회원과 동일하게 이용할 수 있습니다. 
      이용자가 검색,미리보기  등과 같이 개인화 혹은 회원제 서비스를 
	이용하기 위해 회원가입을 할 경우, 미디어vod는 서비스 이용을 위해 
	필요한 최소한의 개인정보를 수집합니다.

      회원가입 시점에 미디어vod가 이용자로부터 수집하는 개인정보는 아래와 같습니다.
     - 회원 가입 시에 ‘아이디, 비밀번호, 이름, 생년월일, 이메일, 휴대전화번호’를 필수항목으로 수집합니다. 만약 이용자가 입력하는 생년월일이 만14세 미만 아동일 경우에는 법정대리인 정보(법정대리인의 이름, 생년월일, 이메일, 중복가입확인정보(DI), 휴대전화번호)를 추가로 수집합니다. 그리고 선택항목으로 프로필 정보를 수집합니다.
     - 단체아이디로 회원가입 시 단체아이디, 비밀번호, 단체이름, 이메일주소, 휴대전화번호를 필수항목으로 수집합니다. 그리고 단체 대표자명을 선택항목으로 수집합니다.
      서비스 이용 과정에서 이용자로부터 수집하는 개인정보는 아래와 같습니다.  
	 
	 
	 
	 미디어vod 내의 개별 서비스 이용, 이벤트 응모 및 경품 신청 과정에서 
	 해당 서비스의 이용자에 한해 추가 개인정보 수집이 발생할 수 있습니다. 
	 추가로 개인정보를 수집할 경우에는 해당 개인정보 수집 시점에서 이용자에게 
	 ‘수집하는 개인정보 항목, 개인정보의 수집 및 이용목적, 개인정보의 보관기간’에 
	 대해 안내 드리고 동의를 받습니다.

       서비스 이용 과정에서 IP 주소, 쿠키, 서비스 이용 기록, 기기정보, 위치정보가 
	 생성되어 수집될 수 있습니다. 또한 이미지 및 음성을 이용한 검색 서비스 등에서 
	 이미지나 음성이 수집될 수 있습니다.
       구체적으로 1) 서비스 이용 과정에서 이용자에 관한 정보를 자동화된 방법으로 생성하여 
	 이를 저장(수집)하거나,
     2) 이용자 기기의 고유한 정보를 원래의 값을 확인하지 못 하도록 안전하게 변환하여 수집합니다. 
	 서비스 이용 과정에서 위치정보가 수집될 수 있으며,
       미디어vod에서 제공하는 위치기반 서비스에 대해서는 '미디어vod 위치정보 이용약관'에서 
	 자세하게 규정하고 있습니다.
       이와 같이 수집된 정보는 개인정보와의 연계 여부 등에 따라 개인정보에 해당할 수 있고, 
	 개인정보에 해당하지 않을 수도 있습니다.

     2. 수집한 개인정보의 이용
       미디어vod 및 미디어vod 관련 제반 서비스(모바일 웹 포함)의 회원관리, 서비스 개발・제공 및 향상, 
	 안전한 인터넷 이용환경 구축 등 아래의 목적으로만 개인정보를 이용합니다.

     - 회원 가입 의사의 확인, 연령 확인 및 법정대리인 동의 진행, 이용자 및 법정대리인의 본인 확인, 이용자 식별, 회원탈퇴 의사의 확인 등 회원관리를 위하여 개인정보를 이용합니다.
     - 콘텐츠 등 기존 서비스 제공(광고 포함)에 더하여, 인구통계학적 분석, 서비스 방문 및 이용기록의 분석, 개인정보 및 관심에 기반한 이용자간 관계의 형성, 지인 및 관심사 등에 기반한 맞춤형 서비스 제공 등 신규 서비스 요소의 발굴 및 기존 서비스 개선 등을 위하여 개인정보를 이용합니다.
     - 법령 및 네이버 이용약관을 위반하는 회원에 대한 이용 제한 조치, 부정 이용 행위를 포함하여 서비스의 원활한 운영에 지장을 주는 행위에 대한 방지 및 제재, 계정도용 및 부정거래 방지, 약관 개정 등의 고지사항 전달, 분쟁조정을 위한 기록 보존, 민원처리 등 이용자 보호 및 서비스 운영을 위하여 개인정보를 이용합니다.
     - 유료 서비스 제공에 따르는 본인인증, 구매 및 요금 결제, 상품 및 서비스의 배송을 위하여 개인정보를 이용합니다.
     - 이벤트 정보 및 참여기회 제공, 광고성 정보 제공 등 마케팅 및 프로모션 목적으로 개인정보를 이용합니다.
     - 서비스 이용기록과 접속 빈도 분석, 서비스 이용에 대한 통계, 서비스 분석 및 통계에 따른 맞춤 서비스 제공 및 광고 게재 등에 개인정보를 이용합니다.
     - 보안, 프라이버시, 안전 측면에서 이용자가 안심하고 이용할 수 있는 서비스 이용환경 구축을 위해 개인정보를 이용합니다.
     3. 개인정보의 파기
       회사는 원칙적으로 이용자의 개인정보를 회원 탈퇴 시 지체없이 파기하고 있습니다.
       단, 이용자에게 개인정보 보관기간에 대해 별도의 동의를 얻은 경우, 
	 또는 법령에서 일정 기간 정보보관 의무를 부과하는 경우에는 
	 해당 기간 동안 개인정보를 안전하게 보관합니다.

      이용자에게 개인정보 보관기간에 대해 회원가입 시 또는 서비스 가입 시 
	동의를 얻은 경우는 아래와 같습니다.
      부정가입 및 징계기록 등의 부정이용기록은 부정 가입 및 이용 방지를 위하여 
	수집 시점으로부터 6개월간 보관하고 파기하고 있습니다. 
	부정이용기록 내 개인정보는 가입인증 
	휴대폰 번호(만 14세 미만 회원의 경우 법정대리인 DI)가 있습니다.
      부정이용으로 징계를 받기 전에 회원 가입 및 탈퇴를 
	반복하며 서비스를 부정 이용하는 사례를 막기 위해 
	탈퇴한 이용자의 휴대전화번호를 복호화가 불가능한 
	일방향 암호화(해시 처리)하여 6개월간 보관합니다. 
	QR코드 서비스에서 연락처를 등록한 이후 
	QR코드 삭제 시, 복구 요청 대응을 위해 삭제 시점으로 부터 
	6개월 보관합니다. 
	스마트 플레이스 서비스에서 휴대전화번호를 등록한 경우 
	분쟁 조정 및 고객문의 등을 목적으로 업체 등록/수정 요청시, 또는 
	등록 이후 업체 삭제 요청 시로부터 최대 1년간 보관 할 수 있습니다.

      전자상거래 등에서의 소비자 보호에 관한 법률, 
      전자금융거래법, 통신비밀보호법 등 법령에서 일정기간 정보의 
      보관을 규정하는 경우는 아래와 같습니다. 
      미디어vod는 이 기간 동안 법령의 규정에 따라 개인정보를 보관하며, 
      본 정보를 다른 목적으로는 절대 이용하지 않습니다.
    - 전자상거래 등에서 소비자 보호에 관한 법률
      계약 또는 청약철회 등에 관한 기록: 5년 보관
      대금결제 및 재화 등의 공급에 관한 기록: 5년 보관
     소비자의 불만 또는 분쟁처리에 관한 기록: 3년 보관
    - 전자금융거래법
     전자금융에 관한 기록: 5년 보관
    - 통신비밀보호법
     로그인 기록: 3개월
     회원탈퇴, 서비스 종료, 이용자에게 동의받은 개인정보 보유기간의 
     도래와 같이 개인정보의 수집 및 이용목적이 달성된 개인정보는 
     재생이 불가능한 방법으로 파기하고 있습니다. 
     법령에서 보존의무를 부과한 정보에 대해서도 해당 기간 경과 후 
     지체없이 재생이 불가능한 방법으로 파기합니다.

     전자적 파일 형태의 경우 복구 및 재생이 되지 않도록 기술적인 방법을 
     이용하여 안전하게 삭제하며, 출력물 등은 분쇄하거나 소각하는 방식 등으로 파기합니다.

     참고로 미디어vod는 ‘개인정보 유효기간제’에 따라 1년간 서비스를 
     이용하지 않은 회원의 개인정보를 별도로 분리 보관하여 관리하고 있습니다. 
      </textarea>
    </div>
  </form>
</div>

<div class="container">
  <form>
    <label class="radio-inline">
      <input type="radio" name="optradio" checked>약관에동의
    </label>
    <label class="radio-inline">
      <input type="radio" name="optradio">약관에동의하지않음
    </label>
  </form>
</div>


  <form action="${path}/drama_servlet/list.do"> <!-- name="form1" method="post" action="${path}/drama_servlet/list.do" -->
    <div class="form-group">
      <label>아이디:</label><!--for="userid"  -->
      <input id="userid" class="form-control" placeholder="아이디">
    </div>
    <div class="form-group">
      <label>비밀번호:</label><!--for="passwd"  -->
      <input type="password" class="form-control" id="passwd" placeholder="비밀번호">
    </div>
    
    <div class="form-group">
      <label>이름:</label>
      <input id="name" class="form-control" placeholder="이름">
    </div>
    <div class="form-group">
      <label>주민번호앞자리:</label>
      <input id="resident" class="form-control" placeholder="예)200115">
    </div>
    <div class="form-group">
      <label>이메일:</label>
      <input id="email" class="form-control" placeholder="이메일">
    </div>
    <div class="form-group">
      <label>핸드폰:</label>
      <input id="hp" class="form-control" placeholder="전화번호">
    </div>
    
    <button id="btnSave" class="btn btn-default">회원가입</button>
    <button id="no" class="btn btn-default">회원가입취소</button>
  </form>


</body>
</html>