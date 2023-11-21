package servlets.event.command;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import auth.AuthInfo;
import jdbc.connection.ConnectionProvider;
import mvc.command.CommandHandler;
import servlets.coupon.domain.CouponDTO;
import servlets.coupon.domain.HaveCouponDTO;
import servlets.event.persistence.EventCouponDAO;
import servlets.event.persistence.IEventCoupon;

public class EventCoupon implements CommandHandler {

    private IEventCoupon eventCouponDAO = new EventCouponDAO();

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {

        String method = request.getMethod();

        if (method.equals("GET")) {

            // 회원번호는 세션에서 가져옴
            HttpSession session = request.getSession();
            AuthInfo auth = (AuthInfo) session.getAttribute("auth");

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            
            if (auth == null) {
                // 로그인 정보가 없음, 사용자에게 로그인 요청 메시지 반환
                response.getWriter().print("{\"message\":\"로그인 후 이용해주세요.\"}");
                return null;
            }

            String coupon_no_str = request.getParameter("coupon_no");
            if (coupon_no_str == null || coupon_no_str.equals("undefined")) {
                response.getWriter().print("{\"message\":\"잘못된 요청입니다.\"}");
                return null;
            }
            int coupon_no = Integer.parseInt(coupon_no_str);

            // ConnectionProvider를 사용하여 Connection 객체 얻기
            Connection conn = ConnectionProvider.getConnection();

            try {
                // 쿠폰 번호로 쿠폰 정보 조회
                CouponDTO coupon = eventCouponDAO.getCoupon(conn, coupon_no);

                if(coupon != null){
                    // 조회된 쿠폰 정보를 바탕으로 HaveCouponDTO 객체 생성
                    HaveCouponDTO haveCoupon = new HaveCouponDTO();
                    haveCoupon.setCoupon_no(coupon.getCoupon_no());

                    int memberNo = auth.getMemberNo();
                    if (eventCouponDAO.checkDuplicateCoupon(conn, coupon_no, memberNo)) {
                        // 이미 수령한 쿠폰인 경우, 사용자에게 중복 수령 메시지 반환
                        response.getWriter().print("{\"message\":\"이미 받은 쿠폰입니다.\"}");
                        return null;
                    }
                    haveCoupon.setMember_no(memberNo);

                    // 발급일은 당일로 설정
                    java.sql.Date issueDate = new java.sql.Date(System.currentTimeMillis());
                    haveCoupon.setIssue_date(issueDate);

                    // 만료일은 발급일로부터 use_month 개월수의 25일로 설정
                    Calendar calendar = Calendar.getInstance();
                    calendar.setTime(issueDate);
                    int useMonth = coupon.getUse_month();
                    calendar.add(Calendar.MONTH, useMonth);
                    calendar.set(Calendar.DAY_OF_MONTH, 25);
                    java.sql.Date expiryDate = new java.sql.Date(calendar.getTimeInMillis());
                    haveCoupon.setExpiry_date(expiryDate);

                    // 사용 여부 설정 (미사용)
                    haveCoupon.setUsed(0);

                    // HaveCouponDTO 객체를 데이터베이스에 저장
                    int result = eventCouponDAO.setCoupon(conn, haveCoupon);

                    if(result > 0) {
                    	response.getWriter().print("{\"message\":\"쿠폰이 발급되었습니다.\"}");
                    } else {
                        response.getWriter().print("{\"message\":\"에러가 발상하였습니다.\"}");
                    }

                    return null;
           
                } else {
                	// 쿠폰 정보가 없음, 사용자에게 실패 메시지 반환
                    response.getWriter().print("{\"message\":\"존재하지 않는 요청입니다.\"}");
                    return null;
                }
            } finally {
                // Connection 객체 반환
                if (conn != null) {
                    try {
                        conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        } else { // POST
            // POST 요청 처리 로직
            // ...
        } 

        return null;
    }
}
