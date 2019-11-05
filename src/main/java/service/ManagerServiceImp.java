package service;

import java.util.ArrayList;
import java.util.List;

import dao.ManagerDAO;
import dto.PurchaseDTO;
import dto.ShoppingDTO;
import dto.Shopping_InfoDTO;

public class ManagerServiceImp implements ManagerService{
   //dao 접근
   private ManagerDAO dao;
   
   //생성자
   public ManagerServiceImp() {
   }
   
   //setter
   public void setDao(ManagerDAO dao) {
      this.dao = dao;
   }

   /*배송 중 리스트 출력*/
   @Override
   public List<PurchaseDTO> PurchaseList() {
      return dao.purchaseListMethod();
   }
   
   /*배송 완료 리스트 출력*/
   @Override
   public List<PurchaseDTO> completeList(){
      return dao.completeListMethod();
   }

   /*배송 상태 수정*/
   @Override
   public List<PurchaseDTO> updateList(PurchaseDTO dto){
      /*수정*/
      dao.updateMethod(dto);
      /*후 리스트 출력*/
      return dao.purchaseListMethod();
   }
   
   /*월별 판매량 그래프*/
   @Override
   public ArrayList<Integer> month(){
      ArrayList<Integer> list = new ArrayList<Integer>();
      list.add(dao.month1());
      list.add(dao.month2());
      list.add(dao.month3());
      list.add(dao.month4());
      list.add(dao.month5());
      list.add(dao.month6());
      list.add(dao.month7());
      list.add(dao.month8());
      list.add(dao.month9());
      list.add(dao.month10());
      list.add(dao.month11());
      list.add(dao.month12());
      
      return list;
   }
   
   /*재고 출력*/
   @Override
   public List<ShoppingDTO> stock_list(){
      return dao.stock_list();
   }
   
   /*입고*/
   @Override
   public List<ShoppingDTO> stock_update(ShoppingDTO dto){
      dao.stock_update(dto);
      return dao.stock_list();
   }

   
   
   /*상품관리*/
   /*전체 상품 현황 리스트*/
   @Override
   public List<Shopping_InfoDTO> shoppingInfoListMethod() {
      return dao.shoppingInfoListMethod();
   }

   /*상품 판매 중지*/
   @Override
   public List<Shopping_InfoDTO> shoppingStopMethod(int shop_num) {
      return dao.shoppingStopMethod(shop_num);
   }

   /*상품 재판매*/
   @Override
   public List<Shopping_InfoDTO> shoppingResaleMethod(int shop_num) {
      return dao.shoppingResaleMethod(shop_num);
   }

   /*상품 삭제*/
   @Override
   public List<Shopping_InfoDTO> shoppingDeleteMethod(int shop_num) {
      return dao.shoppingDeleteMethod(shop_num);
   }

   /*상품 추가*/
   @Override
   public List<Shopping_InfoDTO> shoppingInsertMethod(ShoppingDTO dto) {
      return dao.shoppingInsertMethod(dto);
   }
   
}//end class