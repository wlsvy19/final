package dto;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class Shopping_FileDTO {
	private int sreply_num;
	private List<MultipartFile> shop_file;
	private int shop_num;
	
	public Shopping_FileDTO() {
	
	}//end Shopping_FileDTO()

	public int getSreply_num() {
		return sreply_num;
	}

	public void setSreply_num(int sreply_num) {
		this.sreply_num = sreply_num;
	}

	public List<MultipartFile> getShop_file() {
		return shop_file;
	}

	public void setShop_file(List<MultipartFile> shop_file) {
		this.shop_file = shop_file;
	}

	public int getShop_num() {
		return shop_num;
	}

	public void setShop_num(int shop_num) {
		this.shop_num = shop_num;
	}
	
	
}//end class
