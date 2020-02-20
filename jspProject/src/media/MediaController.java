package media;

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
import media.DAO.MediaDAO;
import media.DTO.MediaCommentDTO;
import media.DTO.MediaDTO;
import page.Pager;


public class MediaController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws
	ServletException, IOException {
		
		String url=request.getRequestURL().toString();
		String contextPath=request.getContextPath();
		MediaDAO dao=new MediaDAO();
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
			List<MediaDTO> list=dao.list(start,end);
			request.setAttribute("list", list);
			request.setAttribute("page", pager);
			
			String page="/media/list.jsp";
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
			String ip=request.getRemoteAddr();//클라이언트의 ip주소
			String filename=" ";//공백 1개
			int filesize=0;
			try {
				//첨부파일의 집합
				Enumeration files=multi.getFileNames();
				while(files.hasMoreElements()) {
					//첨부파일의 이름
					String file1=(String)files.nextElement();
					filename=multi.getFilesystemName(file1);
					File f1=multi.getFile(file1);
					if(f1 != null) {
						filesize=(int)f1.length();//파일 사이즈 저장
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			MediaDTO dto=new MediaDTO();
			dto.setWriter(writer);
			dto.setSubject(subject);
			dto.setContent(content);
			dto.setPasswd(passwd);
			dto.setIp(ip);
			if(filename == null || filename.trim().equals("")) {
				filename="-";
			}
			dto.setFilename(filename);
			dto.setFilesize(filesize);
			
			dao.insert(dto);
			String page="/media_servlet/list.do";
			response.sendRedirect(contextPath+page);
		}else if(url.indexOf("download.do") != -1) {//현재사용하진않음
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
		}else if(url.indexOf("view1.do") != -1) {
			int num=Integer.parseInt(request.getParameter("num"));
			System.out.println(num);
			HttpSession session=request.getSession();
			//조회수 증가 처리
			dao.plusReadCount(num, session);
			MediaDTO dto=dao.viewReplace(num);
			//BoardDTO dto=dao.view(num);
			request.setAttribute("dto", dto);
			String page="/media/view.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		}else if(url.indexOf("commentList.do") != -1) {
			int num=Integer.parseInt(request.getParameter("num"));
			System.out.println("댓글을 위한 게시물번호:"+num);
			//댓글 목록 리턴
			List<MediaCommentDTO> list=dao.commentList(num);
			request.setAttribute("list", list);
			String page="/media/comment_list.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		}else if(url.indexOf("comment_add.do") != -1) {
			MediaCommentDTO dto =new MediaCommentDTO();
			//게시물 번호
			int media_num=Integer.parseInt(request.getParameter("media_num"));
			String writer=request.getParameter("writer");
			String content=request.getParameter("content");
			dto.setMedia_num(media_num);
			dto.setWriter(writer);
			dto.setContent(content);
			dao.commentAdd(dto);
		}else if(url.indexOf("reply.do") != -1) {
			int num=Integer.parseInt(request.getParameter("num"));
			MediaDTO dto=dao.view(num);
			dto.setContent("===게시물의 내용==\n"+dto.getContent());
			request.setAttribute("dto", dto);
			String page="/media/reply.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		}else if(url.indexOf("insertReply.do") != -1) {
			int num=Integer.parseInt(request.getParameter("num"));
			MediaDTO dto=dao.view(num);
			int ref=dto.getRef();//답변 그룹 번호
			int re_step=dto.getRe_step()+1;//출력순번
			int re_level=dto.getRe_level()+1;//답변 단계
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
			dto.setFilename("-");
			dto.setFilesize(0);
			dto.setDown(0);
			dao.updateStep(ref, re_step);
			//답글 쓰기
			dao.reply(dto);
			String page="/media_servlet/list.do";
			response.sendRedirect(contextPath+page);
		}else if(url.indexOf("pass_check.do") != -1) {
			//게시물 번호
			int num=Integer.parseInt(request.getParameter("num"));
			//비밀번호
			String passwd=request.getParameter("passwd");
			//비번 check
			String result=dao.passwdCheck(num,passwd);
			String page="";
			if(result != null) {//비밀번호가 맞으면
				page="/media/edit.jsp";
				request.setAttribute("dto", dao.view(num));
				RequestDispatcher rd=request.getRequestDispatcher(page);
				rd.forward(request, response);
			}else {//비밀번호가틀리면
				page=contextPath+"/media_servlet/view.do?num="+num+"&message=error";
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
			String ip=request.getRemoteAddr();//클라이언트의 ip주소
			String filename=" ";//공백 1개
			int filesize=0;
			try {
				Enumeration files=multi.getFileNames();
				while(files.hasMoreElements()) {
					String file1=(String)files.nextElement();
					filename=multi.getFilesystemName(file1);
					File f1=multi.getFile(file1);
					if(f1 != null) {
						filesize=(int)f1.length();//파일 사이즈 저장
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			MediaDTO dto=new MediaDTO();
		    dto.setNum(num);
			dto.setWriter(writer);
			dto.setSubject(subject);
			dto.setContent(content);
			dto.setPasswd(passwd);
			dto.setIp(ip);
			if(filename == null || filename.trim().equals("")) {
				MediaDTO dto2=dao.view(num);
				String fName=dto2.getFilename();
				int fSize=dto2.getFilesize();
				int fDown=dto2.getDown();
				dto.setFilename(fName);
				dto.setFilesize(fSize);
				dto.setDown(fDown);
			}else {
				dto.setFilename(filename);
				dto.setFilesize(filesize);
			}
			
			//첨부파일 삭제 처리  현재상용하진않음
			String fileDel=multi.getParameter("fileDel");
			if(fileDel != null && fileDel.equals("on")) {
				String fileName=dao.getFileName(num);
				File f=new File(Constants.UPLOAD_PATH+fileName);
				f.delete();//파일 삭제
				//첨부파일 정보를 지움
				dto.setFilename("-");
				dto.setFilesize(0);
				dto.setDown(0);
			}
			//레코드 수정
			dao.update(dto);
			String page="/media_servlet/list.do";
			response.sendRedirect(contextPath+page);
		}else if(url.indexOf("delete.do") != -1) {
			MultipartRequest multi=new MultipartRequest(request,
					Constants.UPLOAD_PATH, Constants.MAX_UPLOAD, 
					"utf-8", new DefaultFileRenamePolicy());
			//삭제할 게시물 번호
			int num=Integer.parseInt(multi.getParameter("num"));
			dao.delete(num);
			String page="/media_servlet/list.do";
			response.sendRedirect(contextPath+page);	
		}else if(url.indexOf("search.do") != -1) {
			String search_option=request.getParameter("search_option");
			String keyword=request.getParameter("keyword");
			
			List<MediaDTO> list=dao.searchList(search_option,keyword);
			request.setAttribute("list", list);
			request.setAttribute("search_option", search_option);
			request.setAttribute("keyword", keyword);
			String page="/media/search.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		}else if(url.indexOf("view2.do") != -1) {
			int num=Integer.parseInt(request.getParameter("num"));
			System.out.println(num);
			HttpSession session=request.getSession();
			//조회수 증가 처리
			dao.plusReadCount(num, session);
			MediaDTO dto=dao.viewReplace(num);
			//BoardDTO dto=dao.view(num);
			request.setAttribute("dto", dto);
			String page="/media/view2.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		}else if(url.indexOf("view3.do") != -1) {
			int num=Integer.parseInt(request.getParameter("num"));
			System.out.println(num);
			HttpSession session=request.getSession();
			dao.plusReadCount(num, session);
			MediaDTO dto=dao.viewReplace(num);
			//BoardDTO dto=dao.view(num);
			request.setAttribute("dto", dto);
			String page="/media/view3.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		}else if(url.indexOf("view4.do") != -1) {
			int num=Integer.parseInt(request.getParameter("num"));
			System.out.println(num);
			HttpSession session=request.getSession();
			dao.plusReadCount(num, session);
			MediaDTO dto=dao.viewReplace(num);
			//BoardDTO dto=dao.view(num);
			request.setAttribute("dto", dto);
			String page="/media/view4.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		}else if(url.indexOf("view5.do") != -1) {
			int num=Integer.parseInt(request.getParameter("num"));
			System.out.println(num);
			HttpSession session=request.getSession();
			dao.plusReadCount(num, session);
			MediaDTO dto=dao.viewReplace(num);
			//BoardDTO dto=dao.view(num);
			request.setAttribute("dto", dto);
			String page="/media/view5.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		}else if(url.indexOf("view6.do") != -1) {
			int num=Integer.parseInt(request.getParameter("num"));
			System.out.println(num);
			HttpSession session=request.getSession();
			dao.plusReadCount(num, session);
			MediaDTO dto=dao.viewReplace(num);
			//BoardDTO dto=dao.view(num);
			request.setAttribute("dto", dto);
			String page="/media/view6.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		}else if(url.indexOf("view7.do") != -1) {
			int num=Integer.parseInt(request.getParameter("num"));
			System.out.println(num);
			HttpSession session=request.getSession();
			dao.plusReadCount(num, session);
			MediaDTO dto=dao.viewReplace(num);
			//BoardDTO dto=dao.view(num);
			request.setAttribute("dto", dto);
			String page="/media/view7.jsp";
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
			List<MediaDTO> list=dao.list(start,end);
			request.setAttribute("list", list);
			request.setAttribute("page", pager);
			
			String page="/media/listlog.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		}else if(url.indexOf("viewlog1.do") != -1) {
			int num=Integer.parseInt(request.getParameter("num"));
			System.out.println(num);
			HttpSession session=request.getSession();
			dao.plusReadCount(num, session);
			MediaDTO dto=dao.viewReplace(num);
			//BoardDTO dto=dao.view(num);
			request.setAttribute("dto", dto);
			String page="/media/viewlog.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		}else if(url.indexOf("viewlog2.do") != -1) {
			int num=Integer.parseInt(request.getParameter("num"));
			System.out.println(num);
			HttpSession session=request.getSession();
			dao.plusReadCount(num, session);
			MediaDTO dto=dao.viewReplace(num);
			//BoardDTO dto=dao.view(num);
			request.setAttribute("dto", dto);
			String page="/media/viewlog2.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		}else if(url.indexOf("viewlog3.do") != -1) {
			int num=Integer.parseInt(request.getParameter("num"));
			System.out.println(num);
			HttpSession session=request.getSession();
			dao.plusReadCount(num, session);
			MediaDTO dto=dao.viewReplace(num);
			//BoardDTO dto=dao.view(num);
			request.setAttribute("dto", dto);
			String page="/media/viewlog3.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		}else if(url.indexOf("viewlog4.do") != -1) {
			int num=Integer.parseInt(request.getParameter("num"));
			System.out.println(num);
			HttpSession session=request.getSession();
			dao.plusReadCount(num, session);
			MediaDTO dto=dao.viewReplace(num);
			//BoardDTO dto=dao.view(num);
			request.setAttribute("dto", dto);
			String page="/media/viewlog4.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		}else if(url.indexOf("viewlog5.do") != -1) {
			int num=Integer.parseInt(request.getParameter("num"));
			System.out.println(num);
			HttpSession session=request.getSession();
			dao.plusReadCount(num, session);
			MediaDTO dto=dao.viewReplace(num);
			//BoardDTO dto=dao.view(num);
			request.setAttribute("dto", dto);
			String page="/media/viewlog5.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		}else if(url.indexOf("viewlog6.do") != -1) {
			int num=Integer.parseInt(request.getParameter("num"));
			System.out.println(num);
			HttpSession session=request.getSession();
			dao.plusReadCount(num, session);
			MediaDTO dto=dao.viewReplace(num);
			//BoardDTO dto=dao.view(num);
			request.setAttribute("dto", dto);
			String page="/media/viewlog6.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		}else if(url.indexOf("viewlog7.do") != -1) {
			int num=Integer.parseInt(request.getParameter("num"));
			System.out.println(num);
			HttpSession session=request.getSession();
			dao.plusReadCount(num, session);
			MediaDTO dto=dao.viewReplace(num);
			//BoardDTO dto=dao.view(num);
			request.setAttribute("dto", dto);
			String page="/media/viewlog7.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		}else if(url.indexOf("searchlog.do") != -1) {
			String search_option=request.getParameter("search_option");
			String keyword=request.getParameter("keyword");
			
			List<MediaDTO> list=dao.searchList(search_option,keyword);
			request.setAttribute("list", list);
			request.setAttribute("search_option", search_option);
			request.setAttribute("keyword", keyword);
			String page="/media/searchlog.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		}
	}
	

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
