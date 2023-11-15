package servlets.utils;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class PageDTO {
	private int currentPage = 1;
	private int numberPerPage = 10;
	private int numberOfPageBlock = 10;
	private int totalPages;
	private int start;
	private int end;
	private boolean prev;
	private boolean next;
	
	public PageDTO(int currentPage, int numberPerPage, int numberOfPageBlock, int totalPages) {
		super();
		this.currentPage = currentPage;
		this.numberPerPage = numberPerPage;
		this.numberOfPageBlock = numberOfPageBlock;
		this.totalPages = totalPages;
		
		// 시작 번호, 끝 번호
		start = (currentPage -1) /numberOfPageBlock * numberOfPageBlock +1 ;
		end = start + numberOfPageBlock -1;         
		end = end > totalPages ? totalPages : end;
		
		if( start != 1 ) prev = true;          
		if( end != totalPages ) next = true;
	}
	
	
}
