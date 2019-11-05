package dto;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonFormat;

public class BoardDTO {
	private int board_num;
	private String board_writer;
	private String board_title;
	
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date board_regdate;
	
	private int board_count;
	private String board_content;
	private int board_ref;
	private int board_re_step;
	private int board_re_level;
	private String board_file;
	private String board_type;
	// form 페이지에서 파일첨부를 받아 처리해주는 멤버변수 + jsp 속성 값과 같게 해준다.
	private MultipartFile filename;
	
	private List<Board_ReplyDTO> replyList;

	
	public BoardDTO() {

	}// end BoardDTO()

	public int getBoard_num() {
		return board_num;
	}

	public void setBoard_num(int board_num) {
		this.board_num = board_num;
	}

	public String getBoard_writer() {
		return board_writer;
	}

	public void setBoard_writer(String board_writer) {
		this.board_writer = board_writer;
	}

	public String getBoard_title() {
		return board_title;
	}

	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}

	public Date getBoard_regdate() {
		return board_regdate;
	}

	public void setBoard_regdate(Date board_regdate) {
		this.board_regdate = board_regdate;
	}

	public int getBoard_count() {
		return board_count;
	}

	public void setBoard_count(int board_count) {
		this.board_count = board_count;
	}

	public String getBoard_content() {
		return board_content;
	}

	public void setBoard_content(String board_content) {
		this.board_content = board_content;
	}

	public int getBoard_ref() {
		return board_ref;
	}

	public void setBoard_ref(int board_ref) {
		this.board_ref = board_ref;
	}

	public int getBoard_re_step() {
		return board_re_step;
	}

	public void setBoard_re_step(int board_re_step) {
		this.board_re_step = board_re_step;
	}

	public int getBoard_re_level() {
		return board_re_level;
	}

	public void setBoard_re_level(int board_re_level) {
		this.board_re_level = board_re_level;
	}

	public String getBoard_file() {
		return board_file;
	}

	public void setBoard_file(String board_file) {
		this.board_file = board_file;
	}

	public MultipartFile getFilename() {
		return filename;
	}

	public void setFilename(MultipartFile filename) {
		this.filename = filename;
	}

	public String getBoard_type() {
		return board_type;
	}

	public void setBoard_type(String board_type) {
		this.board_type = board_type;
	}

	public List<Board_ReplyDTO> getReplyList() {
		return replyList;
	}

	public void setReplyList(List<Board_ReplyDTO> replyList) {
		this.replyList = replyList;
	}

}// end class
