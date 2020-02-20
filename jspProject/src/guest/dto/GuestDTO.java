package guest.dto;

public class GuestDTO {
	
	private int idx;//게시물번호
	private String name;//이름
	private String email;//이메일
	private String passwd;//수정삭제용비번
	private String content;//내용
	private String post_date;//작성일시
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getPost_date() {
		return post_date;
	}
	public void setPost_date(String post_date) {
		this.post_date = post_date;
	}
	@Override
	public String toString() {
		return "GuestDTO [idx=" + idx + ", name=" + name + ", email=" + email + ", passwd=" + passwd + ", content="
				+ content + ", post_date=" + post_date + "]";
	}
	
	

}
