package service;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.BoardDTO;
import dto.MemberDTO;
import dto.PurchaseDTO;
import dto.Shopping_LikeDTO;

public interface MemberService {
	// 회원가입 프로세스
	public void memberJoinProcess(MemberDTO dto);

	// 로그인 처리 프로세스
	public boolean loginCheckProcess(MemberDTO dto, HttpSession session);

	// 회원정보
	public MemberDTO viewMemberProcess(MemberDTO dto);

	// 로그아웃 처리 프로세스
	public void logoutMethod(HttpSession session);

	// 아이디찾기 프로세스(이름,이메일 사용)
	public String idSearchProcess(HttpServletResponse resp, MemberDTO dto) throws IOException;

	// 비밀번호 프로세스(아이디,생년월일 사용)
	public String pwSearchProcess(HttpServletResponse resp, MemberDTO dto) throws IOException;

	// 개인정보수정 프로세스
	public void memberUpdateProcess(MemberDTO dto);

	// 아이디찾기 프로세스
	public int idCheckProcess(String mem_id);

	// 회원탈퇴 메소드
	public void memberDeleteProcess(String mem_id);

	// 회원정보 삭제를 위한 비밀번호 체크
	public boolean checkPwProcess(String mem_id, String mem_pw);

	/* 마이페이지 회원 아이디, 포인트 가져오기 */
	public MemberDTO id_point(String mem_id);

	/* 내가 작성한 게시글 가져오기 */
	public List<BoardDTO> my_board(String mem_id);

	/* 배송 중 리스트 출력 */
	public List<PurchaseDTO> PurchaseList(String mem_id);

	public void hobbyInsertProcess(MemberDTO dto);

	/*관심상품 출력하기*/
	public List<Shopping_LikeDTO> member_like(String mem_id);

}
