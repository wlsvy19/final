package service;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MemberDAO;
import dto.BoardDTO;
import dto.MemberDTO;
import dto.PurchaseDTO;
import dto.Shopping_LikeDTO;

public class MemberServiceImp implements MemberService {
	private MemberDAO dao;

	public void setDao(MemberDAO dao) {
		this.dao = dao;
	}

	// 회원가입
	@Override
	public void memberJoinProcess(MemberDTO dto) {
		dao.memberJoinMethod(dto);
	}

	// 로그인 처리
	@Override
	public boolean loginCheckProcess(MemberDTO dto, HttpSession session) {
		boolean result = dao.loginCheckMethod(dto);

		if (result == true) {// true일경우 세션에 등록

			MemberDTO viewMember = viewMemberProcess(dto);
			// 세션에 변수 등록
			session.setAttribute("mem_id", viewMember.getMem_id());
			session.setAttribute("mem_name", viewMember.getMem_name());
			session.setAttribute("mem_birth", viewMember.getMem_birth());
			session.setAttribute("mem_email", viewMember.getMem_email());
			session.setAttribute("mem_phone", viewMember.getMem_phone());
			session.setAttribute("mem_gender", viewMember.getMem_gender());
			session.setAttribute("mem_hobby", viewMember.getMem_hobby());

			session.setAttribute("mem_oaddress", viewMember.getMem_oaddress());
			session.setAttribute("mem_address", viewMember.getMem_address());
			session.setAttribute("mem_detailaddress", viewMember.getMem_detailaddress());
		}
		return result;
	}

	@Override
	public MemberDTO viewMemberProcess(MemberDTO dto) {
		return dao.viewMemberMethod(dto);
	}

	@Override
	public void logoutMethod(HttpSession session) {
		// 세션종료
		session.invalidate();
	}

	@Override
	public String idSearchProcess(HttpServletResponse resp, MemberDTO dto) throws IOException {
		String mem_id = dao.idSearchMethod(dto);
		return mem_id;
	}

	@Override
	public String pwSearchProcess(HttpServletResponse resp, MemberDTO dto) throws IOException {
		String mem_pw = dao.pwSearchMethod(dto);
		return mem_pw;
	}

	@Override
	public void memberUpdateProcess(MemberDTO dto) {
		dao.memberUpdateMethod(dto);
	}

	@Override
	public int idCheckProcess(String mem_id) {
		return dao.idCheckMethod(mem_id);

	}

	@Override
	public void memberDeleteProcess(String mem_id) {
		dao.memberDeleteMethod(mem_id);
	}

	@Override
	public boolean checkPwProcess(String mem_id, String mem_pw) {
		return dao.checkPwMethod(mem_id, mem_pw);
	}

	/* 마이페이지 회원 아이디, 포인트 가져오기 */
	@Override
	public MemberDTO id_point(String mem_id) {
		return dao.id_point(mem_id);
	}

	/* 내가 작성한 게시글 가져오기 */
	@Override
	public List<BoardDTO> my_board(String mem_id) {
		System.out.println("daoimp ++++++++++++++" + mem_id);
		return dao.my_board(mem_id);
	}

	/* 배송 중 리스트 출력 */
	@Override
	public List<PurchaseDTO> PurchaseList(String mem_id) {
		return dao.purchaseListMethod(mem_id);
	}

	@Override
	public void hobbyInsertProcess(MemberDTO dto) {
		dao.hobbyInsert(dto);
	}

	@Override
	public List<Shopping_LikeDTO> member_like(String mem_id){
		return dao.member_like(mem_id);
	}
	
}