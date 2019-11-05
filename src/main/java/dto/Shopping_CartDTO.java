package dto;

public class Shopping_CartDTO {
	private String mem_id;
	private int shop_num;
	private int cart_buycount;
	
	public Shopping_CartDTO() {

	}

	public String getMem_id() {
		return mem_id;
	}

	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}

	public int getShop_num() {
		return shop_num;
	}

	public void setShop_num(int shop_num) {
		this.shop_num = shop_num;
	}

	public int getCart_buycount() {
		return cart_buycount;
	}

	public void setCart_buycount(int cart_buycount) {
		this.cart_buycount = cart_buycount;
	}
	
}
