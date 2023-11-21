package servlets.order.command;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import auth.AuthInfo;
import mvc.command.CommandHandler;
import servlets.order.domain.BoxOrderProductDTO;
import servlets.order.domain.OrderCouponDTO;
import servlets.order.domain.OrderMemberInfoDTO;
import servlets.order.service.BoxOrderService;

public class BoxOrder implements CommandHandler {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("> BoxOrder.process..");
		
		// 상품번호 받아오기
		String productsNo [] = request.getParameterValues("productsNo");
		
		// 유저번호 받아오기
		HttpSession session = request.getSession(false);
		AuthInfo member = (AuthInfo) session.getAttribute("auth");
		int memberNo = member.getMemberNo();
		
		BoxOrderService service = BoxOrderService.getInstanse();
		
		// 상품 정보 출력
		ArrayList<BoxOrderProductDTO> plist = service.selectProducts(productsNo);
		request.setAttribute("productList", plist);
		
		// 이름, 전화번호 출력
		OrderMemberInfoDTO miDto = service.getNameAndTel(memberNo);
		request.setAttribute("miDto", miDto);
		
		// 쿠폰 정보 가져오기
		ArrayList<OrderCouponDTO> clist = service.selectCoupon(memberNo, productsNo);
		if (clist != null) {
			request.setAttribute("couponList", clist);
		} // if
		
		return "/WEB-INF/views/order/box/step1.jsp";
	} // process()

}