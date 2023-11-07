package curation.domain;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@Data
@NoArgsConstructor
public class KidsResultDTO {

	   private int program_no;         		// 프로그램번호
	   private int img_no;     	 				// 이미지 번호
	   private String program_name;      	// 프로그램명
	   private String day_week;      		// 요일
	   private String products_no;      		// 상품번호
	   private String products_name;      	// 상품명
	   private String program_content;    	// 프로그램 내용

}

