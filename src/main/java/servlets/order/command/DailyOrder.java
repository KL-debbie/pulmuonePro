package servlets.order.command;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import auth.AuthInfo;
import mvc.command.CommandHandler;
import servlets.order.domain.DrkOrderProductDTO;
import servlets.order.domain.OrderCouponDTO;
import servlets.order.domain.OrderMemberInfoDTO;
import servlets.order.service.BoxOrderService;
import servlets.order.service.DrkOrderService;

public class DailyOrder implements CommandHandler {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("> DailyOrder.process..");
		
		// > 유저 정보 가져오기
		HttpSession session = request.getSession(false);
		AuthInfo member = (AuthInfo) session.getAttribute("auth");
		int memberNo = member.getMemberNo();
		
		// > 주문 내용 가져오기
		
		// item String
        String jsonStr = request.getParameter("item");		// {"item":[{"itemCode":"0071654","dayQty":[1,1,1,1,1]}]
        
        // pattern 지정
        Pattern pattern = Pattern.compile("\\{\"itemCode\":\"(.*?)\",\"dayQty\":\\[(.*?)\\]\\}");
        Matcher matcher = pattern.matcher(jsonStr);
        
        // list 생성
        ArrayList<String> itemCodeList = new ArrayList<>();
        ArrayList<int []> dayQtyList = new ArrayList<>();
        
        // list에 데이터 담기
        String itemCode, dayQtyStr;
        while (matcher.find()) {
            itemCode = matcher.group(1);
            dayQtyStr = matcher.group(2);

            // dayQtyStr 처리
            String [] dayQtyArr = dayQtyStr.split(",");
            int[] dayQty = new int[dayQtyArr.length];
            // parseInt
            for (int i = 0; i < dayQtyArr.length; i++) {
                dayQty[i] = Integer.parseInt(dayQtyArr[i].trim());
            } // for

            // 추출한 데이터 리스트에 저장
            itemCodeList.add(itemCode);
            dayQtyList.add(dayQty);

            // 확인용 출력
            System.out.println("Item Code: " + itemCode);
            System.out.println("Day Qty: " + Arrays.toString(dayQty));
        } // while
        
        
        // > service 객체 생성
        DrkOrderService service = DrkOrderService.getInstanse();
        BoxOrderService bService = BoxOrderService.getInstanse();
        
        
        // 1. 상품 정보 출력
        ArrayList<DrkOrderProductDTO> prdList = service.selectProducts(itemCodeList);
        request.setAttribute("prdList", prdList);
        
        // 2. 이름 및 전화번호
        OrderMemberInfoDTO miDto = bService.getNameAndTel(memberNo);
		request.setAttribute("miDto", miDto);
		
		// 쿠폰 정보 가져오기
		
        
        
		return "/WEB-INF/views/order/daily/step1.jsp";
	}
}