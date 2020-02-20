package enter.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;

import enter.dto.EnterCommentDTO;
import enter.dto.EnterDTO;
import sqlmap.MybatisManager;

public class EnterDAO {
	public List<EnterDTO> list(int start, int end){
		List<EnterDTO> list=null;
		SqlSession session=null;
		//혹시 있을지 모를 예외발생을 처리하기 위해 try~catch문처리
		try {
			session=MybatisManager.getInstance().openSession();
			Map<String,Object> map=new HashMap<>();
			map.put("start", start);
			map.put("end", end);
			list=session.selectList("enter.list",map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null) session.close();
		}
		return list;
	}

		//게시물 저장
		public void insert(EnterDTO dto) {
			SqlSession session=null;
			try {
				session=MybatisManager.getInstance().openSession();
				session.insert("enter.insert", dto);
				session.commit();//auto commit 아님
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(session != null) session.close();
			}
		}//insert(EnterDTO dto)

		//첨부파일의 이름 찾기
		public String getFileName(int num) {
			String result="";
			SqlSession session=null;
			try {
				session=MybatisManager.getInstance().openSession();
				result = session.selectOne("enter.getFileName", num);
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
				session.update("enter.plusDown", num);
				session.commit();//auto commit 아님
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(session != null) session.close();
			}
			
		}

		public EnterDTO view(int num) {
			EnterDTO dto=null;
			SqlSession session=null;
			try {
				session=MybatisManager.getInstance().openSession();
				dto = session.selectOne("enter.view", num);
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(session != null) session.close();
			}
			return dto;
		}
		
		public EnterDTO viewReplace(int num) {
			EnterDTO dto=null;
			SqlSession session=null;
			try {
				session=MybatisManager.getInstance().openSession();
				dto = session.selectOne("enter.view", num);
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
				long current_time=System.currentTimeMillis();//현재시각
				session=MybatisManager.getInstance().openSession();
				if(current_time-read_time>5*1000) {//현재시간-읽은시간>5초,
					//하루에 한번 증가 24*60*60*1000
					session.update("enter.plusReadCount", num);
					session.commit();//auto commit 아님
					//최근 열람 시각 업데이트
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
		public List<EnterCommentDTO> commentList(int num) {
			List<EnterCommentDTO> list=null;
			SqlSession session=null;
			try {
				session = MybatisManager.getInstance().openSession();
				list=session.selectList("enter.commentList", num);
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(session!=null) session.close();
			}
			return list;

		}

		//뎃글 추가
		public void commentAdd(EnterCommentDTO dto) {
			SqlSession session=null;
			try {
				session=MybatisManager.getInstance().openSession();
				session.insert("enter.commentAdd", dto);
				session.commit();//auto commit 아님
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
				EnterDTO dto=new EnterDTO();
				dto.setRef(ref);
				dto.setRe_step(re_step);
				session.update("enter.updateStep", dto);
				session.commit();//auto commit 아님
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(session != null) session.close();
			}
			
		}

		//답글 쓰기
		public void reply(EnterDTO dto) {
			SqlSession session=null;
			try {
				session=MybatisManager.getInstance().openSession();
				session.insert("enter.reply", dto);
				session.commit();//auto commit 아님
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
				result=session.selectOne("enter.pass_check", map);
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(session!=null) session.close();
			}
			return result;
		}

		//수정
		public void update(EnterDTO dto) {
			SqlSession session=null;
			try {
				session=MybatisManager.getInstance().openSession();
				session.update("enter.update", dto);
				session.commit();//auto commit 아님
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
				session.update("enter.delete", num);
				session.commit();//auto commit 아님
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(session != null) session.close();
			}
			
		}

		//검색기능
		public List<EnterDTO> searchList(String search_option, String keyword) {
			List<EnterDTO> list=null;
			//try ~ with문 : java1.7부터 사용 가능
			//try(){}문장에서 finally절을 안써도 자동으로 리소스가 정리된다.
			try(SqlSession session
					=MybatisManager.getInstance().openSession()) {
			Map<String,String> map=new HashMap<>();
			map.put("search_option", search_option);
			map.put("keyword", "%"+keyword+"%");
			list=session.selectList("enter.searchList", map);
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
				result=session.selectOne("enter.count");
			} catch (Exception e) {
				e.printStackTrace();
			}
			return result;
		}
		public EnterDTO view2(int num) {
			EnterDTO dto=null;
			SqlSession session=null;
			try {
				session=MybatisManager.getInstance().openSession();
				dto = session.selectOne("enter.view", num);
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(session != null) session.close();
			}
			return dto;
		}
			
	}

