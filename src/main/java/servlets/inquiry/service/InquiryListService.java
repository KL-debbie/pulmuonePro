package servlets.inquiry.service;

import java.sql.Connection;
import java.util.ArrayList;

import jdbc.connection.ConnectionProvider;
import servlets.inquiry.dao.InquiryDAO;
import servlets.inquiry.dao.InquiryDAOImpl;
import servlets.inquiry.model.InquiryDTO;

public class InquiryListService {
	private InquiryDAO dao = new InquiryDAOImpl();
	
	public ArrayList<InquiryDTO> select(String user_id, String cate) {
		ArrayList<InquiryDTO> list = null;
		try (Connection conn = ConnectionProvider.getConnection() ) {
			list = dao.select(conn, user_id, cate);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	public int selectCount(String user_id, String cate) {
		
		try (Connection conn = ConnectionProvider.getConnection() ) {
			return dao.selectCount(conn, user_id, cate);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return 0;
	}
}
