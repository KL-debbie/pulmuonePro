package servlets.order.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;

import jdbc.JdbcUtil;
import servlets.order.domain.DrkOrderProductDTO;

public class DrkOrderImpl implements DrkOrderDAO {
	
	// 싱글톤
	private DrkOrderImpl() {}
	private static DrkOrderImpl instance = new DrkOrderImpl();
	public static DrkOrderImpl getInstance() {
		return instance;
	}
	
	// 1. 상품 정보 조회
	@Override
	public ArrayList<DrkOrderProductDTO> selectProducts(Connection conn, ArrayList<String> productsNo) throws SQLException {
		Iterator<String> ir = productsNo.iterator();
		
		String sql = " SELECT DISTINCT p.products_no, products_name, price, products_size, img_path, system_name "
				+ " FROM products p LEFT JOIN products_img i ON p.products_no = i.products_no "
				+ " WHERE p.products_no IN( ";
				while (ir.hasNext()) {
					String prd = (String) ir.next();
					sql += prd+",";
				} // while
				sql += " -1 )  AND origin_name != 'View.png'";
				
		DrkOrderProductDTO dto = null;
		ArrayList<DrkOrderProductDTO> list = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				list = new ArrayList<>();
				do {
					dto = new DrkOrderProductDTO();
					dto.setProductsNo(rs.getString("products_no"));
					dto.setProductsName(rs.getString("products_name"));
					dto.setPrice(rs.getInt("price"));
					dto.setProductsSize(rs.getString("products_size"));
					dto.setImgPath(rs.getString("img_path"));
					dto.setSystemName(rs.getString("system_name"));
					list.add(dto);
				} while (rs.next());
			} // if
		} catch (Exception e) {
			System.out.println("DrkOrderDAO selectProducts() error...");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(pstmt);
			JdbcUtil.close(rs);
		} // try
		return list;
	} // selectProducts
	
	

}