package dto;

public class Shopping_InfoDTO {
   private int shopInfo_num;
   private String shopInfo_name;
   private String shopInfo_code;
   private int shopInfo_price;
   private double shopInfo_starcnt; //int -> double
   private int shopInfo_chk;
   
   public int getShopInfo_num() {
      return shopInfo_num;
   }
   
   public void setShopInfo_num(int shopInfo_num) {
      this.shopInfo_num = shopInfo_num;
   }
   
   public String getShopInfo_name() {
      return shopInfo_name;
   }
   
   public void setShopInfo_name(String shopInfo_name) {
      this.shopInfo_name = shopInfo_name;
   }
   
   public String getShopInfo_code() {
      return shopInfo_code;
   }
   
   public void setShopInfo_code(String shopInfo_code) {
      this.shopInfo_code = shopInfo_code;
   }
   
   public int getShopInfo_price() {
      return shopInfo_price;
   }
   
   public void setShopInfo_price(int shopInfo_price) {
      this.shopInfo_price = shopInfo_price;
   }
   
   public double getShopInfo_starcnt() {
      return shopInfo_starcnt;
   }
   
   public void setShopInfo_starcnt(double shopInfo_starcnt) {
      this.shopInfo_starcnt = shopInfo_starcnt;
   }

   public int getShopInfo_chk() {
      return shopInfo_chk;
   }

   public void setShopInfo_chk(int shopInfo_chk) {
      this.shopInfo_chk = shopInfo_chk;
   }
   
   

}//end class