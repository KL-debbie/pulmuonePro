package servlets.notice.command;

import java.io.File;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.oreilly.servlet.multipart.FileRenamePolicy;

import mvc.command.CommandHandler;
import net.sf.json.JSONObject;
import servlets.notice.model.NoticeImageDTO;

public class NoticeImageUpload implements CommandHandler{

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String saveDirectory = request.getRealPath("/upload/notice/");
		
		File f = new File(saveDirectory);
	  	if( !f.exists() ) {
	  		f.mkdirs();
	  	}
	  	int maxPostSize = 5 * 1024 * 1024; // 5MB  기본단위 바이트
	  	String encoding = "UTF-8";
	  	FileRenamePolicy policy = new DefaultFileRenamePolicy(); // 파일 중복 처리 _1, _2, 로 생성해줌
	  	
	  	MultipartRequest multiRequest = new MultipartRequest(
	  				request, saveDirectory, maxPostSize, encoding, policy
	  			);
	  	
	  	File file = multiRequest.getFile("upload");
	  	String realPath = request.getServletContext().getRealPath("/upload/notice");
	  	if( file != null ) {
	  		String fileSystemName = multiRequest.getFilesystemName("upload");
	  		String originName = multiRequest.getOriginalFileName("upload");
	  		String img_size = String.valueOf( file.length() );
	  		String img_type = originName.substring(originName.lastIndexOf(".")+1);
	  		
	  		NoticeImageDTO dto = new NoticeImageDTO(0, 0, fileSystemName, originName, img_size, img_type, saveDirectory);
	  		System.out.println(fileSystemName);
	  		System.out.println(originName);
	  		System.out.println(img_size);
	  		System.out.println(img_type);
	  		
			
	  	}
	  	
	  	////*
	  	//request.setCharacterEncoding("UTF-8");
		//String path = "/upload"; // 개발자 지정 폴더
		//String real_save_path = request.getServletContext().getRealPath(path);
		//MultipartRequest multi = new MultipartRequest(request, real_save_path, maxRequestSize, "UTF-8", new DefaultFileRenamePolicy());
		//String fileName = multi.getOriginalFileName("upload"); // ckeditor5 static const
		//JSONObject outData = new JSONObject();
		//outData.put("uploaded", true);
		//outData.put("url", request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + realPath + "/" + originName);
		//response.setContentType("application/json");
		//response.setCharacterEncoding("UTF-8");
		//response.getWriter().print(outData.toString());
		


	  	
	  	
	  	System.out.println("-------");
	  	System.out.println( file );
		System.out.println("upload..");
		return realPath;
		
		
		
	}

}
