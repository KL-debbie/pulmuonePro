package servlets.curation.persistence;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import servlets.curation.domain.CurationDTO;
import servlets.curation.domain.KidsDTO;

public interface CurationDAO {

	//1. 큐레이션 시작
//	ArrayList<CurationDTO> start() throws SQLException;	

  // 2. step1 시작
//   String step1Show(Connection con) throws SQLException;

   // 3. step2 시작
//  List<CurationDTO> step2List(Connection con) throws SQLException;

   // 4. step3 시작
//  List<CurationDTO> step3List(Connection con) throws SQLException;

  // 5. step3 결과(프로그램/상품 선택 창)
//   ArrayList<CurationDTO> selectOne(Connection con) throws SQLException;

   // 6. 맞춤 프로그램
//   ArrayList<CurationDTO> selectPG(int proNo, String proName) throws SQLException;
//   List<CurationDTO> selectPG(Connection con, String path) throws SQLException;
   List<CurationDTO> selectPG( Connection con,String path, int num) throws SQLException;
//   CurationDTO selectPG(Connection con) throws SQLException;
   
   //   // 7. 맞춤 상품
//   ArrayList<CurationDTO> selectPD(int proNo, String proName) throws SQLException;
   List<CurationDTO> selectPD(Connection con,String path, int num) throws SQLException;
   
   // 8. 키즈 상품
//   KidsDTO select(Connection con, int num) throws SQLException;
   List<KidsDTO> selectList(Connection con) throws SQLException;
   List<KidsDTO> select(Connection con, int num) throws SQLException;
   

   // 프리뷰 큐레이션
//   List<CurationDTO> search(Connection con) throws SQLException;
   
   // 프리뷰 큐레이션
//   List<KidsDTO> searchKids(Connection con) throws SQLException;
}