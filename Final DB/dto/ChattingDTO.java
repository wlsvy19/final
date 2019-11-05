package dto;

import java.util.Date;

public class ChattingDTO {
	private int chat_category;
	private String chat_sendid;
	private String chat_receiver;
	private String chat_content;
	private Date chat_regdate;
	
	public ChattingDTO() {
	
	}//end ChattingDTO()

	public int getChat_category() {
		return chat_category;
	}

	public void setChat_category(int chat_category) {
		this.chat_category = chat_category;
	}

	public String getChat_sendid() {
		return chat_sendid;
	}

	public void setChat_sendid(String chat_sendid) {
		this.chat_sendid = chat_sendid;
	}

	public String getChat_receiver() {
		return chat_receiver;
	}

	public void setChat_receiver(String chat_receiver) {
		this.chat_receiver = chat_receiver;
	}

	public String getChat_content() {
		return chat_content;
	}

	public void setChat_content(String chat_content) {
		this.chat_content = chat_content;
	}

	public Date getChat_regdate() {
		return chat_regdate;
	}

	public void setChat_regdate(Date chat_regdate) {
		this.chat_regdate = chat_regdate;
	}
	
	
}//end class
