package servlets.notice.service;

import java.sql.Connection;
import java.util.ArrayList;

import jdbc.connection.ConnectionProvider;
import servlets.notice.dao.NoticeDAO;
import servlets.notice.dao.NoticeDAOImpl;
import servlets.notice.model.NoticeDTO;

public class NoticeListService {
	private NoticeDAO noticeDAO = new NoticeDAOImpl();
	
	public ArrayList<NoticeDTO> getNoticeList(int pageNo, int numberPerPage) {
		
		ArrayList<NoticeDTO> list = null;
		
		try (Connection conn = ConnectionProvider.getConnection() ){
			list = noticeDAO.select(conn, pageNo, numberPerPage);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	public int getTotalRows() {
		int totalRows = 0;
		try (Connection conn = ConnectionProvider.getConnection() ){
			totalRows = noticeDAO.selectCount(conn);
		} catch( Exception e) {
			e.printStackTrace();
		}
		return totalRows;
	}
	
	public int getTotalPages(int numberPerPage) {
		int totalPages = 0;
		try (Connection conn = ConnectionProvider.getConnection() ){
			totalPages = noticeDAO.getTotalPages(conn, numberPerPage);
		} catch( Exception e) {
			e.printStackTrace();
		}
		return totalPages;
	}
}
