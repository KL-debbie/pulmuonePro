package curation.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.command.CommandHandler;

public class CkidsresultHandler implements CommandHandler{

	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String method = request.getMethod();
		if (method.equals("GET")) {
			System.out.println("Kid result Start");
			
			return "/pulmuonePro/customer/product/result/kids.jsp";
		} 
		return null;
	}

}
