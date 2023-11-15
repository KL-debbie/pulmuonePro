package servlets.notice.service;

import java.sql.Connection;

import jdbc.connection.ConnectionProvider;
import servlets.notice.dao.NoticeDAO;
import servlets.notice.dao.NoticeDAOImpl;
import servlets.notice.model.NoticeDTO;

public class NoticeWriteService {
	
	private NoticeDAO noticeDAO = new NoticeDAOImpl();
	
	public int write (NoticeDTO vo) {
		int insertRow = 0;
		
		try (Connection conn = ConnectionProvider.getConnection() ) {
			insertRow = noticeDAO.write(conn, vo);
		} catch (Exception e ) {
			e.printStackTrace();
		}
		
		return insertRow; 
	}
}
