package servlets.inquiry.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.command.CommandHandler;
import servlets.inquiry.service.InquiryDeleteService;
import servlets.inquiry.service.InquiryViewService;

public class InquiryDelete implements CommandHandler {

	private InquiryDeleteService inquiryDeleteService = new InquiryDeleteService();
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		response.setContentType("text/html; charset=UTF-8");
		
		String pcategory = request.getParameter("category");
		String pseq = request.getParameter("seq");
		String category = null;
		int seq = 0;
		String user_id = "aaaaaaaa";
		
		if( pseq != null && pseq != "" ) {
			seq = Integer.parseInt( pseq );
		}
		
		if( pcategory != null && pcategory != "" ) {
			category = pcategory;
		}
		
		int deleteCount = inquiryDeleteService.delete(user_id, category, seq);
		
		if( deleteCount > 0 ) {
			response.sendRedirect("/mypage/inquiry/list.do?success");
			return null;
		}
		
		response.sendRedirect("/mypage/inquiry/list.do?fail");
		return null;
	}

}
