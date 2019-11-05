package service;

import java.util.ArrayList;
import java.util.List;

import dto.PurchaseDTO;
import dto.ShoppingDTO;
import dto.Shopping_InfoDTO;

public interface ManagerService {
   /*판매 관리*/
   public List<PurchaseDTO> PurchaseList();
   public List<PurchaseDTO> completeList();
   public List<PurchaseDTO> updateList(PurchaseDTO dto);
   
   /*판매 그래프*/
   public ArrayList<Integer> month();
   
   /*재고 관리*/
   public List<ShoppingDTO> stock_list();
   public List<ShoppingDTO> stock_update(ShoppingDTO dto);
   
   /*상품관리*/
   public List<Shopping_InfoDTO> shoppingInfoListMethod();
   public List<Shopping_InfoDTO> shoppingStopMethod(int shop_num);
   public List<Shopping_InfoDTO> shoppingResaleMethod(int shop_num);
   public List<Shopping_InfoDTO> shoppingDeleteMethod(int shop_num);
   public List<Shopping_InfoDTO> shoppingInsertMethod(ShoppingDTO dto);
   
}//end interface