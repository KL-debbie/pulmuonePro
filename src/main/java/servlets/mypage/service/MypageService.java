package servlets.mypage.service;

import java.sql.Connection;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Map;

import jdbc.JdbcUtil;
import jdbc.connection.ConnectionProvider;
import servlets.mypage.dao.MypageDAOImpl;
import servlets.mypage.dto.BoxOrderListDTO;
import servlets.mypage.dto.BoxOrderSimpleInfoDTO;
import servlets.order.domain.BoxOrderDTO;
import servlets.order.domain.BoxPayDTO;
import servlets.order.domain.BoxShipDTO;
import servlets.order.domain.OrderCouponDTO;

public class MypageService {
	
	// 1. 매일배송 관련
	
	
	
	// 2. 택배배송 관련
		// 	1) 총 택배배송 주문 건수
		public int boxOrderCnt(int memberNo) {
			Connection conn = null;
			MypageDAOImpl dao = null;
			
			int totalCnt = 0;
			
			try {
				conn = ConnectionProvider.getConnection();
				dao = new MypageDAOImpl(conn);
				
				totalCnt = dao.boxOrderCnt(memberNo);
			} catch (Exception e) {
				System.out.println("MypageService.boxOrderCnt() error...");
				e.printStackTrace();
			} finally {
				JdbcUtil.close(conn);
			} // try
			return totalCnt;
		} // boxOrderCnt()
		
		// 	2) 택배배송 주문 내역
		//		a. 결제완료 주문 건수, 배송준비중 주문 건수, 배송중 주문건수, 배송완료 주문건수
		public int[] boxOrderStatus(int memberNo) {
			Connection conn = null;
			MypageDAOImpl dao = null;
			
			int orderCnt [] = new int [4];
			
			try {
				conn = ConnectionProvider.getConnection();
				dao = new MypageDAOImpl(conn);
				
				orderCnt = dao.boxOrderStatus(memberNo);
			} catch (Exception e) {
				System.out.println("MypageService.boxOrderStatus() error...");
				e.printStackTrace();
			} finally {
				JdbcUtil.close(conn);
			} // try
			return orderCnt;
		} // boxOrderStatus()
		
		// 		b. 최근 2개의 주문 내역 정보(주문번호, 상품명, 결제금액, 주문일자, 주문상태)
		public ArrayList<BoxOrderSimpleInfoDTO> currBoxOrderList(int memberNo) {
			Connection conn = null;
			MypageDAOImpl dao = null;
			
			ArrayList<BoxOrderSimpleInfoDTO> list = null;
			
			try {
				conn = ConnectionProvider.getConnection();
				dao = new MypageDAOImpl(conn);
				
				list = dao.currBoxOrderList(memberNo);
			} catch (Exception e) {
				System.out.println("MypageService.currBoxOrderList() error...");
				e.printStackTrace();
			} finally {
				JdbcUtil.close(conn);
			} // try
			return list;
		} // currBoxOrderList()
		
		
		// 	3) 택배배송 주문 내역 - 리스트 조회 및 날짜 검색
		public ArrayList<BoxOrderListDTO> selectBoxOrderList(int memberNo, Date startSearchDate, Date endSearchDate) {
			Connection conn = null;
			MypageDAOImpl dao = null;
			ArrayList<BoxOrderListDTO> list = null;
			
			try {
				conn = ConnectionProvider.getConnection();
				dao = new MypageDAOImpl(conn);
				list = dao.selectBoxOrderList(memberNo, startSearchDate, endSearchDate);
			} catch (Exception e) {
				System.out.println("MypageService.selectBoxOrderList() error...");
				e.printStackTrace();
			} finally {
				JdbcUtil.close(conn);
			} // try
			return list;
		} // selectBoxOrderList()

		// 	4) 택배배송 취소
		//		a. 주문 내역, 주문 상품 정보 조회
		public BoxOrderListDTO selectBoxOrder(int boxOrderNo) {
			Connection conn = null;
			MypageDAOImpl dao = null;
			BoxOrderListDTO dto = null;
			
			try {
				conn = ConnectionProvider.getConnection();
				dao = new MypageDAOImpl(conn);
				
				dto = dao.selectBoxOrder(boxOrderNo);
			} catch (Exception e) {
				System.out.println("MypageService.selectBoxOrder() error...");
				e.printStackTrace();
			} finally {
				JdbcUtil.close(conn);
			} // try
			return dto;
		} // selectBoxOrder()
		
		//		b. 결제 정보 조회
		public BoxPayDTO selectBoxPay(int boxOrderNo) {
			Connection conn = null;
			MypageDAOImpl dao = null;
			BoxPayDTO dto = null;
			
			try {
				conn = ConnectionProvider.getConnection();
				dao = new MypageDAOImpl(conn);
				
				dto = dao.selectBoxPay(boxOrderNo);
				
			} catch (Exception e) {
				System.out.println("MypageService.selectBoxPay() error...");
				e.printStackTrace();
			} finally {
				JdbcUtil.close(conn);
			} // try
			return dto;
		} // selectBoxPay()

		//		c, d. 결제 정보 조회
		public int updateBoxOrder(int boxOrderNo) {
			Connection conn = null;
			MypageDAOImpl dao = null;
			int rowCnt1 = 0, rowCnt2 = 0;
			
			try {
				conn = ConnectionProvider.getConnection();
				dao = new MypageDAOImpl(conn);
				
				rowCnt1 = dao.updateBoxOrder(boxOrderNo);
				rowCnt2 = dao.updateBoxPay(boxOrderNo);
			} catch (Exception e) {
				System.out.println("MypageService.updateBoxOrder() error...");
				e.printStackTrace();
			} finally {
				JdbcUtil.close(conn);
			} // try
			return rowCnt1+rowCnt2;
		} // updateBoxOrder()
		
		//	5) 택배배송 주문 상세 내역
		public BoxShipDTO selectBoxShip(int boxOrderNo) {
			Connection conn = null;
			MypageDAOImpl dao = null;
			BoxShipDTO dto = null;
			
			try {
				conn = ConnectionProvider.getConnection();
				dao = new MypageDAOImpl(conn);
				
				dto = dao.selectBoxShip(boxOrderNo);
			} catch (Exception e) {
				System.out.println("MypageService.selectBoxShip() error...");
				e.printStackTrace();
			} finally {
				JdbcUtil.close(conn);
			} // try
			return dto;
		} // selectBoxShip()
		
		//	5) 택배배송 주문 상세 내역
		public ArrayList<OrderCouponDTO> selectUsedCoupon(int payNo) {
			Connection conn = null;
			MypageDAOImpl dao = null;
			ArrayList<OrderCouponDTO> list = null;
			
			try {
				conn = ConnectionProvider.getConnection();
				dao = new MypageDAOImpl(conn);
				
				list = dao.selectUsedCoupon(payNo);
			} catch (Exception e) {
				System.out.println("MypageService.selectUsedCoupon() error...");
				e.printStackTrace();
			} finally {
				JdbcUtil.close(conn);
			} // try
			return list;
		} // selectUsedCoupon()
	

}
