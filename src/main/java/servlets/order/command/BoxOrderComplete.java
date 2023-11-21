package servlets.order.command;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.command.CommandHandler;
import servlets.order.domain.BoxOrderInfoDTO;
import servlets.order.domain.BoxOrderProductDTO;
import servlets.order.service.BoxOrderService;

public class BoxOrderComplete implements CommandHandler {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("> BoxOrderComplete.process..");
		
		int boxOrderNo = Integer.parseInt(request.getParameter("boxOrderNo"));
		
		BoxOrderService service = BoxOrderService.getInstanse();
		
		// 상품 리스트
		ArrayList<BoxOrderProductDTO> orderProductlist = service.selectOrderProductList(boxOrderNo);
		request.setAttribute("orderProductlist", orderProductlist);
		
		// 배송지 정보(우편번호, 주소, 상세주소, 배송메모), 결제 정보(상품판매가, 상품할인판매가, 쿠폰할인금액, 배송비, 결제수단, 최종결제금액) 조회
		BoxOrderInfoDTO boxOrderInfo = service.selectBoxOrderInfo(boxOrderNo);
		request.setAttribute("boxOrderInfo", boxOrderInfo);
		
		return "/WEB-INF/views/order/box/step2.jsp";
	} // process()

}