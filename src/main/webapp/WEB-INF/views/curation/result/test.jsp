<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<body>
	<div class="wrapper">
		<main class="kids">
			<div id="container-wrapper" class="container-wrapper">
				<!-- TODO : 회원쪽 페이지들은 <div class="container-wrapper member"> -->			
				<div class="modal" id="productPreviewModal" tabindex="-1"
					style="display: none; padding-left: 17px;" aria-modal="true"
					role="dialog">
					<div class="modal-dialog modal-dialog-centered"
						style="width: 430px;">
						<div class="modal-content modal-product">

							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close"></button>
								<div class="thumb-normal">

									<c:forEach var="dto" items="${list }">
<%-- 										<img src="/resources/assets/images/prev/${dto.system_name }"> --%>
										<img src="/resources/assets/images/${dto.system_name }">
									</c:forEach>
								</div>
							</div>

							<c:forEach var="dto" items="${list}">
								<div class="modal-body">
									<div class="info-area">
										<h2>${dto.products_name }</h2>
										<p>${dto.products_sub_name}</p>
										<div class="product-addiction" style="border-bottom: none">
											<div class="price-item">
												<p>${dto.price}<span>원</span>
												</p>
												<span>(${dto.products_size })</span>
											</div>
										</div>
									</div>
									<div class="button-set">
										<a href="/product/daily/view.do?tag=${dto.products_tag }"
											class="button-basic primary">상세보기</a>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>

			</div>
	</div>
	</main>
	</div>
</body>
</html>