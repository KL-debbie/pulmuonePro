package servlets.curation.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.naming.NamingException;

import jdbc.JdbcUtil;
import jdbc.connection.ConnectionProvider;
import servlets.curation.domain.KidsDTO;
import servlets.curation.persistence.CurationDAO;
import servlets.curation.persistence.DAOImpl;

public class KidService {
	
	 // 1. 싱글톤
	   private KidService() {}      
	   private static KidService instance = null;  
	   public static KidService getInstance() {   
	      if(   instance == null  ) {
	         instance = new KidService();
	      }
	      return instance;
	   }

	   public List<KidsDTO> selectList(){
	      //
	      Connection con = null;
	      try {
	         con = ConnectionProvider.getConnection();
	          DAOImpl dao = DAOImpl.getInstance();
	         List<KidsDTO> list = null;
	         list = dao.selectList(con);
	         return list;
	      } catch (NamingException | SQLException e) { 
	         //e.printStackTrace();  syso("ListService.select() 에러 : ")
	         throw new RuntimeException(e);
	      } finally {
	         JdbcUtil.close(con);
	      }
	      
	   }// List select
	   
	   public List<KidsDTO> select(int num){
		   Connection con = null;
		      try {
		         con = ConnectionProvider.getConnection();
		          DAOImpl dao = DAOImpl.getInstance();
		          
		         List<KidsDTO> dto = null;
		        
		         dto = dao.select(con,  num);
		        		 return dto;
		         
		      } catch (NamingException | SQLException e) { 
		         //e.printStackTrace();  syso("ListService.select() 에러 : ")
		         throw new RuntimeException(e);
		      } finally {
		         JdbcUtil.close(con);
		      }
	   }

}//class