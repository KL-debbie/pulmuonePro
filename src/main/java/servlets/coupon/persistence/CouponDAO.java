package servlets.coupon.persistence;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

import servlets.coupon.domain.CouponDTO;
import servlets.coupon.domain.HaveCouponDTO;

public interface CouponDAO {

	ArrayList<HaveCouponDTO> selectCoupon(int memberNo, Connection conn);

	CouponDTO selectCouponInfo(int couponNo, Connection conn);

}
