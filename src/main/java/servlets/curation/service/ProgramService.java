package servlets.curation.service;

import java.nio.file.Path;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.naming.NamingException;

import jdbc.JdbcUtil;
import jdbc.connection.ConnectionProvider;
import servlets.curation.domain.CurationDTO;
import servlets.curation.domain.KidsDTO;
import servlets.curation.persistence.CurationDAO;
import servlets.curation.persistence.DAOImpl;

public class ProgramService {
	
	 // 1. 싱글톤
	   private ProgramService() {}      
	   private static ProgramService instance = null;  
	   public static ProgramService getInstance() {   
	      if(   instance == null  ) {
	         instance = new ProgramService();
	      }
	      return instance;
	   }

	   public List<CurationDTO> selectPG( String path, int num){
	      //
	      Connection con = null;
	      try {
	         con = ConnectionProvider.getConnection();
	          DAOImpl dao = DAOImpl.getInstance();
	         List<CurationDTO> list = null;
	         
	         list = dao.selectPG(con, path, num);
	         return list;
	      } catch (NamingException | SQLException e) { 
	         //e.printStackTrace();  syso("ListService.select() 에러 : ")
	         throw new RuntimeException(e);
	      } finally {
	         JdbcUtil.close(con);
	      }
	      
	   }// List select
	   

}//class