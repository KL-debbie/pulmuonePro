package servlets.mypage.command;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import auth.AuthInfo;
import mvc.command.CommandHandler;
import servlets.mypage.dto.BoxOrderListDTO;
import servlets.mypage.service.MypageService;

public class OrderBox implements CommandHandler {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("OrderBox.java : MY녹즙 택배배송 주문내역 페이지");
		
		// > 회원 정보 가져오기
		HttpSession session = request.getSession(false);
		AuthInfo member = (AuthInfo) session.getAttribute("auth");
		int memberNo = member.getMemberNo();
		
		// > service 객체 생성
		MypageService service = new MypageService();
		
		// 1. 총 택배배송 주문 건수
		int boxOrderCnt = service.boxOrderCnt(memberNo);
		request.setAttribute("boxOrderCnt", boxOrderCnt);
		
		// 2. 택배배송 리스트 조회
		String startSearchDate = request.getParameter("startSearchDate");
		String endSearchDate = request.getParameter("endSearchDate");
		
		int year, month, date;
		Date startDate = null, endDate = null;
		if (startSearchDate == null || endSearchDate == null) {	// null일 시, 오늘 날짜
			java.util.Date t = new java.util.Date();
			year = t.getYear();
			month = t.getMonth()+1;
			date = t.getDate();
			
			endDate = new Date(year, month, date);
			startDate = new Date(year, month, date);
			startDate.setMonth(month-3);
		} else {	// 
			year = Integer.parseInt(startSearchDate.substring(0, 4))-1900;
			month = Integer.parseInt(startSearchDate.substring(5, 7));
			date = Integer.parseInt(startSearchDate.substring(8, 10));
			
			startDate = new Date(year, month, date);
			
			year = Integer.parseInt(endSearchDate.substring(0, 4))-1900;
			month = Integer.parseInt(endSearchDate.substring(5, 7));
			date = Integer.parseInt(endSearchDate.substring(8, 10));
			
			endDate = new Date(year, month, date);
			
			endDate.setDate(endDate.getDate()+1);	// 하루 추가
			
			System.out.println("startDate = " + startDate);
			System.out.println("endDate = " + endDate);
		} // if
		
		ArrayList<BoxOrderListDTO> boxOrderList = service.selectBoxOrderList(memberNo, startDate, endDate);
		request.setAttribute("boxOrderList", boxOrderList);
		
		return "/WEB-INF/views/mypage/order/box/orderBox.jsp";
	}

}