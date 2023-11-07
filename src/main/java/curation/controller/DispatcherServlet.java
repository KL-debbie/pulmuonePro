package curation.controller;

import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;
import java.util.Set;
import java.util.Map.Entry;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.command.CommandHandler;

public class DispatcherServlet extends HttpServlet{

	
	private static final long serialVersionUID = 2590071771477155720L;

	private Map<String, CommandHandler > commandHandlerMap = new HashMap<>();


	@Override
	public void init() throws ServletException {
		
		String path = this.getInitParameter("path"); //web.xml 수정!
		// System.out.println(path);
		String realpath = this.getServletContext().getRealPath(path);
//		System.out.println(realpath);
		Properties prop = new Properties();
		 
		try (FileReader reader = new FileReader(realpath);) {
			prop.load(reader);
			
		} catch (Exception e) {
			throw new ServletException();
		}
		
		// prop(String, String) -> commandHandlerMap<String, 실제객체>
		Set<Entry<Object, Object>> set = prop.entrySet();
		Iterator<Entry<Object, Object>> ir = set.iterator();
		while (ir.hasNext()) {
			Entry<Object, Object> entry = ir.next();
			String url = (String) entry.getKey();  //  /board/list.do
			String className = (String) entry.getValue();
//			System.out.print(url);
//			System.out.println(className);

			Class<?> commandhandlerClass;
			try {
				commandhandlerClass = Class.forName(className);
				System.out.println(commandhandlerClass);
				CommandHandler commandHandler =  (CommandHandler) commandhandlerClass.newInstance();
				this.commandHandlerMap.put(url, commandHandler);
			} catch (ClassNotFoundException | InstantiationException e) {
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			}
		}//while
		
	}// init
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		System.out.println(request.getRequestURL());
		
		//  /jspPro/days06/list.do
		String requestURI = request.getRequestURI();
		String path = request.getContextPath();
		requestURI=requestURI.replace(path, "");

		CommandHandler handler = this.commandHandlerMap.get(requestURI);
		String viewPage = null;
		try {
		viewPage = handler.process(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// [포워딩] 리다이렉트
		if (viewPage != null ) { // viewpage 존재
			RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
			dispatcher.forward(request, response);
		}//if
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	
	}

	@Override
	public void destroy() {
//		System.out.println("> DispatcherServlet.destroy() 호출 ");

	}


	
}
