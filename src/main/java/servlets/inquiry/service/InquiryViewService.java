package servlets.inquiry.service;

import java.sql.Connection;

import jdbc.connection.ConnectionProvider;
import servlets.inquiry.dao.InquiryDAO;
import servlets.inquiry.dao.InquiryDAOImpl;
import servlets.inquiry.model.InquiryDTO;

public class InquiryViewService {
	private InquiryDAO dao = new InquiryDAOImpl();
	
	public InquiryDTO selectView(String user_id, String cate, int seq) {
		InquiryDTO vo = null;
		try (Connection conn = ConnectionProvider.getConnection() ) {
			vo = dao.view(conn, user_id, cate, seq);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return vo;
	}
}
