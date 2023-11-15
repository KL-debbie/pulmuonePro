package servlets.notice.service;

import java.sql.Connection;

import jdbc.connection.ConnectionProvider;
import servlets.notice.dao.NoticeDAO;
import servlets.notice.dao.NoticeDAOImpl;
import servlets.notice.model.NoticeDTO;

public class NoticeViewService {
	private NoticeDAO noticeDAO = new NoticeDAOImpl();
	
	public NoticeDTO getDetailView (int seq) {
		NoticeDTO vo = null;
		try (Connection conn = ConnectionProvider.getConnection() ) {
			vo = noticeDAO.view(conn, seq);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return vo;
	}
}
