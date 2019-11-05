package dao;

import java.util.List;

import dto.MemberDTO;
import dto.PurchaseDTO;
import dto.ShoppingDTO;
import dto.Shopping_CartDTO;
import dto.Shopping_FileDTO;
import dto.Shopping_LikeDTO;
import dto.Shopping_ReplyDTO;

public interface ShoppingDAO {
	public List<ShoppingDTO> shopListMethod(String category, String selectOption);

	public ShoppingDTO shopInfoMethod(int shop_num);

	public List<ShoppingDTO> shopCartInfoMethod(String mem_id);

	public void shopLikeOn(Shopping_LikeDTO dto);

	public void shopLikeOff(Shopping_LikeDTO dto);

	public List<Shopping_LikeDTO> shopLikeChk(Shopping_LikeDTO dto);

	public void shopCartIn(Shopping_CartDTO dto);

	public List<Shopping_CartDTO> shopNum(Shopping_CartDTO dto);

	public void shopCartOut(Shopping_CartDTO dto);

	public List<Integer> shopCartInfo(String mem_id);

	public void shopCartUpdate(Shopping_CartDTO dto);

	public MemberDTO payMemInfo(String mem_id);

	public void payComplete(String mem_id);
	
	public void replyOldFileDeleteAll(int num);

	public void purchaseIn(PurchaseDTO dto);

	public void shoppingUpt(PurchaseDTO dto);

	public void memPointMethod(MemberDTO memberDTO);

	///////////////////////////////////////////////////////////////////////////////////////////////////

	///////////////////////////////////////////////////////////////////////////////////////////////////

	public void replyInsertMethod(Shopping_ReplyDTO dto); // 후기 댓글 추가하기 위한 메소드

	public List<Shopping_ReplyDTO> replyListMethod(int shop_num); // 후기 댓글 리스트 모두 검색해오는 메소드

	public void replyFileDeleteMethod(int sreply_num); // 후기 댓글 멀티파일 삭제하기 위한 메소드

	public void replyDeleteMethod(int sreply_num); // 후기 댓글 삭제하기 위한 메소드

	public List<Shopping_FileDTO> replyUpdateFileMethod(int sreply_num); // 선택된 후기 댓글 사진 가지고 오기 위한 메소드

	public void replyUpdateMethod(Shopping_ReplyDTO dto); // 멀티 파일 이외에 수정된 후기 업데이트하기 위한 메소드

	public void multiInsertMethod(Shopping_ReplyDTO dto); // 멀피 파일만 추가하는 메소드(수정시 사용)

	public void replyOtherFileDeleteMethod(Shopping_ReplyDTO dto); // 기존 파일중 남아있는것 이외의 파일을 삭제하기 위한 메소드

	public List<Integer> purConditionMethod(PurchaseDTO dto); // 해당 상품에 대한 회원의 배송상태 값을 가지고 오기 위한 메소드

	public void starUpdateMethod(int shop_num); // 별점 계산에 대한 것

}// end interface
