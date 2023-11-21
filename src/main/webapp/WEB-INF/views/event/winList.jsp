<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
                    
                    <div class="list-area">
                    
                        <div class="list-head">
                            <em class="count">총 <span>${eventWinners.size()}</span>건</em>
                        </div>
                        
                        <table class="tbl-col event-winner-list" style="margin-top: 30px">
                            <caption></caption>
                            <colgroup>
                                <col>
                                <col>
                            </colgroup>
                            <tbody id="pagable-list" data-list-object="replace">
                                <c:forEach var="eventWinner" items="${eventWinners}">
                                    <tr>
                                        <td class="al">
                                            <a href="/event/winner/view.do?win_board_no=${eventWinner.win_board_no}">
                                               [발표] ${eventWinner.win_title} <span>${eventWinner.win_regdate}</span>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        
                        <nav aria-label="Page navigation example" class="pagenavi-area" data-pagination="">
						    <input type="hidden" id="pageNo" name="pageNo">
						    <ul class="pagination">
						        <c:forEach var="i" begin="1" end="${totalPages}">
						            <li class="page-item ${i == currentPage ? 'active' : ''}">
						                <a class="page-link" href="/event/winner.do?currentPage=${i}">${i}</a>
						            </li>
						        </c:forEach>
						    </ul>
						</nav>

                        
                    </div>
                    
                </div>
            </div>
        </div>
        <%@ include file="/WEB-INF/views/layouts/footer.jsp"%>
        <%@ include file="/WEB-INF/views/ui/footermodal.jsp"%>
    </div>
</body>
</html>
