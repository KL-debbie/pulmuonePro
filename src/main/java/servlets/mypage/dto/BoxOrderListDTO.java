package servlets.mypage.dto;

import java.util.ArrayList;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import servlets.order.domain.BoxOrderProductDTO;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BoxOrderListDTO {
	
	private int boxOrderNo;
	private String boxOrderDate;
	private int boxOrderStatus;
	private ArrayList<BoxOrderProductDTO> productList;
	
}