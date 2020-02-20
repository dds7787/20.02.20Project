package guest;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import guest.dao.GuestDAO;
import guest.dto.GuestDTO;



/*@WebServlet("/")*/
public class GuestController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public GuestController() {
        super();
       
    }

	
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws
	ServletException, IOException {
		
		String url=request.getRequestURL().toString();
		System.out.println(url);
		String contextPath=request.getContextPath();
		GuestDAO dao=new GuestDAO();
		if(url.indexOf("list.do") != -1) {
			//검색옵션과 검색키워드
			String searchkey=request.getParameter("searchkey");
			String search=request.getParameter("search");
			
			if(searchkey==null) searchkey="name";
			if(search==null) search="";
			
			System.out.println("searchkey:"+searchkey);
			System.out.println("search:"+search);
			
			List<GuestDTO> items=dao.getList(searchkey,search);//방명록 리스트
			request.setAttribute("list", items);
			request.setAttribute("count", items.size());//레코드갯수
			
			request.setAttribute("searchkey", searchkey);
			request.setAttribute("search", search);
			
			//방명록이 list.jsp에 출력
			String page="/guest/list.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		}else if(url.indexOf("insert.do") != -1) {
			String name=request.getParameter("name");
			String email=request.getParameter("email");
			String passwd=request.getParameter("passwd");
			String content=request.getParameter("content");
			GuestDTO dto=new GuestDTO();
			dto.setName(name);
			dto.setEmail(email);
			dto.setPasswd(passwd);
			dto.setContent(content);
			dao.gbInsert(dto);//dao에 레코드 추가 요청
			//방명록 목록 갱신
			String page="/guest_servlet/list.do";
			response.sendRedirect(contextPath+page);
		}else if(url.indexOf("passwd_check.do") != -1) {
			int idx=Integer.parseInt(request.getParameter("idx"));
			String passwd=request.getParameter("passwd");
			System.out.println("게시물번호:"+idx);
			System.out.println("사용자가 입력한 비번:"+passwd);
			boolean result=dao.passwdCheck(idx, passwd);
			//비번이 맞으면 true 틀리면 false 값이 리턴됨
			System.out.println("결과:"+result);
			String uri="";
			if(result) {
				url="/guest/edit.jsp";//수정용 출력페이지
				//게시물 내용을 dto로 리턴받음
				GuestDTO dto=dao.gbDetail(idx);
				request.setAttribute("dto", dto);
			}else {
				url="/guest_servlet/list.do";
			}
			//화면 이동
			RequestDispatcher rd=request.getRequestDispatcher(url);
			rd.forward(request, response);
		}else if(url.indexOf("update.do") != -1) {
			int idx=Integer.parseInt(request.getParameter("idx"));
			String name=request.getParameter("name");
			String email=request.getParameter("email");
			String passwd=request.getParameter("passwd");
			String content=request.getParameter("content");
			GuestDTO dto=new GuestDTO();
			dto.setIdx(idx);
			dto.setName(name);
			dto.setEmail(email);
			dto.setPasswd(passwd);
			dto.setContent(content);
			dao.gbUpdate(dto);
			//처리가 끝난 후 list등 edit으로든 정해서 가야한다.
			String page="/guest_servlet/list.do";
			response.sendRedirect(contextPath+page);
		}else if(url.indexOf("delete.do") != -1) {
			int idx=Integer.parseInt(request.getParameter("idx"));
			//레코드 삭제
			dao.gbDelete(idx);
			//목록으로 이동
			String page="/guest_servlet/list.do";
			response.sendRedirect(contextPath+page);
		}
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
