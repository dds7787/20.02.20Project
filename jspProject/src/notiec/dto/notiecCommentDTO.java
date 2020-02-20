package notiec.dto;

import java.util.Date;

public class notiecCommentDTO {

	private int comment_num;
	private int notiec_num;
	private String writer;
	private String content;
	private Date reg_date;
	public int getComment_num() {
		return comment_num;
	}
	public void setComment_num(int comment_num) {
		this.comment_num = comment_num;
	}
	public int getNotiec_num() {
		return notiec_num;
	}
	public void setNotiec_num(int notiec_num) {
		this.notiec_num = notiec_num;
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
		return "notiecCommentDTO [comment_num=" + comment_num + ", notiec_num=" + notiec_num + ", writer=" + writer
				+ ", content=" + content + ", reg_date=" + reg_date + "]";
	}
	
	
}
