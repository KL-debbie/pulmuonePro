package curation.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.naming.NamingException;

import curation.domain.KidsResultDTO;
import curation.persistence.KidsResultDAO;
import jdbc.JdbcUtil;
import jdbc.connection.ConnectionProvider;

public class ListService {
	

	   // 1. 싱글톤
	   private ListService() {}      
	   private static ListService instance = null;  
	   public static ListService getInstance() {   
	      if(   instance == null  ) {
	         instance = new ListService();
	      }
	      return instance;
	   }


}//class
