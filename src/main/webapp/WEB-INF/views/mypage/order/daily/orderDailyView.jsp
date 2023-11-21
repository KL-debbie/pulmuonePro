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
								<h2 class="container-title">음용내역 상세</h2>
							</div>
							
							<div class="dropdown">
								<div class="dropdown-menu"></div>
							</div>
											
							<div class="page-addiction-wrapper">
								<div class="info-copy">
									<div class="box dropdown" style="width:441px;padding: 0; margin-bottom:13px;">
										<a style="width: 100%" id="searchText" class="btn " href="#" role="button" data-toggle="dropdown" aria-expanded="false">
											<button class="nickname-format" style="width: 100%">
												<div style="display:flex; flex: 1; align-items: center">
													<label>기본</label>
													<h5>음용1</h5>
													<span>1</span>
												</div>
											</button>
										</a>
<style>
	button.nickname-format:after {}
</style>
										<div class="dropdown-menu" style="max-height: 200px; overflow-y: scroll">
											<a class="dropdown-item" href="/mypage/drink/drinks/230000234094/23812">음용1(1)</a>
										</div>
									</div>
								</div>
								
								<div class="button-wrapper" style="padding-top:4px;">
									<button data-toggle="modal" data-target="#nicknameModal" class="rounded-button">애칭수정</button>
									<a href="#" data-default="Y" data-custno="230000234094" data-nickname="음용1" onclick="smartDetail(this)" class="rounded-button">스마트청구서</a>
								</div>
							</div>
								
					
							<table class="doc-style-table height disabled">
								<colgroup>
									<col width="105px">
									<col width="354px">
									<col width="108px">
									<col width="*">
								</colgroup>
								<tbody>
									<tr>
										<th>담당가맹점</th>
										<td>서초홈가맹점</td>
										<th>주문구분</th>
										<td>홈페이지 주문</td>
									</tr>
									
									<tr>
										<th>가맹점연락처</th>
										<td>
											<ul class="addiction-info">
												<li class="tel">
													<label></label>
													<p data-call-text="">02-547-0519</p>
												</li>
												<li class="phone">
													<label></label>
													<p data-call-text="">010-3899-4569</p>
												</li>
											</ul>
										</td>
										
										<th>음용시작일</th>
										<td class="between" style="position: relative ; display: table-cell">
											<span>2023.10.04</span>
										</td>
									</tr>
									
										<tr>
											<th>결제수단</th>
											<td colspan="3">카드 결제
												<a href="/mypage/drink/paymethod" class="button-text">결제수단관리</a>
											</td>
										</tr>
										<tr>
											<th>배송정보</th>
											<td colspan="3">
												임재석(자택) / 010-1234-1234 / 서울 서초구 청두곶2길 6 303호 
												<a href="/mypage/order/daily/stop.do?orderNo=1" class="button-text">음용중지</a>
											</td>
										</tr>
									</tbody>
								</table>
								
								<div class="box-partition title-sep title-btn" style="margin:22px 0 0;">
									<div class="title">
										<h2>음용스케쥴</h2>
										<div class="button-set">
											<a style="cursor: pointer" href="/mypage/order/daily/changeHistory.do?orderNo=1" class="rounded-button">홈페이지 변경내역</a>
											<a href="/mypage/order/daily/change.do?orderNo=1" class="rounded-button primary">음용상품변경</a>
											<button type="button" id="changeDayBtn" class="rounded-button black">배송일정변경</button>
										</div>
									</div>
									<div class="part-horizontal">
										<div class="calendar-ui">
											<div class="calendar-wrap">
												<div class="month-control" style="justify-content: space-between">
													<div style="display: flex; align-items: center">
														<a class="arr" id="prev-month" style="cursor: pointer;">
															<div id="calendar-left-btn"></div>
														</a>
													
														<div class="date">
															<span id="calYear">2023</span>.
															<span id="calMonth">11</span>
														</div>
													
														<a class="arr" id="next-month" style="cursor: pointer;">
															<div id="calendar-right-btn"></div>
														</a>
													</div>
					
													<div id="today-button-action">
														<button class="today-button">오늘</button>
													</div>
					
												</div>
												
												<table class="scriptCalendar" style="width: 100%;">
													<thead>
														<tr>
															<td>일</td>
															<td>월</td>
															<td>화</td>
															<td>수</td>
															<td>목</td>
															<td>금</td>
															<td>토</td>
														</tr>
													</thead>
													
													<tbody>
														<tr>
															<td style="color: rgb(187, 187, 187); line-height: 3;">29</td>
															<td style="color: rgb(187, 187, 187); line-height: 3;">30</td>
															<td style="color: rgb(187, 187, 187); line-height: 3;">31</td>
															<td style="color: rgb(102, 102, 102); line-height: 3; background-color: rgb(255, 255, 255);">
																<div style="cursor:pointer;" class="checkDrink day-with-symbol"><span>01</span></div>
															</td>
															<td style="color: rgb(102, 102, 102); line-height: 3; background-color: rgb(255, 255, 255);">
																<div style="cursor:pointer;" class="checkDrink day-with-symbol"><span>02</span></div>
															</td>
															<td style="color: rgb(102, 102, 102); line-height: 3; background-color: rgb(255, 255, 255);">
																<div style="cursor:pointer;" class="checkDrink day-with-symbol"><span>03</span></div>
															</td>
															<td style="color: rgb(102, 102, 102); line-height: 3; background-color: rgb(255, 255, 255);">
																<div class=""><span class="">04</span></div>
															</td>
														</tr>
														<tr>
															<td style="color: rgb(239, 103, 95); line-height: 3; background-color: rgb(255, 255, 255);">
																<div class=""><span class="">05</span></div>
															</td>
															<td style="color: rgb(102, 102, 102); line-height: 3; background-color: rgb(255, 255, 255);">
																<div style="cursor:pointer;" class="checkDrink day-with-symbol"><span>06</span></div>
															</td>
															<td style="color: rgb(102, 102, 102); line-height: 3; background-color: rgb(255, 255, 255);">
																<div class="day-with-symbol"> <span class="change-shipping">07</span></div>
															</td>
															<td style="color: rgb(102, 102, 102); line-height: 3; background-color: rgb(255, 255, 255);">
																<div class="day-with-symbol"><span class="change-shipping">08</span></div>
															</td>
															<td style="color: rgb(102, 102, 102); line-height: 3; background-color: rgb(255, 255, 255);">
																<div class="day-with-symbol"> <span class="change-shipping">09</span></div>
															</td>
															<td style="color: rgb(102, 102, 102); line-height: 3; background-color: rgb(255, 255, 255);">
																<div class="day-with-symbol"> <span class="change-shipping">10</span></div>
															</td>
															<td style="color: rgb(102, 102, 102); line-height: 3; background-color: rgb(255, 255, 255);">
																<div class=""> <span class="">11</span></div>
															</td>
														</tr>
														<tr>
															<td style="color: rgb(239, 103, 95); line-height: 3; background-color: rgb(255, 255, 255);">
																<div class=""> <span class="">12</span></div>
															</td>
															<td style="color: rgb(102, 102, 102); line-height: 3; background-color: rgb(255, 255, 255);">
																<div class="day-with-symbol"> <span class="change-shipping">13</span></div>
															</td>
															<td style="color: rgb(102, 102, 102); line-height: 3; background-color: rgb(255, 255, 255);">
																<div style="cursor:pointer;" class="checkDrink day-with-symbol"><span>14</span></div>
															</td>
															<td style="color: rgb(102, 102, 102); line-height: 3; background-color: rgb(255, 255, 255);">
																<div style="cursor:pointer;" class="checkDrink day-with-symbol"><span>15</span></div>
															</td>
															<td style="color: rgb(102, 102, 102); line-height: 3; background-color: rgb(255, 255, 255);">
																<div style="cursor:pointer;" class="checkDrink day-with-symbol"><span>16</span></div>
															</td>
															<td style="color: rgb(102, 102, 102); line-height: 3; background-color: rgb(255, 255, 255);">
																<div style="cursor:pointer;" class="checkDrink day-with-symbol"><span>17</span></div>
															</td>
															<td style="color: rgb(102, 102, 102); line-height: 3; background-color: rgb(255, 255, 255);">
																<div class=""> <span class="">18</span></div>
															</td>
														</tr>
														<tr>
															<td style="color: rgb(239, 103, 95); line-height: 3; background-color: rgb(255, 255, 255);">
																<div class=""> <span class="">19</span></div>
															</td>
															<td style="color: rgb(102, 102, 102); line-height: 3; background-color: rgb(255, 255, 255);">
																<div style="cursor:pointer;" class="checkDrink day-with-symbol"><span>20</span></div>
															</td>
															<td style="color: rgb(51, 51, 51); line-height: 3; background-color: rgb(255, 255, 255);">
																<div style="cursor:pointer;" class="checkDrink day-with-symbol"><span>21</span></div>
															</td>
															<td style="color: rgb(102, 102, 102); line-height: 3; background-color: rgb(255, 255, 255); cursor: pointer; font-weight: bold;">
																<div style="cursor:pointer;" class="checkDrink day-with-symbol"><span>22</span></div>
															</td>
															<td style="color: rgb(102, 102, 102); line-height: 3; background-color: rgb(255, 255, 255); cursor: pointer;">
																<div style="cursor:pointer;" class="checkDrink day-with-symbol"><span>23</span></div>
															</td>
															<td style="color: rgb(102, 102, 102); line-height: 3; background-color: rgb(255, 255, 255); cursor: pointer;">
																<div style="cursor:pointer;" class="checkDrink day-with-symbol"><span>24</span></div>
															</td>
															<td style="color: rgb(102, 102, 102); line-height: 3; background-color: rgb(255, 255, 255); cursor: pointer;">
																<div class=""> <span class="">25</span></div>
															</td>
														</tr>
														<tr>
															<td style="color: rgb(239, 103, 95); line-height: 3; background-color: rgb(255, 255, 255); cursor: pointer;">
																<div class=""> <span class="">26</span></div>
															</td>
															<td style="color: rgb(102, 102, 102); line-height: 3; background-color: rgb(255, 255, 255); cursor: pointer;">
																<div style="cursor:pointer;" class="checkDrink day-with-symbol"><span>27</span></div>
															</td>
															<td style="color: rgb(102, 102, 102); line-height: 3; background-color: rgb(255, 255, 255); cursor: pointer;">
																<div style="cursor:pointer;" class="checkDrink day-with-symbol"><span>28</span></div>
															</td>
															<td style="color: rgb(102, 102, 102); line-height: 3; background-color: rgb(255, 255, 255); cursor: pointer;">
																<div style="cursor:pointer;" class="checkDrink day-with-symbol"><span>29</span></div>
															</td>
															<td style="color: rgb(102, 102, 102); line-height: 3; background-color: rgb(255, 255, 255); cursor: pointer;">
																<div style="cursor:pointer;" class="checkDrink day-with-symbol"><span>30</span></div>
															</td>
															<td style="color: rgb(187, 187, 187); line-height: 3;">
																<div style="cursor:pointer;" class="checkDrink day-with-symbol"><span>01</span></div></td>
															<td style="color: rgb(187, 187, 187); line-height: 3;">02</td>
														</tr>
													</tbody>
												</table>
												
												<div>
													<ul class="legend-wrap" style="border-bottom: none">
														<li><span style="background-color: #7acc12"></span>배송(예정)</li>
														<li><span style="border: 2px solid #7acc12"></span>배송일정변경</li>
														<li><span style="background-color: #ddd"></span>미배송</li>
													</ul>
													<p class="calendar-alert">배송일 클릭 시 음용 상품 확인이 가능합니다.</p>
												</div>
											</div>
										</div>
										
										<div class="product-wrapper">
											<div class="part-head" style="margin-bottom:22px;">
												<h5 style="font-weight:500;">다음주 음용상품</h5>
											</div>
														
											<div class="product-week" style="height: 100%;">
												<ul id="next-drink-label" class="header">
													<li>
														<label>월</label>
														<span class="active">1</span>
													</li>
													<li>
														<label>화</label>
														<span class="active">1</span>
													</li>
													<li>
														<label>수</label>
														<span class="active">1</span>
													</li>
													<li>
														<label>목</label>
														<span class="active">1</span>
													</li>
													<li>
														<label>금</label>
														<span class="active">1</span>
													</li>
												</ul>
																		
												<ul class="contents hp" style="display: flex" id="next-drink-label2">
													<li>
														<div data-item-code="undefined" class="item">
															<span class="number">1</span>
															<div class="thumb">
																<img src="/file/download/product/5e98ba4b-ea3d-4b14-b7db-a6b4399981dc.png" alt="">
															</div>
														</div>
													</li>
													<li>
														<div data-item-code="undefined" class="item">
															<span class="number">1</span>
															<div class="thumb">
																<img src="/file/download/product/abde0d7f-d546-4cc4-acec-99a4b895b9d7.jpg" alt="">
															</div>
														</div>
													</li>
													<li>
														<div data-item-code="undefined" class="item">
															<span class="number">1</span>
															<div class="thumb">
																<img src="/file/download/product/4cf0398b-fb18-45f9-97c4-be8b5bd2edd6.jpg" alt="">
															</div>
														</div>
													</li>
													<li>
														<div data-item-code="undefined" class="item">
															<span class="number">1</span>
															<div class="thumb">
																<img src="/file/download/product/42da9a6f-9889-4ff7-bf77-af5989855f86.jpg" alt="">
															</div>
														</div>
													</li>
													<li>
														<div data-item-code="undefined" class="item">
															<span class="number">1</span>
															<div class="thumb">
																<img src="/file/download/product/685a5aac-588c-4366-82c4-217f17b38067.jpg" alt="">
															</div>
														</div>
													</li>
												</ul>
											</div>
										</div>
									</div>
								</div>
								
								<div class="alert-area lg" style="padding-bottom:40px;">
									<h4>음용내역조회 안내</h4>
									<ul>
										<li>타 쇼핑몰 주문 건은 음용 상품 변경이 불가합니다.</li>
										<li>이사 등으로 인한 배송 지역 변경 시, 현재 배송 중인 가맹점 또는 1:1 문의 게시판을 통해 문의해주세요.</li>
										<li>실제 음용 내역과 상이한 경우에는 배송 가맹점 또는 1:1 문의 게시판을 통해 문의해주세요.</li>
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
		
		<div class="modal fade" id="subscribeModal" tabindex="-1" aria-labelledby="subscribeModal" aria-hidden="true">
			<div class="modal-dialog basic-width modal-dialog-centered modal-dialog-scrollable">
				<div class="modal-content">
					<div class="modal-header" style="border:0; padding:20px 28px 12px 30px;">
						<h5 class="modal-title" id="subscribeModalLabel">정기주문 신청</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						</button>
					</div>
					<div class="recommend-pack">
						<div class="pack-title">추천 패키지 상품</div>
						<div class="subscribe-set"></div>
						<button id="subscribe" class="rect-button primary">정기주문 신청</button>
					</div>
					<div class="btn-area pack">
						<a href="/product/daily" class="rect-button">원하는 상품을 찾아보시겠어요?</a>
						<a href="/customer/product" class="rect-button">맞춤상품 추천을 받아보시겠어요?</a>
					</div>
				</div>
			</div>
		</div>
		
		<div class="modal fade" id="todayProductModal" tabindex="-1" aria-labelledby="todayProductModal" aria-hidden="true">
			<div class="modal-dialog basic-width modal-dialog-centered">
									
				<div class="modal-content">
					<div class="modal-header" style="border:0; padding-bottom:16px;">
						<h5 class="modal-title" id="todayProductModalLabel"></h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close"></button>
					</div>
										
					<ul class="product-content-list" style="margin-bottom:0;">
						<li>
							<div class="thumb"></div>
							<div class="contents">
								<p class="name">아이러브 루테인<span>(130ml)</span></p>
								<div class="info">
									<span class="quantity"><b>1</b>개</span>
								</div>
							</div>
						</li>
					</ul>
										
					<div class="button-set">
						<button data-dismiss="modal" class="button-basic primary">확인</button>
					</div>
				
				</div>
			</div>
		</div>
		
		<div class="modal fade" id="nicknameModal" tabindex="-1" aria-labelledby="nicknameModal" aria-hidden="true">
			<div class="modal-dialog basic-width modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header" style="border:0; padding:22px 28px 14px 30px;">
						<h5 class="modal-title" id="nicknameModalLabel" style="margin-top:2px;">애칭수정</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close"></button>
					</div>
										
					<div style="padding:0 30px 48px">
						<div class="form-input none-dt">
							<dl>
								<dt><label>변경할애칭</label></dt>
								<dd><input id="nickname-edit" name="nickname" value="음용1" placeholder="변경할 애칭" type="text"></dd>
							</dl>
						</div>
					</div>
										
					<div class="button-set">
						<button id="nickname-edit-btn" class="button-basic primary">수정하기</button>
					</div>
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
						}else {
					    windowRef.focus();
						}
					
					  }
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

</body>

</html>