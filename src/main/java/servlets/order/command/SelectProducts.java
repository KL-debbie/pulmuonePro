package servlets.order.command;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import auth.AuthInfo;
import mvc.command.CommandHandler;

public class SelectProducts implements CommandHandler {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("> SelectProducts.process..");
		return "/WEB-INF/views/order/selectProducts.jsp";
	} // process()

}