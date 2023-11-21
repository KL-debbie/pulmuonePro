<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/views/layouts/head.jsp"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.time.temporal.ChronoUnit"%>
<%@ page import="java.time.format.DateTimeParseException"%>
<%
LocalDate now = LocalDate.now();
%>

<body>
	<div class="wrapper">
		<%@ include file="/WEB-INF/views/layouts/header.jsp"%>
		<main class="page forum">
			<div class="breadcrumb-style">
				<div class="container">
					<ul>
						<li><a href="/">홈</a></li>
						<li><a href="/mypage.do">MY녹즙</a></li>
						<li><a class="active" href="">쿠폰</a></li>
					</ul>
				</div>
			</div>
			<div class="container aside-layout" style="padding-bottom: 120px;">
				<%@ include file="/WEB-INF/views/layouts/mypage/aside.jsp"%>
				<div class="container">
					<div class="border-wrapper">
						<h2 class="container-title">쿠폰</h2>
						<div class="page-tab">
							<a href="/mypage/benefit/coupon.do" class="active">전체</a> <a
								href="/mypage/benefit/coupon?type=CPTP012">매일배송</a> <a
								href="/mypage/benefit/coupon?type=CPTP013">택배배송</a>
							<button style="margin-left: 20px; color: #7acc12"
								onclick="openWindowPop('/resources/assets/images/common/couponGuide.png','popup')"
								target="img">쿠폰사용가이드</button>
						</div>
					</div>
					<div class="coupon-srch">
						<form id="registCoupon">
							<div class="form-input none-dt">
								<dl>
									<dt>
										<label>쿠폰번호</label>
									</dt>
									<dd>
										<input type="text" name="code" placeholder="쿠폰번호를 입력하세요.">
										<button class="btn-square">쿠폰등록</button>
									</dd>
								</dl>
							</div>
						</form>
					</div>
					<div class="page-addiction-wrapper"
						style="align-items: center; margin-bottom: 2px;">
						<div class="info-copy"></div>
						<div class="price-tag coupon right">
							<label>사용가능한 쿠폰</label>
							<p class="value">${usableCoupons}</p>
						</div>
					</div>
					<div class="coupon-item-list">
						<ul id="pagable-list" data-list-object="append">
							<c:forEach var="coupon" items="${couponInfoList}" varStatus="status">
							<c:set var="haveCoupon" value="${couponList[status.index]}" />
												<c:set var="expiryDateObj" value="${haveCoupon.expiry_date}" scope="page" />
												<%
													LocalDate expiryDate = null;
													Object expiryDateObj = pageContext.getAttribute("expiryDateObj");
													LocalDate today = LocalDate.now();
	
													if (expiryDateObj instanceof java.sql.Date) {
														expiryDate = ((java.sql.Date) expiryDateObj).toLocalDate();
													} else if (expiryDateObj instanceof String) {
														try {
															expiryDate = LocalDate.parse((String) expiryDateObj);
														} catch (DateTimeParseException e) {
															e.printStackTrace();
														}
													}
	
													long daysLeft = expiryDate != null ? ChronoUnit.DAYS.between(today, expiryDate) : 0;
												%>
								<% if (daysLeft >= 1) { %>
								<li>
								    <c:choose>
							            <c:when test="${haveCoupon.used == 1}">
							                <div class="item disabled">
							            </c:when>
							            <c:otherwise>
							                <div class="item ">
							            </c:otherwise>
							        </c:choose>
										<div style="min-height: 175px" class="body">
											<div
												style="display: flex; justify-content: space-between; min-height: 35px">
												<h4>${coupon.coupon_name}</h4>
												<c:if test="${haveCoupon.used != 1}">
												    <a style="padding: 0 18px; font-size: 13px; height: 34px" href="/mypage/drink/bill" class="rounded-button">사용하러가기</a>
												</c:if>
											</div>
											<div class="date">
												<p>${haveCoupon.issue_date}~${haveCoupon.expiry_date}</p>
												<span><%=daysLeft%>일 남음</span>
											</div>
											<ul>
												<li>${coupon.duplication == 0 ? '중복사용가능' : '중복사용 불가능'}</li>
												<li class="prtn">${coupon.delivery_type == 0 ? '전 매일배송상품 사용가능' : '전 택배배송상품 사용가능'} &nbsp;&nbsp;/&nbsp;&nbsp;
													전 가맹점 사용가능</li>
											</ul>
										</div>
										<div class="foot">
											<p class="price">
											    <c:choose>
											        <c:when test="${coupon.discount < 1}">
											            <fmt:formatNumber value="${coupon.discount}" type="number" minFractionDigits="2" maxFractionDigits="2" /><span>%</span>
											        </c:when>
											        <c:otherwise>
											            <fmt:formatNumber value="${coupon.discount}" type="number" pattern="#"/><span>원</span>
											        </c:otherwise>
											    </c:choose>
											</p>
											<p class="out">사용완료</p>
											<%-- <P>${haveCoupon.used}</P> --%>
										</div>
									</div>
								</li>
								<% } %>
							</c:forEach>
						</ul>
					</div>
					<div class="alert-area lg between"
						style="padding-top: 38px; margin-top: 30px">
						<h4 style="margin-bottom: 17px;">유의사항</h4>
						<ul>
							<li>매일 배송 상품에 사용 가능한 쿠폰은 매 월 25일까지 스마트청구서에서 적용 가능합니다.</li>
							<li>스마트청구서는 MY녹즙&gt;매일배송음용내역&gt;영수증조회에서 확인 가능합니다.</li>
							<li>스마트청구서에서 사용한 쿠폰은 사용 취소가 불가합니다.</li>
							<li>가맹점 사정에 따라 일부 쿠폰은 사용이 불가할 수 있습니다.</li>
						</ul>
					</div>
				</div>
		</main>
		<%@ include file="/WEB-INF/views/layouts/footer.jsp"%>
		<script>
			function OnloadImg(url) {
				var img = new Image();
				img.src = url;
				var img_width = img.width;
				var win_width = img.width + 25;
				var height = img.height + 30;
				var OpenWindow = window.open('', '_blank', 'width=' + img_width
						+ ', height=' + height
						+ ', menubars=no, scrollbars=auto');
				OpenWindow.document
						.write("<style>body{margin:0px;}</style><img src='"+url+"' width='"+win_width+"'>");
			}
		</script>
		<img src="/resources/assets/images/common/couponGuide.png"
			style="display: none" id="guideImage" alt="">
	</div>
</body>
</html>
