package dao;

import java.util.List;

import javax.servlet.http.HttpSession;

import dto.BoardDTO;
import dto.MemberDTO;
import dto.PurchaseDTO;
import dto.Shopping_LikeDTO;

public interface MemberDAO {
	// 회원가입 메소드
	public void memberJoinMethod(MemberDTO dto);

	// 로그인 처리 메소드
	public boolean loginCheckMethod(MemberDTO dto);

	// 회원정보 메소드
	public MemberDTO viewMemberMethod(MemberDTO dto);

	// 로그아웃 처리 메소드
	public void logoutMethod(HttpSession session);

	// 아이디찾기 메소드(이름,이메일 사용)
	public String idSearchMethod(MemberDTO dto);

	// 비밀번호찾기 메소드(아이디,생년월일 사용)
	public String pwSearchMethod(MemberDTO dto);

	// 개인정보 수정 메소드
	public void memberUpdateMethod(MemberDTO dto);

	// 아이디중복체크 메소드
	public int idCheckMethod(String mem_id);

	// 회원탈퇴 메소드
	public void memberDeleteMethod(String mem_id);

	// 회원정보 삭제를 위한 비밀번호 체크
	public boolean checkPwMethod(String mem_id, String mem_pw);

	/* 마이페이지 회원 아이디, 포인트 가져오기 */
	public MemberDTO id_point(String mem_id);

	/* 내가 작성한 게시글 가져오기 */
	public List<BoardDTO> my_board(String mem_id);

	/* 배송 중 리스트 출력 */
	public List<PurchaseDTO> purchaseListMethod(String mem_id);

	public void hobbyInsert(MemberDTO dto);

	/*관심상품 가져오기*/
	public List<Shopping_LikeDTO> member_like(String mem_id);
}
