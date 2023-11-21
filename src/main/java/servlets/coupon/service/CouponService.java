package servlets.coupon.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.NamingException;

import jdbc.JdbcUtil;
import jdbc.connection.ConnectionProvider;
import servlets.coupon.domain.CouponDTO;
import servlets.coupon.domain.HaveCouponDTO;
import servlets.coupon.persistence.CouponDAOImpl;

public class CouponService {
	
	private CouponDAOImpl couponDAO;

	public CouponService() {
		couponDAO = new CouponDAOImpl();
	}

	public List<HaveCouponDTO> getCouponsByMemberNo(int memberNo) {
		Connection conn = null;
		try {
			conn = ConnectionProvider.getConnection();
			return couponDAO.selectCoupon(memberNo, conn);
		} catch (SQLException | NamingException e) {
			throw new RuntimeException(e);
		} finally {
			JdbcUtil.close(conn);
		}
	}
	
	public CouponDTO getCouponInfo(int couponNo) {
		Connection conn = null;
		try {
			conn = ConnectionProvider.getConnection();
			return couponDAO.selectCouponInfo(couponNo, conn);
		} catch (SQLException | NamingException e) {
			throw new RuntimeException(e);
		} finally {
			JdbcUtil.close(conn);
		}
	}
	
    public List<CouponDTO> getCouponInfosByMemberNo(int memberNo) {
        List<HaveCouponDTO> haveCoupons = getCouponsByMemberNo(memberNo);
        List<CouponDTO> coupons = new ArrayList<>();

        for (HaveCouponDTO haveCoupon : haveCoupons) {
            CouponDTO coupon = getCouponInfo(haveCoupon.getCoupon_no());
            if (coupon != null) {
                coupons.add(coupon);
            }
        }

        return coupons;
    }

}//class
