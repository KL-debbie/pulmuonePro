package servlets.order.persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;

import jdbc.JdbcUtil;
import servlets.order.domain.BoxOrderInfoDTO;
import servlets.order.domain.BoxOrderProductDTO;
import servlets.order.domain.BoxPayDTO;
import servlets.order.domain.BoxShipDTO;
import servlets.order.domain.OrderAddrBookDTO;
import servlets.order.domain.OrderCouponDTO;
import servlets.order.domain.OrderMemberInfoDTO;

public class BoxOrderImpl implements BoxOrderDAO {
	
	// 싱글톤
	private BoxOrderImpl() {}
	private static BoxOrderImpl instance = new BoxOrderImpl();
	public static BoxOrderImpl getInstance() {
		return instance;
	}
	
	@Override
	public ArrayList<BoxOrderProductDTO> selectProducts(Connection conn, String [] productsNo) throws SQLException {
		String sql = " SELECT DISTINCT p.products_no, category_no, products_name, products_type, products_size, price, NVL(event_price, price) event_price, img_path, system_name "
				+ " FROM products p LEFT JOIN products_img i ON p.products_no = i.products_no "
				+ " WHERE p.products_no IN( ";
				for(int i = 0; i < productsNo.length; i++) {
					sql += productsNo[i]+", ";
				} // for
				sql += " -1 )  AND origin_name != 'View.png'";
				
		BoxOrderProductDTO dto = null;
		ArrayList<BoxOrderProductDTO> list = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			System.out.println("try");
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				System.out.println("if");
				list = new ArrayList<>();
				do {
					dto = new BoxOrderProductDTO();
					dto.setProductsNo(rs.getString("products_no"));
					dto.setCategoryNo(rs.getInt("category_no"));
					dto.setProductsName(rs.getString("products_name"));
					dto.setProductsType(rs.getString("products_type"));
					dto.setProductsSize(rs.getString("products_size"));
					dto.setPrice(rs.getInt("price"));
					dto.setEventPrice(rs.getInt("event_price"));
					dto.setImgPath(rs.getString("img_path"));
					dto.setOriginName(rs.getString("system_name"));
					list.add(dto);
				} while (rs.next());
			} // if
		} catch (Exception e) {
			System.out.println("BoxOrderDAO selectProducts() error...");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(pstmt);
			JdbcUtil.close(rs);
		} // try
		return list;
	} // selectProducts

	@Override
	public int getProductsPrice(Connection conn, String[] productsNo) {
		String sql = " SELECT SUM(price) price"
				+ " FROM products "
				+ " WHERE products_no IN ( ";
		for (int i = 0; i < productsNo.length; i++) {
			sql += productsNo[i] + " , ";
		}
		sql += " -1) ";
		
		int price = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				do {
					price += rs.getInt("price");
				} while (rs.next());
			} // if
		} catch (Exception e) {
			System.out.println("BoxOrderDAO getProductsPrice() error...");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(pstmt);
			JdbcUtil.close(rs);
		} // try
		
		return price;
	}

	@Override
	public ArrayList<OrderCouponDTO> selectCoupon(Connection conn, int memberNo, int priductsPrice) throws SQLException {
		String sql = " SELECT h.coupon_no, coupon_name, discount, duplication, max_discount "
				+ " FROM have_coupon h JOIN coupon c ON h.coupon_no = c.coupon_no "
				+ " WHERE member_no = " + memberNo + " AND delivery_type = 1 AND used = 0 AND NVL(c.discount, discount) <= " + priductsPrice;
		
		OrderCouponDTO dto = null;
		ArrayList<OrderCouponDTO> list = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				list = new ArrayList<>();
				do {
					dto = new OrderCouponDTO();
					dto.setCouponNo(rs.getInt("coupon_no"));
					dto.setCouponName(rs.getString("coupon_name"));
					dto.setDiscount(rs.getDouble("discount"));
					dto.setDuplication(rs.getInt("duplication"));
					dto.setMaxDiscount(rs.getInt("max_discount"));
					list.add(dto);
				} while (rs.next());
			} // if
		} catch (Exception e) {
			System.out.println("BoxOrderDAO selectCoupon() error...");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(pstmt);
			JdbcUtil.close(rs);
		} // try
		
		return list;
	} // selectCoupon

	@Override
	public OrderMemberInfoDTO getNameAndTel(Connection conn, int memberNo) throws SQLException {
		String sql = " SELECT name, tel "
				+ " FROM member "
				+ " WHERE member_no = " + memberNo;
		
		OrderMemberInfoDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto = new OrderMemberInfoDTO();
				dto.setName(rs.getString("name"));
				dto.setTel(rs.getString("tel"));
			} // if
		} catch (Exception e) {
			System.out.println("BoxOrderDAO getNameAndTel() error...");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(pstmt);
			JdbcUtil.close(rs);
		} // try
		
		return dto;
	} // getNameAndTel
	
	@Override
	public int insertBoxOrder(Connection conn, int memberNo, int boxOrderStatus) throws SQLException {
		int rowCount = 0;
		int orderNo = 0;
		
		String sql = " { CALL procedure_insertBoxOrder(?, ?, ?) } ";
		
		CallableStatement cstmt = null;
		
		try {
			cstmt = conn.prepareCall(sql);
			cstmt.setInt(1, memberNo);
			cstmt.setInt(2, boxOrderStatus);
			cstmt.registerOutParameter(3, Types.INTEGER);
			rowCount = cstmt.executeUpdate();
			if (rowCount == 1) {
				orderNo = cstmt.getInt(3);
			} // if
		} catch (Exception e) {
			System.out.println("BoxOrderDAO insertBoxOrder() error...");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(cstmt);
		} // try
		
		return orderNo;
	} // insertBoxOrder

	@Override
	public int insertBoxOrderedProducts(Connection conn, int boxOrderNo, String productsNo, int productsCnt) throws SQLException {
		int rowCount = 0;
		
		String sql = " INSERT INTO box_order_products (box_order_no, products_no, products_cnt) "
				+ " VALUES (?, ?, ?) ";
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boxOrderNo);
			pstmt.setString(2, productsNo);
			pstmt.setInt(3, productsCnt);
			rowCount = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("BoxOrderDAO insertBoxOrderedProducts() error...");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(pstmt);
			JdbcUtil.close(rs);
		} // try
		
		return rowCount;
	} // insertBoxOrderedProducts

	@Override
	public int insertBoxShip(Connection conn, BoxShipDTO dto) throws SQLException {
		int rowCount = 0;
		
		String sql = " INSERT INTO box_ship (box_order_no, box_receiver, box_tel, box_zip_code, box_addr, box_addr_detail, box_memo) "
				+ " VALUES (?, ?, ?, ?, ?, ?, ?) ";
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getBoxOrderNo());
			pstmt.setString(2, dto.getBoxReceiver());
			pstmt.setString(3, dto.getBoxTel());
			pstmt.setString(4, dto.getBoxZipCode());
			pstmt.setString(5, dto.getBoxAddr());
			pstmt.setString(6, dto.getBoxAddrDetail());
			pstmt.setString(7, dto.getBoxMemo());
			rowCount = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("BoxOrderDAO insertBoxShip() error...");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(pstmt);
			JdbcUtil.close(rs);
		} // try
		
		return rowCount;
	} // insertBoxShip

	@Override
	public int insertAddrBook(Connection conn, OrderAddrBookDTO dto) throws SQLException {
		int rowCount = 0;
		
		String sql = " INSERT INTO addr_book (addr_no, member_no, addr_name, name, tel, zip_code, addr, addr_detail, memo) "
				+ " VALUES (SEQ_ADDR_BOOK.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?) ";
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getMemberNo());
			pstmt.setString(2, dto.getName());
			pstmt.setString(3, dto.getName());
			pstmt.setString(4, dto.getTel());
			pstmt.setString(5, dto.getZipCode());
			pstmt.setString(6, dto.getAddr());
			pstmt.setString(7, dto.getAddrDetail());
			pstmt.setString(8, dto.getMemo());
			rowCount = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("BoxOrderDAO insertAddrBook() error...");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(pstmt);
			JdbcUtil.close(rs);
		} // try
		
		return rowCount;
	} // insertAddrBook

	@Override
	public int insertPay(Connection conn, BoxPayDTO dto) throws SQLException {
		int rowCount = 0;
		int boxPayNo = 0;
		
		String sql = " { CALL procedure_insertBoxPay(?, ?, ?, ?, ?, ?, ?, ?) } ";

		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		try {
			cstmt = conn.prepareCall(sql);
			cstmt.setInt(1, dto.getBoxOrderNo());
			cstmt.setInt(2, dto.getBoxPrice());
			cstmt.setInt(3, dto.getBoxSalePrice());
			cstmt.setInt(4, dto.getBoxDiscountPrice());
			cstmt.setInt(5, dto.getBoxShippingFee());
			cstmt.setInt(6, dto.getBoxFinalPrice());
			cstmt.setInt(7, dto.getBoxPayMethod());
			cstmt.registerOutParameter(8, Types.INTEGER);
			rowCount = cstmt.executeUpdate();
			if (rowCount == 1) {
				boxPayNo = cstmt.getInt(8);
			} // if
		} catch (Exception e) {
			System.out.println("BoxOrderDAO insertPay() error...");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(cstmt);
			JdbcUtil.close(rs);
		} // try
		
		return boxPayNo;
	} // insertPay()

	@Override
	public int updateHaveCoupon(Connection conn, int boxPayNo, int memberNo, int couponNo) throws SQLException {
		int rowCount = 0;
		
		String sql = " UPDATE have_coupon "
				+ " SET "
				+ "	used = 1 "
				+ " , box_pay_no = ? "
				+ " WHERE member_no = ? AND coupon_no = ? ";
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boxPayNo);
			pstmt.setInt(2, memberNo);
			pstmt.setInt(3, couponNo);
			rowCount = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("BoxOrderDAO updateHaveCoupon() error...");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(pstmt);
			JdbcUtil.close(rs);
		} // try
		
		return rowCount;
	} // updateHaveCoupon



	@Override
	public ArrayList<BoxOrderProductDTO> selectOrderProductList(Connection conn, int boxOrderNo) throws SQLException {
		String sql = " SELECT DISTINCT products_name, img_path, system_name "
				+ " FROM products p JOIN box_order_products b ON p.products_no = b.products_no "
				+ " JOIN products_img i ON p.products_no = i.products_no "
				+ " WHERE box_order_no = "+boxOrderNo+" AND origin_name != 'View.png'";
				
		BoxOrderProductDTO dto = null;
		ArrayList<BoxOrderProductDTO> list = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				list = new ArrayList<>();
				do {
					dto = new BoxOrderProductDTO();
					dto.setProductsName(rs.getString("products_name"));
					dto.setImgPath(rs.getString("img_path"));
					dto.setOriginName(rs.getString("system_name"));
					list.add(dto);
				} while (rs.next());
			} // if
		} catch (Exception e) {
			System.out.println("BoxOrderDAO selectOrderProductList() error...");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(pstmt);
			JdbcUtil.close(rs);
		} // try
		return list;
	} // selectOrderProductList

	@Override
	public BoxOrderInfoDTO selectBoxOrderInfo(Connection conn, int boxOrderNo) throws SQLException {
		String sql = " SELECT box_zip_code, box_addr, box_addr_detail, box_memo, box_price, box_sale_price, box_discount_price, box_shipping_fee, box_final_price, box_pay_method "
				+ " FROM box_ship s JOIN box_pay p ON s.box_order_no = p.box_order_no "
				+ " WHERE s.box_order_no = "+boxOrderNo;
				
		BoxOrderInfoDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto = new BoxOrderInfoDTO();
				dto.setZipCode(rs.getString("box_zip_code"));
				dto.setAddr(rs.getString("box_addr"));
				dto.setAddrDetail(rs.getString("box_addr_detail"));
				dto.setMemo(rs.getString("box_memo"));
				dto.setPrice(rs.getInt("box_price"));
				dto.setSalePrice(rs.getInt("box_sale_price"));
				dto.setDiscountPrice(rs.getInt("box_discount_price"));
				dto.setShippingFee(rs.getInt("box_shipping_fee"));
				dto.setFinalPrice(rs.getInt("box_final_price"));
				dto.setPayMethod(rs.getInt("box_pay_method"));
			} // if
		} catch (Exception e) {
			System.out.println("BoxOrderDAO selectOrderProductList() error...");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(pstmt);
			JdbcUtil.close(rs);
		} // try
		return dto;
	} // selectShipOne

}