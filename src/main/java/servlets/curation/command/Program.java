package servlets.curation.command;

import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.command.CommandHandler;
import servlets.curation.domain.CurationDTO;
import servlets.curation.service.ProgramService;

public class Program implements CommandHandler{
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("> Program start..");
		
		String path = request.getRequestURI();
		ProgramService pg = ProgramService.getInstance();
		int num = 4;
//				(int)(Math.random()*8)+1; 
//		
//		switch (num) {
//		case 1:
//			num = 1;
//			break;
//		case 2:
//			num = 2;
//			break;
//		case 3:
//			num = 3;
//			break;
//		case 4:
//			num = 4;
//			break;
//		case 5:
//			num = 5;
//			break;
//		case 6:
//			num = 6;
//			break;
//		case 7:
//			num = 7;
//			break;
//		case 8:
//			num = 8;
//			break;
//		}

		
		List<CurationDTO> list = pg.selectPG(path, num);
		
		request.setAttribute("list", list);
		
	
			
			return "/WEB-INF/views/curation/result/programs.jsp";
		}

}
