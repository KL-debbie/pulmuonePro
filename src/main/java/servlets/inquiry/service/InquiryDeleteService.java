package servlets.inquiry.service;

import java.sql.Connection;

import jdbc.connection.ConnectionProvider;
import servlets.inquiry.dao.InquiryDAO;
import servlets.inquiry.dao.InquiryDAOImpl;

public class InquiryDeleteService {
	
	private InquiryDAO inquiryDAO = new InquiryDAOImpl();
	
	public int delete(String user_id, String category, int seq) {
		try (Connection conn = ConnectionProvider.getConnection() ) {
			return inquiryDAO.delete(conn, user_id, category, seq);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return 0;
	}
}
