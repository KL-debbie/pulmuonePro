package servlets.coupon.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@Data
@Builder
@NoArgsConstructor
public class HaveCouponDTO {

	private int coupon_no;
	private int member_no; 
	private Date issue_date;
	private Date expiry_date;
	private int used;
	private int box_pay_no;
	private int drk_pay_no;
	
}
