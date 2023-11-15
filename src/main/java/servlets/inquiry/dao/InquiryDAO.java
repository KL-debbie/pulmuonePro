package servlets.inquiry.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

import servlets.inquiry.model.InquiryDTO;

public interface InquiryDAO {
	// 문의 작성
	int write (Connection conn, InquiryDTO dto) throws SQLException;
	
	// 문의 목록
	ArrayList<InquiryDTO> select (Connection conn, String user_id, String category) throws SQLException;
	
	// 문의 갯수 
	int selectCount (Connection conn, String user_id, String category) throws SQLException;
	
	// 문의 상세보기
	InquiryDTO view (Connection conn, String user_id, String category, int seq) throws SQLException;
	
	// 문의 삭제
	int delete (Connection conn, String user_id, String category, int seq) throws SQLException;
}
