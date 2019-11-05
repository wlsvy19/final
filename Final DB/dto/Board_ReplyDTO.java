package dto;

import java.util.Date;

public class Board_ReplyDTO {
	private int board_num;
	private int reply_num;
	private	String reply_writer;
	private	String reply_content;
	private Date reply_regdate;
	private int reply_like;
	
	public Board_ReplyDTO() {
	
	}//end Board_ReplyDTO()

	public int getBoard_num() {
		return board_num;
	}

	public void setBoard_num(int board_num) {
		this.board_num = board_num;
	}

	public int getReply_num() {
		return reply_num;
	}

	public void setReply_num(int reply_num) {
		this.reply_num = reply_num;
	}

	public String getReply_writer() {
		return reply_writer;
	}

	public void setReply_writer(String reply_writer) {
		this.reply_writer = reply_writer;
	}

	public String getReply_content() {
		return reply_content;
	}

	public void setReply_content(String reply_content) {
		this.reply_content = reply_content;
	}

	public Date getReply_regdate() {
		return reply_regdate;
	}

	public void setReply_regdate(Date reply_regdate) {
		this.reply_regdate = reply_regdate;
	}

	public int getReply_like() {
		return reply_like;
	}

	public void setReply_like(int reply_like) {
		this.reply_like = reply_like;
	}
	
	
}//end class
