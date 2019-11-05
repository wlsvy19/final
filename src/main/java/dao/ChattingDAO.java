package dao;

import java.util.List;

import dto.ChattingDTO;

public interface ChattingDAO {

	/* 회원 입장 채팅 문의하기 리스트 출력 */
	public List<ChattingDTO> user_chat_list(String sendid);

	/* 회원 입장 채팅 문의하기 입력 */
	public void user_chat_insert(ChattingDTO dto);

	public List<ChattingDTO> managerChatList(String chat_receiver);

	public void managerChatInsert(ChattingDTO dto);

	/* 혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린 */
	/* 중복없이 아이디당 최신값들 리스트 받아오기 */
	public List<ChattingDTO> forManagerListAll();

	/* 혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린 */
}
