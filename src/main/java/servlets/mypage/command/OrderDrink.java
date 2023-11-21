package servlets.mypage.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.command.CommandHandler;

public class OrderDrink implements CommandHandler {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("OrderDrink.java : MY녹즙 매일배송 주문내역 페이지");
		
		String drinkingType = request.getParameter("drinkingType");
		request.setAttribute("drinkingType", drinkingType);
		
		return "/WEB-INF/views/mypage/order/daily/orderDaily.jsp";
	}

}