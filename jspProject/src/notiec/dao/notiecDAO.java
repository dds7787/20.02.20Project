package notiec.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;

import notiec.dto.notiecCommentDTO;
import notiec.dto.notiecDTO;
import sqlmap.MybatisManager;

public class notiecDAO {

	public List<notiecDTO> list(int start, int end){
		List<notiecDTO> list=null;
		SqlSession session=null;
		//혹시 있을지 모를 예외발생을 처리하기 위해 try~catch문처리
		try {
			session=MybatisManager.getInstance().openSession();
			Map<String,Object> map=new HashMap<>();
			map.put("start", start);
			map.put("end", end);
			list=session.selectList("notiec.list",map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null) session.close();
		}
		return list;
	}

		//게시물 저장
		public void insert(notiecDTO dto) {
			SqlSession session=null;
			try {
				session=MybatisManager.getInstance().openSession();
				session.insert("notiec.insert", dto);
				session.commit();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(session != null) session.close();
			}
		}//insert(dto)

		//첨부파일의 이름 찾기
		public String getFileName(int num) {
			String result="";
			SqlSession session=null;
			try {
				session=MybatisManager.getInstance().openSession();
				result = session.selectOne("notiec.getFileName", num);
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(session != null) session.close();
			}
			return result;
		}

		//다운로드 횟수 증가 처리
		public void plusDown(int num) {
			SqlSession session=null;
			try {
				session=MybatisManager.getInstance().openSession();
				session.update("notiec.plusDown", num);
				session.commit();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(session != null) session.close();
			}
			
		}

		public notiecDTO view(int num) {
			notiecDTO dto=null;
			SqlSession session=null;
			try {
				session=MybatisManager.getInstance().openSession();
				dto = session.selectOne("notiec.view", num);
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(session != null) session.close();
			}
			return dto;
		}
		
		public notiecDTO viewReplace(int num) {
			notiecDTO dto=null;
			SqlSession session=null;
			try {
				session=MybatisManager.getInstance().openSession();
				dto = session.selectOne("notiec.view", num);
				//줄바꿈 처리
				String content=dto.getContent();
				content=content.replace("\n", "<br>");
				dto.setContent(content);
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(session != null) session.close();
			}
			return dto;
		}
		
		//조회수 증가 처리
		public void plusReadCount(int num, HttpSession count_session) {
			SqlSession session=null;
			try {
				long read_time=0;
				if(count_session.getAttribute("read_time_"+num)!=null) {
				read_time=(long)count_session.getAttribute("read_time_"+num);
				}
				long current_time=System.currentTimeMillis();
				session=MybatisManager.getInstance().openSession();
				if(current_time-read_time>5*1000) {
					session.update("notiec.plusReadCount", num);
					session.commit();
					count_session.setAttribute(
							"read_time_"+num, current_time);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(session != null) session.close();
			}
			
		}

		//댓글 목록
		public List<notiecCommentDTO> commentList(int num) {
			List<notiecCommentDTO> list=null;
			SqlSession session=null;
			try {
				session = MybatisManager.getInstance().openSession();
				list=session.selectList("notiec.commentList", num);
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(session!=null) session.close();
			}
			return list;

		}

		//뎃글 추가
		public void commentAdd(notiecCommentDTO dto) {
			SqlSession session=null;
			try {
				session=MybatisManager.getInstance().openSession();
				session.insert("notiec.commentAdd", dto);
				session.commit();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(session != null) session.close();
			}
			
		}

		//답글의 순서 조정
		public void updateStep(int ref, int re_step) {
			SqlSession session=null;
			try {
				session=MybatisManager.getInstance().openSession();
				notiecDTO dto=new notiecDTO();
				dto.setRef(ref);
				dto.setRe_step(re_step);
				session.update("notiec.updateStep", dto);
				session.commit();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(session != null) session.close();
			}
			
		}

		//답글 쓰기
		public void reply(notiecDTO dto) {
			SqlSession session=null;
			try {
				session=MybatisManager.getInstance().openSession();
				session.insert("notiec.reply", dto);
				session.commit();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(session != null) session.close();
			}
			
		}

		//비밀번호 체크
		public String passwdCheck(int num, String passwd) {
			String result=null;
			SqlSession session=null;
			try {
				session = MybatisManager.getInstance().openSession();
				Map<String,Object> map=new HashMap<>();
				map.put("num", num);
				map.put("passwd", passwd);
				result=session.selectOne("notiec.pass_check", map);
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(session!=null) session.close();
			}
			return result;
		}

		//수정
		public void update(notiecDTO dto) {
			SqlSession session=null;
			try {
				session=MybatisManager.getInstance().openSession();
				session.update("notiec.update", dto);
				session.commit();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(session != null) session.close();
			}
			
		}
		
		//삭제
		public void delete(int num) {
			SqlSession session=null;
			try {
				session=MybatisManager.getInstance().openSession();
				session.update("notiec.delete", num);
				session.commit();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(session != null) session.close();
			}
			
		}

		//검색기능
		public List<notiecDTO> searchList(String search_option, String keyword) {
			List<notiecDTO> list=null;
			try(SqlSession session
					=MybatisManager.getInstance().openSession()) {
			Map<String,String> map=new HashMap<>();
			map.put("search_option", search_option);
			map.put("keyword", "%"+keyword+"%");
			list=session.selectList("notiec.searchList", map);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return list;
		}
		

		//게시물 갯수 계산
		public int count() {
			int result=0;
			try(SqlSession session
			=MybatisManager.getInstance().openSession()){
				result=session.selectOne("notiec.count");
			} catch (Exception e) {
				e.printStackTrace();
			}
			return result;
		}
		public notiecDTO view2(int num) {
			notiecDTO dto=null;
			SqlSession session=null;
			try {
				session=MybatisManager.getInstance().openSession();
				dto = session.selectOne("notiec.view", num);
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(session != null) session.close();
			}
			return dto;
		}
		//삭제
		public void delete2(int num) {
			SqlSession session=null;
			try {
				session=MybatisManager.getInstance().openSession();
				session.update("notiec.delete2", num);
				session.commit();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(session != null) session.close();
			}
			
		}
		
		public void update2(notiecDTO dto) {
			SqlSession session=null;
			try {
				session=MybatisManager.getInstance().openSession();
				session.update("notiec.update2", dto);
				session.commit();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(session != null) session.close();
			}	
		}
}
