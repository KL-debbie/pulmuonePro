package servlets.order.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BoxPayDTO {
	
	private int boxPayNo;
	private int boxOrderNo;
	private String boxPayDateTime;
	private int boxPrice;
	private int boxSalePrice;
	private int boxDiscountPrice;
	private int boxShippingFee;
	private int boxFinalPrice;
	private int boxPayMethod;
	private int boxPayStatus;
	
}