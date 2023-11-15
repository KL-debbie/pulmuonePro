package servlets.faq.service;

import java.sql.Connection;
import java.util.ArrayList;

import jdbc.connection.ConnectionProvider;
import servlets.faq.dao.FaqDAO;
import servlets.faq.dao.FaqDAOImpl;
import servlets.faq.model.FaqDTO;

public class FaqListService {
	private FaqDAO faqDAO = new FaqDAOImpl();
	
	public ArrayList<FaqDTO> getFaqList(int pageNo, int category, int numberPerPage, String searchKeyword) {
		
		ArrayList<FaqDTO> list = null;
		
		try (Connection conn = ConnectionProvider.getConnection() ) {
			if( searchKeyword.equals("") ) {
				list = faqDAO.select(conn, category, pageNo, numberPerPage);
			}else {
				list = faqDAO.search(conn, pageNo, numberPerPage, searchKeyword);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public int getFaqTotalPage (int numberPerPage, int category, String searchKeyword ) {
		int totalPage = 0;
		try (Connection conn = ConnectionProvider.getConnection() ) {
			totalPage = faqDAO.getTotalPages(conn, numberPerPage, category, searchKeyword);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return totalPage;
	}
	
	public int getFaqTotal (int category, String searchKeyword) {
		int total = 0;
		try (Connection conn = ConnectionProvider.getConnection() ) {
			total = faqDAO.selectCount(conn, category, searchKeyword);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return total;
	}
}
