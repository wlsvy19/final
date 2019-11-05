package dto;

import java.util.Date;

public class ShoppingDTO {
	private int shop_num;
	private String shop_name;
	private String shop_code;
	private int shop_price;
	private Date shop_regdate;
	private int shop_sellcnt;
	private int shop_stock;
	private String shop_imgpath;
	private int shop_starcnt;
	
	public ShoppingDTO() {

	}//end ShoppingDTO()

	public int getShop_num() {
		return shop_num;
	}

	public void setShop_num(int shop_num) {
		this.shop_num = shop_num;
	}

	public String getShop_name() {
		return shop_name;
	}

	public void setShop_name(String shop_name) {
		this.shop_name = shop_name;
	}

	public String getShop_code() {
		return shop_code;
	}

	public void setShop_code(String shop_code) {
		this.shop_code = shop_code;
	}

	public int getShop_price() {
		return shop_price;
	}

	public void setShop_price(int shop_price) {
		this.shop_price = shop_price;
	}

	public Date getShop_regdate() {
		return shop_regdate;
	}

	public void setShop_regdate(Date shop_regdate) {
		this.shop_regdate = shop_regdate;
	}

	public int getShop_sellcnt() {
		return shop_sellcnt;
	}

	public void setShop_sellcnt(int shop_sellcnt) {
		this.shop_sellcnt = shop_sellcnt;
	}

	public int getShop_stock() {
		return shop_stock;
	}

	public void setShop_stock(int shop_stock) {
		this.shop_stock = shop_stock;
	}

	public String getShop_imgpath() {
		return shop_imgpath;
	}

	public void setShop_imgpath(String shop_imgpath) {
		this.shop_imgpath = shop_imgpath;
	}

	public int getShop_starcnt() {
		return shop_starcnt;
	}

	public void setShop_starcnt(int shop_starcnt) {
		this.shop_starcnt = shop_starcnt;
	}
	
	
	
}//end class
