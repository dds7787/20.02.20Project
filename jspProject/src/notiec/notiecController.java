package notiec;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import common.Constants;
import notiec.dao.notiecDAO;
import notiec.dto.notiecCommentDTO;
import notiec.dto.notiecDTO;
import page.Pager;


//@WebServlet("/")
public class notiecController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public notiecController() {
        super();
    }

	
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws
	ServletException, IOException {
		
		String url=request.getRequestURL().toString();
		String contextPath=request.getContextPath();
		notiecDAO dao=new notiecDAO();
		if(url.indexOf("list.do") != -1) {
			int count=dao.count();
			int curPage=1;
			if(request.getParameter("curPage") != null) {
				curPage=Integer.parseInt(request.getParameter("curPage"));
			}
			Pager pager=new Pager(count, curPage);
			int start=pager.getPageBegin();
			int end=pager.getPageEnd();
			
			//System.out.println("list.do 호출");
			List<notiecDTO> list=dao.list(start,end);
			request.setAttribute("list", list);
			request.setAttribute("page", pager);
			
			String page="/notice/list.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		}else if(url.indexOf("insert.do") != -1) {
			//파일업로드 처리
			File uploadDir=new File(Constants.UPLOAD_PATH);
			if(!uploadDir.exists()) {
				uploadDir.mkdir();
			}
			MultipartRequest multi=new MultipartRequest(request,
					Constants.UPLOAD_PATH, Constants.MAX_UPLOAD, "utf-8", 
					new DefaultFileRenamePolicy());
			String writer=multi.getParameter("writer");
			String subject=multi.getParameter("subject");
			String content=multi.getParameter("content");
			String passwd=multi.getParameter("passwd");
			String ip=request.getRemoteAddr();
			notiecDTO dto=new notiecDTO();
			dto.setWriter(writer);
			dto.setSubject(subject);
			dto.setContent(content);
			dto.setPasswd(passwd);
			dto.setIp(ip);
			dao.insert(dto);
			String page="/notiec_servlet/listlog.do";
			response.sendRedirect(contextPath+page);
		}else if(url.indexOf("download.do") != -1) {
			int num=Integer.parseInt(request.getParameter("num"));
			String filename=dao.getFileName(num);
			System.out.println("첨부파일 이름:"+filename);
			
			//다운로드할 파일 경로
			String path=Constants.UPLOAD_PATH+filename;
			byte b[]=new byte[4096];//바이트배열 생성
			FileInputStream fis=new FileInputStream(path);
			String mimeType=getServletContext().getMimeType(path);
			if(mimeType==null) {
				mimeType="application/octet-stream;charset=utf-8";
			}
			filename = 
					new String(filename.getBytes("utf-8"),"8859_1");
			response.setHeader("Content-Disposition", 
					"attachment;filename="+filename);
			ServletOutputStream out=response.getOutputStream();
			int numRead;
			while(true) {
				numRead = fis.read(b,0,b.length);//데이터 읽음
				if(numRead == -1) break; //더 이상 내용이 없으면
				out.write(b,0,numRead);//데이터 쓰기
			}
			out.flush();
			out.close();
			fis.close();
			dao.plusDown(num);
		}else if(url.indexOf("view.do") != -1) {
			int num=Integer.parseInt(request.getParameter("num"));
			System.out.println(num);
			HttpSession session=request.getSession();
			//조회수 증가 처리
			dao.plusReadCount(num, session);
			notiecDTO dto=dao.viewReplace(num);
			//BoardDTO dto=dao.view(num);
			request.setAttribute("dto", dto);
			String page="/notice/view.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		}else if(url.indexOf("commentList.do") != -1) {
			int num=Integer.parseInt(request.getParameter("num"));
			System.out.println("댓글을 위한 게시물번호:"+num);
			//댓글 목록 리턴
			List<notiecCommentDTO> list=dao.commentList(num);
			request.setAttribute("list", list);
			String page="/notice/comment_list.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		}else if(url.indexOf("comment_add.do") != -1) {
			notiecCommentDTO dto =new notiecCommentDTO();
			//게시물 번호
			int notiec_num=Integer.parseInt(request.getParameter("notiec_num"));
			String writer=request.getParameter("writer");
			String content=request.getParameter("content");
			dto.setNotiec_num(notiec_num);
			dto.setWriter(writer);
			dto.setContent(content);
			dao.commentAdd(dto);
		}else if(url.indexOf("reply.do") != -1) {
			int num=Integer.parseInt(request.getParameter("num"));
			notiecDTO dto=dao.view(num);
			dto.setContent("===게시물의 내용==\n"+dto.getContent());
			request.setAttribute("dto", dto);
			String page="/notice/reply.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		}else if(url.indexOf("insertReply.do") != -1) {
			int num=Integer.parseInt(request.getParameter("num"));
			notiecDTO dto=dao.view(num);
			int ref=dto.getRef();
			int re_step=dto.getRe_step()+1;
			int re_level=dto.getRe_level()+1;
			String writer=request.getParameter("writer");
			String subject=request.getParameter("subject");
			String content=request.getParameter("content");
			String passwd=request.getParameter("passwd");
			dto.setWriter(writer);
			dto.setSubject(subject);
			dto.setContent(content);
			dto.setPasswd(passwd);
			dto.setRef(ref);
			dto.setRe_level(re_level);
			dto.setRe_step(re_step);
			dao.updateStep(ref, re_step);
			//답글 쓰기
			dao.reply(dto);
			String page="/notiec_servlet/list.do";
			response.sendRedirect(contextPath+page);
		}else if(url.indexOf("pass_check.do") != -1) {
			int num=Integer.parseInt(request.getParameter("num"));
			String passwd=request.getParameter("passwd");
			String result=dao.passwdCheck(num,passwd);
			String page="";
			if(result != null) {//비밀번호가 맞으면
				page="/notice/edit.jsp";
				request.setAttribute("dto", dao.view(num));
				RequestDispatcher rd=request.getRequestDispatcher(page);
				rd.forward(request, response);
			}else {//비밀번호가틀리면
				page=contextPath+"/notiec_servlet/view.do?num="+num+"&message=error";
				response.sendRedirect(page);
			}//else
		}else if(url.indexOf("update.do") != -1) {
			File uploadDir=new File(Constants.UPLOAD_PATH);
			if(!uploadDir.exists()) {//업로드디렉토리가 존재하지 않으면
				uploadDir.mkdir();//디렉토리를 만듦
			}
			MultipartRequest multi=new MultipartRequest(request,
					Constants.UPLOAD_PATH, Constants.MAX_UPLOAD, "utf-8", 
					new DefaultFileRenamePolicy());
			int num=Integer.parseInt(multi.getParameter("num"));
			String writer=multi.getParameter("writer");
			String subject=multi.getParameter("subject");
			String content=multi.getParameter("content");
			String passwd=multi.getParameter("passwd");
			String ip=request.getRemoteAddr();
			
			notiecDTO dto=new notiecDTO();
		    dto.setNum(num);
			dto.setWriter(writer);
			dto.setSubject(subject);
			dto.setContent(content);
			dto.setPasswd(passwd);
			dto.setIp(ip);
			//레코드 수정
			dao.update(dto);
			String page="/notiec_servlet/list.do";
			response.sendRedirect(contextPath+page);
		}else if(url.indexOf("delete.do") != -1) {
			MultipartRequest multi=new MultipartRequest(request,
					Constants.UPLOAD_PATH, Constants.MAX_UPLOAD, 
					"utf-8", new DefaultFileRenamePolicy());
			int num=Integer.parseInt(multi.getParameter("num"));
			dao.delete(num);
			String page="/notiec_servlet/list.do";
			response.sendRedirect(contextPath+page);	
		}else if(url.indexOf("search.do") != -1) {
			String search_option=request.getParameter("search_option");
			String keyword=request.getParameter("keyword");
			
			List<notiecDTO> list=dao.searchList(search_option,keyword);
			request.setAttribute("list", list);
			request.setAttribute("search_option", search_option);
			request.setAttribute("keyword", keyword);
			String page="/notiec/search.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		}else if(url.indexOf("listlog.do") != -1) {
			int count=dao.count();
			int curPage=1;
			if(request.getParameter("curPage") != null) {
				curPage=Integer.parseInt(request.getParameter("curPage"));
			}
			Pager pager=new Pager(count, curPage);
			int start=pager.getPageBegin();
			int end=pager.getPageEnd();
			
			//System.out.println("list.do 호출");
			List<notiecDTO> list=dao.list(start,end);
			request.setAttribute("list", list);
			request.setAttribute("page", pager);
			
			String page="/notice/listlog.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		}else if(url.indexOf("delete2.do") != -1) {
			MultipartRequest multi=new MultipartRequest(request,
					Constants.UPLOAD_PATH, Constants.MAX_UPLOAD, 
					"utf-8", new DefaultFileRenamePolicy());
			int num=Integer.parseInt(multi.getParameter("num"));
			dao.delete2(num);
			String page="/notiec_servlet/view.do";
			response.sendRedirect(contextPath+page);
		}else if(url.indexOf("update2.do") != -1) {
			File uploadDir=new File(Constants.UPLOAD_PATH);
			if(!uploadDir.exists()) {//업로드디렉토리가 존재하지 않으면
				uploadDir.mkdir();//디렉토리를 만듦
			}
			MultipartRequest multi=new MultipartRequest(request,
					Constants.UPLOAD_PATH, Constants.MAX_UPLOAD, "utf-8", 
					new DefaultFileRenamePolicy());
			int num=Integer.parseInt(multi.getParameter("num"));
			String writer=multi.getParameter("writer");
			String subject=multi.getParameter("subject");
			String content=multi.getParameter("content");
			String passwd=multi.getParameter("passwd");
			String ip=request.getRemoteAddr();
			
			notiecDTO dto=new notiecDTO();
		    dto.setNum(num);
			dto.setWriter(writer);
			dto.setSubject(subject);
			dto.setContent(content);
			dto.setPasswd(passwd);
			dto.setIp(ip);
			//레코드 수정
			dao.update2(dto);
			String page="/notiec_servlet/view.do";
			response.sendRedirect(contextPath+page);
		}else if(url.indexOf("listlog.do") != -1) {
			int count=dao.count();
			int curPage=1;
			if(request.getParameter("curPage") != null) {
				curPage=Integer.parseInt(request.getParameter("curPage"));
			}
			Pager pager=new Pager(count, curPage);
			int start=pager.getPageBegin();
			int end=pager.getPageEnd();
			
			//System.out.println("list.do 호출");
			List<notiecDTO> list=dao.list(start,end);
			request.setAttribute("list", list);
			request.setAttribute("page", pager);
			
			String page="/notice/listlog.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		}else if(url.indexOf("viewlog.do") != -1) {
			int num=Integer.parseInt(request.getParameter("num"));
			System.out.println(num);
			HttpSession session=request.getSession();
			//조회수 증가 처리
			dao.plusReadCount(num, session);
			notiecDTO dto=dao.viewReplace(num);
			//BoardDTO dto=dao.view(num);
			request.setAttribute("dto", dto);
			String page="/notice/viewlog.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		}else if(url.indexOf("insertReplylog.do") != -1) {
			int num=Integer.parseInt(request.getParameter("num"));
			notiecDTO dto=dao.view(num);
			int ref=dto.getRef();
			int re_step=dto.getRe_step()+1;
			int re_level=dto.getRe_level()+1;
			String writer=request.getParameter("writer");
			String subject=request.getParameter("subject");
			String content=request.getParameter("content");
			String passwd=request.getParameter("passwd");
			dto.setWriter(writer);
			dto.setSubject(subject);
			dto.setContent(content);
			dto.setPasswd(passwd);
			dto.setRef(ref);
			dto.setRe_level(re_level);
			dto.setRe_step(re_step);
			dao.updateStep(ref, re_step);
			//답글 쓰기
			dao.reply(dto);
			String page="/notiec_servlet/listlog.do";
			response.sendRedirect(contextPath+page);
		}else if(url.indexOf("replylog.do") != -1) {
			int num=Integer.parseInt(request.getParameter("num"));
			notiecDTO dto=dao.view(num);
			dto.setContent("===게시물의 내용==\n"+dto.getContent());
			request.setAttribute("dto", dto);
			String page="/notice/replylog.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		}else if(url.indexOf("pass_checklog.do") != -1) {
			int num=Integer.parseInt(request.getParameter("num"));
			String passwd=request.getParameter("passwd");
			String result=dao.passwdCheck(num,passwd);
			String page="";
			if(result != null) {//비밀번호가 맞으면
				page="/notice/editlog.jsp";
				request.setAttribute("dto", dao.view(num));
				RequestDispatcher rd=request.getRequestDispatcher(page);
				rd.forward(request, response);
			}else {//비밀번호가틀리면
				page=contextPath+"/notiec_servlet/viewlog.do?num="+num+"&message=error";
				response.sendRedirect(page);
			}//else
		}else if(url.indexOf("updatelog.do") != -1) {
			File uploadDir=new File(Constants.UPLOAD_PATH);
			if(!uploadDir.exists()) {//업로드디렉토리가 존재하지 않으면
				uploadDir.mkdir();//디렉토리를 만듦
			}
			MultipartRequest multi=new MultipartRequest(request,
					Constants.UPLOAD_PATH, Constants.MAX_UPLOAD, "utf-8", 
					new DefaultFileRenamePolicy());
			int num=Integer.parseInt(multi.getParameter("num"));
			String writer=multi.getParameter("writer");
			String subject=multi.getParameter("subject");
			String content=multi.getParameter("content");
			String passwd=multi.getParameter("passwd");
			String ip=request.getRemoteAddr();
			
			notiecDTO dto=new notiecDTO();
		    dto.setNum(num);
			dto.setWriter(writer);
			dto.setSubject(subject);
			dto.setContent(content);
			dto.setPasswd(passwd);
			dto.setIp(ip);
			//레코드 수정
			dao.update(dto);
			String page="/notiec_servlet/listlog.do";
			response.sendRedirect(contextPath+page);
		}else if(url.indexOf("deletelog.do") != -1) {
			MultipartRequest multi=new MultipartRequest(request,
					Constants.UPLOAD_PATH, Constants.MAX_UPLOAD, 
					"utf-8", new DefaultFileRenamePolicy());
			int num=Integer.parseInt(multi.getParameter("num"));
			dao.delete(num);
			String page="/notiec_servlet/listlog.do";
			response.sendRedirect(contextPath+page);
		}
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
