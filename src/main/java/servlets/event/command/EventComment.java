package servlets.event.command;

import java.net.URLDecoder;
import java.sql.Connection;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import auth.AuthInfo;
import jdbc.connection.ConnectionProvider;
import mvc.command.CommandHandler;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import servlets.event.domain.EventCommentDTO;
import servlets.event.persistence.EventCommentDAO;

public class EventComment implements CommandHandler{

    private EventCommentDAO commentDAO = new EventCommentDAO();

    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {

        String method = request.getMethod(); // GET, POST

        if (method.equals("GET")) {

            int event_no = Integer.parseInt(request.getParameter("event_no"));
            int currentPage = request.getParameter("currentPage") != null ? Integer.parseInt(request.getParameter("currentPage")) : 1;
            int numberPerPage = 10;

            JSONObject jsonResponse = new JSONObject();
            JSONArray jsonCommentArr = new JSONArray();

            try (Connection conn = ConnectionProvider.getConnection()) {
                List<EventCommentDTO> comments = commentDAO.selectList(conn, event_no, currentPage, numberPerPage);

                for (EventCommentDTO comment : comments) {
                    JSONObject jsonComment = new JSONObject();
                    jsonComment.put("comment_no", comment.getComment_no());
                    jsonComment.put("event_no", comment.getEvent_no());
                    jsonComment.put("member_no", comment.getMember_no());
                    jsonComment.put("write_date", comment.getWrite_date().toString());
                    jsonComment.put("content", comment.getContent());
                    jsonComment.put("name", comment.getName());

                    jsonCommentArr.add(jsonComment);
                }

                int totalComments = commentDAO.selectCount(conn, event_no);
                int totalPages = (int) Math.ceil((double) totalComments / numberPerPage);

                jsonResponse.put("comments", jsonCommentArr);
                jsonResponse.put("totalComments", totalComments);
                jsonResponse.put("totalPages", totalPages);
                jsonResponse.put("currentPage", currentPage);
            }

            response.setContentType("application/json; charset=utf-8");
            response.getWriter().write(jsonResponse.toString());

        } else { // POST
        	
        	int event_no = Integer.parseInt(request.getParameter("event_no"));
        	String content = URLDecoder.decode(request.getParameter("content"), "UTF-8");

        	// 세션에서 사용자 정보 가져오기
        	HttpSession session = request.getSession();
        	AuthInfo authInfo = (AuthInfo) session.getAttribute("auth");

        	// 로그인 상태 확인
        	if (authInfo == null) {
        	    // 로그인이 되어 있지 않은 경우
        	    JSONObject jsonResponse = new JSONObject();
        	    jsonResponse.put("result", "not_logged_in");

        	    response.setContentType("application/json; charset=utf-8");
        	    response.getWriter().write(jsonResponse.toString());
        	} else {
        	    // 로그인이 되어 있는 경우
        	    EventCommentDTO commentDTO = new EventCommentDTO();
        	    commentDTO.setEvent_no(event_no);
        	    // 세션에서 가져온 사용자 정보에서 memberNo를 가져옴
        	    commentDTO.setMember_no(authInfo.getMemberNo());
        	    commentDTO.setContent(content);
        	    commentDTO.setName(authInfo.getName());

        	    try (Connection conn = ConnectionProvider.getConnection()) {
        	    	
        	    	 boolean isDuplicated = commentDAO.duplicateParticipation(conn, authInfo.getMemberNo(), event_no);
        	    	
        	    	 if (isDuplicated) {
        	            // 댓글이 이미 존재하는 경우
        	            JSONObject jsonResponse = new JSONObject();
        	            jsonResponse.put("result", "already_participated");

        	            response.setContentType("application/json; charset=UTF-8");
        	            response.getWriter().write(jsonResponse.toString());
        	        } else {
        	        	// 댓글이 존재하지 않는 경우, 댓글을 저장
        	        	int result = commentDAO.insert(conn, commentDTO);
        	        	
        	        	JSONObject jsonResponse = new JSONObject();
        	        	if(result > 0) {
        	        		jsonResponse.put("result", "success");
        	        	} else {
        	        		jsonResponse.put("result", "fail");
        	        	}
        	        	
        	        	response.setContentType("application/json; charset=UTF-8");
        	        	response.getWriter().write(jsonResponse.toString());
        	        	
        	        }
        	    }
        	    
        	}



        } // if

        return null; // JSON 응답을 직접 작성하므로 null을 반환
    }
}
