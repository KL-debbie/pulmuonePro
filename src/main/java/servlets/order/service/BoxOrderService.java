package servlets.order.service;

import java.sql.Connection;
import java.util.ArrayList;

import jdbc.JdbcUtil;
import jdbc.connection.ConnectionProvider;
import servlets.order.domain.BoxOrderInfoDTO;
import servlets.order.domain.BoxOrderProductDTO;
import servlets.order.domain.BoxPayDTO;
import servlets.order.domain.BoxShipDTO;
import servlets.order.domain.OrderAddrBookDTO;
import servlets.order.domain.OrderCouponDTO;
import servlets.order.domain.OrderMemberInfoDTO;
import servlets.order.persistence.BoxOrderImpl;

public class BoxOrderService {

	// 싱글톤
	private BoxOrderService() {}
	private static BoxOrderService instanse = null;
	public static BoxOrderService getInstanse() {
		if (instanse == null) {
			instanse = new BoxOrderService();
		} // if
		return instanse;
	} // getInstanse()
	
	
	private Connection conn = null;
	
	public ArrayList<BoxOrderProductDTO> selectProducts(String [] productsNo) {
		try {
			conn = ConnectionProvider.getConnection();
			BoxOrderImpl dao = BoxOrderImpl.getInstance();
			ArrayList<BoxOrderProductDTO> list = dao.selectProducts(conn, productsNo);
			return list;
		} catch (Exception e) {
			System.out.println("BoxOrderService.selectProducts() 에러");
			e.printStackTrace();
			throw new RuntimeException(e);
		} finally {
			JdbcUtil.close(conn);
		} // try
	} // selectProducts()
	
	public ArrayList<OrderCouponDTO> selectCoupon(int memberNo, String [] productsNo) {
		try {
			conn = ConnectionProvider.getConnection();
			BoxOrderImpl dao = BoxOrderImpl.getInstance();
			// 상품 가격 구하기
			int priductsPrice = dao.getProductsPrice(conn, productsNo);
			// 사용 가능한 쿠폰 조회 하기
			ArrayList<OrderCouponDTO> list = null;
			list = dao.selectCoupon(conn, memberNo, priductsPrice);
			return list;
		} catch (Exception e) {
			System.out.println("BoxOrderService.selectCoupon() 에러");
			e.printStackTrace();
			throw new RuntimeException(e);
		} finally {
			JdbcUtil.close(conn);
		} // try
	} // selectCoupon()
	
	public OrderMemberInfoDTO getNameAndTel(int memberNo) {
		try {
			conn = ConnectionProvider.getConnection();
			BoxOrderImpl dao = BoxOrderImpl.getInstance();
			OrderMemberInfoDTO dto = null;
			dto = dao.getNameAndTel(conn, memberNo);
			return dto;
		} catch (Exception e) {
			System.out.println("BoxOrderService.getNameAndTel() 에러");
			e.printStackTrace();
			throw new RuntimeException(e);
		} finally {
			JdbcUtil.close(conn);
		} // try
	} // getNameAndTel()
	
	public int insertBoxOrder(int memberNo, int boxOrderStatus) {
		try {
			conn = ConnectionProvider.getConnection();
			BoxOrderImpl dao = BoxOrderImpl.getInstance();
			int boxOrderNo = dao.insertBoxOrder(conn, memberNo, boxOrderStatus);
			return boxOrderNo;
		} catch (Exception e) {
			System.out.println("BoxOrderService.insertBoxOrder() 에러");
			e.printStackTrace();
			throw new RuntimeException(e);
		} finally {
			JdbcUtil.close(conn);
		} // try
	} // insertBoxOrder()
	
	public int insertBoxOrderedProducts(int boxOrderNo, String [] productsNo, String [] productsCnt) {
		try {
			conn = ConnectionProvider.getConnection();
			BoxOrderImpl dao = BoxOrderImpl.getInstance();
			int rowCount = 0, cnt = 0;
			for (int i = 0; i < productsNo.length; i++) {
				cnt = Integer.parseInt(productsCnt[i]);
				rowCount += dao.insertBoxOrderedProducts(conn, boxOrderNo, productsNo[i], cnt);
			} // for
			return rowCount;
		} catch (Exception e) {
			System.out.println("BoxOrderService.insertBoxOrderedProducts() 에러");
			e.printStackTrace();
			throw new RuntimeException(e);
		} finally {
			JdbcUtil.close(conn);
		} // try
	} // insertBoxOrderedProducts()
	
	public int insertBoxShip(BoxShipDTO dto) {
		try {
			conn = ConnectionProvider.getConnection();
			BoxOrderImpl dao = BoxOrderImpl.getInstance();
			int rowCount = dao.insertBoxShip(conn, dto);
			return rowCount;
		} catch (Exception e) {
			System.out.println("BoxOrderService.insertBoxShip() 에러");
			e.printStackTrace();
			throw new RuntimeException(e);
		} finally {
			JdbcUtil.close(conn);
		} // try
	} // insertBoxShip()
	
	public int insertAddrBook(OrderAddrBookDTO dto) {
		try {
			conn = ConnectionProvider.getConnection();
			BoxOrderImpl dao = BoxOrderImpl.getInstance();
			int rowCount = dao.insertAddrBook(conn, dto);
			return rowCount;
		} catch (Exception e) {
			System.out.println("BoxOrderService.insertBoxShip() 에러");
			e.printStackTrace();
			throw new RuntimeException(e);
		} finally {
			JdbcUtil.close(conn);
		} // try
	} // insertAddrBook()
	
	public int insertPay(BoxPayDTO dto) {
		try {
			conn = ConnectionProvider.getConnection();
			BoxOrderImpl dao = BoxOrderImpl.getInstance();
			int boxPayNo = dao.insertPay(conn, dto);
			return boxPayNo;
		} catch (Exception e) {
			System.out.println("BoxOrderService.insertPay() 에러");
			e.printStackTrace();
			throw new RuntimeException(e);
		} finally {
			JdbcUtil.close(conn);
		} // try
	} // insertPay()
	
	public int updateHaveCoupon(int boxPayNo, int memberNo, String [] couponNos) {
		try {
			conn = ConnectionProvider.getConnection();
			BoxOrderImpl dao = BoxOrderImpl.getInstance();
			int rowCount = 0, couponNo = 0;
			for (int i = 0; i < couponNos.length; i++) {
				couponNo = Integer.parseInt(couponNos[i]);
				rowCount += dao.updateHaveCoupon(conn, boxPayNo, memberNo, couponNo);
			} // for
			return rowCount;
		} catch (Exception e) {
			System.out.println("BoxOrderService.updateHaveCoupon() 에러");
			e.printStackTrace();
			throw new RuntimeException(e);
		} finally {
			JdbcUtil.close(conn);
		} // try
	} // updateHaveCoupon()
	
	
	public ArrayList<BoxOrderProductDTO> selectOrderProductList(int boxOrderNo) {
		try {
			conn = ConnectionProvider.getConnection();
			BoxOrderImpl dao = BoxOrderImpl.getInstance();
			ArrayList<BoxOrderProductDTO> list = null;
			list = dao.selectOrderProductList(conn, boxOrderNo);
			return list;
		} catch (Exception e) {
			System.out.println("BoxOrderService.selectOrderProductList() 에러");
			e.printStackTrace();
			throw new RuntimeException(e);
		} finally {
			JdbcUtil.close(conn);
		} // try
	} // selectOrderProductList()
	
	public BoxOrderInfoDTO selectBoxOrderInfo(int boxOrderNo) {
		try {
			conn = ConnectionProvider.getConnection();
			BoxOrderImpl dao = BoxOrderImpl.getInstance();
			BoxOrderInfoDTO dto = null;
			dto = dao.selectBoxOrderInfo(conn, boxOrderNo);
			return dto;
		} catch (Exception e) {
			System.out.println("BoxOrderService.selectBoxOrderInfo() 에러");
			e.printStackTrace();
			throw new RuntimeException(e);
		} finally {
			JdbcUtil.close(conn);
		} // try
	} // selectBoxOrderInfo()
	
}