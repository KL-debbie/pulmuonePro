package servlets.notice.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.command.CommandHandler;
import servlets.notice.model.NoticeDTO;
import servlets.notice.service.NoticeViewService;

public class NoticeView implements CommandHandler {

	private NoticeViewService noticeViewService = new NoticeViewService();
	
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String pseq = request.getParameter("seq");
		int seq = 1;
		if( pseq != null ) {
			seq = Integer.parseInt(pseq);
		}
		
		NoticeDTO vo = null;
		
		vo = noticeViewService.getDetailView(seq);
		
		request.setAttribute("vo", vo);
		
		return "/WEB-INF/views/notice/view.jsp";
	}

}
