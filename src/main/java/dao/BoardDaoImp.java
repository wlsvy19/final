package dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import dto.BoardDTO;
import dto.Board_ReplyDTO;
import dto.NoticeDTO;
import dto.PageDTO;

public class BoardDaoImp implements BoardDAO {
	private SqlSessionTemplate sqlSession;

	public BoardDaoImp() {

	}// end BoardDaoImp()
	
	/*게시글*//*게시글*//*게시글*//*게시글*//*게시글*//*게시글*//*게시글*//*게시글*/
	/*게시글*//*게시글*//*게시글*//*게시글*//*게시글*//*게시글*//*게시글*//*게시글*/
	/*게시글*//*게시글*//*게시글*//*게시글*//*게시글*//*게시글*//*게시글*//*게시글*/
	
	/* 생성자 */
	public BoardDaoImp(SqlSessionTemplate sqlSession) {
		this.sqlSession = sqlSession;
	}

	/* 프로퍼티 ====== 둘 중에 하나만 골라서 해라. */
	public void setSqlSession(SqlSessionTemplate sqlSession) {
		this.sqlSession = sqlSession;
	}

	/* 전체 레코드 수 */
	@Override
	public int count() {
		return sqlSession.selectOne("board.count");
	}// end count()

	/* 현재 페이지에서 몇번째 레코드에서 몇번째 레코드까지 가져올지 */
	@Override
	public List<BoardDTO> list(PageDTO pv) {
		return sqlSession.selectList("board.list", pv);
	}// end list()

	// readCount() 와 content() 는 하나의 트랜잭션으로 같이 처리되어야 한다.
	@Override
	public void readCount(int num) {
		sqlSession.update("board.readCount", num);
	}// end readCount()

	@Override
	public BoardDTO content(int num) {
		return sqlSession.selectOne("board.content", num);
	}// end content()

	// 답변글일때 호출되어야함
	@Override
	public void reStepCount(BoardDTO dto) {
		sqlSession.update("board.reStepCount", dto);
	}// end reStepCount()

	// 글쓰기,답변글쓰기
	@Override
	public void save(BoardDTO dto) {
		sqlSession.insert("board.save", dto);
	}// end save()

	@Override
	public BoardDTO updateNum(int num) {
		// view.jsp 와 update.jsp 에 뿌려주는 건 같다.
		return sqlSession.selectOne("board.content", num);
	}// end updateNum()

	@Override
	public void update(BoardDTO dto) {
		sqlSession.update("board.upt", dto);
	}// end updateNum()

	@Override
	public void replydel(int num) {
		sqlSession.delete("board.replydel", num);
	}

	@Override
	public void delete(int num) {
		sqlSession.delete("board.del", num);
	}// end delete()

	@Override
	public void replydel2(int num) {
		sqlSession.delete("board.replydel2", num);
	}

	@Override
	public void delete2(int num) {
		sqlSession.delete("board.del2", num);
	}// end delete()

	@Override
	public String getFile(int num) {
		return sqlSession.selectOne("board.uploadFile", num);
	}// end getFile()

	/*댓글 *//*댓글 *//*댓글 *//*댓글 *//*댓글 *//*댓글 *//*댓글 *//*댓글 *//*댓글 *//*댓글 */
	/*댓글 *//*댓글 *//*댓글 *//*댓글 *//*댓글 *//*댓글 *//*댓글 *//*댓글 *//*댓글 *//*댓글 */
	/*댓글 *//*댓글 *//*댓글 *//*댓글 *//*댓글 *//*댓글 *//*댓글 *//*댓글 *//*댓글 *//*댓글 */

	@Override
	public List<BoardDTO> boardListMethod() {
		return sqlSession.selectList("board.b_list");
	}

	@Override
	public BoardDTO boardviewMethod(int bno) {
		return sqlSession.selectOne("board.b_view", bno);
	}

	@Override
	public void replyInsertMethod(Board_ReplyDTO rdto) {
		sqlSession.insert("reply.r_insert", rdto);
	}

	@Override
	public List<Board_ReplyDTO> replyListMethod(int bno) {
		return sqlSession.selectList("reply.r_list", bno);
	}

	@Override
	public void replyDeleteMethod(int rno) {
		sqlSession.delete("reply.r_delete", rno);
	}

	@Override
	public void replyUpdateMethod(Board_ReplyDTO rdto) {
		sqlSession.update("reply.r_update", rdto);
	}
	
	/*카테고리*//*카테고리*//*카테고리*//*카테고리*//*카테고리*//*카테고리*//*카테고리*/
	/*카테고리*//*카테고리*//*카테고리*//*카테고리*//*카테고리*//*카테고리*//*카테고리*/
	/*카테고리*//*카테고리*//*카테고리*//*카테고리*//*카테고리*//*카테고리*//*카테고리*/
	
	/* 카테고리별 list 출력 */
	@Override
	public List<BoardDTO> category_list(HashMap<String, Object> map) {
		return sqlSession.selectList("board.category_list", map);
	}

	/* 카테고리별 레코드 수 출력 */
	@Override
	public int category_count(String category) {
		return sqlSession.selectOne("board.category_count", category);
	}// end count()

	/*공지사항*//*공지사항*//*공지사항*//*공지사항*//*공지사항*//*공지사항*//*공지사항*/
	/*공지사항*//*공지사항*//*공지사항*//*공지사항*//*공지사항*//*공지사항*//*공지사항*/
	/*공지사항*//*공지사항*//*공지사항*//*공지사항*//*공지사항*//*공지사항*//*공지사항*/
	
	/* 관리자 공지사항 레코드 수 출력 */
	@Override
	public int notice_count() {
		return sqlSession.selectOne("board.notice_count");
	}// end notice_count()

	/* 관리자 공지사항 list 출력 */
	@Override
	public List<NoticeDTO> notice_list(PageDTO pv) {
		return sqlSession.selectList("board.notice_list", pv);
	}// end list()

	// readCount() 와 content() 는 하나의 트랜잭션으로 같이 처리되어야 한다.
	@Override
	public void notice_readCount(int num) {
		sqlSession.update("board.notice_readCount", num);
	}// end readCount()

	@Override
	public NoticeDTO notice_content(int num) {
		return sqlSession.selectOne("board.notice_content", num);
	}// end content()

	// 글쓰기,답변글쓰기
	@Override
	public void notice_save(NoticeDTO dto) {
		sqlSession.insert("board.notice_save", dto);
	}// end save()

	@Override
	public NoticeDTO notice_updateNum(int num) {
		// view.jsp 와 update.jsp 에 뿌려주는 건 같다.
		return sqlSession.selectOne("board.notice_content", num);
	}// end updateNum()

	@Override
	public void notice_update(NoticeDTO dto) {
		sqlSession.update("board.notice_upt", dto);
	}// end updateNum()

	@Override
	public void notice_delete(int num) {
		sqlSession.delete("board.notice_del", num);
	}// end delete()
	
	@Override
	public String notice_getFile(int num) {
		return sqlSession.selectOne("board.notice_uploadFile", num);
	}// end getFile()

	
	/*검색*//*검색*//*검색*//*검색*//*검색*//*검색*//*검색*//*검색*//*검색*//*검색*//*검색*//*검색*//*검색*//*검색*/
	/*검색*//*검색*//*검색*//*검색*//*검색*//*검색*//*검색*//*검색*//*검색*//*검색*//*검색*//*검색*//*검색*//*검색*/
	/*검색*//*검색*//*검색*//*검색*//*검색*//*검색*//*검색*//*검색*//*검색*//*검색*//*검색*//*검색*//*검색*//*검색*/
	
	/* Q&A 검색 리스트 카운트*/
	@Override
	public int search_count(BoardDTO dto) {
		return sqlSession.selectOne("board.search_count", dto);
	}// end count()
	
	/* Q&A 검색 리스트 출력*/
	@Override
	public List<BoardDTO> board_search(HashMap<String, Object> map) {
		return sqlSession.selectList("board.board_search", map);
	}
	
	/* notice 검색 리스트 카운트*/
	@Override
	public int noticesearch_count(NoticeDTO dto) {
		return sqlSession.selectOne("board.notice_searchcount", dto);
	}// end count()
	
	/* notice 검색 리스트 출력*/
	@Override
	public List<NoticeDTO> notice_search(HashMap<String, Object> map) {
		return sqlSession.selectList("board.notice_search", map);
	}
	
	/*메인페이지 공지사항 출력용*/
	@Override
	public List<NoticeDTO> main_notice(PageDTO pv) {
		return sqlSession.selectList("board.main_notice", pv);
	}// end list()
	
	
}// end class