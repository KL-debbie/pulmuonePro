package servlets.faq.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class FaqDTO {
	private int q_no;
	private int faq_no;
	private String question;
	private String answer;
}
