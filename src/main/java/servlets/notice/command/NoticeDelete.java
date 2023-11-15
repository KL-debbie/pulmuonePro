package servlets.notice.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.command.CommandHandler;
import servlets.notice.service.NoticeDeleteService;

public class NoticeDelete implements CommandHandler {
	
	private NoticeDeleteService noticeDeleteService = new NoticeDeleteService();

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String pseq = request.getParameter("seq");
		int seq = 0;
		if( pseq != null || !pseq.equals("") ) {
			seq = Integer.parseInt(pseq);
		}
		String location = "/forum/notice/list.do";
		
		System.out.println(seq);
		
		int deleteRow = noticeDeleteService.delete(seq);
		
		System.out.println(deleteRow);
		if( deleteRow == 1 ) {
			location += "?success";
		}else {
			location += "?fail";
		}
		
		
		response.sendRedirect(location);
		
		return null;
	}

}
