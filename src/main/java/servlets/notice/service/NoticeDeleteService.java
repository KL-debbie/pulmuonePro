package servlets.notice.service;

import java.sql.Connection;
import java.sql.SQLException;

import jdbc.connection.ConnectionProvider;
import servlets.notice.dao.NoticeDAO;
import servlets.notice.dao.NoticeDAOImpl;

public class NoticeDeleteService {
	private NoticeDAO noticeDAO = new NoticeDAOImpl();
	
	public int delete(int seq) {
		int deleteRow = 0;
		
		try (Connection conn = ConnectionProvider.getConnection() ) {
			deleteRow = noticeDAO.delete(conn, seq);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return deleteRow;
	}
}
