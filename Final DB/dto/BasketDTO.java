package dto;

public class BasketDTO {
	private	String basket_phone;
	private	String basket_address;
	private	String basket_detailaddress;
	private	String basket_oaddress;
	
	public BasketDTO() {
		
	}//end BasketDTO()

	public String getBasket_phone() {
		return basket_phone;
	}

	public void setBasket_phone(String basket_phone) {
		this.basket_phone = basket_phone;
	}

	public String getBasket_address() {
		return basket_address;
	}

	public void setBasket_address(String basket_address) {
		this.basket_address = basket_address;
	}

	public String getBasket_detailaddress() {
		return basket_detailaddress;
	}

	public void setBasket_detailaddress(String basket_detailaddress) {
		this.basket_detailaddress = basket_detailaddress;
	}

	public String getBasket_oaddress() {
		return basket_oaddress;
	}

	public void setBasket_oaddress(String basket_oaddress) {
		this.basket_oaddress = basket_oaddress;
	}
	
	
	
}//end class
