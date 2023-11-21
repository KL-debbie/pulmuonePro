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
							<h2 class="container-title">음용상품변경</h2>
						</div>
						<div class="page-addiction-wrapper">
							<div class="info-copy">
								<div class="box" style="flex:1; margin-bottom:13px;">
									<div class="nickname-format">
										
											<label>기본</label>
										
										<h5>음용1</h5>
										<span>1</span>
									</div>
								</div>
							</div>
						</div>
						<div class="page-addiction-wrapper" style="margin-bottom:10px;">
							<div class="info-copy description" style="margin-top:2px;">
								<p>※ 원하시는 스케줄에 따라 상품/요일/수량 변경이 가능합니다.</p>
								<p>※ 타 쇼핑몰 고객은 상품 변경이 불가합니다.</p>
							</div>
							<button class="rect-button primary" style="width:120px;" type="button" id="addProduct">상품추가하기</button>
						</div>
						<div class="box-partition">
							<ul class="drinkchange-list ch">
				
							<li class="">
									<div class="item" href="/">
										<div class="thumb">
											<img src="/file/download/product/685a5aac-588c-4366-82c4-217f17b38067.jpg" alt="">
										</div>
										<div class="contents">
											<span>10.05 부터 </span>
											<p class="prd-title">
												핸디밀 그린샐러드 식이섬유플랜
												<b style="font-size: 16px" class="pause"></b>
											</p>
											<b class="price">3,300<span> 원(190ml)</span></b>
										</div>
									</div>
									<div class="select-group">
				
									<div class="select-item">
				                    <span>월</span>
				                    <div class="unit">
				                        <button type="button" class="plus">
				                        </button>
				                        <em>0</em>
				                        <button type="button" class="minus">
				                        </button>
				                    </div>
				                </div><div class="select-item">
				                    <span>화</span>
				                    <div class="unit">
				                        <button type="button" class="plus">
				                        </button>
				                        <em>0</em>
				                        <button type="button" class="minus">
				                        </button>
				                    </div>
				                </div><div class="select-item">
				                    <span>수</span>
				                    <div class="unit">
				                        <button type="button" class="plus">
				                        </button>
				                        <em>0</em>
				                        <button type="button" class="minus">
				                        </button>
				                    </div>
				                </div><div class="select-item">
				                    <span>목</span>
				                    <div class="unit">
				                        <button type="button" class="plus">
				                        </button>
				                        <em>0</em>
				                        <button type="button" class="minus">
				                        </button>
				                    </div>
				                </div><div class="select-item">
				                    <span>금</span>
				                    <div class="unit">
				                        <button type="button" class="plus">
				                        </button>
				                        <em>1</em>
				                        <button type="button" class="minus">
				                        </button>
				                    </div>
				                </div></div>
									<button type="button" class="btn-delete">
										<i class="ico ico-prd-delete"></i>
										<span class="hide">카트에서 삭제</span>
									</button>
								</li><li class="">
									<div class="item" href="/">
										<div class="thumb">
											<img src="/file/download/product/42da9a6f-9889-4ff7-bf77-af5989855f86.jpg" alt="">
										</div>
										<div class="contents">
											<span>10.05 부터 </span>
											<p class="prd-title">
												핸디밀 블랙콩콩 비타D플랜 <b style="font-size: 16px" class="pause"></b>
											</p>
											<b class="price">3,300<span> 원(190ml)</span>
											</b>
										</div>
									</div>
									<div class="select-group">
				
									<div class="select-item">
				                    <span>월</span>
				                    <div class="unit">
				                        <button type="button" class="plus">
				                        </button>
				                        <em>0</em>
				                        <button type="button" class="minus">
				                        </button>
				                    </div>
				                </div><div class="select-item">
				                    <span>화</span>
				                    <div class="unit">
				                        <button type="button" class="plus">
				                        </button>
				                        <em>0</em>
				                        <button type="button" class="minus">
				                        </button>
				                    </div>
				                </div><div class="select-item">
				                    <span>수</span>
				                    <div class="unit">
				                        <button type="button" class="plus">
				                        </button>
				                        <em>0</em>
				                        <button type="button" class="minus">
				                        </button>
				                    </div>
				                </div><div class="select-item">
				                    <span>목</span>
				                    <div class="unit">
				                        <button type="button" class="plus">
				                        </button>
				                        <em>1</em>
				                        <button type="button" class="minus">
				                        </button>
				                    </div>
				                </div><div class="select-item">
				                    <span>금</span>
				                    <div class="unit">
				                        <button type="button" class="plus">
				                        </button>
				                        <em>0</em>
				                        <button type="button" class="minus">
				                        </button>
				                    </div>
				                </div></div>
									<button type="button" class="btn-delete">
										<i class="ico ico-prd-delete"></i>
										<span class="hide">카트에서 삭제</span>
									</button>
								</li><li class="">
									<div class="item" href="/">
										<div class="thumb">
											<img src="/file/download/product/abde0d7f-d546-4cc4-acec-99a4b895b9d7.jpg" alt="">
										</div>
										<div class="contents">
											<span>10.05 부터 </span>
											<p class="prd-title">
												아이러브엑스투 <b style="font-size: 16px" class="pause"></b>
											</p>
											<b class="price">3,300<span> 원(130ml)</span>
											</b>
										</div>
									</div>
									<div class="select-group">
				
									<div class="select-item">
				                    <span>월</span>
				                    <div class="unit">
				                        <button type="button" class="plus">
				                        </button>
				                        <em>0</em>
				                        <button type="button" class="minus">
				                        </button>
				                    </div>
				                </div><div class="select-item">
				                    <span>화</span>
				                    <div class="unit">
				                        <button type="button" class="plus">
				                        </button>
				                        <em>1</em>
				                        <button type="button" class="minus">
				                        </button>
				                    </div>
				                </div><div class="select-item">
				                    <span>수</span>
				                    <div class="unit">
				                        <button type="button" class="plus">
				                        </button>
				                        <em>0</em>
				                        <button type="button" class="minus">
				                        </button>
				                    </div>
				                </div><div class="select-item">
				                    <span>목</span>
				                    <div class="unit">
				                        <button type="button" class="plus">
				                        </button>
				                        <em>0</em>
				                        <button type="button" class="minus">
				                        </button>
				                    </div>
				                </div><div class="select-item">
				                    <span>금</span>
				                    <div class="unit">
				                        <button type="button" class="plus">
				                        </button>
				                        <em>0</em>
				                        <button type="button" class="minus">
				                        </button>
				                    </div>
				                </div></div>
									<button type="button" class="btn-delete">
										<i class="ico ico-prd-delete"></i>
										<span class="hide">카트에서 삭제</span>
									</button>
								</li><li class="">
									<div class="item" href="/">
										<div class="thumb">
											<img src="/file/download/product/5e98ba4b-ea3d-4b14-b7db-a6b4399981dc.png" alt="">
										</div>
										<div class="contents">
											<span>10.05 부터 </span>
											<p class="prd-title">
												바이탈엑스투 스타트업 메모리케어 <b style="font-size: 16px" class="pause"></b>
											</p>
											<b class="price">4,500<span> 원(125g)</span>
											</b>
										</div>
									</div>
									<div class="select-group">
				
									<div class="select-item">
				                    <span>월</span>
				                    <div class="unit">
				                        <button type="button" class="plus">
				                        </button>
				                        <em>1</em>
				                        <button type="button" class="minus">
				                        </button>
				                    </div>
				                </div><div class="select-item">
				                    <span>화</span>
				                    <div class="unit">
				                        <button type="button" class="plus">
				                        </button>
				                        <em>0</em>
				                        <button type="button" class="minus">
				                        </button>
				                    </div>
				                </div><div class="select-item">
				                    <span>수</span>
				                    <div class="unit">
				                        <button type="button" class="plus">
				                        </button>
				                        <em>0</em>
				                        <button type="button" class="minus">
				                        </button>
				                    </div>
				                </div><div class="select-item">
				                    <span>목</span>
				                    <div class="unit">
				                        <button type="button" class="plus">
				                        </button>
				                        <em>0</em>
				                        <button type="button" class="minus">
				                        </button>
				                    </div>
				                </div><div class="select-item">
				                    <span>금</span>
				                    <div class="unit">
				                        <button type="button" class="plus">
				                        </button>
				                        <em>0</em>
				                        <button type="button" class="minus">
				                        </button>
				                    </div>
				                </div></div>
									<button type="button" class="btn-delete">
										<i class="ico ico-prd-delete"></i>
										<span class="hide">카트에서 삭제</span>
									</button>
								</li><li class="">
									<div class="item" href="/">
										<div class="thumb">
											<img src="/file/download/product/4cf0398b-fb18-45f9-97c4-be8b5bd2edd6.jpg" alt="">
										</div>
										<div class="contents">
											<span>11.06 부터 </span>
											<p class="prd-title">
												하트러브 엑스투 <b style="font-size: 16px" class="pause"></b>
											</p>
											<b class="price">3,300<span> 원(130ml)</span>
											</b>
										</div>
									</div>
									<div class="select-group">
				
									<div class="select-item">
				                    <span>월</span>
				                    <div class="unit">
				                        <button type="button" class="plus">
				                        </button>
				                        <em>0</em>
				                        <button type="button" class="minus">
				                        </button>
				                    </div>
				                </div><div class="select-item">
				                    <span>화</span>
				                    <div class="unit">
				                        <button type="button" class="plus">
				                        </button>
				                        <em>0</em>
				                        <button type="button" class="minus">
				                        </button>
				                    </div>
				                </div><div class="select-item">
				                    <span>수</span>
				                    <div class="unit">
				                        <button type="button" class="plus">
				                        </button>
				                        <em>1</em>
				                        <button type="button" class="minus">
				                        </button>
				                    </div>
				                </div><div class="select-item">
				                    <span>목</span>
				                    <div class="unit">
				                        <button type="button" class="plus">
				                        </button>
				                        <em>0</em>
				                        <button type="button" class="minus">
				                        </button>
				                    </div>
				                </div><div class="select-item">
				                    <span>금</span>
				                    <div class="unit">
				                        <button type="button" class="plus">
				                        </button>
				                        <em>0</em>
				                        <button type="button" class="minus">
				                        </button>
				                    </div>
				                </div></div>
									<button type="button" class="btn-delete">
										<i class="ico ico-prd-delete"></i>
										<span class="hide">카트에서 삭제</span>
									</button>
								</li><li class="">
									<div class="item" href="/">
										<div class="thumb">
											<img src="/file/download/product/0512477d-b440-4adf-9cd3-3cc9ca29ab98.png" alt="">
										</div>
										<div class="contents">
											<span>11.06 부터 </span>
											<p class="prd-title">
												식물성유산균쌀요거트 <b style="font-size: 16px" class="pause"></b>
											</p>
											<b class="price">2,300<span> 원(150ml)</span>
											</b>
										</div>
									</div>
									<div class="select-group">
				
									<div class="select-item">
				                    <span>월</span>
				                    <div class="unit">
				                        <button type="button" class="plus">
				                        </button>
				                        <em>0</em>
				                        <button type="button" class="minus">
				                        </button>
				                    </div>
				                </div><div class="select-item">
				                    <span>화</span>
				                    <div class="unit">
				                        <button type="button" class="plus">
				                        </button>
				                        <em>0</em>
				                        <button type="button" class="minus">
				                        </button>
				                    </div>
				                </div><div class="select-item">
				                    <span>수</span>
				                    <div class="unit">
				                        <button type="button" class="plus">
				                        </button>
				                        <em>0</em>
				                        <button type="button" class="minus">
				                        </button>
				                    </div>
				                </div><div class="select-item">
				                    <span>목</span>
				                    <div class="unit">
				                        <button type="button" class="plus">
				                        </button>
				                        <em>0</em>
				                        <button type="button" class="minus">
				                        </button>
				                    </div>
				                </div><div class="select-item">
				                    <span>금</span>
				                    <div class="unit">
				                        <button type="button" class="plus">
				                        </button>
				                        <em>1</em>
				                        <button type="button" class="minus">
				                        </button>
				                    </div>
				                </div></div>
									<button type="button" class="btn-delete">
										<i class="ico ico-prd-delete"></i>
										<span class="hide">카트에서 삭제</span>
									</button>
								</li></ul>
							<div class="empty-area" style="padding: 160px 0; display: none">
								<img src="/resources/images/ui/ico-alert.png" alt="empty">
								<b>변경할 상품이 없습니다.</b>
							</div>
				
						</div>
						<div class="form-input period" style="margin-top:10px; margin-bottom:16px;">
							<dl class="date">
								<dt style="padding-left:20px; margin-right:30px;">
									<label>변경배송 시작일</label>
									<button class="btn-question" data-toggle="modal" data-target="#tooltipModal"><i class="ico ico-question"></i><span class="hide">자세한 내용 보기</span>
									</button>
								</dt>
								<dd style="min-width:153px;">
									<input type="text" name="datepicker" data-placeholder="날짜를 입력하세요.">
								</dd>
							</dl>
						</div>
						<div class="dual-layout">
							<div>
								<table class="doc-style-table h40">
									<tbody><tr>
										<th>총 상품금액 (4주 기준)</th>
										<td class="np">
											<div class="price-tag xs right">
												<p class="value total">80,000</p>
												<span class="unit" style="font-weight:300; color:#333;">원</span>
											</div>
										</td>
									</tr>
									<tr>
										<th>총 할인금액</th>
										<td class="np">
											<div class="price-tag xs right">
												<p class="value">0</p>
												<span class="unit" style="font-weight:300; color:#333;">원</span>
											</div>
										</td>
									</tr>
								</tbody></table>
							</div>
							<div>
								<table class="doc-style-table h40">
									<tbody><tr>
										<th>배송비</th>
										<td class="np">
											<div class="price-tag xs right">
												<p class="value">0</p>
												<span class="unit" style="font-weight:300; color:#333;">원</span>
											</div>
										</td>
									</tr>
									<tr>
										<th class="bigger">최종결제금액</th>
										<td class="np">
											<div class="price-tag  sm right">
												<p class="value final" style="color:#333">80,000</p>
												<span class="unit" style="font-size:20px;font-weight:300; color:#333;">원</span>
											</div>
										</td>
									</tr>
								</tbody></table>
							</div>
						</div>
						<div class="addiction-foot" style="margin-top:26px;">
							<p class="foot-copy">
								※ 변경시작일로부터 4주 기준 예상 음용대금으로 실제 월 청구금액과 상이할 수 있습니다.
							</p>
							<div class="btn-area-right">
								<a id="cancel" style="cursor:pointer;padding:0; width:140px;" class="btn-default btn-white">취소</a>
								<a style="cursor:pointer; padding:0; width:140px;" id="changeProductBtn" class="btn-default btn-default">음용상품변경</a>
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