package servlets.event.persistence;

import java.sql.*;
import java.util.*;

import servlets.event.domain.EventCommentDTO;

public class EventCommentDAO implements IEventCommnet{

	@Override
	public List<EventCommentDTO> selectList(Connection con, int event_no, int currentPage, int numberPerPage) throws SQLException {
	    int start = (currentPage - 1) * numberPerPage + 1;
	    int end = start + numberPerPage - 1;

	    String sql = "SELECT * FROM (" +
	                 "  SELECT rownum rnum, c.comment_no, c.event_no, c.member_no, c.write_date, c.content, m.name " +
	                 "  FROM (" +
	                 "    SELECT * FROM event_comment WHERE event_no = ? ORDER BY comment_no DESC" +
	                 "  ) c" +
	                 "  INNER JOIN member m ON c.member_no = m.member_no" +
	                 ") WHERE rnum BETWEEN ? AND ?";
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    List<EventCommentDTO> comments = new ArrayList<>();
	    
	    try {
	        stmt = con.prepareStatement(sql);                                                                    
	        stmt.setInt(1, event_no);  // event_no 값을 설정
	        stmt.setInt(2, start);
	        stmt.setInt(3, end);
	        rs = stmt.executeQuery();
	        
	        while (rs.next()) {
	            EventCommentDTO comment = new EventCommentDTO();
	            comment.setComment_no(rs.getInt("comment_no"));
	            comment.setEvent_no(rs.getInt("event_no"));
	            comment.setMember_no(rs.getInt("member_no"));
	            comment.setWrite_date(rs.getDate("write_date"));
	            comment.setContent(rs.getString("content"));
	            // 이름 마스킹 처리
	            String name = rs.getString("name");
	            if (name.length() > 2) {
	                name = name.charAt(0) + "*".repeat(name.length() - 2) + name.charAt(name.length() - 1);
	            } else if (name.length() == 2) {
	                name = name.charAt(0) + "*";
	            }
	            comment.setName(name);
	            comments.add(comment);
	        }
	    } catch (SQLException e) {
	        System.out.println("EventCommentDAO.java selectList() error...");
	        e.printStackTrace();
	    } finally {
	        if (rs != null) {
	            try {
	                rs.close();
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
	        if (stmt != null) {
	            try {
	                stmt.close();
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
	    }
	    
	    return comments;
	}




	@Override
	public int insert(Connection con, EventCommentDTO dto) throws SQLException {
	    String sql = "INSERT INTO event_comment (event_no, member_no, content) VALUES (?, ?, ?)";
	    try (PreparedStatement pstmt = con.prepareStatement(sql)) {
	        pstmt.setInt(1, dto.getEvent_no());
	        pstmt.setInt(2, dto.getMember_no());
	        pstmt.setString(3, dto.getContent());
	        return pstmt.executeUpdate();
	    }
	}


    @Override
    public int delete(Connection con, int comment_no) throws SQLException {
        String sql = "DELETE FROM event_comment WHERE comment_no = ?";
        try (PreparedStatement pstmt = con.prepareStatement(sql)) {
            pstmt.setInt(1, comment_no);
            return pstmt.executeUpdate();
        }
    }

    @Override
    public int update(Connection con, int comment_no, String content) throws SQLException {
        String sql = "UPDATE event_comment SET content = ? WHERE comment_no = ?";
        try (PreparedStatement pstmt = con.prepareStatement(sql)) {
            pstmt.setString(1, content);
            pstmt.setInt(2, comment_no);
            return pstmt.executeUpdate();
        }
    }
    
    @Override
    public int selectCount(Connection con, int event_no) throws SQLException {
        String sql = "SELECT COUNT(*) FROM event_comment WHERE event_no = ?";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            stmt = con.prepareStatement(sql);
            stmt.setInt(1, event_no);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            } else {
                return 0;
            }
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
        }
    }
    
    @Override
    public boolean duplicateParticipation(Connection conn, int member_no, int event_no) throws SQLException {
        String sql = "SELECT COUNT(*) FROM event_comment WHERE member_no = ? AND event_no = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, member_no);
            pstmt.setInt(2, event_no);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }


}
