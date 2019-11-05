package dto;

import java.util.List;

public class Shopping_LikeDTO {
	private String mem_id;
	private int shop_num;
	private ShoppingDTO likeList;
	
	public Shopping_LikeDTO() {

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

	public ShoppingDTO getLikeList() {
		return likeList;
	}

	public void setLikeList(ShoppingDTO likeList) {
		this.likeList = likeList;
	}

	
}
