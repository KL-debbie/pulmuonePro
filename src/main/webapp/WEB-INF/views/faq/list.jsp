<%@page import="servlets.utils.PageDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String category = request.getParameter("category");
	PageDTO paging = (PageDTO) request.getAttribute("paging");
%>
<%@ include file="/WEB-INF/views/layouts/head.jsp" %>
<body>
	<div class="wrapper">

		<%@ include file="/WEB-INF/views/layouts/header.jsp" %>
		<main class="page faq forum">
			<div class="container">
				<div class="breadcrumb-style">
                    <div class="wrap">
                        <ul>
                            <li><a href="/">홈</a></li>
                            <li><a href="/forum/faq/list.do?">고객기쁨센터</a></li>
                            <li><a class="active">FAQ</a></li>
                        </ul>
                    </div>
                </div>
                
                <div class="page-wrap">
					<%@ include file="/WEB-INF/views/layouts/forum/aside.jsp" %>

					<div class="page-content">
						<form id="searchForm">
							<input type="hidden" id="category" name="category" value="<%=category%>">
							<div class="border-wrapper">
								<h2 class="container-title">
									FAQ
								</h2>
							</div>
							<div class="coupon-srch" style="border-bottom:0; padding-bottom:0;">
								<div class="form-input none-dt">
									<dl>
										<dd>
											<input title="검색어 입력" type="text" id="searchKeyword" name="searchKeyword" placeholder="궁금하신 내용을 입력해주세요."  maxlength="30" autocomplete="off">
											<button class="btn-square" id="faqSearchBtn">검색</button>
										</dd>
									</dl>
								</div>
							</div>


							<div class="list-area">
								<div class="tab-area faq">
									<ul class="nav nav-tabs" role="tablist">
				
										<li>
											<a href="/forum/faq/list.do">TOP 10</a>
										</li>
										
											<li>
												<a href="/forum/faq/list.do?category=1">회원</a>
											</li>
										
											<li>
												<a href="/forum/faq/list.do?category=2" class="">혜택</a>
											</li>
										
											<li>
												<a href="/forum/faq/list.do?category=3" class="">주문/배송</a>
											</li>
										
											<li>
												<a href="/forum/faq/list.do?category=4" >상품</a>
											</li>
										
											<li>
												<a href="/forum/faq/list.do?category=5" class="">음용</a>
											</li>
										
											<li>
												<a href="/forum/faq/list.do?category=6" class="">기타</a>
											</li>
									</ul>
								</div>
								
								<c:if test="${ not empty param.searchKeyword }">
									<div class="search-result-box">
										<p><span>"${ param.searchKeyword }"</span> 검색결과 총 <span>${total }</span>건</p>
									</div>
								</c:if>
								<div class="accordion faq-list" id="pagable-list" data-list-object="replace">
									<c:choose>
										
										<c:when test="${ param.category == null && param.category != '' }">
											<%@ include file="top10.jsp" %>
										</c:when>
										<c:otherwise>
											<c:choose>
												<c:when test="${ list.size() eq null }">
													<div class="empty-area" style="padding: 160px 0">
														<img src="/resources/assets/images/ui/ico-alert.png" alt="empty">
														<b>검색결과가 없습니다.</b>
													</div>
												</c:when>
												<c:otherwise>
													<c:forEach items="${ list }" var="item">
														<div class="card">
															<div class="card-header">
																<h2 class="mb-0" style="width: 100%">
																	<button class="btn btn-link btn-block text-left"
																		type="button" style="width: 100%">${ item.question }</button>
																</h2>
															</div>
															<div class="faq-contents-area">
																<div class="card-body">
																	<p>
																		<span
																			style="font-family: Arial; color: rgb(119, 119, 119);"><span
																			style="font-size: 13.3333px;">${ item.answer }</span></span>&nbsp;
																	</p>
																</div>
															</div>
														</div>
													</c:forEach>
												</c:otherwise>
											</c:choose>
										</c:otherwise>
									</c:choose>
									
									
								</div>
								<c:if test="${ param.category != null }">
									<nav aria-label="Page navigation example" class="pagenavi-area" data-pagination="">
										<input type="hidden" id="pageNo" name="pageNo">
										<ul class="pagination">
											<c:forEach begin="${ paging.start }" end="${ paging.end }" step="1" var="i">
												<c:choose>
													<c:when test="${ i eq paging.currentPage }">
														<li class="page-item active">
															<a class="page-link active" data-param="${i }" >${i }</a>
														</li>	
													</c:when>
													<c:otherwise>
														<li class="page-item">
															<a class="page-link" data-list-more="#pagable-list" data-param="${i }">${i }</a>
														</li>
													</c:otherwise>
												</c:choose>
											</c:forEach>
										</ul>
									</nav>
								</c:if>
								
							</div>
						</form>
					</div>
				</div>
				
			</div>
		</main>
		<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
 
 	</div>
	
<script>
	$(function(){
		$("#searchKeyword").focus();
		$("#searchKeyword").select();
		
 		
		$("#searchKeyword").val( `${param.searchKeyword }`);
		
		$(".faq .tab-area ul li a").removeClass("active");
		$(".faq .tab-area ul li").eq(<%=category%>).find("a").addClass("active");
		
		
		$("#searchForm").submit(function(e){
			$("#category").val("");
		})
		
		let $pageItem = $(".faq .pagenavi-area .pagination .page-item a");
		
		$pageItem.each(function(i, el) {
			let aparam = $(this).data("param");
			$(this).attr("href", `/forum/faq/list.do?category=${ param.category }&pageNo=\${aparam}`)
		})
	
	})
</script>
</body>
</html>