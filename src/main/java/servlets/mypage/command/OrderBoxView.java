package servlets.mypage.command;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.command.CommandHandler;
import servlets.mypage.dto.BoxOrderListDTO;
import servlets.mypage.service.MypageService;
import servlets.order.domain.BoxPayDTO;
import servlets.order.domain.BoxShipDTO;
import servlets.order.domain.OrderCouponDTO;

public class OrderBoxView implements CommandHandler {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("OrderBox.java : MY녹즙 택배배송 주문내역 상세보기 페이지");
		
		// > service 객체 생성
		MypageService service = new MypageService();
		
		// > 주문번호 가져오기
		int orderNo = Integer.parseInt(request.getParameter("boxOrderNo"));
		
		// 1. 주문 및 상품 정보 조회
		BoxOrderListDTO boxOrder = service.selectBoxOrder(orderNo);
		request.setAttribute("boxOrder", boxOrder);
		
		// 2. 배송지 정보(이름, 연락처, 우편번호, 주소, 상세주소, 메모)
		BoxShipDTO boxShip = service.selectBoxShip(orderNo);
		request.setAttribute("boxShip", boxShip);
		
		// 3. 결제 정보 조회
		BoxPayDTO boxPay = service.selectBoxPay(orderNo);
		request.setAttribute("boxPay", boxPay);
		
		// 4. 사용된 쿠폰(이름, 혜택(금액/율)
		int payNo = boxPay.getBoxPayNo();
		ArrayList<OrderCouponDTO> couponList = service.selectUsedCoupon(payNo);
		request.setAttribute("couponList", couponList);
		
		
		return "/WEB-INF/views/mypage/order/box/orderBoxView.jsp";
	}

}