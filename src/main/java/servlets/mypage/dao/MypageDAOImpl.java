package servlets.mypage.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import jdbc.JdbcUtil;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import servlets.mypage.dto.BoxOrderListDTO;
import servlets.mypage.dto.BoxOrderSimpleInfoDTO;
import servlets.order.domain.BoxOrderProductDTO;
import servlets.order.domain.BoxPayDTO;
import servlets.order.domain.BoxShipDTO;
import servlets.order.domain.OrderCouponDTO;


@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor

public class MypageDAOImpl implements MypageDAO {

	private Connection conn = null;
	
	// 1. 매일배송 관련
	
	
	// 2. 택배배송 관련
		// 	1) 총 택배배송 주문 건수 
		@Override
		public int boxOrderCnt(int memberNo) throws SQLException {
			String sql = " SELECT COUNT(*) total_cnt " 
					+ " FROM box_order "
					+ " WHERE member_no = " + memberNo;

			PreparedStatement pstmt = null;
			ResultSet rs = null;

			int boxOrderCnt = 0;

			try {
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					boxOrderCnt = rs.getInt("total_cnt");
				} // if
			} catch (Exception e) {
				System.out.println("MypageDAOImpl.boxOrderCnt() error...");
				e.printStackTrace();
			} finally {
				JdbcUtil.close(pstmt);
				JdbcUtil.close(rs);
			} // try
			return boxOrderCnt;
		} // boxOrderCnt()

		// 	2) 택배배송 주문 내역
		//		a. 결제완료 주문 건수, 배송준비중 주문 건수, 배송중 주문건수, 배송완료 주문건수
		@Override
		public int [] boxOrderStatus(int memberNo) throws SQLException {
			String sql = " SELECT COUNT(*) status_cnt " 
					+ " FROM box_order "
					+ " WHERE member_no = ? AND box_order_status = ? ";

			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			int [] orderCnt = new int [4];
			
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, memberNo);
				for (int i = 0; i < 4; i++) {
					pstmt.setInt(2, i+1);
					rs = pstmt.executeQuery();
					
					if (rs.next()) orderCnt[i] = rs.getInt("status_cnt");
				} // for
				
			} catch (Exception e) {
				System.out.println("MypageDAOImpl.boxOrderStatus() error...");
				e.printStackTrace();
			} finally {
				JdbcUtil.close(pstmt);
				JdbcUtil.close(rs);
			} // try
			return orderCnt;
		} // boxOrderStatus

		// 		b. 최근 2개의 주문 내역 정보(주문번호, 상품명, 결제금액, 주문일자, 주문상태)
		@Override
		public ArrayList<BoxOrderSimpleInfoDTO> currBoxOrderList(int memberNo) throws SQLException {
			String sql = " SELECT box_order_no, products_name, box_order_date, box_order_status, box_final_price " 
					+ " FROM ( "
						+ " WITH pn AS ( "
							+ " SELECT box_order_no, products_name "
							+ " FROM ( "
									+ " SELECT box_order_no, products_no, ROW_NUMBER() OVER(PARTITION BY box_order_no ORDER by products_no) AS prn "
									+ " FROM box_order_products "
								+ " ) op JOIN products p ON op.products_no = p.products_no "
							+ " WHERE prn = 1 "
						+ " ) "
						+ " SELECT o.box_order_no, products_name, box_order_date, box_order_status, box_final_price "
							+ " , ROW_NUMBER() OVER(PARTITION BY member_no ORDER BY o.box_order_no DESC ) AS rn "
						+ " FROM pn JOIN box_order o ON pn.box_order_no = o.box_order_no "
								+ " JOIN box_pay p ON pn.box_order_no = p.box_order_no "
						+ " WHERE member_no = ? "
						+ " ) "
					+ " WHERE rn IN (1, 2) ";

			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			BoxOrderSimpleInfoDTO dto = null;
			ArrayList<BoxOrderSimpleInfoDTO> list = null;

			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, memberNo);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					list = new ArrayList<>();
					do {
						dto = new BoxOrderSimpleInfoDTO();
						dto.setOrderNo(rs.getInt("box_order_no"));
						dto.setProductsName(rs.getString("products_name"));
						dto.setBoxOrderDate(rs.getString("box_order_date"));
						dto.setBoxOrderStatus(rs.getInt("box_order_status"));
						dto.setFinalPrice(rs.getInt("box_final_price"));
						list.add(dto);
					} while (rs.next());
				} // if
			} catch (Exception e) {
				System.out.println("MypageDAOImpl.currBoxOrderList() error...");
				e.printStackTrace();
			} finally {
				JdbcUtil.close(pstmt);
				JdbcUtil.close(rs);
			} // try
			return list;
		} // currBoxOrderList()
		
		// 	3) 택배배송 주문 내역 - 리스트 조회 및 날짜 검색
		@Override
		public ArrayList<BoxOrderListDTO> selectBoxOrderList(int memberNo, Date startSearchDate, Date endSearchDate) throws SQLException {
			String sql = " SELECT box_order_no, box_order_date, box_order_status "
					+ " FROM box_order "
					+ " WHERE member_no = ? AND box_order_date BETWEEN ? AND ? "
					+ " ORDER BY box_order_date DESC ";
			
			String sql2 = " SELECT DISTINCT p.products_no, products_type, products_name, products_size, products_cnt, price, event_price, img_path, system_name, tracking_no,products_tag "
					+ " FROM box_order_products o JOIN products p ON o.products_no = p.products_no "
											+ " JOIN products_img i ON p.products_no = i.products_no "
											+ " JOIN box_ship s ON o.box_order_no = s.box_order_no "
					+ " WHERE o.box_order_no = ? AND origin_name != 'View.png'"
					+ " ORDER BY p.products_no ";
			
			PreparedStatement pstmt1 = null;
			ResultSet rs1 = null;
			PreparedStatement pstmt2 = null;
			ResultSet rs2 = null;
			
			BoxOrderListDTO odto = null;
			BoxOrderProductDTO pdto = null;
			ArrayList<BoxOrderListDTO> list1 = null;
			ArrayList<BoxOrderProductDTO> list2 = null;

			try {
				pstmt1 = conn.prepareStatement(sql);
				pstmt1.setInt(1, memberNo);
				pstmt1.setDate(2, startSearchDate);
				pstmt1.setDate(3, endSearchDate);
				rs1 = pstmt1.executeQuery();
				if (rs1.next()) {
					list1 = new ArrayList<>();
					do {
						odto = new BoxOrderListDTO();
						odto.setBoxOrderNo(rs1.getInt("box_order_no"));
						odto.setBoxOrderDate(rs1.getString("box_order_date"));
						odto.setBoxOrderStatus(rs1.getInt("box_order_status"));
						
						pstmt2 = conn.prepareStatement(sql2);
						pstmt2.setInt(1, rs1.getInt("box_order_no"));
						rs2 = pstmt2.executeQuery();
						
						if (rs2.next()) {
							list2 = new ArrayList<>();
							do {
								pdto = new BoxOrderProductDTO();
								pdto.setProductsNo(rs2.getString("products_no"));
								pdto.setProductsType(rs2.getString("products_type"));
								pdto.setProductsName(rs2.getString("products_name"));
								pdto.setProductsSize(rs2.getString("products_size"));
								pdto.setProductsCnt(rs2.getString("products_cnt"));
								pdto.setPrice(rs2.getInt("price"));
								pdto.setEventPrice(rs2.getInt("event_price"));
								pdto.setImgPath(rs2.getString("img_path"));
								pdto.setOriginName(rs2.getString("system_name"));
								pdto.setTrackingNo(rs2.getString("tracking_no"));
								pdto.setProductsTag(rs2.getString("products_tag"));
								list2.add(pdto);
							} while (rs2.next());
						} // if
						
						JdbcUtil.close(pstmt2);
						JdbcUtil.close(rs2);
						odto.setProductList(list2);
						
						list1.add(odto);
					} while (rs1.next());
				} // if
			} catch (Exception e) {
				System.out.println("MypageDAOImpl.selectBoxOrderList() error...");
				e.printStackTrace();
			} finally {
				JdbcUtil.close(pstmt2);
				JdbcUtil.close(rs2);
				JdbcUtil.close(pstmt1);
				JdbcUtil.close(rs1);
			} // try
			return list1;
		}

		// 	4) 택배배송 취소
		//		a. 주문 내역, 주문 상품 정보 조회
		@Override
		public BoxOrderListDTO selectBoxOrder(int orderNo) throws SQLException {
			String sql = " SELECT box_order_date, box_order_status "
					+ " FROM box_order "
					+ " WHERE box_order_no = ? ";
			
			String sql2 = " SELECT DISTINCT p.products_no, products_type, products_name, products_size, products_cnt, price, event_price, img_path, system_name, tracking_no, products_tag "
					+ " FROM box_order_products o JOIN products p ON o.products_no = p.products_no "
											+ " JOIN products_img i ON p.products_no = i.products_no "
											+ " JOIN box_ship s ON o.box_order_no = s.box_order_no "
					+ " WHERE o.box_order_no = ? AND origin_name != 'View.png' "
					+ " ORDER BY p.products_no ";
			
			PreparedStatement pstmt1 = null;
			ResultSet rs1 = null;
			PreparedStatement pstmt2 = null;
			ResultSet rs2 = null;
			
			BoxOrderListDTO odto = null;
			BoxOrderProductDTO pdto = null;
			ArrayList<BoxOrderProductDTO> list2 = null;

			try {
				pstmt1 = conn.prepareStatement(sql);
				pstmt1.setInt(1, orderNo);
				rs1 = pstmt1.executeQuery();
				if (rs1.next()) {
					odto = new BoxOrderListDTO();
					odto.setBoxOrderNo(orderNo);
					odto.setBoxOrderDate(rs1.getString("box_order_date"));
					odto.setBoxOrderStatus(rs1.getInt("box_order_status"));
					
					pstmt2 = conn.prepareStatement(sql2);
					pstmt2.setInt(1, orderNo);
					rs2 = pstmt2.executeQuery();
					
					if (rs2.next()) {
						list2 = new ArrayList<>();
						do {
							pdto = new BoxOrderProductDTO();
							pdto.setProductsNo(rs2.getString("products_no"));
							pdto.setProductsType(rs2.getString("products_type"));
							pdto.setProductsName(rs2.getString("products_name"));
							pdto.setProductsSize(rs2.getString("products_size"));
							pdto.setProductsCnt(rs2.getString("products_cnt"));
							pdto.setPrice(rs2.getInt("price"));
							pdto.setEventPrice(rs2.getInt("event_price"));
							pdto.setImgPath(rs2.getString("img_path"));
							pdto.setOriginName(rs2.getString("system_name"));
							pdto.setTrackingNo(rs2.getString("tracking_no"));
							pdto.setProductsTag(rs2.getString("products_tag"));
							list2.add(pdto);
						} while (rs2.next());
						odto.setProductList(list2);
					} // if
						
					JdbcUtil.close(pstmt2);
					JdbcUtil.close(rs2);
				} // if
			} catch (Exception e) {
				System.out.println("MypageDAOImpl.selectBoxOrder() error...");
				e.printStackTrace();
			} finally {
				JdbcUtil.close(pstmt1);
				JdbcUtil.close(rs1);
			} // try
			return odto;
		} // selectBoxOrder

		//		b. 결제 정보 조회
		@Override
		public BoxPayDTO selectBoxPay(int orderNo) throws SQLException {
			String sql = " SELECT box_pay_no, box_pay_datetime, box_price, box_sale_price, box_discount_price, box_shipping_fee, box_final_price, box_pay_method, box_pay_status " 
					+ " FROM box_pay "
					+ " WHERE box_order_no = " + orderNo;

			PreparedStatement pstmt = null;
			ResultSet rs = null;
			BoxPayDTO dto = null;

			try {
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					dto = new BoxPayDTO();
					dto.setBoxPayNo(rs.getInt("box_pay_no"));
					dto.setBoxPayDateTime(rs.getString("box_pay_datetime"));
					dto.setBoxPrice(rs.getInt("box_price"));
					dto.setBoxSalePrice(rs.getInt("box_sale_price"));
					dto.setBoxDiscountPrice(rs.getInt("box_discount_price"));
					dto.setBoxShippingFee(rs.getInt("box_shipping_fee"));
					dto.setBoxFinalPrice(rs.getInt("box_final_price"));
					dto.setBoxPayMethod(rs.getInt("box_pay_method"));
					dto.setBoxPayStatus(rs.getInt("box_pay_status"));
				} // if
			} catch (Exception e) {
				System.out.println("MypageDAOImpl.selectBoxPay() error...");
				e.printStackTrace();
			} finally {
				JdbcUtil.close(pstmt);
				JdbcUtil.close(rs);
			} // try
			return dto;
		} // selectBoxPay

		//		c. 주문 결제 정보 업데이트
		@Override
		public int updateBoxOrder(int orderNo) throws SQLException {
			String sql1 = " UPDATE box_order " 
					+ " SET box_order_status = -1 "
					+ " WHERE box_order_no = " + orderNo;

			PreparedStatement pstmt = null;
			int rowCnt = 0;

			try {
				pstmt = conn.prepareStatement(sql1);
				rowCnt = pstmt.executeUpdate();
			} catch (Exception e) {
				System.out.println("MypageDAOImpl.updateBoxOrder() error...");
				e.printStackTrace();
			} finally {
				JdbcUtil.close(pstmt);
			} // try
			return rowCnt;
		} // updateBoxOrder
		
		//		d. 주문 결제 정보 업데이트
		@Override
		public int updateBoxPay(int orderNo) throws SQLException {
			String sql1 = " UPDATE box_pay " 
					+ " SET box_pay_status = 1 "
					+ " WHERE box_order_no = " + orderNo;
		
			PreparedStatement pstmt = null;
			int rowCnt = 0;
		
			try {
				pstmt = conn.prepareStatement(sql1);
				rowCnt = pstmt.executeUpdate();
			} catch (Exception e) {
				System.out.println("MypageDAOImpl.updateBoxPay() error...");
				e.printStackTrace();
			} finally {
				JdbcUtil.close(pstmt);
			} // try
			return rowCnt;
		}

		//	5) 택배배송 주문 상세 내역
		@Override
		public BoxShipDTO selectBoxShip(int orderNo) throws SQLException {
			String sql = " SELECT box_receiver, box_tel, box_zip_code, box_addr, box_addr_detail, box_memo "
					+ " FROM box_ship "
					+ " WHERE box_order_no = " + orderNo;

			PreparedStatement pstmt = null;
			ResultSet rs = null;
			BoxShipDTO dto = null;

			try {
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					dto = new BoxShipDTO();
					dto.setBoxReceiver(rs.getString("box_receiver"));
					dto.setBoxTel(rs.getString("box_tel"));
					dto.setBoxZipCode(rs.getString("box_zip_code"));
					dto.setBoxAddr(rs.getString("box_addr"));
					dto.setBoxAddrDetail(rs.getString("box_addr_detail"));
					dto.setBoxMemo(rs.getString("box_memo"));
				} // if
			} catch (Exception e) {
				System.out.println("MypageDAOImpl.selectBoxShip() error...");
				e.printStackTrace();
			} finally {
				JdbcUtil.close(pstmt);
				JdbcUtil.close(rs);
			} // try
			return dto;
		} // selectBoxShip

		
		// 	6) 사용한 쿠폰 리스트
		@Override
		public ArrayList<OrderCouponDTO> selectUsedCoupon(int payNo) throws SQLException {
			String sql = " SELECT coupon_name, discount "
					+ " FROM have_coupon h JOIN coupon c ON h.coupon_no = c.coupon_no "
					+ " WHERE box_pay_no = " + payNo;

			PreparedStatement pstmt = null;
			ResultSet rs = null;
			OrderCouponDTO dto = null;
			ArrayList<OrderCouponDTO> list = null;

			try {
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					list = new ArrayList<>();
					do {
						dto = new OrderCouponDTO();
						dto.setCouponName(rs.getString("coupon_name"));
						dto.setDiscount(rs.getDouble("discount"));
						list.add(dto);
					} while (rs.next());
				} // if
			} catch (Exception e) {
				System.out.println("MypageDAOImpl.selectUsedCoupon() error...");
				e.printStackTrace();
			} finally {
				JdbcUtil.close(pstmt);
				JdbcUtil.close(rs);
			} // try
			return list;
		} // selectUsedCoupon
	
	
	// 3. 시음선물 관련
	
	
	// 4. 쿠폰 관련
				
				
	// 5. 리뷰 관련
				
				
	// 6. 1:1 문의 관련
	
	
	
	
} // class
