<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>풀무원 녹즙 | 맞춤큐레이션</title>
<meta name="description" content="하루 한 병 건강한 습관 풀무원녹즙, 신선한 채소와 과일의 영양을 매일 아침 배송합니다.">
<meta name="viewport"     content="width=device-width,initial-scale=1.0">
<script src="/resources/assets/js/jquery-2.1.4.min.js"></script>
<script src="/resources/assets/js/jquery.form.min.js"></script>


<link rel="stylesheet" href="/resources/assets/css/bootstrap.min.css">
<link rel="stylesheet" href="/resources/assets/css/bootstrap-fdd.css">
<script src="/resources/assets/js/bootstrap.bundle.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js" ></script>
<script src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js" integrity="sha384-DRe+1gYJauFEenXeWS8TmYdBmDUqnR5Rcw7ax4KTqOxXWd4NAMP2VPU5H69U7yP9" crossorigin="anonymous"></script>
<script src="/resources/assets/js/clipboard.min.js"></script>
<script src="/resources/assets/js/fdd.js"></script>
<script src="/resources/assets/js/request.js"></script>
<!-- 	<link rel="stylesheet" href="/resources/assets/css/contents_v1.css"> -->

	<link rel="stylesheet" href="/resources/assets/css/owl.carousel.min.css"/>
	<link rel="stylesheet" href="/resources/assets/css/owl.theme.default.css"/>
	<script src="/resources/assets/js/owl.carousel.min.js"></script>

<!-- 	<link rel="stylesheet" href="/resources/assets/css/layout_style.css"> -->
<!-- 	<link rel="stylesheet" href="/resources/assets/css/a-guide.css"> -->
<!-- 	<link rel="stylesheet" href="/resources/assets/css/contents2.css"> -->

	<link rel="stylesheet" href="/resources/assets/css/daterangepicker.css"/>
	<script src="/resources/assets/js/daterangepicker.js"></script>
	<link rel="stylesheet" href="/resources/assets/css/style.css">
<link rel="shortcut icon" type="image/x-icon" href="/resources/assets/images/pul_favicon.png">
</head>
<body>
<div class="wrapper">
<%@ include file="/WEB-INF/views/layouts/header.jsp" %>
<main class="step1">
<div id="container-wrapper" class="container-wrapper"> <!-- TODO : 회원쪽 페이지들은 <div class="container-wrapper member"> -->

<!-- <form id="customerForm" action="/customer/product/result/result.do" method="post"> -->
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
					<a href="/customer/product/step1.do" style="font-size: 16px" class="button-basic primary sessionReset">맞춤큐레이션 시작</a>
				</div>
				<div class="kids-depth" style="padding-top: 30px">
					<div class="text-wrapper" style="margin-bottom: 35px">
						<h3>
							혹시<br/>
							<b>키즈제품</b>을 원하시나요?
						</h3>
					</div>
					<a href="/customer/product/result/kids.do?singleYn=N" class="button-basic border" style="font-size: 16px">키즈제품 바로가기</a>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- </form> -->
</div>

<!--E:cbody-->

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
	<a href="/mypage/drink/drink"><img src="/resources/images/ui/quick1.png" alt=""></a>
	<a id="quickChangeDrink" href="/mypage/drink/drink"><img src="/resources/images/ui/quick2.png" alt=""></a>
	<a id="quickChangeSchedule" href="/mypage/drink/drink"><img src="/resources/images/ui/quick3.png" alt=""></a>
	<a href="/mypage/drink/bill"><img src="/resources/images/ui/quick4.png" alt=""></a>
	<a href="#"><img src="/resources/images/ui/quickTop.png" alt=""></a>
</div>
</main>
<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
</div>
</body>
</html>