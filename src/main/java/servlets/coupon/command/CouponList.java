package servlets.coupon.command;


import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import auth.AuthInfo;
import mvc.command.CommandHandler;
import servlets.coupon.domain.CouponDTO;
import servlets.coupon.domain.HaveCouponDTO;
import servlets.coupon.service.CouponService;

public class CouponList implements CommandHandler{

	private CouponService couponService = new CouponService();

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println(">CouponList.process ");
		HttpSession session = request.getSession(false);
		AuthInfo auth = (AuthInfo) session.getAttribute("auth");
		int memberNo = auth.getMemberNo();
				
		List<HaveCouponDTO> couponList = couponService.getCouponsByMemberNo(memberNo);
		List<CouponDTO> couponInfoList = couponService.getCouponInfosByMemberNo(memberNo);
		
        int usableCoupons = 0;
        for (HaveCouponDTO coupon : couponList) {
            if (coupon.getUsed() == 0) {
                usableCoupons++;
            }
        }
		
		//1.  포워딩 전 데이터 저장
		request.setAttribute("couponList", couponList);
		request.setAttribute("couponInfoList", couponInfoList);
		request.setAttribute("usableCoupons", usableCoupons);

		return "/WEB-INF/views/coupon/list.jsp";
	}

}
