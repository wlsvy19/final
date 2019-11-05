package dao;

import java.util.List;

import dto.PurchaseDTO;
import dto.ShoppingDTO;
import dto.Shopping_InfoDTO;

public interface ManagerDAO {
   /*판매 관리*/
   public List<PurchaseDTO> purchaseListMethod();
   public List<PurchaseDTO> completeListMethod();
   public List<PurchaseDTO> updateMethod(PurchaseDTO dto);
   
   /*판매 그래프*/
   public int month1();
   public int month2();
   public int month3();
   public int month4();
   public int month5();
   public int month6();
   public int month7();
   public int month8();
   public int month9();
   public int month10();
   public int month11();
   public int month12();
   
   /*재고 관리*/
   public List<ShoppingDTO> stock_list();
   public void stock_update(ShoppingDTO dto);
   
   /*상품관리*/
   public List<Shopping_InfoDTO> shoppingInfoListMethod();
   public List<Shopping_InfoDTO> shoppingStopMethod(int shop_num);
   public List<Shopping_InfoDTO> shoppingResaleMethod(int shop_num);
   public List<Shopping_InfoDTO> shoppingDeleteMethod(int shop_num);
   public List<Shopping_InfoDTO> shoppingInsertMethod(ShoppingDTO dto);
   
}//end interface