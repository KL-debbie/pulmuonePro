package servlets.notice.command;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import mvc.command.CommandHandler;
import servlets.notice.model.NoticeDTO;
import servlets.notice.service.NoticeWriteService;

public class NoticeWrite implements CommandHandler {
	
	private NoticeWriteService noticeWriteService = new NoticeWriteService();
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		if( request.getMethod().equalsIgnoreCase("GET") ) {
			
			return "/WEB-INF/views/notice/write.jsp";
		}else {
			
			response.setContentType("text/html; charset=UTF-8");
			
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			
			NoticeDTO dto = new NoticeDTO(0, title, content, null);
						
			System.out.println(title);
			System.out.println(content);
			
			int insertRow = 0;
			try {
				insertRow = noticeWriteService.write(dto);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			String location = "";
			
			if( insertRow == 1) {
				location = "/forum/notice/list.do?success";
			}else {
				location = "/forum/notice/write.do";
			}
			
			
			request.setAttribute("writed", insertRow);
			
			response.sendRedirect(location);
			return null;
		}
		
	}

}
