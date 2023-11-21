package servlets.mypage.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BoxOrderSimpleInfoDTO {

	private int orderNo;
	private String productsName;
	private int finalPrice;
	private int boxOrderStatus;
	private String boxOrderDate;
}