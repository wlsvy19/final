package dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import dto.MemberDTO;
import dto.PurchaseDTO;
import dto.ShoppingDTO;
import dto.Shopping_CartDTO;
import dto.Shopping_FileDTO;
import dto.Shopping_InfoDTO;
import dto.Shopping_LikeDTO;
import dto.Shopping_ReplyDTO;

public class ShoppingDaoImp implements ShoppingDAO {
	private SqlSessionTemplate sqlSession;

	public ShoppingDaoImp() {

	}

	public void setSqlSession(SqlSessionTemplate sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public List<ShoppingDTO> shopListMethod(String category, String selectOption) {
		if (category.equals("전체")) {
			if (selectOption.equals("등록")) {
				return sqlSession.selectList("shopping.all");
			} else if (selectOption.equals("별점")) {
				return sqlSession.selectList("shopping.allb");
			} else {
				return sqlSession.selectList("shopping.allp");
			}
		} else {
			if (selectOption.equals("등록")) {
				return sqlSession.selectList("shopping.list", category);
			} else if (selectOption.equals("별점")) {
				return sqlSession.selectList("shopping.listb", category);
			} else {
				return sqlSession.selectList("shopping.listp", category);
			}
		}
	}

	@Override
	public ShoppingDTO shopInfoMethod(int shop_num) {
		return sqlSession.selectOne("shopping.info", shop_num);
	}

	@Override
	public void shopLikeOn(Shopping_LikeDTO dto) {
		sqlSession.insert("shopping.likeOn", dto);
	}

	@Override
	public void shopLikeOff(Shopping_LikeDTO dto) {
		sqlSession.delete("shopping.likeOff", dto);
	}

	@Override
	public List<Shopping_LikeDTO> shopLikeChk(Shopping_LikeDTO dto) {
		return sqlSession.selectList("shopping.likeChk", dto);
	}

	@Override
	public void shopCartIn(Shopping_CartDTO dto) {
		sqlSession.insert("shopping.cartIn", dto);
	}

	@Override
	public void shopCartOut(Shopping_CartDTO dto) {
		sqlSession.delete("shopping.cartDel", dto);
	}

	@Override
	public List<Shopping_CartDTO> shopNum(Shopping_CartDTO dto) {
		return sqlSession.selectList("shopping.cartNum", dto);
	}

	@Override
	public List<Integer> shopCartInfo(String mem_id) {
		return sqlSession.selectList("shopping.cartList", mem_id);
	}

	@Override
	public void shopCartUpdate(Shopping_CartDTO dto) {
		sqlSession.update("shopping.cartUpt", dto);
	}

	@Override
	public List<ShoppingDTO> shopCartInfoMethod(String mem_id) {
		return sqlSession.selectList("shopping.cartInfo", mem_id);
	}

	@Override
	public MemberDTO payMemInfo(String mem_id) {
		return sqlSession.selectOne("shopping.payMemInfo", mem_id);
	}

	@Override
	public void payComplete(String mem_id) {
		sqlSession.delete("shopping.payComplete", mem_id);
	}

	@Override
	public void purchaseIn(PurchaseDTO dto) {
		sqlSession.insert("shopping.puchaseIn", dto);
	}

	@Override
	public void shoppingUpt(PurchaseDTO dto) {
		sqlSession.update("shopping.shoppingUpt", dto);
	}

	@Override
	public void memPointMethod(MemberDTO memberDTO) {
		sqlSession.update("shopping.memPointUpt", memberDTO);
	}

	/////////////////////////////////////////////////////////////////////////////////////////////////////////

	// 후기 댓글 추가를 위한 메소드
	@Override
	public void replyInsertMethod(Shopping_ReplyDTO rdto) {
		System.out.println("dao in");
		System.out.println("==replyNum넣기 전======================================================");
		for (Shopping_FileDTO fdto : rdto.getmFileList()) {
			System.out.println("fdto.getShop_num() : " + fdto.getShop_num());
			System.out.println("fdto.getShop_file() : " + fdto.getShop_file());
			System.out.println("fdto.getSreply_num() : " + fdto.getSreply_num()); // 0값 -> 아직 댓글이 댓글 번호를 받기 전에 받은 값이므로
			// 0값을 가지고 있다.
		}

		// 댓글추가
		sqlSession.insert("shopping.deplyInsert", rdto);

		// 방금 추가한 댓글의 번호
		int replyNum = sqlSession.selectOne("shopping.deplyNum");

		System.out.println("*****************************");
		System.out.println("replyNum : " + replyNum);

		System.out.println("==replyNum넣기======================================================");
		for (Shopping_FileDTO fdto : rdto.getmFileList()) {
			System.out.println("fdto.getShop_num() : " + fdto.getShop_num());
			System.out.println("fdto.getShop_file() : " + fdto.getShop_file());

			fdto.setSreply_num(replyNum);
			System.out.println("fdto.getSreply_num() : " + fdto.getSreply_num());

			sqlSession.insert("shopping.deplyMultiInsert", fdto);
		}
	}

	// 후기 댓글 전체 리스트 불러오는 메소드
	@Override
	public List<Shopping_ReplyDTO> replyListMethod(int shop_num) {
		System.out.println("*********후기 댓글 전체 불러오기 위한 dao 들어왔다**********");
		System.out.println("shop_num : " + shop_num);
		return sqlSession.selectList("shopping.deplyAll", shop_num);
	}

	// 후기 댓글 삭제를 위한 메소드
	@Override
	public void replyDeleteMethod(int sreply_num) {
		System.out.println("후기 댓글 삭제");
		System.out.println("sreply_num : " + sreply_num);
		sqlSession.delete("shopping.sreplyDelete", sreply_num);
	}

	// 후기 댓글의 멀티파일 삭제를 위한 메소드
	@Override
	public void replyFileDeleteMethod(int sreply_num) {
		System.out.println("*********멀티 파일 삭제 dao 들어왔다**********");
		System.out.println("sreply_num : " + sreply_num);
		sqlSession.delete("shopping.sreplyFileDelete", sreply_num);

	}

	// 후기 수정할때 선택한 이미지를 받아올 것
	@Override
	public List<Shopping_FileDTO> replyUpdateFileMethod(int sreply_num) {
		System.out.println("dao in");
		return sqlSession.selectList("shopping.sreplyUpdateFile", sreply_num);
	}

	// 후기 댓글 멀티파일 이외에 수정하는 메소드
	@Override
	public void replyUpdateMethod(Shopping_ReplyDTO rdto) {
		System.out.println("*********멀티 파일 이외 수정 dao 들어왔다**********");
		System.out.println("====>update mapper 연결했다.<====");
		sqlSession.update("shopping.sreplyUpdateOther", rdto);
	}

	// 새롭게 수정한 멀티파일을 추가하기 위한 메소드
	@Override
	public void multiInsertMethod(Shopping_ReplyDTO rdto) {
		System.out.println("*********멀티 파일 추가 전용 dao 들어왔다**********");
		// 이 과정을 처리하기 위해선 mFileList에 shop_num, sreply_num. shop_file이 모두 들어 있어야 함 ->
		// 컨트롤러에서 처리해서 올것
		for (Shopping_FileDTO fdto : rdto.getmFileList()) {
			System.out.println("====>insert mapper 연결했다.<====");
			sqlSession.insert("shopping.deplyMultiInsert", fdto);
		}

	}

	// 기존에 있던 파일중 남아 있어야 하는것 이외의 파일들 삭제하기 위한 메소드
	@Override
	public void replyOtherFileDeleteMethod(Shopping_ReplyDTO rdto) {
		for (Shopping_FileDTO fdto : rdto.getOldFileList()) {
			System.out.println("====>delete mapper 연결했다.<====");
			sqlSession.delete("shopping.sdeplyDeleteOther", fdto);
		}
	}

	// 해당 상품에 대한 회원의 배송 상태여부를 가지고 오기 위한 메소드
	@Override
	public List<Integer> purConditionMethod(PurchaseDTO pdto) {
		return sqlSession.selectList("shopping.purCondition", pdto);
	}

	// 별점 계산하여 처리하기 위한 메소드
	@Override
	public void starUpdateMethod(int shop_num) {
		// 1.별점 계산
		System.out.println("별점 계산 Mapper 연결");
		double star = sqlSession.selectOne("shopping.starCnt", shop_num);
		// 2.상품 테이블에 업로드
		ShoppingDTO dto = new ShoppingDTO();
		dto.setShop_starcnt(star);
		dto.setShop_num(shop_num);
		System.out.println("상품 테이블에 업로드 Mapper 연결");
		sqlSession.update("shopping.star_up", dto);
		// 3.상품 정보 테이블에 업로드
		Shopping_InfoDTO idto = new Shopping_InfoDTO();
		idto.setShopInfo_starcnt(star);
		idto.setShopInfo_num(shop_num);
		System.out.println("상품 정보 테이블에 업로드 Mapper 연결");
		sqlSession.update("shopping.starInfo_up", idto);
	}

	// 추가
	@Override
	public void replyOldFileDeleteAll(int num) {
		sqlSession.update("shopping.sdeplyDeleteOldAll", num);
	}
}