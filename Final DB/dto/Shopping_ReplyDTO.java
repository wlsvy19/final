package dto;

import java.util.Date;

public class Shopping_ReplyDTO {
	private int shop_num;
	private int sreply_num;
	private String sreply_writer;
	private String sreply_content;
	private Date sreply_regdate;
	private int sreply_star;
	
	public Shopping_ReplyDTO() {
		
	}//end Shopping_ReplyDTO()

	public int getShop_num() {
		return shop_num;
	}

	public void setShop_num(int shop_num) {
		this.shop_num = shop_num;
	}

	public int getSreply_num() {
		return sreply_num;
	}

	public void setSreply_num(int sreply_num) {
		this.sreply_num = sreply_num;
	}

	public String getSreply_writer() {
		return sreply_writer;
	}

	public void setSreply_writer(String sreply_writer) {
		this.sreply_writer = sreply_writer;
	}

	public String getSreply_content() {
		return sreply_content;
	}

	public void setSreply_content(String sreply_content) {
		this.sreply_content = sreply_content;
	}

	public Date getSreply_regdate() {
		return sreply_regdate;
	}

	public void setSreply_regdate(Date sreply_regdate) {
		this.sreply_regdate = sreply_regdate;
	}

	public int getSreply_star() {
		return sreply_star;
	}

	public void setSreply_star(int sreply_star) {
		this.sreply_star = sreply_star;
	}
	
	
}//end class
