package service;

import java.util.List;

import dao.ChattingDAO;
import dto.ChattingDTO;

public class ChattingServiceImp implements ChattingService {
	private ChattingDAO dao;

	public ChattingServiceImp() {

	}

	public void setDao(ChattingDAO dao) {
		this.dao = dao;
	}

	/* 회원 입장 채팅 문의하기 리스트 출력 */
	@Override
	public List<ChattingDTO> user_chat_list(String sendid) {
		return dao.user_chat_list(sendid);
	}

	/* 회원 입장 채팅 문의하기 입력 */
	@Override
	public List<ChattingDTO> user_chat_insert(ChattingDTO dto) {
		System.out.println("서비스 임프 컨텐츠===============>" + dto.getChat_content());
		System.out.println("서비스 임프 sendid ============>" + dto.getChat_sendid());

		dao.user_chat_insert(dto);
		return dao.user_chat_list(dto.getChat_sendid());
	}

	@Override
	public List<ChattingDTO> managerChatListProcess(String chat_receiver) {
		return dao.managerChatList(chat_receiver);
	}

	@Override
	public void managerChatInsertProcess(ChattingDTO dto) {
		dao.managerChatInsert(dto);
	}

	/* 혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린 */
	/* 중복없이 아이디당 최신값들 리스트 받아오기 */
	@Override
	public List<ChattingDTO> forManagerListAll() {
		System.out.println("service in and dao 호출");
		return dao.forManagerListAll();
	}

	/* 혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린 */

}// end class