package dto;

import java.util.Date;

public class WarehouseDTO {
	private int ware_num;
	private int shop_num;
	private Date ware_regdate;
	private int ware_cnt;
	private int ware_price;
	
	public WarehouseDTO() {
	
	}//end WarehouseDTO()

	public int getWare_num() {
		return ware_num;
	}

	public void setWare_num(int ware_num) {
		this.ware_num = ware_num;
	}

	public int getShop_num() {
		return shop_num;
	}

	public void setShop_num(int shop_num) {
		this.shop_num = shop_num;
	}

	public Date getWare_regdate() {
		return ware_regdate;
	}

	public void setWare_regdate(Date ware_regdate) {
		this.ware_regdate = ware_regdate;
	}

	public int getWare_cnt() {
		return ware_cnt;
	}

	public void setWare_cnt(int ware_cnt) {
		this.ware_cnt = ware_cnt;
	}

	public int getWare_price() {
		return ware_price;
	}

	public void setWare_price(int ware_price) {
		this.ware_price = ware_price;
	}
	
	
	
}//end class
