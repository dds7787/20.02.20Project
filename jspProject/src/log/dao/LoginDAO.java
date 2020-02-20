package log.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import config.DB;
import crypt.BCrypt;
import log.dto.LoginDTO;
import sqlmap.MybatisManager;


public class LoginDAO {

	public LoginDTO logDetail(String userid) {
		LoginDTO dto = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DB.getConn();
			String sql = "select * from log where userid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto = new LoginDTO();
				dto.setUserid(userid);
				dto.setPasswd(rs.getString("passwd"));
				dto.setName(rs.getString("name"));
				dto.setEmail(rs.getString("email"));
				dto.setHp(rs.getString("hp"));
				dto.setJoin_date(rs.getDate("join_date"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null) rs.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			try {
				if(pstmt!=null) pstmt.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			try {
				if(conn!=null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}//finally
		return dto;
	}//end memberDetail()

	public void insert(LoginDTO dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DB.getConn();
			StringBuilder sql = new StringBuilder();
			sql.append("insert into log ");
			sql.append(" (userid,passwd,name,email,hp) values ");
			sql.append(" (?,?,?,?,?)");
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getUserid());
			String passwd = BCrypt.hashpw(dto.getPasswd(), BCrypt.gensalt());
			pstmt.setString(2, passwd);
			pstmt.setString(3, dto.getName());
			pstmt.setString(4, dto.getEmail());
			pstmt.setString(5, dto.getHp());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt!=null) pstmt.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			try {
				if(conn!=null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}//finally
		
	}//insert()
	/*
	 * public void insert(LoginDTO dto) { SqlSession session=null; try {
	 * session=MybatisManager.getInstance().openSession();
	 * session.insert("log.insert", dto); session.commit();//auto commit 아님 } catch
	 * (Exception e) { e.printStackTrace(); } finally { if(session != null)
	 * session.close(); } }
	 */
	

	public String loginCheck(LoginDTO dto) {
		String result = "";
		Connection conn=null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn=DB.getConn();
			String sql = "select * from log where userid=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getUserid());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				String passwd = rs.getString("passwd");
				if(BCrypt.checkpw(dto.getPasswd(), passwd)) {
					result = rs.getString("name")+"님 환영합니다.";
				}else {
					result = "로그인 실패";
				}
			}else {
					result = "로그인 실패";
			}
		} catch (Exception e) {
		    e.printStackTrace();
		}finally {
			try {
				if(rs!=null) rs.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			try {
				if(pstmt!=null) pstmt.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			try {
				if(conn!=null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return result;
	}

//	public void update(LoginDTO dto) {//수정
//		SqlSession session=null;
//   	try {
//			session=MybatisManager.getInstance().openSession();
//			session.update("log.update", dto);
//			session.commit();
//		} catch (Exception e) {
//			e.printStackTrace();
//			} finally {
//			if(session != null) session.close();
//		}
//		
//	}

//	public void delete(String userid) {//삭제
//     	SqlSession session=null;
//		try {
//			session=MybatisManager.getInstance().openSession();
//			session.update("log.delete", userid);
//			session.commit();
//		} catch (Exception e) {
//			e.printStackTrace();
//		} finally {
//			if(session != null) session.close();
//		}
//		
//	}
	
    	public void update(LoginDTO dto) { //수정
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DB.getConn();
			StringBuilder sb = new StringBuilder();
			sb.append("update log set ");
			sb.append(" passwd=?, name=?, email=?, hp=? ");
			sb.append(" where userid=?");
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, dto.getPasswd());
			pstmt.setString(2, dto.getName());
			pstmt.setString(3, dto.getEmail());
			pstmt.setString(4, dto.getHp());
			pstmt.setString(5, dto.getUserid());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(pstmt!=null) pstmt.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			try {
				if(conn!=null) conn.close();
     		} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
	}
	
//	public void update(LoginDTO dto) {
//		Connection conn = null;
//		PreparedStatement pstmt = null;
//		try {
//			conn = DB.getConn();
///			StringBuilder sql = new StringBuilder();
//			sql.append("update log set ");
//			sql.append(" passwd=?, name=?, email=?, hp=? ");
//			sql.append(" where userid=?");
//			pstmt = conn.prepareStatement(sql.toString());
//			pstmt.setString(1, dto.getUserid());
//			String passwd = BCrypt.hashpw(dto.getPasswd(), BCrypt.gensalt());
//			pstmt.setString(2, passwd);
//			pstmt.setString(3, dto.getName());
//			pstmt.setString(4, dto.getEmail());
//			pstmt.setString(5, dto.getHp());
//			pstmt.executeUpdate();
//		} catch (Exception e) {
//			e.printStackTrace();
//		} finally {
//			try {
//				if(pstmt!=null) pstmt.close();
//			} catch (Exception e2) {
//				e2.printStackTrace();
//			}
//			try {
//				if(conn!=null) conn.close();
//			} catch (Exception e2) {
//				e2.printStackTrace();
//			}
//		}//finally
		
//	}
	

	public void delete(String userid) {//삭제
		Connection conn = null;
		PreparedStatement pstmt =null;
		try {
			conn = DB.getConn();
			String sql = "delete from log where userid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			pstmt.executeUpdate();//레코드삭제
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(pstmt!=null) pstmt.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			try {
				if(conn!=null) conn.close();
			} catch (Exception e2) {
			    e2.printStackTrace();
			}
		}
		
	}
	

	public List<LoginDTO> logList() {
		List<LoginDTO> items=new ArrayList<>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DB.getConn();
			String sql = "select * from log order by userid";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				LoginDTO dto = new LoginDTO();
				dto.setUserid(rs.getString("userid"));
				dto.setPasswd(rs.getString("passwd"));
				dto.setName(rs.getString("name"));
				dto.setEmail(rs.getString("email"));
				dto.setHp(rs.getString("hp"));
				dto.setJoin_date(rs.getDate("join_date"));
				items.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null) rs.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			try {
				if(pstmt!=null) pstmt.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			try {
				if(conn!=null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}//finally
		return items;
	}
}
