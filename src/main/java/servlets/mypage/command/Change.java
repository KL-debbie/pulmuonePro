package servlets.mypage.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.command.CommandHandler;

public class Change implements CommandHandler {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("Change.java : MY녹즙 매일배송 상품 변경 페이지");
		return "/WEB-INF/views/mypage/order/daily/change.jsp";
	}

}