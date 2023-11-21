package servlets.coupon.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import jdbc.JdbcUtil;
import servlets.coupon.domain.CouponDTO;
import servlets.coupon.domain.HaveCouponDTO;

public class CouponDAOImpl implements CouponDAO {

	// 쿠폰 확인
	@Override
	public ArrayList<HaveCouponDTO> selectCoupon(int memberNo, Connection conn) {
		ArrayList<HaveCouponDTO> coupons = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			String sql = "SELECT * FROM have_coupon WHERE member_no = ? ORDER BY used ASC";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, memberNo);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				HaveCouponDTO coupon = new HaveCouponDTO();
				coupon.setCoupon_no(rs.getInt("coupon_no"));
				coupon.setMember_no(rs.getInt("member_no"));
				coupon.setIssue_date(rs.getDate("issue_date"));
				coupon.setExpiry_date(rs.getDate("expiry_date"));
				coupon.setUsed(rs.getInt("used"));
				coupon.setBox_pay_no(rs.getInt("box_pay_no"));
				coupon.setDrk_pay_no(rs.getInt("drk_pay_no"));
				coupons.add(coupon);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(pstmt);
			JdbcUtil.close(rs);
		}

		return coupons;
	}

	@Override
	public CouponDTO selectCouponInfo(int couponNo, Connection conn) {
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    CouponDTO coupon = null;
	    
	    try {
	        String sql = "SELECT * FROM coupon WHERE coupon_no = ?";
	        
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, couponNo);
	        rs = pstmt.executeQuery();
	        
	        if (rs.next()) {
	            coupon = new CouponDTO();
	            coupon.setCoupon_no(rs.getInt("coupon_no"));
	            coupon.setCoupon_name(rs.getString("coupon_name"));
	            coupon.setDiscount(rs.getDouble("discount"));
	            coupon.setDelivery_type(rs.getInt("delivery_type"));
	            coupon.setDuplication(rs.getInt("duplication"));
	            coupon.setUse_month(rs.getInt("use_month"));
	            coupon.setMin_price(rs.getInt("min_price"));
	            coupon.setMax_discount(rs.getInt("max_discount"));
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        JdbcUtil.close(pstmt);
	        JdbcUtil.close(rs);
	    }
	    
	    return coupon;
	}

}

