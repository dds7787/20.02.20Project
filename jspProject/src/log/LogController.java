package log;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import common.Constants;
import log.dao.LoginDAO;
import log.dto.LoginDTO;

public class LogController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public LogController() {
        super();
        
    }

	
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws
	ServletException, IOException {
		String url=request.getRequestURL().toString();
		String contextPath=request.getContextPath();
		LoginDAO dao=new LoginDAO();
		if(url.indexOf("join.do") != -1) { //BCrypt방식회원가입
			String userid=request.getParameter("userid");
			String passwd=request.getParameter("passwd");
			String name=request.getParameter("name");
			String email=request.getParameter("email");
			String hp=request.getParameter("hp");
			LoginDTO dto=new LoginDTO();//MemberDTO 생성
			dto.setUserid(userid);
			dto.setPasswd(passwd);
			dto.setName(name);
			dto.setEmail(email);
			dto.setHp(hp);
			dao.insert(dto);
			
			String page="/drama_servlet/list.do";
		    RequestDispatcher rd=request.getRequestDispatcher(page);
		    rd.forward(request,response);
			 
			 
			 
		}else if(url.indexOf("log_bcrypt.do") != -1) {//암호화로그인기능
			String userid=request.getParameter("userid");
			String passwd=request.getParameter("passwd");
			System.out.println("아이디:"+userid);
			System.out.println("패스워드:"+passwd);
			LoginDTO dto=new LoginDTO();
			dto.setUserid(userid);
			dto.setPasswd(passwd);
			String result=dao.loginCheck(dto);
			System.out.println(result);
			/* request.setAttribute("result", result); */
			String page="/drama_servlet/list.do";
			/*
			 * RequestDispatcher rd= request.getRequestDispatcher(page); 
			 * rd.forward(request,response);
			 */
			//
			if(!result.equals("로그인 실패")) {//로그인 성공
				HttpSession session=request.getSession();
				session.setAttribute("userid", userid);
				session.setAttribute("message", result);
				page="/log_servlet/list.do";
				response.sendRedirect(request.getContextPath()+page);
			}else {//로그인 실패
				response.sendRedirect(request.getContextPath()
						+page+"?message=error");
			}
		   }else if(url.indexOf("logout.do") != -1) {//로그아웃 처리
			HttpSession session=request.getSession();
			session.invalidate();
			String page=request.getContextPath()
					+"/drama_servlet/list.do?message=logout";
			response.sendRedirect(page);
	       }else if(url.indexOf("view.do") != -1) {
				String userid=request.getParameter("userid");
				System.out.println("클릭한 아이디 : "+userid);
				LoginDTO dto=dao.logDetail(userid);
				request.setAttribute("dto", dto);
				String page="/log/log_view.jsp";
				RequestDispatcher rd= request.getRequestDispatcher(page);
				rd.forward(request, response);
	       }else  if(url.indexOf("update.do") != -1) {//수정
	        String userid=request.getParameter("userid");
			String passwd=request.getParameter("passwd");
			String name=request.getParameter("name");
			String email=request.getParameter("email");
			String hp=request.getParameter("hp");
			LoginDTO dto=new LoginDTO();//DTO 생성
			dto.setUserid(userid);
			dto.setPasswd(passwd);
			dto.setName(name);
			dto.setEmail(email);
			dto.setHp(hp);
			dao.update(dto);
			//페이지 이동
			response.sendRedirect(contextPath+"/log_servlet/list.do");
		}else if(url.indexOf("delete.do") != -1) {//삭제
			String userid=request.getParameter("userid");
			//레코드 삭제처리
			dao.delete(userid);
			//페이지 이동
			response.sendRedirect(contextPath+"/log_servlet/list.do");
		}else if(url.indexOf("list.do") != -1) {//member_servlet/list.do
			System.out.println("list.do호출....");
			System.out.println(request.getRequestURI());
			System.out.println(url.indexOf("list.do"));
			
		    //HashMap 생성
			Map<String,Object> map=new HashMap<>();
			List<LoginDTO> list=dao.logList();
			map.put("list", list);
			//ArrayList에 담겨진 레코드의 갯수로 저장
			map.put("count", list.size());
			
			//최종적으로map담긴 값을 setAttribute에 저장
			request.setAttribute("map", map);
			//출력을 위해 포워딩할 uri를 지정
			//String page="/ch06/member_list.jsp"; //기존
			String page="/log/loglist.jsp";  //변경
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);//포워딩
		}else if(url.indexOf("log_bcrypt2.do") != -1) {//암호화로그인기능
			String userid=request.getParameter("userid");
			String passwd=request.getParameter("passwd");
			System.out.println("아이디:"+userid);
			System.out.println("패스워드:"+passwd);
			LoginDTO dto=new LoginDTO();
			dto.setUserid(userid);
			dto.setPasswd(passwd);
			String result=dao.loginCheck(dto);
			System.out.println(result);
			/* request.setAttribute("result", result); */
			String page="/drama_servlet/list.do";
			/*
			 * RequestDispatcher rd= request.getRequestDispatcher(page); 
			 * rd.forward(request,response);
			 */
			//
			if(!result.equals("로그인 실패")) {//로그인 성공
				HttpSession session=request.getSession();
				session.setAttribute("userid", userid);
				session.setAttribute("message", result);
				page="/notiec_servlet/listlog.do";
				response.sendRedirect(request.getContextPath()+page);
			}else {//로그인 실패
				response.sendRedirect(request.getContextPath()
						+page+"?message=error");
			}
	 }
		
}
	

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
