package dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import dto.PurchaseDTO;
import dto.ShoppingDTO;
import dto.Shopping_InfoDTO;

public class ManagerDaoImp implements ManagerDAO{
   //mybatis에 접근하기 위한 SqlSessionTemplate 변수
   private SqlSessionTemplate sqlSession;
   
   //생성자
   public ManagerDaoImp() {
      
   }
   
   //setter
   public void setSqlSession(SqlSessionTemplate sqlSession) {
      this.sqlSession = sqlSession;
   }

   /*배송 중 리스트 출력*/
   @Override
   public List<PurchaseDTO> purchaseListMethod() {
      return sqlSession.selectList("manager.purchase_list");
   }
   
   /*배송 완료 리스트 출력*/
   @Override
   public List<PurchaseDTO> completeListMethod(){
      return sqlSession.selectList("manager.complete_list");
   }
   
   /*배송 상태 수정*/
   @Override
   public List<PurchaseDTO> updateMethod(PurchaseDTO dto){
      return sqlSession.selectList("manager.purchase_update", dto);
   }
   
   /*재고 출력*/
   @Override
   public List<ShoppingDTO> stock_list(){
      return sqlSession.selectList("manager.stock_list");
   }
   
   /*입고*/
   @Override
   public void stock_update(ShoppingDTO dto) {
      System.out.println("=================================================dao");
      System.out.println("dto.shop_stock ==================> " + dto.getShop_stock());
      System.out.println("dto.shop_num ==================> " + dto.getShop_num());
      System.out.println("=================================================dao");
      sqlSession.update("manager.stock_update", dto);
   }
   
   
   
   
   
   /*월별 판매량 그래프*/
   @Override
   public int month1() {
      return sqlSession.selectOne("manager.month1");
   }
   @Override
   public int month2() {
      return sqlSession.selectOne("manager.month2");
   }
   @Override
   public int month3() {
      return sqlSession.selectOne("manager.month3");
   }
   @Override
   public int month4() {
      return sqlSession.selectOne("manager.month4");
   }
   @Override
   public int month5() {
      return sqlSession.selectOne("manager.month5");
   }
   @Override
   public int month6() {
      return sqlSession.selectOne("manager.month6");
   }
   @Override
   public int month7() {
      return sqlSession.selectOne("manager.month7");
   }
   @Override
   public int month8() {
      return sqlSession.selectOne("manager.month8");
   }
   @Override
   public int month9() {
      return sqlSession.selectOne("manager.month9");
   }
   @Override
   public int month10() {
      return sqlSession.selectOne("manager.month10");
   }
   @Override
   public int month11() {
      return sqlSession.selectOne("manager.month11");
   }
   @Override
   public int month12() {
      return sqlSession.selectOne("manager.month12");
   }

   
   
   
   /*전체 상품 현황 리스트*/
   @Override
   public List<Shopping_InfoDTO> shoppingInfoListMethod() {
      return sqlSession.selectList("manager.shop_info_all");
   }

   /*상품 판매 중지*/
   @Override
   public List<Shopping_InfoDTO> shoppingStopMethod(int shop_num) {
      //1.임시 저장 테이블에 저장
      sqlSession.insert("manager.pshop_temp_in", shop_num);
      //2.멀티파일 삭제
      sqlSession.delete("manager.pshop_file_del", shop_num);
      //3.댓글 삭제
      sqlSession.delete("manager.pshop_reply_del", shop_num);
      //4.상품 삭제
      sqlSession.delete("manager.pshop_del", shop_num);
      //5.상품정보 테이블에 상태값 변경
      sqlSession.update("manager.shop_info_stop", shop_num);
      //6.수정된 사항이 포함된 전체 리스트 반환
      return sqlSession.selectList("manager.shop_info_all");
   }

   /*상품 재판매*/
   @Override
   public List<Shopping_InfoDTO> shoppingResaleMethod(int shop_num) {
      //1.상품 복귀
      sqlSession.insert("manager.pshop_rein", shop_num);
      //2.임시 저장 테이블에서 삭제
      sqlSession.delete("manager.pshop_temp_del", shop_num);
      //3.상품정보 테이블에 상태값 변경
      sqlSession.update("manager.shop_info_sale", shop_num);
      //4.수정된 사항이 포함된 전체 리스트 반환
      return sqlSession.selectList("manager.shop_info_all");
   }

   /*상품 삭제*/
   @Override
   public List<Shopping_InfoDTO> shoppingDeleteMethod(int shop_num) {
      //1.멀티파일 삭제
      sqlSession.delete("manager.pshop_file_del", shop_num);
      //2.댓글 삭제
      sqlSession.delete("manager.pshop_reply_del", shop_num);
      //3.상품 삭제
      sqlSession.delete("manager.pshop_del", shop_num);
      //4.상품정보 테이블에서 해당 상품 삭제
      sqlSession.delete("manager.shop_info_del", shop_num);
      //5.수정된 사항이 포함된 전체 리스트 반환
      return sqlSession.selectList("manager.shop_info_all");
   }

   /*상품 추가*/
   @Override
   public List<Shopping_InfoDTO> shoppingInsertMethod(ShoppingDTO dto) {
      //1.상품 테이블에 추가
      sqlSession.insert("manager.shop_new", dto);
      //2.상품정보 테이블에 추가
      Shopping_InfoDTO ifdto = new Shopping_InfoDTO();
      int num = sqlSession.selectOne("manager.shop_newNum"); //동일한 상품번호를 가지고 있어야 하므로 (디비상에서 테스트하다가 값이 안맞을 수 있음)
      ifdto.setShopInfo_num(num);
      ifdto.setShopInfo_name(dto.getShop_name());
      ifdto.setShopInfo_code(dto.getShop_code());
      ifdto.setShopInfo_price(dto.getShop_price());
      sqlSession.insert("manager.shop_info_new", ifdto);
      //3.수정된 사항이 포함된 전테 리스트 반환
      return sqlSession.selectList("manager.shop_info_all");
   }
   
   

}