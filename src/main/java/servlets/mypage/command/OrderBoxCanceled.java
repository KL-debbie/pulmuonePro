package servlets.mypage.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.command.CommandHandler;
import servlets.mypage.dto.BoxOrderListDTO;
import servlets.mypage.service.MypageService;
import servlets.order.domain.BoxPayDTO;

public class OrderBoxCanceled implements CommandHandler {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("OrderBoxCancel.java : MY녹즙 택배배송 주문 취소 페이지");
		
		// orderNo 가져오기
		int orderNo = Integer.parseInt(request.getParameter("orderNo"));
		
		// > service 객체 생성
		MypageService service = new MypageService();
		
		// 1. 주문 및 상품 정보 조회
		BoxOrderListDTO boxOrder = service.selectBoxOrder(orderNo);
		request.setAttribute("boxOrder", boxOrder);
		
		// 2. 결제 정보 조회
		BoxPayDTO boxPay = service.selectBoxPay(orderNo);
		request.setAttribute("boxPay", boxPay);
		
		// 3. 주문, 결제 정보 업데이트
		int canceled = service.updateBoxOrder(orderNo);
		
		if (canceled == 2) {
			return "/WEB-INF/views/mypage/order/box/canceled.jsp";
		} else {
			return "/WEB-INF/views/mypage/order/box/cancel.jsp";
		} // if
	} // process
} // class