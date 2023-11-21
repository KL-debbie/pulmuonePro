package servlets.event.persistence;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import servlets.event.domain.EventCommentDTO;

public interface IEventCommnet {

	// 1. 글 목록
	List<EventCommentDTO> selectList(Connection con, int event_no, int currentPage, int numberPerPage) throws SQLException;

	// 2. 글 추가
	int insert( Connection con, EventCommentDTO dto) throws SQLException;

	// 3. 삭제
	int delete(Connection con, int num) throws SQLException;

	// 4. 수정
	int update(Connection con, int comment_no, String content) throws SQLException;

	
	int selectCount(Connection con, int event_no) throws SQLException;

	// 중복확인
	boolean duplicateParticipation(Connection conn, int member_no, int event_no) throws SQLException;


}
