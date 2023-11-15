package servlets.inquiry.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.command.CommandHandler;
import servlets.inquiry.model.InquiryDTO;
import servlets.inquiry.service.InquiryViewService;

public class InquiryView implements CommandHandler {
	
	private InquiryViewService inquiryViewService = new InquiryViewService();
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String pcategory = request.getParameter("category");
		String pseq = request.getParameter("seq");
		String category = null;
		int seq = 0;
		String user_id = "aaaaaaaa";
		
		InquiryDTO vo = null;
		
		System.out.println(pcategory);
		System.out.println(pseq);
		
		if( pseq != null && pseq != "" ) {
			seq = Integer.parseInt( pseq );
		}
		
		if( pcategory != null && pcategory != "" ) {
			category = pcategory;
		}else {
			response.sendRedirect("/mypage/inquiry/list.do?fail");
			return null;
		}
		
		vo = inquiryViewService.selectView(user_id, category, seq);
		
		request.setAttribute("vo", vo);
		
		return "/WEB-INF/views/inquiry/view.jsp";
	}
	
}
