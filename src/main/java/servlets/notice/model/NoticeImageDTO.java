package servlets.notice.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class NoticeImageDTO {
	/*
	 	IMG_NO      NOT NULL NUMBER        
		NOTICE_NO   NOT NULL NUMBER        
		SYSTEM_NAME NOT NULL VARCHAR2(100) 
		ORIGIN_NAME NOT NULL VARCHAR2(100) 
		IMG_SIZE    NOT NULL VARCHAR2(10)  
		IMG_TYPE    NOT NULL VARCHAR2(10)  
		IMG_PATH    NOT NULL VARCHAR2(200)
	 */
	private int img_no;     
	private int notice_no;  
	private String system_name;
	private String origin_name;
	private String img_size;
	private String img_type;  
	private String img_path;  
	
}
