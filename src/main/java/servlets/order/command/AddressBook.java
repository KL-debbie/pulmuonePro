package servlets.order.command;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import auth.AuthInfo;
import mvc.command.CommandHandler;

public class AddressBook implements CommandHandler {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("> AddressBook.process..");
		return "/WEB-INF/views/order/addressBook.jsp";
	} // process()

}