package dto;

public class Shopping_FileDTO {
	private int sreply_num;
	private String shop_file;
	private int shop_num;
	
	/*private List<MultipartFile> filename;*/
	
	public Shopping_FileDTO() {
	
	}//end Shopping_FileDTO()

	public int getSreply_num() {
		return sreply_num;
	}

	public void setSreply_num(int sreply_num) {
		this.sreply_num = sreply_num;
	}

	public int getShop_num() {
		return shop_num;
	}

	public void setShop_num(int shop_num) {
		this.shop_num = shop_num;
	}

	public String getShop_file() {
		return shop_file;
	}

	public void setShop_file(String shop_file) {
		this.shop_file = shop_file;
	}

	/*public List<MultipartFile> getFilename() {
		return filename;
	}

	public void setFilename(List<MultipartFile> filename) {
		this.filename = filename;
	}*/
	
	
}//end class
