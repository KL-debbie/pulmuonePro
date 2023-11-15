package servlets.curation.domain;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@Data
@NoArgsConstructor
public class CurationDTO {

	private int curation_no;
	private int program_no;         		// 프로그램번호
	private int img_no;	     	 			// 작성자
	private String program_name;      	// 프로그램명
	private String dayweek;      		// 요일
	private String products_no;      		// 상품번호
	private String products_name;      	// 상품명
	private String program_content;    	// 프로그램 내용
	private String lifestyle_change01;  // 저체중
	private String lifestyle_change02;  // 정상
	private String lifestyle_change03;  // 비만
	private String System_name;
	private int price;
	private int products_tag;
	private String Products_size;
	private String Products_sub_name;
}