package servlets.order.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BoxOrderProductDTO {
	
	private String productsNo;
	private int categoryNo;
	private String productsName;
	private String productsCnt;
	private String productsType;
	private String productsSize;
	private int price;
	private int eventPrice;
	private String imgPath;
	private String originName;
	private String TrackingNo;
	private String productsTag;
	
}