package servlets.notice.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.command.CommandHandler;
import servlets.notice.model.NoticeDTO;
import servlets.notice.service.NoticeEditService;
import servlets.notice.service.NoticeViewService;

public class NoticeEdit implements CommandHandler {

	private NoticeEditService noticeEditService = new NoticeEditService();
	private NoticeViewService noticeViewService = new NoticeViewService();
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		if( request.getMethod().equalsIgnoreCase("GET")) {
			String pseq = request.getParameter("seq");
			int seq = 1;
			if( pseq != null ) {
				seq = Integer.parseInt(pseq);
			}
			
			NoticeDTO vo = null;
			
			vo = noticeViewService.getDetailView(seq);
			
			request.setAttribute("vo", vo);
			
			return "/WEB-INF/views/notice/edit.jsp";
		}else {
			response.setContentType("text/html; charset=UTF-8");
			
			String pseq = request.getParameter("seq");
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			int seq = 0;
			
			if( pseq != null || pseq != "" ) {
				seq = Integer.parseInt(pseq);
			}
			
			NoticeDTO dto = new NoticeDTO(seq, title, content, null);
						
			System.out.println(seq);
			System.out.println(title);
			System.out.println(content);
			
			int updateRow = 0;
			try {
				updateRow = noticeEditService.edit(dto);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			System.out.println(updateRow);
			String location = "";
			
			if( updateRow == 1) {
				location = "/forum/notice/view.do?seq=" + seq + "&edit=success";
			}else {
				location = "/forum/notice/edit.do?edit=fail";
			}
			
			response.sendRedirect(location);
			return null;
			
		}
	}
}
