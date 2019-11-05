<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="css/board/board_update.css" type="text/css" rel="stylesheet" />
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$('#update').bind('click', updateRun);
		$("#back").bind('click',backRun);
		$('[name=board_content]').val($('[name=board_content]').val().trim());
		$('[name=board_content]').val($('[name=board_content]').val().replace(/<br\s?\/?>/g, "\n"));
	});

	function updateRun() {
		$('[name=board_content]').val($('[name=board_content]').val().replace(/\n/gi, '<br/>'));
		$('#frm').attr('action', 'update.do').submit();
		alert('게시글이 수정되었습니다.');
	}
	
	function backRun(){
		//history.back();
		history.go(-1);
	}
</script>
</head>
<body>
<div id = all>
	<div class = "writeintro">
		<h3 class = "qnawrite">수정하기</h3>
	<hr/>
	</div>
	
	<form name="frm" id="frm" method="post" enctype="multipart/form-data">
		<table>
			<tr>
				<td>카테고리</td>
				<td>
					<select id = "category" name="board_type">
  						<option>배송</option>
  						<option>주문/결제</option>
  						<option>취소/교환</option>
  						<option>기타</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>작성자</th>
				<td>${dto.board_writer}</td>
			</tr>

			<tr>
				<td>제목</th>
				<td><input type="text" name="board_title" id="subject" value="${dto.board_title}" /></td>
			</tr>

			
			<tr>
				<td>내용</th>
				<td>
				<textarea name="board_content" rows="13" cols="40" id="board_content">
						${dto.board_content}
				</textarea>
				</td>
			</tr>

			<tr>
				<td>첨부파일</th>
				<td><input type="file" name="filename" /> <span>${fn:substringAfter(dto.board_file, "_") }</span>
				</td>
			</tr>
		</table>
		
		
		<div class = "button">
		<input type="hidden" name="board_num" value="${dto.board_num}" /> 
		<input type="hidden" name="currentPage" value="${currentPage}" />
			
			<span class = "button1"> 
				<input type="button" id="update" value="수정" />
		 	</span>
		 	<span class = "button2">
				<input type="button" id="back" value="취소" />
			</span>
		</div>	
	</form>
</div>
</body>
</html>









