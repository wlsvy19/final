package dto;

import java.util.Date;

public class PurchaseDTO {
   private int purchase_num;
   private String mem_id;
   private int shop_num;
   private String purchase_name;
   private String purchase_phone;
   private int purchase_cnt;
   private int purchase_totalprice;
   private Date purchase_regdate;
   private int purchase_condition;
   private String purchase_oaddress;
   private String purchase_address;
   private String purchase_detailaddress;
   private ShoppingDTO shop; 
   public PurchaseDTO() {

   }//end PurchaseDTO()

   public int getPurchase_num() {
      return purchase_num;
   }

   public void setPurchase_num(int purchase_num) {
      this.purchase_num = purchase_num;
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

   public String getPurchase_name() {
      return purchase_name;
   }

   public void setPurchase_name(String purchase_name) {
      this.purchase_name = purchase_name;
   }

   public String getPurchase_phone() {
      return purchase_phone;
   }

   public void setPurchase_phone(String purchase_phone) {
      this.purchase_phone = purchase_phone;
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

   public String getPurchase_oaddress() {
      return purchase_oaddress;
   }

   public void setPurchase_oaddress(String purchase_oaddress) {
      this.purchase_oaddress = purchase_oaddress;
   }

   public String getPurchase_address() {
      return purchase_address;
   }

   public void setPurchase_address(String purchase_address) {
      this.purchase_address = purchase_address;
   }

   public String getPurchase_detailaddress() {
      return purchase_detailaddress;
   }

   public void setPurchase_detailaddress(String purchase_detailaddress) {
      this.purchase_detailaddress = purchase_detailaddress;
   }

   public ShoppingDTO getShop() {
      return shop;
   }

   public void setShop(ShoppingDTO shop) {
      this.shop = shop;
   }

}//end class