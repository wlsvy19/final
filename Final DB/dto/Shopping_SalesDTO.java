package dto;

import java.util.Date;

public class Shopping_SalesDTO {
	private int sales_num;
	private int shop_num;
	private Date sales_regdate;
	private int sales_cnt;
	private int sales_price;
	
	public Shopping_SalesDTO() {
	
	}//end Shopping_SalesDTO()

	public int getSales_num() {
		return sales_num;
	}

	public void setSales_num(int sales_num) {
		this.sales_num = sales_num;
	}

	public int getShop_num() {
		return shop_num;
	}

	public void setShop_num(int shop_num) {
		this.shop_num = shop_num;
	}

	public Date getSales_regdate() {
		return sales_regdate;
	}

	public void setSales_regdate(Date sales_regdate) {
		this.sales_regdate = sales_regdate;
	}

	public int getSales_cnt() {
		return sales_cnt;
	}

	public void setSales_cnt(int sales_cnt) {
		this.sales_cnt = sales_cnt;
	}

	public int getSales_price() {
		return sales_price;
	}

	public void setSales_price(int sales_price) {
		this.sales_price = sales_price;
	}
	
	
}//end class
