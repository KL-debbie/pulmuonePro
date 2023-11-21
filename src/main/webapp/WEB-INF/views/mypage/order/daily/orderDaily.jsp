<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="servlets.mypage.dto.BoxOrderListDTO"%>
<%@page import="servlets.order.domain.BoxOrderProductDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/layouts/head.jsp" %>
<script src="/resources/assets/js/owl.carousel.min.js"></script>
<script src="/resources/assets/js/clipboard.min.js"></script>
<script src="/resources/assets/js/fdd.js"></script>
<body>
<script type="text/javascript">
	$(document).ready(function () {
        $(".visual-area").fddCarousel({ auto: 5000 });
		$(".event-area").fddCarousel({ auto: 5000, activeClick: true });
		$('.prd-list.owl-carousel').owlCarousel({
            items: 4,
            nav: true,
		  loop:false
		});		
	});		
</script>
<script type="text/javascript" src="/resources/assets/js/message.js"></script>

	<div class="wrapper">
		<%@ include file="/WEB-INF/views/layouts/header.jsp"%>
		<main class="page">
			<div id="container-wrapper" class="container-wrapper">
			
				<div class="breadcrumb-style">
					<div class="container">
						<ul>
							<li><a href="/">홈</a></li>
							<li><a href="/mypage">MY녹즙</a></li>
							<li><a class="" href="/mypage/drink/drink">매일배송 음용내역</a></li>
							<li><a class="active" href="/mypage/drink/drink">음용내역</a></li>
						</ul>
					</div>
				</div>			
			
				<div class="container aside-layout" style="padding-bottom:120px; ">
	
					<%@ include file="/WEB-INF/views/layouts/mypage/aside.jsp" %>

						<div class="container">

							<div class="border-wrapper">
								<h2 class="container-title">음용내역</h2>
							</div>
							
							<form id="searchForm">
								<input name="drinkingType" type="hidden" value="Y">
								<div class="page-addiction-wrapper">
									<div class="info-copy"></div>
									<div class="form-input select" style="width:348px;">
										<dl>
											<dt style="padding-left:20px;">
												<label>음용고객번호</label>
											</dt>
											<dd>
												<div class="dropdown">
													<a id="searchText" class="btn dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-expanded="false">음용중</a>
													<div class="dropdown-menu">
														<a class="dropdown-item" data-value="Y">음용중</a>
														<a class="dropdown-item" data-value="N">음용중지</a>
													</div>
												</div>
											</dd>
										</dl>
									</div>
								</div>
							</form>
							

							<div class="drinking-list" data-list-object="append" id="drink-items">
							
								<c:choose>
									<c:when test="${ drinkingType eq 'N' }">
										<div class="caution-unit page">
											<span class="mark"></span>
											<p>음용내역이 없습니다.</p>
											<p class="small-xs">아래 고객번호찾기 또는 1:1문의 게시판을 통해 문의주세요.</p>
										</div>
									</c:when>
									
									<c:otherwise>
										<form class="item">
											<input type="hidden" name="custNumber" value="230000234094">
											<input type="hidden" name="orderNumber" value="18369285571027001056">
											<input type="hidden" name="prtnNm" value="서초홈가맹점">
											<input type="hidden" name="phoneNo" value="01038994569">
											<input type="hidden" name="telNo" value="025470519">
											
											<div class="head">
													<div class="nickname-format xxl">
														<label>기본</label>
														<h5>음용1</h5>
														<span>1</span>
													</div>
												<ul class="info">
													<li>
														<label>담당가맹점</label>
														<p>강남홈가맹점</p>
													</li>
													<li>
														<label>음용시작일</label>
														<p>2023.10.04</p>
													</li>
													<li>
														<label>결제수단</label>
														<textarea style="display: none">{"isComplex":false,"hasExternal":false,"hasHp":true,"hpStartDate":"2023.10.31"}</textarea>
														<textarea style="display: none">{"totalCount":0,"intfacId":"0","drnkCustNm":"신종혁","dlvyCustYn":"Y","cphnno":"01023442891","prtnNm":"서초홈가맹점","prtnId":"23812","buTelNo":"025470519","prtnChfCphnNo":"01038994569","dlvyAddr1":"서울 서초구 청두곶2길 6","dlvyAddr2":"469-9 303호 ","dlvyDrAddr1":"서울 서초구 청두곶2길 6","dlvyDrAddr2":"469-9 303호 ","startDate":"2023.10.31","contractYn":"N","boxYn":"N","rceitKndCd":"50","rceitKnd":"CMS","bankName":"(구)외환은행","acno":"**********","prtnChnl":"CH63","resultMsg":"신규승인","orderNumber":"18369285571027001056","eventYn":"N","acqrSourc":"RR11","cancelAgreementYn":"N"}</textarea>
														<p data-parse-paymethod="">카드결제</p>
													</li>
												</ul>
											</div>
											
											<div class="tail">
												<a class="rounded-button" href="/mypage/order/daily/orderDailyView.do?orderNo=1">상세보기 / 변경</a>
												<div class="button-text-set"></div>
											</div>
										</form>
									</c:otherwise>
								</c:choose>
							</div>
		
							<div class="alert-area lg">
								<h4>고객번호 찾기/등록 안내</h4>
								<ul>
									<li>
										음용중이시나 고객번호 확인이 되지 않으시는 경우에는
										<button class="button-text" type="button" data-toggle="modal" data-target="#numberModal">고객번호찾기</button>
										를 통해 확인해보세요.
									</li>
									<li>'고객번호찾기'를 통해 고객번호 확인이 어려우신 경우에는 홈페이지 1:1 문의 또는 배송가맹점을 통해 문의하세요.</li>
								</ul>
							</div>
							
						</div>
					</div>
			</div>
		
					<div style="" id="mini-side-nav">
						<a href="/mypage/drink/drink"><img src="/resources/assets/images/ui/quick1.png" alt=""></a>
						<a id="quickChangeDrink" href="/mypage/drink/drink"><img src="/resources/assets/images/ui/quick2.png" alt=""></a>
						<a id="quickChangeSchedule" href="/mypage/drink/drink"><img src="/resources/assets/images/ui/quick3.png" alt=""></a>
						<a href="/mypage/drink/bill"><img src="/resources/assets/images/ui/quick4.png" alt=""></a>
						<a href="#"><img src="/resources/assets/images/ui/quickTop.png" alt=""></a>
					</div>

		</main>
	</div>

		<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
		
		<div class="modal fade" id="alertModal" tabindex="-1" aria-labelledby="alertModalLabel" style="display: none;" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="alertModalLabel"></h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						</button>
					</div>
					<div class="modal-body">주문취소된 상품입니다.</div>
					<button type="button" class="modal-footer" data-dismiss="modal">확인</button>
				</div>
			</div>
		</div>
		
		<div class="modal fade" id="confirmModal" tabindex="-1" aria-labelledby="confirmModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="confirmModalLabel"></h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						</button>
					</div>
					<div class="modal-body">
					</div>
					<div class="modal-footer">
						<button type="button" class="cancel" data-dismiss="modal">취소</button>
						<button type="button" class="confirm">확인</button>
					</div>
				</div>
			</div>
		</div>
		
		<div class="modal fade" id="numberModal" tabindex="-1" aria-labelledby="numberModal" aria-hidden="true">
			<div class="modal-dialog basic-width modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header" style="border:0; padding:20px 28px 14px 30px;">
						<h5 class="modal-title" id="numberModalLabel">고객번호등록</h5>
						<button style="margin-top:5px;" type="button" class="close" data-dismiss="modal" aria-label="Close"></button>
					</div>
					<div style="padding:0 30px 40px">
						<div class="form-input">
							<dl>
								<dt style="min-width: 107px"><label>휴대폰번호</label></dt>
								<dd>
									<input id="phoneNumber" maxlength="13" data-call-text="" type="hidden">
									<input maxlength="13" type="text" name="_x_undefined">
								</dd>
							</dl>
						</div>
						<div class="form-input">
							<dl>
								<dt style="min-width: 107px"><label>고객번호</label></dt>
								<dd>
									<input class="numberOnly" id="custNumber" type="text">
								</dd>
							</dl>
						</div>
					<div class="form-input">
							<dl>
								<dt style="min-width: 107px"><label>애칭</label></dt>
								<dd>
									<input id="nickname" maxlength="5" type="text">
								</dd>
							</dl>
						</div>
					</div>
					<div class="button-set">
						<button id="register" type="button" class="button-basic primary">등록하기</button>
					</div>
				</div>
			</div>
		</div>

<script>
	// 음용중, 음용중지 검색
	$(".dropdown-item").on("click", function() {
		location.href = "/mypage/order/daily.do?drinkingType="+$(this).attr("data-value");
	})
	
	$(function () {
		function getUrlParams() {
			var params = {};
			window.location.search.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(str, key, value) { params[key] = value; });
			return params;
		}

		// getUrlParams() 함수를 사용하여 쿼리 매개변수 추출
		var params = getUrlParams();
		console.log(params);
		// 출력: { name: 'John', age: '25', city: 'seoul' }

		// 특정 쿼리 매개변수 값 가져오기
		var drinkingType = params.drinkingType;

		if (drinkingType == 'Y') $("#searchText").text("음용중");
		else $("#searchText").text("음용중지");
	})
</script>

</body>

</html>