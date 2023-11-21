package servlets.order.service;

import java.sql.Connection;
import java.util.ArrayList;

import jdbc.JdbcUtil;
import jdbc.connection.ConnectionProvider;
import servlets.order.domain.DrkOrderProductDTO;
import servlets.order.persistence.DrkOrderImpl;

public class DrkOrderService {

	// 싱글톤
	private DrkOrderService() {}
	private static DrkOrderService instanse = null;
	public static DrkOrderService getInstanse() {
		if (instanse == null) {
			instanse = new DrkOrderService();
		} // if
		return instanse;
	} // getInstanse()
	
	
	private Connection conn = null;
	
	public ArrayList<DrkOrderProductDTO> selectProducts(ArrayList<String> productsNo) {
		try {
			conn = ConnectionProvider.getConnection();
			DrkOrderImpl dao = DrkOrderImpl.getInstance();
			ArrayList<DrkOrderProductDTO> list = null;
			list = dao.selectProducts(conn, productsNo);
			return list;
		} catch (Exception e) {
			System.out.println("DrkOrderService.selectProducts() 에러");
			e.printStackTrace();
			throw new RuntimeException(e);
		} finally {
			JdbcUtil.close(conn);
		} // try
	} // selectProducts()
	
}