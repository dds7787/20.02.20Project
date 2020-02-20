package culture.dto;

import java.util.Date;

public class CultureCommentDTO {
	private int comment_num;
	private int culture_num;
	private String writer;
	private String content;
	private Date reg_date;
	public int getComment_num() {
		return comment_num;
	}
	public void setComment_num(int comment_num) {
		this.comment_num = comment_num;
	}
	public int getCulture_num() {
		return culture_num;
	}
	public void setCulture_num(int culture_num) {
		this.culture_num = culture_num;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	@Override
	public String toString() {
		return "CultureCommentDTO [comment_num=" + comment_num + ", culture_num=" + culture_num + ", writer=" + writer
				+ ", content=" + content + ", reg_date=" + reg_date + "]";
	}
	
	

}
