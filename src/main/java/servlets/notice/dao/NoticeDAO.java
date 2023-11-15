package servlets.notice.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

import servlets.notice.model.NoticeDTO;

public interface NoticeDAO {
	// 조회
	ArrayList<NoticeDTO> select(Connection conn, int pageNo, int numberPerPage) throws SQLException;
	
	// 총 개수 
	int selectCount(Connection conn) throws SQLException;
	
	// 총 페이지 
	int getTotalPages(Connection conn, int numberPerPage) throws SQLException;
	
	// 상세페이지 
	NoticeDTO view(Connection conn, int seq) throws SQLException;
	
	// 글쓰기 
	int write(Connection conn, NoticeDTO dto) throws SQLException;

	// 글 수정 
	int edit (Connection conn, NoticeDTO dto) throws SQLException;
	
	// 삭제 
	int delete(Connection conn, int seq) throws SQLException;
}
