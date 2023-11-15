package servlets.inquiry.command;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.command.CommandHandler;
import servlets.inquiry.model.InquiryDTO;
import servlets.inquiry.service.InquiryWriteService;

public class InquiryWrite implements CommandHandler{

	private InquiryWriteService inquiryWriteService = new InquiryWriteService();
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		if( request.getMethod().equalsIgnoreCase("GET") ) {
			
			return "/WEB-INF/views/inquiry/write.jsp";
		}else {
			System.out.println("InquiryWriteService.process..");
			String inquiry_cate = request.getParameter("cate1");
			String email = request.getParameter("emailAddHost");
			String title = request.getParameter("title");
			String contents = request.getParameter("contents");
			
			int insertRow = 0;
			InquiryDTO dto = new InquiryDTO(0, "aaaaaaaa", inquiry_cate, email, title, contents, null, "0");
			
			
			insertRow = inquiryWriteService.write(dto);
			
			if( insertRow > 0 ) {
				response.sendRedirect("/mypage/inquiry/list.do");
			}else {
				response.sendRedirect("/mypage/inquiry/write.do?fail");				
			}
			
		}
		
		return null;
	}
	
}
