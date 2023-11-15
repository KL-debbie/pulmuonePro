package servlets.inquiry.model;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class InquiryDTO {
	/*
		INQUIRY_NO   NOT NULL NUMBER       
		MEMBER_ID             VARCHAR2(15) 
		INQUIRY_CATE NOT NULL VARCHAR2(30) 
		EMAIL        NOT NULL VARCHAR2(40) 
		TITLE        NOT NULL VARCHAR2(90) 
		CONTENT      NOT NULL CLOB         
		REGDATE      NOT NULL DATE         
		STATUS       NOT NULL CHAR(1)      
	 */
	private int inquiry_no;
	private String member_id;
	private String inquiry_cate;
	private String email;
	private String title;
	private String content;
	private Date regdate;
	private String status;
	
}
