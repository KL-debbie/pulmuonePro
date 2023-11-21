package servlets.coupon.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@Data
@Builder
@NoArgsConstructor
public class CouponDTO {

	private int coupon_no;
	private String coupon_name; 
	private double discount;
	private int delivery_type;
	private int duplication;
	private int use_month;
	private int min_price;
	private int max_discount;
	
}
