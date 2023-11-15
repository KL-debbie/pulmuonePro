package servlets.notice.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

import jdbc.JdbcUtil;
import servlets.notice.model.NoticeDTO;

public class NoticeDAOImpl implements NoticeDAO {

	@Override
	public ArrayList<NoticeDTO> select(Connection conn, int pageNo, int numberPerPage) throws SQLException {
		int begin = (pageNo-1) * numberPerPage + 1;
		int end = begin + numberPerPage - 1;

		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = " SELECT * "
				+ " FROM ( "
				+ "    SELECT ROWNUM no, n.* "
				+ "    FROM ( "
				+ "        SELECT notice_no, title, content, regdate "
				+ "        FROM notice "
				+ "        ORDER BY regdate DESC "
				+ "    ) n "
				+ ") b "
				+ "WHERE b.no BETWEEN ? AND ? ";

		ArrayList<NoticeDTO> list = null;
		NoticeDTO vo = null;

		int notice_no; 
		String title;
		String content;
		Date regdate;


		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, begin);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery();
			
			if(rs.next() ) {
				list = new ArrayList<>();
				
				do {
					notice_no = rs.getInt("notice_no");
					title = rs.getString("title");
					content = rs.getString("content");
					regdate = rs.getDate("regdate");
					vo = new NoticeDTO(notice_no, title, content, regdate);
					
					list.add(vo);
				} while (rs.next());
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(conn);
			JdbcUtil.close(pstmt);
		}
		

		return list;
	}

	@Override
	public int selectCount(Connection conn) throws SQLException {
		int totalRows = 0;
		String sql = " SELECT COUNT(*) "
				+ " FROM notice ";
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if( rs.next()) totalRows = rs.getInt(1);
			
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
		
		return totalRows;
	}

	@Override
	public int getTotalPages(Connection conn, int numberPerPage) throws SQLException {
		int totalPages = 0;
		String sql = " SELECT CEIL(COUNT(*)/ ?) "
				+ " FROM notice ";
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, numberPerPage);
			rs = pstmt.executeQuery();
			if( rs.next() ) {
				totalPages = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
		
		return totalPages;
	}

	@Override
	public NoticeDTO view(Connection conn, int seq) throws SQLException {
		String sql = " SELECT notice_no, title, content, regdate "
				+ " FROM notice "
				+ " WHERE notice_no = ? ";
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		NoticeDTO vo = null;
		
		int notice_no; 
		String title;  
		String content;
		Date regdate;  
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, seq);
			rs = pstmt.executeQuery();
			if( rs.next() ) {
				notice_no = rs.getInt("notice_no");
				title = rs.getString("title");
				content = rs.getString("content");
				regdate = rs.getDate("regdate");
				vo = new NoticeDTO(notice_no, title, content, regdate);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
		
		
		return vo;
	}

	@Override
	public int write(Connection conn, NoticeDTO dto) throws SQLException {
		int insertRow = 0;
		String sql = " INSERT INTO notice (notice_no, title, content) "
				+ "	VALUES ( "
				+ "    seq_notice.NEXTVAL, ?, ? "
				+ ") ";
		
		PreparedStatement pstmt = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			insertRow = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(pstmt);
		}
		
		return insertRow;
	}

	@Override
	public int delete(Connection conn, int seq) throws SQLException {
		int deleteRow = 0;
		String sql = " DELETE FROM notice "
				+ " WHERE notice_no = ? ";
		
		PreparedStatement pstmt = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, seq);
			deleteRow = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(conn);
			JdbcUtil.close(pstmt);
		}
		
		return deleteRow;
	}

	@Override
	public int edit(Connection conn, NoticeDTO dto) throws SQLException {
		String sql = " UPDATE notice "
				+ " SET title = ?, content = ? "
				+ " WHERE notice_no = ? ";
		
		PreparedStatement pstmt = null;
		int editCount = 0;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setInt(3, dto.getNotice_no());
			
			editCount = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(conn);
			JdbcUtil.close(pstmt);
		}
		
		return editCount;
	}

}
