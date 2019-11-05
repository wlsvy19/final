package dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import dto.ChattingDTO;

public class ChattingDaoImp implements ChattingDAO {
	private SqlSessionTemplate sqlSession;

	public ChattingDaoImp() {

	}// end BoardDaoImp()

	/* 생성자 */
	public ChattingDaoImp(SqlSessionTemplate sqlSession) {
		this.sqlSession = sqlSession;
	}

	/* 프로퍼티 ====== 둘 중에 하나만 골라서 해라. */
	public void setSqlSession(SqlSessionTemplate sqlSession) {
		this.sqlSession = sqlSession;
	}

	/* 회원 입장 채팅 문의하기 리스트 출력 */
	@Override
	public List<ChattingDTO> user_chat_list(String sendid) {
		System.out.println("다오임프 sendid================>" + sendid);
		return sqlSession.selectList("chat.user_chat_list", sendid);
	}

	/* 회원 입장 채팅 문의하기 입력 */
	@Override
	public void user_chat_insert(ChattingDTO dto) {
		System.out.println("다오임프 아이디 =========>" + dto.getChat_sendid());
		System.out.println("다오임프 컨텐츠 ==========>" + dto.getChat_content());
		sqlSession.insert("chat.user_chat_insert", dto);
	}

	@Override
	public List<ChattingDTO> managerChatList(String chat_receiver) {
		return sqlSession.selectList("chat.managerChatList", chat_receiver);
	}

	@Override
	public void managerChatInsert(ChattingDTO dto) {
		sqlSession.insert("chat.managerChatInsert", dto);
	}

	/* 혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린 */
	/* 중복없이 아이디당 최신값들 리스트 받아오기 */
	@Override
	public List<ChattingDTO> forManagerListAll() {
		System.out.println("관리자 채팅 목록 dao in and go mapper");
		return sqlSession.selectList("chat.manager_chatAll");
	}

	/* 혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린 */
}// end class