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
	
	<div class="wrapper">
		<%@ include file="/WEB-INF/views/layouts/header.jsp"%>
		<main class="page">
			<div id="container-wrapper" class="container-wrapper"> <!-- TODO : 회원쪽 페이지들은 <div class="container-wrapper member"> -->

<script>
	var formatter = new Intl.NumberFormat();
	$(function () {
		if(false){
			alert("주문내역 중 취소가 불가능한 상품이 있습니다. 고객센터에 문의해주세요.",function (){
				location.href='/mypage/order/box.do';
			});
		} // if
		
		$('input[name=select-product]').prop('checked', true);
		$('input[name=select-product-all]').prop('checked', true);

		$('#select-all').click(function (){
			$('input[name=select-product]').prop('checked', $(this).is(':checked'));
			$('input[name=select-product-all]').prop('checked', $(this).is(':checked'));
		})

		$('input[name=select-product]').change(function () {
			var item = $('input[name=select-product]').length;
			var checkItem = $('input[name=select-product]:checked').length;

			if(item === checkItem)$('#select-all').prop('checked','checked')
			else $('#select-all').prop('checked',false)
		})

		// 쵀대값일 경우 + disabled

		$('.btn-plus').click(function () {
			alert("부분취소는 고객센터에 문의해주세요.");
			return;

			const maxQty = $(this).siblings('.box-qty').data('max-qty');
			const qty = $(this).siblings('.box-qty').text()
			// console.log(maxQty, qty)
			if(maxQty===parseInt(qty)){
				$(this).prop('disabled','disabled')
				return;
			}
			$(this).siblings('.box-qty').text(parseInt(qty) + 1)
			calculateBoxPrice($(this))
		})
		$('.btn-minus').click(function () {
			alert("부분취소는 고객센터에 문의해주세요.");
			return;

			$('.btn-plus').prop('disabled',false)
			const qty = $(this).siblings('.box-qty').text()
			if (qty > 1) {
				$(this).siblings('.box-qty').text(parseInt(qty) - 1)
				calculateBoxPrice($(this))
			}
		})

		$('.item').click(function(){
			var orders = 2;
			// 택배배송리스트 1개인 경우
			if(orders == 1) $(".select-product-checkbox.each").prop("disabled", false);
			else alert("부분취소는 고객센터에 문의해주세요.");
		})
	})
	
	function calculateBoxPrice(propThis) {
		let qty;
		if(propThis.is('.btn-plus')) qty = propThis.prev().text();
		else if(propThis.is('.btn-minus')) qty = propThis.next().text();

		// 가격 변동
		const eachPrice = propThis.parent().parent().parent().find('.value.origin').data('eachprice');
		propThis.parent().parent().parent().find('.value.origin').text(formatter.format(eachPrice * qty));

		// 세일가격 변동
		if(propThis.parent().parent().parent().find('.value').is('.value.sale')){
			const eachSalePrice = propThis.parent().parent().parent().find('.value.sale').data('eachprice');
			propThis.parent().parent().parent().find('.value.sale').text(formatter.format((eachPrice * qty)-(eachSalePrice * qty)));
		} // if

	}
</script>

<div class="breadcrumb-style">
	<div class="container">
		<ul>
			<li><a href="/">홈</a></li>
			<li><a href="/mypage">MY녹즙</a></li>
			<li><a class="" href="/mypage/order/box.do">택배배송 주문내역</a></li>
			<li><a class="" href="/mypage/order/box/cancel.do">주문취소하기</a></li>
		</ul>
	</div>
</div>

<div class="container aside-layout" style="padding-bottom:120px; ">
	
	<%@ include file="/WEB-INF/views/layouts/mypage/aside.jsp" %>

	<div class="container">
		<div class="border-wrapper">
			<h2 class="container-title">주문취소하기</h2>
		</div>
		
		<div class="page-addiction-wrapper" style="align-items: center; margin-bottom:23px;">
			<div class="info-copy" style="padding-left:2px; padding-top:9px;">
				<p class="detailsinfo">${ boxOrder.boxOrderDate.substring(0, 10) }</p>
				<p class="detailsinfo"><label>주문번호</label>${ boxOrder.boxOrderNo }</p>
			</div>
		</div>
		
		<div class="box-partition" style="margin-bottom:12px; padding:0 20px; height:60px;">
			<label class="check-type">
				<input type="checkbox" class="select-product-checkbox" id="select-all" name="select-product-all">
				<span style="font-size:16px; margin-bottom:4px; padding-left:51px;">전체선택</span>
			</label>
		</div>
		
		<div class="box-partition">
			<div class="delivery-order-list check-style details cancel">
				<ul>
					<%
						BoxOrderListDTO order = (BoxOrderListDTO) request.getAttribute("boxOrder");
						ArrayList<BoxOrderProductDTO> prdList = order.getProductList();
						
						DecimalFormat decimalFormat = new DecimalFormat("#,###");
						
						Iterator<BoxOrderProductDTO> ir = prdList.iterator();
						while(ir.hasNext()) {
							BoxOrderProductDTO prd = ir.next();
					%>
					<li>
						<label class="item-wrapper">
							<input name="select-product" class="select-product-checkbox each" data-status="BOCC001" data-ordernum="${ boxOrder.boxOrderNo }" type="checkbox" disabled="">
							<div class="item" href="/">
								<a class="thumb">
									<img src="/<%= prd.getImgPath() %>/<%= prd.getOriginName() %>" alt="">
								</a>
								<div class="contents">
									<div class="product">
										<label class="category"><%= prd.getProductsType() %></label>
										<a class="title"><%= prd.getProductsName()  %></a>
									</div>
									<span><%= prd.getProductsSize() %></span>
									<div class="info">
										<div class="select-item horizontal">
											<span>수량</span>
											<div class="unit">
												<em data-max-qty="<%= prd.getProductsCnt() %>" class="box-qty"><%= prd.getProductsCnt() %></em>
											</div>
										</div>
					<%
							int price = prd.getPrice();
							int salePrice = prd.getEventPrice();
							int cnt = Integer.parseInt(prd.getProductsCnt());
							price *= cnt;
							salePrice *= cnt;
							if(prd.getPrice() != prd.getEventPrice() && prd.getEventPrice() != 0) {
					 %>
										<div class="before-price-tag" style="margin-left: auto">
											<p class="value origin" style="color:#333;" data-eachprice="<%= price %>"><%= decimalFormat.format(price) %></p>
											<span class="unit">원</span>
										</div>
										<div class="price-tag right sm">
											<p class="value sale" style="color:#333;" data-eachprice="<%= salePrice %>"><%= decimalFormat.format(salePrice) %></p>
											<span class="unit">원</span>
										</div>
					<%
							} else {
					%>
										<div class="price-tag right sm" style="margin-left: auto">
											<p class="value origin" style="color:#333;" data-eachprice="<%= price %>"><%= decimalFormat.format(price) %></p>
											<span class="unit">원</span>
										</div>
					<%
							} // if
					%>
									</div>
								</div>
							</div>
						</label>
						<div class="foot"></div>
					</li>
					<%
						} // while
					%>
				</ul>
			</div>
		</div>
		
		<div class="box-partition rf" style="margin-top:20px;">
			<div class="part" style="padding-left:28px; padding-top:24px; padding-bottom:34px;">
				<div class="part-head">
					<h5>환불안내</h5>
				</div>
				<ul class="horizontal-info-list" style="margin-top:24px;">
					<li>
						<label>최종 상품금액</label>
						<div class="price-tag xs">
							<p class="value" style="color:#333;">
								<fmt:formatNumber value="${ boxPay.boxSalePrice }" type="number"></fmt:formatNumber>
							</p>
							<span class="unit">원</span>
						</div>
					</li>
					<c:choose>
						<c:when test="${ boxPay.boxDiscountPrice eq 0 }">
							<li>
								<label>쿠폰할인금액</label>
								<div class="price-tag xs">
									<p class="value" style="black;">0</p>
									<span class="unit">원</span>
								</div>
							</li>
						</c:when>
						<c:otherwise>
							<li>
								<label>쿠폰할인금액</label>
								<div class="price-tag xs">
									<p class="value" style="color:red;">
										<fmt:formatNumber value="${ boxPay.boxDiscountPrice }" type="number"></fmt:formatNumber>
									</p>
									<span class="unit">원</span>
								</div>
							</li>
						</c:otherwise>
					</c:choose>
					<li>
						<label>배송비</label>
						<div class="price-tag xs">
							<p class="value" style="color:#333;">
								<fmt:formatNumber value="${ boxPay.boxShippingFee }" type="number"></fmt:formatNumber>
							</p>
							<span class="unit">원</span>
						</div>
					</li>
					
					<li>
						<label>환불예상금액</label>
						<div class="price-tag xs">
							<p class="value" style="color:#333;">
								<fmt:formatNumber value="${ boxPay.boxFinalPrice }" type="number"></fmt:formatNumber>
							</p>
							<span class="unit">원</span>
						</div>
					</li>
					<li>
						<label>환불 수단</label>
						<c:choose>
							<c:when test="${ boxPay.boxPayMethod eq 0 }">
								<p>신용카드</p>
							</c:when>
							<c:when test="${ boxPay.boxPayMethod eq 1 }">
								<p>실시간 계좌이체</p>
							</c:when>
							<c:otherwise>
								<p>가상계좌</p>
							</c:otherwise>
						</c:choose>
					</li>
				</ul>
			</div>
		</div>
		
		<div class="btn-area-right" style="margin-top:20px;">
			<a style="padding:0; width:140px;" class="btn-default btn-white" onclick="location.href='/mypage/order/box.do'">목록으로</a>
			<button id="cancelBtn" type="button" style="padding:0; width:140px;" class="btn-default btn-black" data-toggle="modal" data-target="#pauseModal">취소하기</button>
		</div>
		
	</div>
</div>

<script>
  var windowRef = null;
  function openWindowPop(url, name){
    var image = document.getElementById('guideImage');
    var w = image.width;
    var h = image.height;
    var options = `width=${w},height=${h}, status=no, menubar=no, toolbar=no, resizable=no`;
	if(windowRef===null|| windowRef.closed){
	    windowRef = window.open('', name, options);
	    windowRef.document.write(`<img src="${url}" width="${w}" maxWidth=100vw />`);
	    windowRef.document.body.style.margin=0;
	} else {
    	windowRef.focus();
	} // if
  } // openWindowPop
</script>

<div style="" id="mini-side-nav">
	<a href="/mypage/drink/drink"><img src="/resources/images/ui/quick1.png" alt=""></a>
	<a id="quickChangeDrink" href="/mypage/drink/drink"><img src="/resources/images/ui/quick2.png" alt=""></a>
	<a id="quickChangeSchedule" href="/mypage/drink/drink"><img src="/resources/images/ui/quick3.png" alt=""></a>
	<a href="/mypage/drink/bill"><img src="/resources/images/ui/quick4.png" alt=""></a>
	<a href="#"><img src="/resources/images/ui/quickTop.png" alt=""></a>
</div>

</div>
		</main>		
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
	
 </div>

 <script>
	$("#cancelBtn").click(function(){
		const checked = $('input[name=select-product]:checked');
		
		if(checked.length===0){
			return alert('취소할 상품을 선택해주세요');
		} // if
		
		let orderNo = ${ param.orderNo };
		
		confirmDesign('','선택하신 상품 주문을 취소 하시겠습니까?',function (){
			let url = "/mypage/order/box/canceled.do?orderNo=" + orderNo;
			alert('취소가 완료되었습니다.');
			location.href = url
		})
	})
</script>
 
</body>

</html>