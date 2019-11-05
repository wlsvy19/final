package dto;

import java.util.Date;

public class PurchaseDTO {
	private String mem_id;
	private int shop_num;
	private int purchase_cnt;
	private int purchase_totalprice;
	private Date purchase_regdate;
	private int purchase_condition;
	
	public PurchaseDTO() {

	}//end PurchaseDTO()

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

	public int getPurchase_cnt() {
		return purchase_cnt;
	}

	public void setPurchase_cnt(int purchase_cnt) {
		this.purchase_cnt = purchase_cnt;
	}

	public int getPurchase_totalprice() {
		return purchase_totalprice;
	}

	public void setPurchase_totalprice(int purchase_totalprice) {
		this.purchase_totalprice = purchase_totalprice;
	}

	public Date getPurchase_regdate() {
		return purchase_regdate;
	}

	public void setPurchase_regdate(Date purchase_regdate) {
		this.purchase_regdate = purchase_regdate;
	}

	public int getPurchase_condition() {
		return purchase_condition;
	}

	public void setPurchase_condition(int purchase_condition) {
		this.purchase_condition = purchase_condition;
	}
	
	
	
}//end class
