package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;

import dto.BoardDTO;
import dto.MemberDTO;
import dto.PurchaseDTO;
import dto.ShoppingDTO;
import dto.Shopping_LikeDTO;

public class MemberDaoImp implements MemberDAO {
	private SqlSessionTemplate sqlSession;

	public MemberDaoImp() {

	}

	public void setSqlSession(SqlSessionTemplate sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void memberJoinMethod(MemberDTO dto) {
		sqlSession.insert("member.join", dto);

	}

	@Override
	public boolean loginCheckMethod(MemberDTO dto) {
		String name = sqlSession.selectOne("member.logincheck", dto);

		return (name == null) ? false : true;
	}

	@Override
	public MemberDTO viewMemberMethod(MemberDTO dto) {

		return sqlSession.selectOne("member.viewmember", dto);
	}

	@Override
	public void logoutMethod(HttpSession session) {

	}

	@Override
	public String idSearchMethod(MemberDTO dto) {

		return sqlSession.selectOne("member.idsearch", dto);
	}

	@Override
	public String pwSearchMethod(MemberDTO dto) {

		return sqlSession.selectOne("member.pwsearch", dto);
	}

	@Override
	public void memberUpdateMethod(MemberDTO dto) {
		sqlSession.update("member.update", dto);
	}

	@Override
	public int idCheckMethod(String mem_id) {
		return sqlSession.selectOne("member.idcheck", mem_id);

	}

	@Override
	public void memberDeleteMethod(String mem_id) {
		sqlSession.delete("member.delete", mem_id);

	}

	@Override
	public boolean checkPwMethod(String mem_id, String mem_pw) {
		boolean result = false;
		Map<String, String> map = new HashMap<String, String>();
		map.put("mem_id", mem_id);
		map.put("mem_pw", mem_pw);
		int count = sqlSession.selectOne("member.checkpw", map);
		if (count == 1)
			result = true;

		return result;
	}

	/* 마이페이지 회원 아이디, 포인트 가져오기 */
	@Override
	public MemberDTO id_point(String mem_id) {
		return sqlSession.selectOne("member.id_point", mem_id);
	}

	/* 내가 작성한 게시글 가져오기 */
	@Override
	public List<BoardDTO> my_board(String mem_id) {
		return sqlSession.selectList("member.my_board", mem_id);
	}

	/* 배송 중 리스트 출력 */
	@Override
	public List<PurchaseDTO> purchaseListMethod(String mem_id) {
		return sqlSession.selectList("member.member_purchase", mem_id);
	}

	@Override
	public void hobbyInsert(MemberDTO dto) {
		sqlSession.update("member.hobbyInput", dto);
	}

	/*관심 상품 가져오기*/
	@Override
	public List<Shopping_LikeDTO> member_like(String mem_id) {
		return sqlSession.selectList("member.member_like", mem_id);
	}
}
