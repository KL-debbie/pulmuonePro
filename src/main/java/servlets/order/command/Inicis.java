package servlets.order.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import auth.AuthInfo;
import mvc.command.CommandHandler;
import servlets.order.domain.BoxPayDTO;
import servlets.order.domain.BoxShipDTO;
import servlets.order.domain.OrderAddrBookDTO;
import servlets.order.service.BoxOrderService;

public class Inicis implements CommandHandler {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("> Inicis.process..");
		
		// 회원 정보 가져오기
		HttpSession session = request.getSession(false);
		AuthInfo member = (AuthInfo) session.getAttribute("auth");
		int memberNo = member.getMemberNo();
		
		// 주문 정보 가져오기
		int boxOrderStatus = request.getParameter("payMethod").equals("VBank") ? 0 : 1;
		String [] productsNo = request.getParameterValues("productsNo");
		String [] productsCnt = request.getParameterValues("productsCnt");
		
		// 배송지 정보 가져오기
		String boxReceiver = request.getParameter("orderName");
		String boxTel = request.getParameter("tel");
		String boxZipCode = request.getParameter("zipCode");
		String boxAddr = request.getParameter("addrRoad");
		String boxAddrDetail = request.getParameter("addrDetail");
		String boxMemo = request.getParameter("orderMemo");
		
		// 결제 정보 가져오기
		int price = Integer.parseInt(request.getParameter("price"));
		int salePrice = Integer.parseInt(request.getParameter("salePrice"));
		int discountPrice = Integer.parseInt(request.getParameter("discountPrice"));
		int shppingPrice = Integer.parseInt(request.getParameter("shppingPrice"));
		int finalPrice = Integer.parseInt(request.getParameter("payPrice"));
		int payMethod = Integer.parseInt(request.getParameter("payMethod"));
		
		// 쿠폰 정보 가져오기
		String [] couponNos = request.getParameterValues("couponIdx");
		
		// inset
		BoxOrderService service = BoxOrderService.getInstanse();
		
		// 1. 주문, 2. 주문상품, 3. 배송지 정보 추가
		int boxOrderNo = service.insertBoxOrder(memberNo, boxOrderStatus);
		service.insertBoxOrderedProducts(boxOrderNo, productsNo, productsCnt);
		BoxShipDTO bsDTO = new BoxShipDTO(boxOrderNo, boxReceiver, boxTel, boxZipCode, boxAddr, boxAddrDetail, boxMemo, null);
		service.insertBoxShip(bsDTO);
		
		// 4. 배송지 정보 -> 주소록에 저장
		String saveAddrChk = request.getParameter("saveAddrChk");
		OrderAddrBookDTO oabDTO = null;
		if (saveAddrChk != null) {
			oabDTO = new OrderAddrBookDTO(-1, memberNo, boxReceiver, boxReceiver, boxTel, 0, boxZipCode, boxAddr, boxAddrDetail, boxMemo, 0);
			service.insertAddrBook(oabDTO);
		} // if
		
		// 5. 결제 정보 추가
		int payStatus = 0;	// 결제 상태 : 결제 완료
		if (payMethod == 2) payStatus--;	// 결제 방법이 무통장입금이면 결제 상태를 '결제 전'으로 바꿈
		BoxPayDTO bpDTO = new BoxPayDTO(0, boxOrderNo, "", price, salePrice, discountPrice, shppingPrice, finalPrice, payMethod, payStatus);
		int boxPayNo = service.insertPay(bpDTO);
		
		// 6. 쿠폰 사용 처리
		if (couponNos!=null) service.updateHaveCoupon(boxPayNo, memberNo, couponNos);
		
		request.setAttribute("boxOrderNo", boxOrderNo);
		// 결과 확인용
		/*
		request.setAttribute("boxOrderProductsRowCnt", boxOrderProductsRowCnt);
		request.setAttribute("boxShipRowCnt", boxShipRowCnt);
		request.setAttribute("addrBookRowCnt", addrBookRowCnt);
		request.setAttribute("boxPayNo", boxPayNo);
		request.setAttribute("haveCouponRowCnt", haveCouponRowCnt);
		*/
		return "/WEB-INF/views/order/inicis/callback.jsp";
	} // process()

}