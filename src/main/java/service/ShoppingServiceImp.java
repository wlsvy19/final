package service;

import java.util.ArrayList;
import java.util.List;

import dao.MemberDAO;
import dao.ShoppingDAO;
import dto.MemberDTO;
import dto.PurchaseDTO;
import dto.ShoppingDTO;
import dto.Shopping_CartDTO;
import dto.Shopping_FileDTO;
import dto.Shopping_LikeDTO;
import dto.Shopping_ReplyDTO;

public class ShoppingServiceImp implements ShoppingService {
	private ShoppingDAO dao;

	public ShoppingServiceImp() {

	}

	public void setDao(ShoppingDAO dao) {
		this.dao = dao;
	}

	@Override
	public List<ShoppingDTO> shopListProcess(String category, String selectOption) {
		return dao.shopListMethod(category, selectOption);
	}

	@Override
	public ShoppingDTO shopInfoProcess(int shop_num) {
		return dao.shopInfoMethod(shop_num);
	}

	@Override
	public void shopLikeOnProcess(Shopping_LikeDTO dto) {
		dao.shopLikeOn(dto);
	}

	@Override
	public void shopLikeOffProcess(Shopping_LikeDTO dto) {
		dao.shopLikeOff(dto);
	}

	@Override
	public List<Shopping_LikeDTO> shopLikeChkProcess(Shopping_LikeDTO dto) {
		return dao.shopLikeChk(dto);
	}

	@Override
	public void shopCartInProcess(Shopping_CartDTO dto) {
		if (dao.shopNum(dto).size() == 0) {
			dao.shopCartIn(dto);
		}
	}

	@Override
	public List<ShoppingDTO> shopCartOutProcess(Shopping_CartDTO dto) {
		dao.shopCartOut(dto);

		return dao.shopCartInfoMethod(dto.getMem_id());
	}

	@Override
	public List<ShoppingDTO> shopCartListProcess(String mem_id) {
		List<ShoppingDTO> list = new ArrayList<ShoppingDTO>();
		List<Integer> clist = dao.shopCartInfo(mem_id);

		for (int i = 0; i < clist.size(); i++) {
			list.add(dao.shopInfoMethod(clist.get(i)));
		}

		return list;
	}

	@Override
	public List<ShoppingDTO> shopCartInfoProcess(String mem_id) {
		return dao.shopCartInfoMethod(mem_id);
	}

	@Override
	public List<ShoppingDTO> shopCartUpdateProcess(Shopping_CartDTO dto) {
		dao.shopCartUpdate(dto);
		return dao.shopCartInfoMethod(dto.getMem_id());
	}

	@Override
	public MemberDTO payMemInfoProcess(String mem_id) {
		return dao.payMemInfo(mem_id);
	}

	@Override
	public void payCompleteProcess(MemberDTO memberDTO, String mem_id) {
		dao.memPointMethod(memberDTO);
		dao.payComplete(mem_id);
	}

	@Override
	public void purchaseInsertProcess(PurchaseDTO dto) {
		dao.purchaseIn(dto);
		dao.shoppingUpt(dto);
	}

	// 후기 댓글 입력(추가)+출력을 위한 메소드
	@Override
	public List<Shopping_ReplyDTO> replyListProcess(Shopping_ReplyDTO rdto) {
		System.out.println("service in");
		// 1.댓글을 추가하는 dao 메소드 호출
		dao.replyInsertMethod(rdto); // 댓글내용추가, 멀티파일추가가 이루어짐
		System.out.println("댓글, 멀티파일  insert 후 comback service");
		System.out.println("rdto.getShop_num() : " + rdto.getShop_num());

		// 별점도 수정하고 가자
		System.out.println("상품에 대한 총 별점 값 수정하기 service에서 dao 호출함");
		dao.starUpdateMethod(rdto.getShop_num());

		// 2.추가된 댓글까지 포함한 모든 댓글을 리스트에 담아 출력해주는 dao 메소드 호출
		return dao.replyListMethod(rdto.getShop_num());
	}

	// 후기 댓글 삭제를 위한 메소드
	@Override
	public List<Shopping_ReplyDTO> replyDeleteProcess(int shop_num, int sreply_num) {
		System.out.println("service in");
		/* System.out.println("shop_num : " + rdto.getShop_num()); */
		System.out.println("shop_num : " + shop_num);

		// 1.댓글을 삭제하는 dao메소드 호출
		dao.replyFileDeleteMethod(sreply_num); // 파일삭제
		dao.replyDeleteMethod(sreply_num); // 댓글삭제

		System.out.println("댓글, 멀티파일  delete 후 comback service");
		/* System.out.println("rdto.getShop_num() : " + rdto.getShop_num()); */
		System.out.println("shop_num : " + shop_num);

		// 별점도 수정하고 가자
		dao.starUpdateMethod(shop_num);

		// 2.댓글 삭제 후 모든 댓글을 리스트에 담아 출력해주는 dao 메소드 호출
		return dao.replyListMethod(shop_num);
	}

	// 후기 댓글 수정시 선택했던 파일들의 값을 가져올 메소드
	@Override
	public List<Shopping_FileDTO> replyUpdateFileProcess(int sreply_num) {
		System.out.println("service in");
		return dao.replyUpdateFileMethod(sreply_num);
	}

	// 후기 댓글 수정
	@Override
	public List<Shopping_ReplyDTO> replyUpdateProcess(Shopping_ReplyDTO rdto) {
		System.out.println("*********수정 service 들어옴**********");
		// 멀피파일 이외의 정보 수정
		System.out.println("====>멀티 파일 말고 다른거 수정하기 위한 dao 호출함<====");
		dao.replyUpdateMethod(rdto);
		System.out.println("====>다시 dao 왔다.<====");
		// 멀티파일 수정
		// 1.기존에 있던 멀티 파일 삭제 -> 기존에 있던 파일중 삭제할 파일만 삭제
		System.out.println("====>기존에 있던 멀티 파일 삭제할 dao 호출함<====");
		// dao.replyFileDeleteMethod(rdto.getSreply_num());

		// 추가
		// 기존에 있던 파일이 아무것도 남아 있지 않을 경우는 하지 않음
		if (rdto.getOldFileList() != null) {
			dao.replyOtherFileDeleteMethod(rdto);
		} else {
			dao.replyOldFileDeleteAll(rdto.getSreply_num());
		}

		/* dao.replyOtherFileDeleteMethod(rdto); */

		System.out.println("====>다시 dao 왔다.<====");
		// 2.새롭게 멀티 파일 추가
		System.out.println("====>새로운 멀티파일 추가할 dao 호출함<====");
		dao.multiInsertMethod(rdto);
		System.out.println("====>다시 dao 왔다.<====");

		// 별점도 수정하고 가자
		dao.starUpdateMethod(rdto.getShop_num());

		// 수정된 리스트로 다시 검색해서 가지고 옴
		System.out.println("====>전체 리스트 불러오는 dao호출함<====");
		return dao.replyListMethod(rdto.getShop_num());
	}

	// 해당 상품에 대한 회원의 배송 상태 여부를 검색
	@Override
	public List<Integer> purConditionProcess(PurchaseDTO pdto) {
		return dao.purConditionMethod(pdto);
	}

	// 별점 추가하기 위한 메소드
	@Override
	public void starUpdateMethod(int shop_num) {
		dao.starUpdateMethod(shop_num);
	}

}