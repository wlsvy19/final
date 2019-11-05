package dto;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class Board_FileDTO {
	private int board_num; 
	private List<MultipartFile> board_file;
	
	public Board_FileDTO() {

	}//end Board_FileDTO()

	public int getBoard_num() {
		return board_num;
	}

	public void setBoard_num(int board_num) {
		this.board_num = board_num;
	}

	public List<MultipartFile> getBoard_file() {
		return board_file;
	}

	public void setBoard_file(List<MultipartFile> board_file) {
		this.board_file = board_file;
	}
	
	
}//end class
