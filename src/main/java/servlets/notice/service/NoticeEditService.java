package servlets.notice.service;

import java.sql.Connection;

import jdbc.connection.ConnectionProvider;
import servlets.notice.dao.NoticeDAO;
import servlets.notice.dao.NoticeDAOImpl;
import servlets.notice.model.NoticeDTO;

public class NoticeEditService {
	private NoticeDAO noticeDAO = new NoticeDAOImpl();
	
	public int edit (NoticeDTO dto) {
		try (Connection conn = ConnectionProvider.getConnection() ) {
			return noticeDAO.edit(conn, dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return 0;
	}
	
}
