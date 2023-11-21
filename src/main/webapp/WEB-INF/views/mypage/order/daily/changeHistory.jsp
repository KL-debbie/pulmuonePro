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
							<li><a class="" href="/mypage/drink/drink">음용내역</a></li>
							<li><a class="active" href="/mypage/drink/drink">변경내역</a></li>
						</ul>
					</div>
				</div>			
			
				<div class="container aside-layout" style="padding-bottom:120px; ">
					<%@ include file="/WEB-INF/views/layouts/mypage/aside.jsp" %>
					
					<div class="container">
					
						<div class="border-wrapper">
							<h2 class="container-title">홈페이지 변경내역</h2>
						</div>
						
						<div class="page-addiction-wrapper">
							<div class="info-copy">
								<div class="box" style="flex:1; margin-bottom:13px;">
									<div class="nickname-format">
										<h5>음용1</h5>
										<span>1</span>
									</div>
								</div>
							</div>
						</div>
						
						<div class="nickname-list change">
							<ul>
								<li>
									<div class="flex-full nickname-format">
										<h5>배송일정변경</h5>
										<span>2023.11.02 신청</span>
									</div>
									<div class="flex">
										<button class="detailBtn rounded-button">상세보기</button>
									</div>
								</li>
								
								<li>
									<div class="flex-full nickname-format">
										<h5>음용상품변경</h5>
										<span>2023.11.01 신청</span>
									</div>
									<div class="flex">
										<button class="detailBtn rounded-button">상세보기</button>
									</div>
								</li>
								
								<li>
									<div class="flex-full nickname-format">
										<h5>음용상품변경</h5>
										<span>2023.11.01 신청</span>
									</div>
									<div class="flex">
										<button class="detailBtn rounded-button">상세보기</button>
									</div>
								</li>
							</ul>
						</div>
						
						<div class="alert-area lg">
							<h4>안내사항</h4>
							<ul>
								<li>배송일정변경 요청 시점과 조회 시점에 따라 일부 상이할 수 있습니다.
								</li>
								<li>변경하신 내역과 상이하신 경우 배송가맹점 또는
									홈페이지 1:1문의 게시판을 통해 문의해주세요.</li>
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
		
</body>

</html>