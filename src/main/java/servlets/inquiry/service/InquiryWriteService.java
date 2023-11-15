package servlets.inquiry.service;

import java.sql.Connection;

import jdbc.connection.ConnectionProvider;
import servlets.inquiry.dao.InquiryDAO;
import servlets.inquiry.dao.InquiryDAOImpl;
import servlets.inquiry.model.InquiryDTO;

public class InquiryWriteService {
	private InquiryDAO dao = new InquiryDAOImpl();
	
	public int write(InquiryDTO dto) {
		int insertRow = 0;
		try (Connection conn = ConnectionProvider.getConnection() ) {
			insertRow = dao.write(conn, dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return insertRow;
	}
}
