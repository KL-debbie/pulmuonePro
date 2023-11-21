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
							<h2 class="container-title">음용중지신청</h2>
						</div>
						
						<div class="drinking-list">
							<div class="item" style="margin-bottom:10px;">
								<div class="head">
									<div class="nickname-format xxl">
										
											<label class="basic">기본</label>
										
										<h5>음용1</h5>
										<span>1</span>
									</div>
									<ul class="info" style="margin-top:15px; margin-bottom:2px;">
										<li>
											<label>담당 가맹점</label>
											<p>서초홈가맹점</p>
										</li>
										<li>
											<label>음용기간</label>
											<p>2023.10.05 ~</p>
										</li>
										<li>
											<label>결제수단</label>
											<p>카드결제</p>
										</li>
									</ul>
								</div>
							</div>
						</div>
						
						<div class="out-partition" style="padding-top:23px;">
							<div class="title">음용중지 사유</div>
							<div class="box-partition" style="margin-bottom:20px;">
								<div class="part" style="padding-top:18px;">
									<div class="vertical-radio-group">
										<label>
											<input value="r1" name="reasonCode" checked="" type="radio">
											<div class="radio-display"></div>
											<p>구매의사가 없다.</p>
										</label>
										<label>
											<input value="r2" name="reasonCode" type="radio">
											<div class="radio-display"></div>
											<p>이용한 상품 및 서비스에 불만족스럽다.</p>
										</label>
										<label>
											<input value="r3" name="reasonCode" type="radio">
											<div class="radio-display"></div>
											<p>타 상품 및 서비스를 이용하고자 한다.</p>
										</label>
										<label>
											<input value="r4" name="reasonCode" type="radio">
											<div class="radio-display"></div>
											<p>홈페이지 회원 혜택이 적다.</p>
										</label>
										<label>
											<input value="r5" name="reasonCode" type="radio">
											<div class="radio-display"></div>
											<p>기타 사유</p>
										</label>
										<div class="form-input none-dt" style="padding-left:40px; margin-top:4px;">
											<dl>
												<dt><label>기타 사유 입력</label></dt>
												<dd>
													<input disabled="" name="reasonDtl" type="text" placeholder="기타사유를 작성해주세요.">
												</dd>
											</dl>
										</div>
									</div>
								</div>
								
								<div class="part">
									<div class="form-input period">
										<dl class="date-complex">
											<dt style="padding-left:20px; width:125px;"><label>희망중지일</label></dt>
											<dd>
												<div>
													<input type="text" readonly="" name="startDate" data-placeholder="날짜를 입력하세요." required="" aria-required="true" value="2023. 11. 24">
												</div>
											</dd>
										</dl>
									</div>
								</div>
							</div>
				
							<span style="padding-left:3px; margin-bottom:10px;display: block" class="foot-copy">
								※ 음용 중지는 가맹점에서 확인 후 진행됩니다. (타 쇼핑몰 주문 건은 홈페이지에서 음용 중지 신청이 불가합니다.)
							</span>
							<span style="padding-left:3px;" class="foot-copy">
								※ 음용 중지일은 영업일 기준 D+3일로 신청 가능합니다. 그 외 원하시는 중지 일정은 1:1 문의 게시판 또는 가맹점을 통해 문의해주세요.
							</span>
				
							<div class="btn-area-right" style="margin-top: 20px">
								<a style="cursor:pointer;padding:0; width:140px;" id="cancel" class="btn-default btn-white">취소</a>
								<button id="requestBtn" class="btn-default">음용중지신청</button>
							</div>
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
		
</body>

</html>