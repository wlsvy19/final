package dto;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class Shopping_ReplyDTO {
   private int shop_num; //int -> Integer -> int
   private int sreply_num;
   private String sreply_writer;
   private String sreply_content;
   private Date sreply_regdate;
   private int sreply_star;
   
   private List<Shopping_FileDTO> mFileList; //resultmap 사용을 하기 위한 변수 선언
   
   private List<MultipartFile> filename;
   
   private List<String> oldFilename; //삭제되지 않고 남아있을 기존의 파일 명을 받아올 리스트
   
   private List<Shopping_FileDTO> oldFileList;
   
   public Shopping_ReplyDTO() {
      
   }//end Shopping_ReplyDTO()

   public int getShop_num() {
      return shop_num;
   }

   public void setShop_num(int shop_num) {
      this.shop_num = shop_num;
   }

   public int getSreply_num() {
      return sreply_num;
   }

   public void setSreply_num(int sreply_num) {
      this.sreply_num = sreply_num;
   }

   public String getSreply_writer() {
      return sreply_writer;
   }

   public void setSreply_writer(String sreply_writer) {
      this.sreply_writer = sreply_writer;
   }

   public String getSreply_content() {
      return sreply_content;
   }

   public void setSreply_content(String sreply_content) {
      this.sreply_content = sreply_content;
   }

   public Date getSreply_regdate() {
      return sreply_regdate;
   }

   public void setSreply_regdate(Date sreply_regdate) {
      this.sreply_regdate = sreply_regdate;
   }

   public int getSreply_star() {
      return sreply_star;
   }

   public void setSreply_star(int sreply_star) {
      this.sreply_star = sreply_star;
   }

   public List<Shopping_FileDTO> getmFileList() {
      return mFileList;
   }

   public void setmFileList(List<Shopping_FileDTO> mFileList) {
      this.mFileList = mFileList;
   }

   public List<MultipartFile> getFilename() {
      return filename;
   }

   public void setFilename(List<MultipartFile> filename) {
      this.filename = filename;
   }

   public List<String> getOldFilename() {
      return oldFilename;
   }

   public void setOldFilename(List<String> oldFilename) {
      this.oldFilename = oldFilename;
   }

   public void setShop_num(Integer shop_num) {
      this.shop_num = shop_num;
   }

   public List<Shopping_FileDTO> getOldFileList() {
      return oldFileList;
   }

   public void setOldFileList(List<Shopping_FileDTO> oldFileList) {
      this.oldFileList = oldFileList;
   }
   
   
   
}//end class