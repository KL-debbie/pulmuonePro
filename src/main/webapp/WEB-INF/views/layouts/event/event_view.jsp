<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<div class="board-cont event-board"
	style="position: relative; min-height: 100px;">
	<div id="content-editor-area" style="line-height: 0;">
		<c:forEach var="image" items="${eventView.images}">
			<c:choose>
				<c:when test="${not empty image.img_link}">
					<a href="${image.img_link}" target="_blank"> <img
						src="${image.img_path}" title="${image.origin_name}"
						class="${image.system_name}" style="line-height: 0;">
					</a>
				</c:when>
				<c:otherwise>
					<img src="${image.img_path}" title="${image.origin_name}"
						class="${image.system_name}" style="line-height: 0;">
				</c:otherwise>
			</c:choose>
			<br style="clear: both;">
		</c:forEach>
	</div>
</div>



<div class="modal fade" id="alertModal" tabindex="-1" aria-labelledby="alertModalLabel" aria-modal="true" role="dialog">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="alertModalLabel"></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                </button>
            </div>
            <div class="modal-body"></div>
            <button type="button" class="modal-footer" id="confirmButton" data-dismiss="modal">확인</button>
        </div>
    </div>
</div>

<script>
$(document).ready(function() {
    $("#content-editor-area > a").click(function(e) {
        e.preventDefault();

        var couponLink = $(this).attr('href');

        $.ajax({
            url: couponLink,
            type: 'GET',
            beforeSend: function() {
                console.log('AJAX 요청을 시작합니다.');
            },
            success: function(response) {
               
                var message = response.message;

                // 모달 창에 메시지를 표시하고, 모달 창을 보이게 합니다.
                $('#alertModal .modal-body').text(message);
                $('#alertModal').modal('show');
                
                // 로그인 후 이용해주세요 메시지인 경우 확인 버튼에 onclick 속성 추가
                if (message === "로그인 후 이용해주세요.") {
                    $('#confirmButton').attr("onclick", "location.href='/member/login.do'");
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.log('AJAX 요청이 실패했습니다.');
                console.log('텍스트 상태: ' + textStatus);
                console.log('오류 메시지: ' + errorThrown);
            },
            complete: function() {
                console.log('AJAX 요청이 완료되었습니다.');
            }
        });
    });
});

$('#confirmButton').click(function() {
    var message = $('#alertModal .modal-body').text();
    if (message === "로그인 후 이용해주세요.") {
        location.href = '/member/login.do';
    } else {
    	$('#alertModal').modal('hide');
    }
});
</script>


