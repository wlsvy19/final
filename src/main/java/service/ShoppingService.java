package service;

import java.util.List;

import dto.MemberDTO;
import dto.PurchaseDTO;
import dto.ShoppingDTO;
import dto.Shopping_CartDTO;
import dto.Shopping_FileDTO;
import dto.Shopping_LikeDTO;
import dto.Shopping_ReplyDTO;

public interface ShoppingService {
	public List<ShoppingDTO> shopListProcess(String category, String selectOption);

	public ShoppingDTO shopInfoProcess(int shop_num);

	public List<ShoppingDTO> shopCartInfoProcess(String mem_id);

	public void shopLikeOnProcess(Shopping_LikeDTO dto);

	public void shopLikeOffProcess(Shopping_LikeDTO dto);

	public List<Shopping_LikeDTO> shopLikeChkProcess(Shopping_LikeDTO dto);

	public void shopCartInProcess(Shopping_CartDTO dto);

	public List<ShoppingDTO> shopCartOutProcess(Shopping_CartDTO dto);

	public List<ShoppingDTO> shopCartListProcess(String mem_id);

	public List<ShoppingDTO> shopCartUpdateProcess(Shopping_CartDTO dto);

	public MemberDTO payMemInfoProcess(String mem_id);

	public void payCompleteProcess(MemberDTO memberDTO, String mem_id);

	public void purchaseInsertProcess(PurchaseDTO dto);

	///////////////////////////////////////////////////////////////////////////////////

	public List<Shopping_ReplyDTO> replyListProcess(Shopping_ReplyDTO dto);

	public List<Shopping_ReplyDTO> replyDeleteProcess(int shop_num, int sreply_num);

	public List<Shopping_FileDTO> replyUpdateFileProcess(int sreply_num);

	public List<Shopping_ReplyDTO> replyUpdateProcess(Shopping_ReplyDTO dto);

	public List<Integer> purConditionProcess(PurchaseDTO dto);

	public void starUpdateMethod(int shop_num);
}// end interface
