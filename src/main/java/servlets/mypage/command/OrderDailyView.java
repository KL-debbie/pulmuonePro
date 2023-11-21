package servlets.mypage.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.command.CommandHandler;

public class OrderDailyView implements CommandHandler {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("OrderDrinkView.java : MY녹즙 매일배송 주문내역 상세 페이지");
		
		return "/WEB-INF/views/mypage/order/daily/orderDailyView.jsp";
	}

}