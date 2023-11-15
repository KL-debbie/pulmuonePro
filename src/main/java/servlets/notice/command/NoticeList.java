package servlets.notice.command;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.command.CommandHandler;
import servlets.notice.model.NoticeDTO;
import servlets.notice.service.NoticeListService;
import servlets.utils.PageDTO;

public class NoticeList implements CommandHandler {

	private NoticeListService noticeListService = new NoticeListService();

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("> NoticeList.process..");

		String ppageNo = request.getParameter("pageNo");
		int numberPerPage = 10; // 페이지당 보여질 개수 
		int numberOfPageBlock = 5; // 페이지번호 갯수 
		int pageNo = 1;
		int totalRows = 0;
		int totalPages = 1;

		if( ppageNo != null ) {
			pageNo = Integer.parseInt(ppageNo);
		}

		ArrayList<NoticeDTO> list = null;
		
		
		list = noticeListService.getNoticeList(pageNo, numberPerPage);
		totalRows = noticeListService.getTotalRows();
		totalPages = noticeListService.getTotalPages(numberPerPage);
		
		PageDTO paging = new PageDTO(pageNo, numberPerPage, numberOfPageBlock, totalPages);
		request.setAttribute("list", list);
		request.setAttribute("totalRows", totalRows);
		request.setAttribute("paging", paging);
		return "/WEB-INF/views/notice/list.jsp";
	}

}
