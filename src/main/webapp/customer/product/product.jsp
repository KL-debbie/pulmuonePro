<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
%>
<html lang="ko">
<head>
<title>풀무원 녹즙 | 맞춤큐레이션</title>
<meta name="description" content="하루 한 병 건강한 습관 풀무원녹즙, 신선한 채소와 과일의 영양을 매일 아침 배송합니다.">
<link rel="stylesheet" href="/pulmuonePro/customer/curation_css/contents2.css">
<link rel="stylesheet" href="/pulmuonePro/customer/curation_css/curation.css">
<link rel="stylesheet" href="/pulmuonePro/customer/curation_css/a-guide.css">
<link rel="stylesheet" href="/pulmuonePro/customer/curation_css/bootstrap.min.css">
<link rel="stylesheet" href="/pulmuonePro/customer/curation_css/curation01.css">
<link rel="stylesheet" href="/pulmuonePro/customer/curation_css/layout_style.css">
<link rel="shortcut icon" href="/pulmuonePro/resources/assets/images/pul_favicon.png">
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>

<style type="text/css">
@media (min-width: 768px){
.container, .container-md, .container-sm {
    max-width: 720px;
}
</style>
</head>
<body>

<div id="container-wrapper" class="container-wrapper"> <!-- TODO : 회원쪽 페이지들은 <div class="container-wrapper member"> -->

<form id="customerForm" action="/customer/product/result" method="post">
<input type="hidden" name="customerType" />
<input type="hidden" name="value" />
<div class="visual-area curation">
	<div class="container">
		<div class="txt-area">
			<p>나만을 위한</p>
			<h1>맞춤큐레이션</h1>
			<span>당신에게 맞는 녹즙 프로그램을 추천해드립니다.</span>
		</div>
	</div>
	<div class="bg-img"></div>
</div>
<div class="texture-depth">
	<div class="breadcrumb-style">
		<div class="container">
			<ul>
				<li><a>홈</a></li>
				<li><a class="active">맞춤큐레이션</a></li>
			</ul>
		</div>
	</div>
	<div class="selection-area">
		<div class="container" >
			<div class="selector" style="padding: 95px 0px 120px">
				<div class="curation-depth" style="padding-top: 30px">
					<div class="text-wrapper" style="margin-bottom: 35px">
						<h3>
							<b>건강목표, 식이섭취, 생활습관</b>에 대해서<br/>
							간단한 설문에 참여하시면 당신에게 맞는<br/>
							녹즙 프로그램을 큐레이션 해드립니다.
						</h3>
					</div>
					<a href="<%= path %>/customer/product/step1.jsp" style="font-size: 16px" class="button-basic primary sessionReset">맞춤큐레이션 시작</a>
				</div>
				<div class="kids-depth" style="padding-top: 30px">
					<div class="text-wrapper" style="margin-bottom: 35px">
						<h3>
							혹시<br/>
							<b>키즈제품</b>을 원하시나요?
						</h3>
					</div>
					<a href="<%=path %>/customer/product/result/kids.jsp?singleYn=N" class="button-basic border" style="font-size: 16px">키즈제품 바로가기</a>
				</div>
			</div>
		</div>
	</div>
</div>
</div>


<!--E:cbody-->
</form>

<script>

$(function(){

  axios.get('/user_summary/default').then(function (response) {

    const {info, customerVo} = response.data.RESULT_MSG;

		const ec = ( !info.overEnd) && (info.complex||info.hasHp) && customerVo.phiCustomerVo.intfacId == '0' && customerVo.phiCustomerVo.dlvyCustYn==='Y'
      if(ec&&customerVo){
        $('#quickChangeDrink').attr('href', `/mypage/drink/drink/change/${customerVo.custnumber}/${customerVo.prtnId}`)
        $('#quickChangeSchedule').attr('href', `/mypage/drink/drink/pause/${customerVo.custnumber}/${customerVo.prtnId}`)
      }else {
        $('#quickChangeDrink').attr('href', `/mypage?with=01`)
        $('#quickChangeSchedule').attr('href', `/mypage?with=01`)
      }
      console.log(window.innerWidth)
      if(window.innerWidth>1450){
        $('#mini-side-nav').show();
      }
  }).catch(function (error) {
    if(window.innerWidth>1450) {
      $('#mini-side-nav').show()
    }
	});
  window.addEventListener('resize', function(){
	  if(window.innerWidth>1450){
		$('#mini-side-nav').show();
	  }else {
		$('#mini-side-nav').hide();
	  }
	})

})

</script>
<div style="display: none" id="mini-side-nav">
	<a href="/mypage/drink/drink"><img src="/pulmuonePro/customer/curation_image/quick1.png" alt=""></a>
	<a id="quickChangeDrink" href="/mypage/drink/drink"><img src="/pulmuonePro/customer/curation_image/quick2.png" alt=""></a>
	<a id="quickChangeSchedule" href="/mypage/drink/drink"><img src="/pulmuonePro/customer/curation_image/quick3.png" alt=""></a>
	<a href="/mypage/drink/bill"><img src="/pulmuonePro/customer/curation_image/quick4.png" alt=""></a>
	<a href="#"><img src="/pulmuonePro/customer/curation_image/quickTop.png" alt=""></a>
</div>

</body>
</html>