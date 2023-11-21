<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/layouts/head.jsp"%>
<body>

    <div class="wrapper">

        <%@ include file="/WEB-INF/views/layouts/header.jsp"%>

        <div class="contents-area">
            <div class="container">
                <div class="location">
                    <a href="/">홈</a> <a href="/event/event/list.do">이벤트</a>
                </div>
                <div class="cont-event-area">
                    <%@ include file="/WEB-INF/views/layouts/event/title_tab_area.jsp"%>

<div class="tab-pane fade show active" id="profile" role="tabpanel" aria-labelledby="profile-t">
                <!--S:당첨자발표 상세-->
                <h3 class="hide">당첨자발표 상세</h3>
                <!--E:당첨자발표 상세-->

                <div class="board-type2">
                    <div class="board-title">
                        <b class="">[발표] ${winnerView.win_title}</b>
                        <span class="text-day">${winnerView.win_regdate}</span>
                    </div>
                    <div class="board-cont">
                        <p>${winnerView.win_content}</p>
                    </div>
                </div>
                <div class="btn-area-right">
                    <a href="/event/winner.do" class="btn-default btn-white">목록으로</a>
                </div>
            </div>

                </div>
            </div>
        </div>

        <%@ include file="/WEB-INF/views/layouts/footer.jsp"%>
        <%@ include file="/WEB-INF/views/ui/footermodal.jsp"%>

    </div>

</body>
</html>
