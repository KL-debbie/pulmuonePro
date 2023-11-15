package servlets.faq.command;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.command.CommandHandler;
import servlets.faq.model.FaqDTO;
import servlets.faq.service.FaqListService;
import servlets.utils.PageDTO;

public class FaqList implements CommandHandler {
	
	private FaqListService listService = new FaqListService();

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) 
			throws Exception {
		System.out.println("> FaqList.process..");
		
		String pcategory = request.getParameter("category");
		String ppageNo = request.getParameter("pageNo");
		
		int category = 1;
		int pageNo = 1;
		int numberPerPage = 5; // 페이지당 글 수
		int totalPages = 0; // 총 페이지수
		int total = 0;
		int numberOfPageBlock = 5;
		
		PageDTO paging = null;
		
		if( pcategory != null && !pcategory.equals("") ) {
			category = Integer.parseInt(pcategory);
		}
		if( ppageNo != null && !ppageNo.equals("") ) {
			pageNo = Integer.parseInt(ppageNo);
		}
		
		// 검색
		String searchKeyword = request.getParameter("searchKeyword");
		if( searchKeyword == null ) searchKeyword = "";
		
		ArrayList<FaqDTO> faqList =  listService.getFaqList(pageNo, category, numberPerPage, searchKeyword);
		totalPages = listService.getFaqTotalPage(numberPerPage, category, searchKeyword);
		total = listService.getFaqTotal(category, searchKeyword);
		
		paging = new PageDTO(pageNo, numberPerPage, numberOfPageBlock, totalPages);
		
		request.setAttribute("list", faqList);
		request.setAttribute("total", total);
		request.setAttribute("paging", paging);
		
		return "/WEB-INF/views/faq/list.jsp";
	}

}
