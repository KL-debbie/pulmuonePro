package servlets.inquiry.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

import jdbc.JdbcUtil;
import servlets.inquiry.model.InquiryDTO;

public class InquiryDAOImpl implements InquiryDAO{

	@Override
	public int write(Connection conn, InquiryDTO dto) throws SQLException {
		String sql = " INSERT INTO inquiry  "
				+ " ( inquiry_no, member_id, inquiry_cate, email, title, content) "
				+ " VALUES ( "
				+ "    seq_inquiry.NEXTVAL, ?, ?, ?, ?, ?"
				+ " ) ";
		
		PreparedStatement pstmt = null;
		int insertRow = 0;
		System.out.println(sql);
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getMember_id());
			pstmt.setString(2, dto.getInquiry_cate());
			pstmt.setString(3, dto.getEmail());
			pstmt.setString(4, dto.getTitle());
			pstmt.setString(5, dto.getContent());
			
			insertRow = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(conn);
			JdbcUtil.close(pstmt);
		}
		
		return insertRow;
	}

	@Override
	public ArrayList<InquiryDTO> select(Connection conn, String user_id, String category) throws SQLException {
		String sql = " SELECT * "
				+ " FROM inquiry "
				+ " WHERE member_id = ? ";
				if( category != "all" ) {
					sql += "AND inquiry_cate = ? ";
				}
		System.out.println(category);
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		ArrayList<InquiryDTO> list = null;
		InquiryDTO vo = null;
		
		int inquiry_no;     
		String member_id;   
		String inquiry_cate;
		String email;       
		String title;       
		String content;     
		Date regdate;       
		String status;
		
		System.out.println(sql);
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			if( category != "all" ) {
				pstmt.setString(2, category);
			}
			rs = pstmt.executeQuery();
			
			if( rs.next() ) {
				list = new ArrayList<>();
				
				do {
					inquiry_no = rs.getInt("inquiry_no");
					member_id = rs.getString("member_id");
					inquiry_cate = rs.getString("inquiry_cate");
					email = rs.getString("email");
					title = rs.getString("title");
					content = rs.getString("content");
					regdate = rs.getDate("regdate");
					status = rs.getString("status");
					
					vo = new InquiryDTO(inquiry_no, member_id, inquiry_cate, email, title, content, regdate, status);
					System.out.println(vo);
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
	public int selectCount(Connection conn, String user_id, String category) throws SQLException {
		String sql = " SELECT COUNT(*) "
				+ " FROM inquiry "
				+ " WHERE member_id = ? ";
		
		if( category != "all" ) {
			sql += "AND inquiry_cate = ? ";
		}
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			if( category != "all" ) {
				pstmt.setString(2, category);
			}
			rs = pstmt.executeQuery();
			
			if( rs.next() ) return rs.getInt(1);
			
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(conn);
			JdbcUtil.close(pstmt);
		}
		
		return 0;
	}

	@Override
	public InquiryDTO view(Connection conn, String user_id, String category, int seq) throws SQLException {
		String sql = " SELECT * "
				+ " FROM inquiry "
				+ " WHERE member_id = ? "
				+ " AND inquiry_cate = ? "
				+ " AND inquiry_no = ? ";
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		InquiryDTO vo = null;
		
		int inquiry_no;     
		String member_id;   
		String inquiry_cate;
		String email;       
		String title;       
		String content;     
		Date regdate;       
		String status;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			pstmt.setString(2, category);
			pstmt.setInt(3, seq);
			rs = pstmt.executeQuery();
			
			if( rs.next() ) {
				inquiry_no = rs.getInt("inquiry_no");
				member_id = rs.getString("member_id");
				inquiry_cate = rs.getString("inquiry_cate");
				email = rs.getString("email");
				title = rs.getString("title");
				content = rs.getString("content");
				regdate = rs.getDate("regdate");
				status = rs.getString("status");
				
				vo = new InquiryDTO(inquiry_no, member_id, inquiry_cate, email, title, content, regdate, status);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(conn);
			JdbcUtil.close(pstmt);
		}
		return vo;
	}

	@Override
	public int delete(Connection conn, String user_id, String category, int seq) throws SQLException {
		String sql = " DELETE FROM inquiry "
				+ " WHERE member_id = ? "
				+ " AND inquiry_cate = ? "
				+ " AND inquiry_no = ? ";
		
		PreparedStatement pstmt = null;
		int deleteRow = 0;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			pstmt.setString(2, category);
			pstmt.setInt(3, seq);
			
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

}
