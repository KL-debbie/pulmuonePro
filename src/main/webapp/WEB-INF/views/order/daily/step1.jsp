<%@page import="servlets.order.domain.DrkOrderProductDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="/WEB-INF/views/layouts/modalHead.jsp"%>

<script>
	var type = "daily";
	var gap = 4;
	var dayOfWeekVal = ['A', 'B', 'C', 'D', 'E'];
	
	var reqItems = [];
	var nfsItem = "".split(",").filter(v=>!!v);
	var nfsList = "".split(",").filter(v=>!!v);
	
	try {
		var items = decodeURIComponent("{&quot;item&quot;:[{&quot;itemCode&quot;:&quot;0071654&quot;,&quot;dayQty&quot;:[1,1,1,1,1]}]}").replace(/\&quot;/g, '"');
	  	reqItems = JSON.parse(items).item;
	  	reqItems = reqItems.filter(x => !nfsList.includes(x.itemCode));
	  	console.log({reqItems})
	} catch (e) {
	    console.log(e)
	} // try
	
	$(document).on("click", ".dropdown-menu .dropdown-item", function (e) {
	  $(this).parent().prev().click();
	})

    console.log({nfsItem})
</script>

<body>
	<div class="wrapper">
	
		<%@ include file="/WEB-INF/views/layouts/header.jsp"%>
		
		<main class="page event">
			<div class="container">
				
				<textarea id="address_tpl" style="display: none">
					&lt;div class="item" style="margin: 0 ; border-radius: 0"&gt;
					        &lt;div class="head"&gt;
					            &lt;div class="nickname-format xl"&gt;
					                &lt;label&gt;기본&lt;/label&gt;
					                &lt;h5&gt;{nickname}&lt;/h5&gt;
					            &lt;/div&gt;
					            &lt;ul class="info" style="margin-top:15px; padding-left:1px;"&gt;
					                &lt;li&gt;
					                    &lt;p&gt;{name}&lt;/p&gt;
					                &lt;/li&gt;
					                &lt;li&gt;
					                    &lt;p&gt;{phoneNumber}&lt;/p&gt;
					                &lt;/li&gt;
					                &lt;li&gt;
					                    &lt;p&gt;({post}) {addr1} {addr2}&lt;/p&gt;
					                &lt;/li&gt;
					            &lt;/ul&gt;
					        &lt;/div&gt;
					        &lt;div class="tail"&gt;
					            &lt;button type="button" class="adapt-address rounded-button"&gt;선택&lt;/button&gt;
					        &lt;/div&gt;
					 &lt;/div&gt;
				</textarea>

				<form id="orderForm">
				
					<input type="hidden" name="cardValidation" id="cardValidation" value="N">
					<input type="hidden" name="payMethod" value="CARD">
					<input type="hidden" name="payPrice" value="58000">

					<div class="location">
						<a href="/">홈</a>
						<a href="/">장바구니</a>
						<a href="/">주문서 작성</a>
					</div>
					
					<div class="cont-checkout-area">
						<div class="title-tab-area">
							<h2 class="cont-title">주문서 작성</h2>
						</div>
						
						<div class="prd-cart-area" style="padding-bottom: 50px;">
							<div class="prd-cart-list-area">
								<div class="checkout-prd-list">
									<%
										ArrayList<DrkOrderProductDTO> prdList = (ArrayList<DrkOrderProductDTO>) request.getAttribute("prdList");
										int prdCnt = prdList.size();
									%>
									
									<div class="checkout-title-area">
										<strong class="list-amount">주문상품 <em class="prd-count" style="padding: 0 16px; margin-left: 2px"><%= prdCnt %></em></strong>
										<button type="button" class="btn-down">
											<i class="ico ico-down"><span class="hide">주문서 닫기</span></i>
										</button>
									</div>
									
									<!-- 상품 정보 list -->
									<ul style="" class="prd-cart-list" id="order_targets">
										<c:forEach items="${ prdList }" var="prd">
										
											<li data-id="" data-itemcode="${ prd.productsNo }" class="order-item order-chk active" data-price="${ prd.price }">
	
												<a href="/product/daily/view.do?tag=281" class="prd-cart">
													<div class="thumb">
														<img src="/${ prd.imgPath }/${ prd.systemName }" alt="">
													</div>
													<div class="prd-info">
														<b class="prd-title"> ${ prd.productsName } </b>
														<b class="now-price">
															<fmt:formatNumber value="${ prd.price }" type="number"></fmt:formatNumber>
															<span> 원</span>
														</b>
													</div>
												</a>
												
												<div class="prd-cart-select-daily">
													<ul data-cart-idx="" data-itemcode="${ prd.productsNo }">
														
														<li>
															<input type="hidden" data-count="0" value="1">
															<span>월</span>
															<div class="prd-select-daily">
																<button type="button" class="prod-add ea-control" data-index="0">
																	+<span class="hide">제품 추가</span>
																</button>
																<em data-itemcount-view="0">1</em>
																<button type="button" class="prod-remove ea-control btn-minus" data-index="0">
																	<span class="hide">제품 빼기</span>
																</button>
															</div>
														</li>
	
														<li class="active">
															<input type="hidden" data-count="1" value="1">
															<span>화</span>
															<div class="prd-select-daily">
																<button type="button" class="prod-add ea-control" data-index="1">
																	+<span class="hide">제품 추가</span>
																</button>
																<em data-itemcount-view="1">1</em>
																<button type="button" class="prod-remove ea-control btn-minus" data-index="1">
																	<span class="hide">제품 빼기</span>
																</button>
															</div>
														</li>
	
														<li>
															<input type="hidden" data-count="2" value="1">
															<span>수</span>
															<div class="prd-select-daily">
																<button type="button" class="prod-add ea-control" data-index="2">
																	+<span class="hide">제품 추가</span>
																</button>
																<em data-itemcount-view="2">1</em>
																<button type="button" class="prod-remove ea-control btn-minus" data-index="2">
																	<span class="hide">제품 빼기</span>
																</button>
															</div>
														</li>
	
														<li>
															<input type="hidden" data-count="3" value="1">
															<span>목</span>
															<div class="prd-select-daily">
																<button type="button" class="prod-add ea-control" data-index="3">
																	+<span class="hide">제품 추가</span>
																</button>
																<em data-itemcount-view="3">1</em>
																<button type="button" class="prod-remove ea-control btn-minus" data-index="3">
																	<span class="hide">제품 빼기</span>
																</button>
															</div>
														</li>
	
														<li>
															<input type="hidden" data-count="4" value="1">
															<span>금</span>
															<div class="prd-select-daily">
																<button type="button" class="prod-add ea-control" data-index="4">
																	+<span class="hide">제품 추가</span>
																</button>
																<em data-itemcount-view="4">1</em>
																<button type="button" class="prod-remove ea-control btn-minus" data-index="4">
																	<span class="hide">제품 빼기</span>
																</button>
															</div>
														</li>
	
													</ul>
												</div>
											</li>
										</c:forEach>
									</ul>

									<div class="select-daily-amount"
										style="padding: 18px 28px 26px 30px">
										<span>요일별 수량을 선택해주세요.</span>
										<button type="button" id="addProductBtn" class="btn-square" style="padding: 0 25px; margin-top: 2px;">상품추가하기</button>
									</div>
									
								</div>
								
								<div class="checkout-input-area">
									<div class="checkout-input-title-area">
										<h3 class="checkout-input-title">배송정보</h3>
										<button type="button">
											<i class="ico ico-down"></i> <span class="hide">현재화면 닫기</span>
										</button>
									</div>
									
									<div class="checkout-input-box">
										<div class="prd-cart-all-select">
											<div class="checkbox chk-type3">
												<input type="checkbox" name="chk-same" id="chk-same" checked="">
												<label for="chk-same">고객정보와 동일</label>
											</div>
											<button id="addressBtn" type="button" class="btn-round2">주소록</button>
										</div>

										<div class="form-input">
											<dl>
												<dt>
													<label for="receiver">받으시는분</label>
												</dt>
												<dd>
													<input type="text" data-receiver="" id="receiver" name="orderName" title="이름을 입력하세요" placeholder="이름을 입력하세요"
														value="이지현" data-init="이지현" data-require="" data-name="받는사람" maxlength="10">
												</dd>
											</dl>

										</div>
										<div class="form-input">
											<dl>
												<dt>
													<label for="phone">휴대폰번호</label>
												</dt>
												<dd>
													<input type="hidden" id="phone" name="orderPhone" maxlength="13" title="휴대폰번호를 입력하세요" data-call-text=""
														placeholder="휴대폰번호를 입력하세요" value="01055234090" data-init="01055234090" data-require="" data-name="휴대폰번호">
													<input type="tel" name="_x_orderPhone" maxlength="13" title="휴대폰번호를 입력하세요" placeholder="휴대폰번호를 입력하세요"
														value="01055234090" data-init="01055234090" data-require="" data-name="휴대폰번호">
												</dd>
											</dl>
										</div>
										<div class="form-input">
											<dl>
												<dt>
													<label for="zipcode">우편번호</label>
												</dt>
												<dd>
													<input id="zipcode" readonly="" name="zipCode" title="주소찾기 버튼을 눌러주세요" placeholder="주소찾기 버튼을 눌러주세요"
														value="" data-init="" data-require="" style="background: #fff" data-name="우편번호">
													<input type="hidden" name="orderStreetAddress" id="orderStreetAddress" value="">
													<button type="button" id="searchPostcode" class="btn-square btn-black">주소찾기</button>
												</dd>
											</dl>
										</div>
										<div class="form-input">
											<dl>
												<dt>
													<label for="addrRoad">주소</label>
												</dt>
												<dd>
													<input type="text" id="addrRoad" name="addrRoad" title="주소 입력" placeholder="" readonly="" value=""
														data-init="" data-require="" style="background: #fff" data-name="주소">
												</dd>
											</dl>
										</div>
										<div class="form-input">
											<dl>
												<dt>
													<label for="addrDetail">상세주소</label>
												</dt>
												<dd>
													<input type="text" id="addrDetail" name="addrDetail" title="상세주소 입력" placeholder="상세주소 입력" value=""
														data-init="" data-require="" data-name="상세주소" maxlength="100">
												</dd>
											</dl>
										</div>
										<div class="form-input">
											<dl>
												<dt>
													<label for="memo">배송메모</label>
												</dt>
												<dd>
													<input id="memo" name="orderMemo" title="배송메모를 입력하세요" placeholder="배송메모를 입력하세요" value="" data-init="">
												</dd>
											</dl>
										</div>

										<div class="form-input">
											<dl>
												<dt>
													<span>배달장소</span>
												</dt>
												<dd>
													<div class="radio-area radio-type2">
														<div class="radio">
															<input type="radio" value="H" id="deliveryPlaceH" name="deliveryPlace">
															<label for="deliveryPlaceH">가정</label>
														</div>
														<div class="radio">
															<input type="radio" value="O" id="deliveryPlaceO" name="deliveryPlace">
															<label for="deliveryPlaceO">회사/사무실</label>
														</div>
													</div>
												</dd>
											</dl>
										</div>

										<div class="checkbox chk-type3" style="margin-top: 28px">
											<input type="checkbox" id="saveAddrChk" name="saveAddrChk" value="Y">
											<label for="saveAddrChk">주소록에 저장</label>
										</div>
									</div>
								</div>

								<div class="checkout-input-area" style="padding-bottom: 31px;">
									<div class="checkout-input-title-area">
										<h3 class="checkout-input-title">배송안내</h3>
									</div>
									<div class="checkout-input-box">

										<div class="form-input">
											<dl>
												<dt>
													<label for="input01"> 배송가맹점
														<button type="button" class="btn-question">
															<i class="ico ico-question"></i> <span class="hide">자세한 내용 보기</span>
															<div class="show-body" title="배송가맹점">
																<ul>
																	<li>입력하신 배송장소 및 주소에 따른 예상 가맹점이며, 실제 배송가맹점과는 상이할 수
																		있습니다.</li>
																	<li>배송장소를 정확히 입력해 주셔야 신속하고 정확하게 배송이 이루어집니다.</li>
																	<li>서울(서초구 우면동), 경기(안양시 만안구, 과천시) 지역은 당분간 가정집 배송이
																		불가합니다.</li>
																	<li>충북(옥천군, 영동군, 보은군)지역은 당분간 배송이 불가합니다.</li>
																	<li>속한 시일 내 정상 배송할 수 있도록 하겠습니다. 고객님의 양해부탁드립니다.</li>
																</ul>
															</div>
														</button>
													</label>
												</dt>
												<dd>
													<input type="text" readonly="" name="prtnName" title="" placeholder="배송 장소 선택 및 주소 입력을 해주세요." value="">
													<input type="hidden" id="officeCode" name="estCd" value="">
													<input type="hidden" id="buTelno" name="officePhoneNumber" value="">
												</dd>
											</dl>
										</div>
										<div class="form-input">
											<dl>
												<dt>
													<label for="input02"> 첫 배송 예정일
														<button type="button" class="btn-question">
															<i class="ico ico-question"></i> <span class="hide">자세한 내용 보기</span>
															<div class="show-body" title="첫 배송일 안내">
																<ul>
																	<li>풀무원녹즙은 주문 생산 방식으로, 첫 배송일은 영업일 기준, 낮 12시 이전 주문
																		시 D+2로 선택 가능합니다. (ex. 월요일 낮 12시 이전 주문 시 수요일 첫배송 가능)</li>
																	<li>실 배송 시작일은 가맹점 사정에 따라 변경될 수 있습니다.</li>
																</ul>
															</div>
														</button>
													</label>
												</dt>
												<dd class="input-util-area" style="position: relative">
													<input type="text" id="ip-datepicker-1" readonly="" name="deliveryDate" title="첫 배송 예정일" placeholder="첫 배송 예정일" value="2022. 08. 08">
													<button type="button" class="btn-cacalendar" style="pointer-events: none; position: absolute; right: 20px;">
														<i class="ico ico-calendar"></i>
														<span class="hide">날짜 선택하기</span>
													</button>
												</dd>
											</dl>
										</div>

									</div>
								</div>
								<div class="checkout-input-area">
									<div class="checkout-input-title-area">
										<h3 class="checkout-input-title">결제정보</h3>
									</div>
									<div class="select-checkout-area">

										<ul class="nav nav-tabs nav-justified" id="myTab-area"
											role="tablist">
											<li data-code="CARD" class="nav-item" role="presentation">
												<a href="#" class="nav-link active" id="checkout-type-tab1" data-target="#checkout-type1" data-toggle="tab"
												data-value="CARD" role="tab" aria-controls="checkout-type1" aria-selected="true">
													<img src="/resources/assets/images/ui/checkout-item01.png" alt="">
													<span>카드결제</span>
												</a>
											</li>
											<li data-code="BANK" class="nav-item" role="presentation">
												<a href="#" data-value="BANK" class="nav-link" id="checkout-type-tab2" data-target="#checkout-type2"
												data-toggle="tab" role="tab" aria-controls="checkout-type2" aria-selected="false">
													<span>계좌결제</span>
												</a>
											</li>
											<li data-code="CASH" class="nav-item" role="presentation">
												<a href="#" data-value="CASH" class="nav-link" id="checkout-type-tab3" data-target="#checkout-type3"
												data-toggle="tab" role="tab" aria-controls="checkout-type3" aria-selected="false">
													<span>현장결제</span>
												</a>
											</li>
										</ul>
										<div class="tab-content checkout-input-box" id="myTabContent">
											<div class="tab-pane fade show active" style="margin-top: 32px;" role="tabpanel" id="checkout-type1" aria-labelledby="checkout-type-tab1">
												<div class="input-area">
													<div class="form-input">
														<dl>
															<dt>
																<label for="input01">카드번호</label>
															</dt>
															<dd>
																<input type="text" name="cardNumber" id="card_number" class="numberOnly" maxlength="19" title="카드번호 입력" placeholder="카드번호 입력">
															</dd>
														</dl>
													</div>
													<div class="form-input">
														<dl>
															<dt>
																<label for="input01">생년월일</label>
															</dt>
															<dd>
																<input type="text" id="birthDay" class="numberOnly" maxlength="6" name="birthDay" title="생년월일 입력 (YYMMDD 6자리)" placeholder="생년월일 입력 (예: 990101)" value="">
															</dd>
														</dl>
													</div>
													<div class="form-input">
														<dl>
															<dt>
																<label for="input01">유효기간</label>
															</dt>
															<dd>
																<input type="text" id="validYYMM" name="validYYMM" title="유효기간 입력" placeholder="유효기간 입력 (MM/YY)" maxlength="5" value="">
																<button type="button" id="validCardBtn" class="btn-square btn-black">카드인증</button>
															</dd>
														</dl>
													</div>
												</div>
											</div>
											<div class="tab-pane fade" style="margin-top: 32px;" role="tabpanel" id="checkout-type2" aria-labelledby="checkout-type-tab2">
												<div class="input-area">
													<div class="form-input">
														<dl>
															<dt>
																<label for="input01">예금주</label>
															</dt>
															<dd>
																<input type="text" id="input01" name="input01" title="예금주 입력" placeholder="" readonly="" value="이지현">
															</dd>
														</dl>
													</div>
													
													<div class="form-input">
														<dl>
															<dt>
																<label for="bankCode">은행</label>
															</dt>
															<dd>
																<select name="bankCode" id="bankCode" class="form-select form-select-lg" aria-label=".form-select-lg example">
																	<option value="">은행을 선택해주세요.</option>
																	<option value="002">산업은행</option>
																	<option value="003">기업은행</option>
																	<option value="004">국민은행</option>
																	<option value="007">수협중앙회</option>
																	<option value="011">농협은행</option>
																	<option value="020">우리은행</option>
																	<option value="023">SC은행</option>
																	<option value="027">한국씨티은행</option>
																	<option value="031">대구은행</option>
																	<option value="032">부산은행</option>
																	<option value="034">광주은행</option>
																	<option value="035">제주은행</option>
																	<option value="037">전북은행</option>
																	<option value="039">경남은행</option>
																	<option value="045">새마을금고</option>
																	<option value="048">신협중앙회</option>
																	<option value="071">우체국</option>
																	<option value="081">KEB하나은행</option>
																	<option value="088">신한은행</option>
																	<option value="209">유안타증권</option>
																	<option value="240">삼성증권</option>
																</select>
																<input type="hidden" name="fdCustId" id="fdCustId">
																<input type="hidden" name="cmsId" id="cmsId">
															</dd>
														</dl>
													</div>
													
													<div class="form-input">
														<dl>
															<dt>
																<label for="accountNumber">계좌번호</label>
															</dt>
															<dd>
																<input type="text" id="accountNumber" name="accountNumber" title="계좌번호 입력" placeholder="계좌번호 입력">
																<button id="callCms" data-isnew="true" data-phone1="010" data-phone2="4090" type="button" class="btn-square btn-black">ARS인증</button>
																<input id="hasRequest" value="false" type="hidden">
															</dd>
														</dl>
														<p id="afterArs" style="margin-left: 137px; margin-top: 5px;">인증이 완료되었습니다.</p>
													</div>
												</div>
											</div>
											<div class="tab-pane fade" role="tabpanel" id="checkout-type3" aria-labelledby="checkout-type-tab3">
											</div>
										</div>
									</div>
								</div>
							</div>

							<div class="prd-checkout-area creat-checkout2">
								<dl>
									<dt>
										<span>상품 판매가 (4주기준)</span> <b>
											<div class="now-price">
												<b data-price-view="origin">58,000</b> <span>원</span>
											</div>
										</b>
									</dt>
									<dd>
										<span>상품 할인 판매가</span> <b>
											<div class="now-price">
												<b data-price-view="sale" class="">58,000</b> <span>원</span>
											</div>
										</b>
									</dd>
									<dd class="checkout-sum">
										<span>4주 예상 금액</span> <b>
											<div class="now-price">
												<b data-price-view="payment">58,000</b> <span>원</span>
											</div>
										</b>
									</dd>
								</dl>
								
								<div class="checkbox chk-type4">
									<input type="checkbox" id="agree-11" name="chk-agree-condition">
									<label for="agree-11">구매조건 확인 및 결제진행 동의</label>
								</div>

								<div class="checkout-text"
									style="margin-top: 20px; margin-bottom: 14px;">
									<p>4주 기준 예상 음용 금액으로, 실제 청구 금액과 상이할 수 있습니다.</p>
									<p>4주 음용 이후 별도 중지 요청이 없으실 경우 매일 정기배송이 유지됩니다.</p>
									<p>영업일 기준 3일 이내에 배송 가맹점에서 유선으 로 주문 확인 안내드리며, 가맹점 사정에 따라 달라질 수 있습니다.</p>
									<p>가맹점의 사정으로 주문 변경 및 취소될 수 있습니다.</p>
								</div>

								<button type="button" id="allOrderBtn" class="btn-default">주문신청</button>
							</div>
						</div>
					</div>
				</form>

			</div>
		</main>
		
		<%@ include file="/WEB-INF/views/layouts/footer.jsp"%>
		<%@ include file="/WEB-INF/views/ui/footermodal.jsp"%>
		
		<div class="modal" id="addressModal" tabindex="-1" aria-labelledby="addressModal" style="display: none;" aria-hidden="true">
		    <div class="modal-dialog modal-dialog-centered">
		        <div class="modal-content ">
		            <div class="modal-header">
		                <h5 class="modal-title" id="emailPolicyLabel">주소록</h5>
		                <button type="button" class="close" data-dismiss="modal" aria-label="Close"></button>
		            </div>
		            
		            <div class="modal-body" style="max-height: 80vh; overflow-y: scroll">
						<div class="drinking-list address" style="margin: 0"></div>
						<div style="padding: 20px">
		                    <button class="btn-default btn-white" style="width: 100%">더보기</button>
		                </div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="modal fade" id="alertModal" tabindex="-1" aria-labelledby="alertModalLabel" style="display: none;" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="alertModalLabel"></h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						</button>
					</div>
					<div class="modal-body" style="max-height: 80vh; overflow-y: scroll; padding: 0px;">
						<div class="drinking-list address" style="margin: 0"></div>
					</div>
					<button type="button" class="modal-footer" data-dismiss="modal">확인</button>
				</div>
			</div>
		</div>
		
		<div class="modal fade" id="addProductModal" tabindex="-1" aria-labelledby="addProductModal" style="display: none;" aria-hidden="true">
		    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-lg">
		        <div class="modal-content">
		        
        		    <div class="modal-header" style="border:0; padding-bottom: 11px">
                		<h5 class="modal-title" id="addProductModalLabel">상품추가</h5>
                		<button type="button" class="close" data-dismiss="modal" aria-label="Close"></button>
            		</div>
            		
            		<form id="searchForm">
                		<input type="hidden" name="searchType" value="daily">
                		<div class="input-search-bar">
                    		<input name="searchKeyword" placeholder="검색어를 입력하세요">
                    		<button id="productSearch">
                       			<img src="/resources/assets/images/ui/ico-srh02.png">
                    		</button>
                		</div>
            		</form>
            		
            		<div style="margin-bottom:1px; overflow-y: scroll;height: 480px;">
                		<ul class="product-content-list add-popup" id="add-product-targets"></ul>
		                <div style="padding: 0px 20px 20px">
		                    <button id="add-product-more" style="width: 100%" class="btn-default btn-white">더보기</button>
		                </div>
            		</div>
        		</div>
    		</div>
		</div>
		
	</div>
	
	<!-- 상품 리스트 불러오기 -->
	<script>
		var root = $('#add-product-targets');
		function showPrds(pageNo) {
			$('#addProductModal').addClass("loading");
			$.ajax({
					url: '/order/selectProducts.do'
					, dataType: "json"
					, cache: false
					, type:"GET"
					, data: { pageNo: pageNo }
					, success: function(response){
						const a = response.prdArr;
						var tpl = null;
				        $.each(a, function (i, prd) {
				        	tpl = '<li class="product-add" style="cursor:pointer;" data-available="null" data-addproduct="'+ prd.productsNo +'">'
				        			+ '<div class="thumb">'
				        				+ '<img src="/'+ prd.imgPath +'/'+ prd.systemName +'" alt="">'
				        			+ '</div>'
				        			+ '<div class="contents">'
				        				+ '<p class="name">'+ prd.productsName +'<span>'+ prd.produtsSize +'</span></p>'
				        				+ '<div class="info">'
				        					+ '<span class="price"><b>'+ prd.price +'</b> 원</span>'
				        				+ '</div>'
				        			+ '</div>'
				        		+ '</li>';
							var el = $(tpl).data("item", prd);
							root.append(el);
						});
				        
				        $('#addProductModal').modal('show');
				        
				        root.find("#addProductModalLabel").on("click", function () {
							$('#addressModal').modal('hide');
						});
				        
				        var hasNext = a[0].totalCount > $('#addProductModal').find('.product-add').length;
				        if (hasNext) {
				        	root.next().show().click(function () {
				        		showPrds(pageNo + 1);
							});
				        } else {
				        	root.next().hide();
				        } // if
						$('#addProductModal').removeClass("loading")
					} // success
					, error : function () {
						alert("error");
					} // error
			}) // ajax
			
			$('body').addClass("modal-open");
			$('#addressModal').addClass("show");
		} // showAddress
		
		$("#addProductBtn").on("click", function() {
			showPrds(0);
		});
	</script>
	
	<!-- 주소록 불러오기 -->
	<script>
		var root = $('#addressModal .modal-body > .address');
		function showAddress(pageNo) {
			$('#addressModal').addClass("loading");
			$.ajax({
					url: '/order/addressBook.do'
					, dataType: "json"
					, cache: false
					, type:"GET"
					, data: { pageNo: pageNo }
					, success: function(response){
						const a = response.addrArr;
						if (a.length > 0) {
							var tpl = null;
					        $.each(a, function (i, addr) {
						    	tpl = '<div class="item" style="margin: 0 ; border-radius: 0">'
											+ '<div class="head">'
												+ '<div class="nickname-format xl">'
													+ '<label>기본</label>'
													+ '<h5>'+ addr.addrName +'</h5>'
										     	+ '</div>'
										    	+ '<ul class="info" style="margin-top:15px; padding-left:1px;">'
										       		+ '<li>'
										        		+ '<p>'+addr.name+'</p>'
										        	+ '</li>'
										        	+ '<li>'
										          		+ '<p>'+addr.tel+'</p>'
										        	+ '</li>'
										        	+ '<li>'
										          		+ '<p>('+addr.zipCode+') '+addr.addr +" "+ addr.addrDetail+'</p>'
										          		+ '<p style="display: none">'+addr.addr+'</p>'
										          		+ '<p style="display: none">'+addr.addrDetail+'</p>'
										          		+ '<p style="display: none">'+addr.memo+'</p>'
										        	+ '</li>'
										      	+ '</ul>'
										    + '</div>'
										    + '<div class="tail">'
										    	+ '<button type="button" class="adapt-address rounded-button">선택</button>'
										    + '</div>'
										+ '</div>';
								var el = $(tpl).data("item", addr);
						        if (addr.defaultAddr != '1') {
						        	el.find("label").remove();
								} // if
								root.append(el);
							});
					        
					        $('#addressModal').modal('show');
					        
					        root.find(".adapt-address").on("click", function () {
								$('#addressModal').modal('hide');
								let pTags = $(this).parent().parent().find("p");
					            $("#receiver").val(pTags.eq(0).text());      // 수령인
					            $("#tel").val(pTags.eq(1).text());            // 전화번호
					            $("#zipcode").val(pTags.eq(2).text().substr(1, 5));   // 우편번호
					            $("#addrRoad").val(pTags.eq(3).text());
					            $("#addrDetail").val(pTags.eq(4).text());
					            $("#memo").val(pTags.eq(5).text());
							});
					        
					        var hasNext = a[0].totalCount > $('#addressModal').find('.item').length;
					        if (hasNext) {
					        	root.next().show().click(function () {
					            	showAddress(pageNo + 1);
								});
					        } else {
					        	root.next().hide();
					        } // if
							$('#addressModal').removeClass("loading")
						} else if (pageNo == 0) {
					    	alert('등록된 주소록이 없습니다.');
							$b('#addressModal').modal("hide");
						} // if
					} // success
					, error : function () {
						alert("error");
					} // error
			}) // ajax
			
			$('body').addClass("modal-open");
			$('#addressModal').addClass("show");
		} // showAddress
		
		$("#addressBtn").on("click", function() {
			root.empty();
			showAddress(0);
		});
	</script>

	<!-- 4주 예상 금액 계산 -->
	<script>
		function calculateTotalPrice() {
			// 초기화
		    var totalPrice = 0;
		    var totalCount = 0;
		    var count = 0;
		    var totalPay = 0;
		    
		    // 1주 예상 금액 계산
		    $("#order_targets [data-itemcode][data-price]").each(function () {
		    	count = 0;
				$(this).find("[data-count]").each(function () {
		        	count += parseInt($(this).val(), 10);
		     	});
		      	totalCount += count;
		      	totalPrice += parseInt($(this).attr("data-price"), 10) * count;
		    });
			
		    // 4주 예상 금액 계산
		    totalPay = totalPrice*gap;
		    
		    // 적용
		    $("[data-price-view='origin']").text(totalPay).toLocaleString();
		    $("[data-price-view='sale']").text(totalPay).toLocaleString();
		    $("[data-price-view='payment']").text(totalPay).toLocaleString();
		    $("input[name='payPrice']").val(totalPay);
		} // calculateTotalPrice()
	</script>
	
	<script>
		$(function () {
			calculateTotalPrice();
		})
	</script>
	
	<!-- 상품 카운트 +- -->
	<script>
		// 상품 + 버튼
		$("button.prod-add").on("click", function() {
			let em = $(this).next("em");
			let input = $(this).parent().prev().prev();
			let cnt = parseInt(em.text())+1;
			em.text(cnt);
			input.val(cnt);
			calculateTotalPrice();
		})
		
		// 상품 - 버튼
		$("button.prod-remove").on("click", function() {
			let em = $(this).prev("em")
			let input = $(this).parent().prev().prev();
			let cnt = parseInt(em.text())-1;
			if (cnt == -1) return;
			em.text(cnt);
			input.val(cnt);
			calculateTotalPrice();
		})
	</script>

	<!-- 다음 주소 api -->
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
		$("#searchPostcode").on("click", function() {
	    	new daum.Postcode({
	      		oncomplete: function (data) {
	        		var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
	        		var extraRoadAddr = ''; 		 // 참고 항목 변수
	        		if (data.bname !== '' && /[동|로|가]$/g.test(data.bname))  extraRoadAddr += data.bname;
	        		if (data.buildingName !== '' && data.apartment === 'Y') {
	          			extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName
	              			: data.buildingName);
	        		} // if
	        		if (extraRoadAddr !== '')  extraRoadAddr = ' (' + extraRoadAddr + ')';
	        		if (fullRoadAddr !== '')  fullRoadAddr += extraRoadAddr;
	        		$("#zipcode").val(data.zonecode);
	        		$("#addrRoad").val(data.roadAddress);
	        		$("#orderStreetAddress").val(data.jibunAddress);
	        		// searchPrtn(data);
	      		}
	    	}).open();
		}) // searchPostcode
	</script>

</body>

</html>