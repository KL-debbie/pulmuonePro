package servlets.mypage.dao;

import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;

import servlets.coupon.domain.HaveCouponDTO;
import servlets.mypage.dto.BoxOrderListDTO;
import servlets.mypage.dto.BoxOrderSimpleInfoDTO;
import servlets.order.domain.BoxPayDTO;
import servlets.order.domain.BoxShipDTO;
import servlets.order.domain.OrderCouponDTO;

public interface MypageDAO {
	
	// 1. 매일배송 관련
	
	
	// 2. 택배배송 관련
		// 	1) 총 택배배송 주문 건수
		int boxOrderCnt(int memberNo) throws SQLException;
				
		// 	2) 택배배송 주문 내역
		// 		a. 결제완료 주문 건수, 배송준비중 주문 건수, 배송중 주문건수, 배송완료 주문건수
		int [] boxOrderStatus(int memberNo) throws SQLException;
		// 		b. 최근 2개의 주문 내역 정보(주문번호, 상품명, 결제금액, 주문일자, 주문상태)
		ArrayList<BoxOrderSimpleInfoDTO> currBoxOrderList(int memberNo) throws SQLException;
		
		// 	3) 택배배송 주문 내역 - 리스트 조회 및 날짜 검색
		ArrayList<BoxOrderListDTO> selectBoxOrderList(int memberNo, Date startSearchDate, Date endSearchDate) throws SQLException;
		
		// 	4) 택배배송 주문 취소
		//		a. 주문 내역, 주문 상품 정보 조회
		BoxOrderListDTO selectBoxOrder(int orderNo) throws SQLException;
		//		b. 결제 정보 조회
		BoxPayDTO selectBoxPay(int orderNo) throws SQLException;
		// 		c. 주문 정보 업데이트
		int updateBoxOrder(int orderNo) throws SQLException;
		//		d. 결제 정보 업데이트
		int updateBoxPay(int orderNo) throws SQLException;
		
		//	5) 택배배송 주문 상세 내역
		BoxShipDTO selectBoxShip(int orderNo) throws SQLException;
		
		// 	6) 사용한 쿠폰 리스트
		ArrayList<OrderCouponDTO> selectUsedCoupon(int payNo)  throws SQLException;
		
	
	// 3. 시음선물 관련
			
			
	// 4. 쿠폰 관련
			
			
	// 5. 리뷰 관련 servlets.review 참조
			
			
	// 6. 1:1 문의 관련 servlets.inquiry 참조 
	
	
}
