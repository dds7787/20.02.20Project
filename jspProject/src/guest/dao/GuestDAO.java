package guest.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import guest.dto.GuestDTO;
import sqlmap.MybatisManager;

public class GuestDAO {
	
	public List<GuestDTO> getList(String searchkey, String search){
		SqlSession session=MybatisManager.getInstance().openSession();
		List<GuestDTO> list=null;
		if(searchkey.equals("name_content")) {
			list=session.selectList("gbListAll","%"+search+"%");
		}else {
			
			Map<String,String> map=new HashMap<>();
			map.put("searchkey", searchkey);
			map.put("search", "%"+search+"%");
			list=session.selectList("gbList",map);
		}
		
		
		
		for(GuestDTO dto : list) {
			String content=dto.getContent();
			content=content.replace("<", "&lt");
			content=content.replace(">", "&gt");
			content=content.replace("\n", "<br>");
			content=content.replace("  ", "&nbsp;&nbsp;");
			dto.setContent(content);
		}
		session.close();
		return list;
	}

	
	public void gbInsert(GuestDTO dto) {
		SqlSession session=MybatisManager.getInstance().openSession();
		session.insert("gbInsert", dto);
		session.commit();
		session.close();
	}

	public boolean passwdCheck(int idx, String passwd) {//비밀번호체크
		boolean result=false;
		
		SqlSession session=MybatisManager.getInstance().openSession();
		GuestDTO dto=new GuestDTO();
	    dto.setIdx(idx);
	    dto.setPasswd(passwd);
	    int count=session.selectOne("passwdCheck", dto);
	    session.close();
	    if(count==1) {
	    	result=true;
	    }
		return result;
	}
	
	
	public GuestDTO gbDetail(int idx) {
		GuestDTO dto=new GuestDTO();
		SqlSession session=MybatisManager.getInstance().openSession();
		dto = session.selectOne("gbDetail",idx);
		session.close();
		return dto;
	}
	
    //게시물 수정
	public void gbUpdate(GuestDTO dto) {
		SqlSession session=MybatisManager.getInstance().openSession();
		session.update("guest.gbUpdate",dto);
		session.commit();
		session.close();
		
	}
	
    //게시물삭제
	public void gbDelete(int idx) {
		SqlSession session=MybatisManager.getInstance().openSession();
		session.delete("guest.gbDelete",idx);
	    session.commit();
	    session.close();
		
	}
	

}
