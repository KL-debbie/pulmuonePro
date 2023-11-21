package servlets.mypage.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.command.CommandHandler;

public class ChangeHistory implements CommandHandler {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("ChangeHistory.java : MY녹즙 매일배송 변경 내역 조회 페이지");
		return "/WEB-INF/views/mypage/order/daily/changeHistory.jsp";
	}

}