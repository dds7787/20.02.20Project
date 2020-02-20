package media.DTO;

import java.util.Date;

public class MediaCommentDTO {
	private int comment_num;
	private int media_num;
	private String writer;
	private String content;
	private Date reg_date;
	public int getComment_num() {
		return comment_num;
	}
	public void setComment_num(int comment_num) {
		this.comment_num = comment_num;
	}
	public int getMedia_num() {
		return media_num;
	}
	public void setMedia_num(int media_num) {
		this.media_num = media_num;
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
		return "MediaCommentDTO [comment_num=" + comment_num + ", media_num=" + media_num + ", writer=" + writer
				+ ", content=" + content + ", reg_date=" + reg_date + "]";
	}
	
	

}
