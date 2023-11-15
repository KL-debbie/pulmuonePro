<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/layouts/head.jsp" %>
<body>
<div class="wrapper">

	<%@ include file="/WEB-INF/views/layouts/header.jsp" %>
	<main class="page notice forum">
		<div class="container">
			<div class="breadcrumb-style">
                <div class="wrap">
                    <ul>
                        <li><a href="/">홈</a></li>
                        <li><a href="/forum/faq/list.do">고객기쁨센터</a></li>
                        <li><a class="active">공지사항</a></li>
                    </ul>
                </div>
            </div>
                
            <div class="page-wrap">
				<%@ include file="/WEB-INF/views/layouts/forum/aside.jsp" %>

				<div class="page-content">
					<div class="border-wrapper">
			            <h2 class="container-title">
			                공지사항
			            </h2>
			        </div>
					<div class="board-type2">
						<div class="board-title">
							<b class="">${ vo.title }</b>
							<span class="text-day"><fmt:formatDate value="${vo.regdate}" pattern="yyyy.MM.dd" /> </span>
						</div>
						
						<div class="board-cont">
							${vo.content }
						 </div>
						<div class="btn-area-right" style="margin-top: 20px;">
							<button onclick="noticeModify()" class="btn-default btn-board-button btn-gray" style="color: #666;">수정</button>
							<button onclick="noticeDelete()" class="btn-default btn-board-button btn-gray" style="color: #666;">삭제</button>
							<button onclick="location.href='/forum/notice/list.do'" class="btn-default btn-board-button btn-white">목록으로</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
	
</div>

<%@ include file="/WEB-INF/views/ui/modal.jsp" %>

<script>
	function noticeModify() {
		location.href = `/forum/notice/edit.do?seq=${ param.seq }`;		
	}
	
	function noticeDelete()  {
		location.href = `/forum/notice/delete.do?seq=${ param.seq }`;
	}
	
	$(function(){
		
		if( `${param.edit}` == "success" ) {
			$(".modal-body").text("공지사항 게시글이 수정되었습니다.");	
			$("#alertModal").modal();
		}
	})
	
	
	
	
</script>

</body>
</html>
