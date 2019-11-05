<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="css/board/notice_view.css" type="text/css" rel="stylesheet" />
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.11/handlebars.js"></script>
<script type="text/javascript">
	
	var urno = '';
	var fileList = [];
	

	$(document).ready(function() {
		$('#list').on('click', listRun);
		$('#update').on('click', updateRun);
		$('#delete').on('click', deleteRun);

		//댓글 수정,삭제 버튼에 click이벤트 연결
										
	});//end ready()/////////////////////////////////////////////////////
	/* ------------------------- 버튼기능 ------------------------- */
	function listRun() {
		$('#frm').attr('action', 'notice.do').submit();
	}

	function updateRun() {
		$('#frm').attr('action', 'notice_update.do').submit();
	}

	function deleteRun() {
		alert('게시글이 삭제되었습니다.');
		$('#frm').attr('action', 'notice_delete.do').submit();
	}
	
	/* ------------------------- 버튼기능 ------------------------- */
</script>
</head>
<body id="body">
<div id = all>
	<div class = "viewintro">
		<h3 class = "qnawrite">공지 사항</h3>
	<hr/>
			
	<table id = "table">
		<tr height="50px">
			<td class = "category" width="100px"> <p class = "pcategory">공 지</p></td>
			<td>${dto.notice_title}</td>
			<td width="150px"><c:if test="${!empty dto.notice_file}">
				<a href="contentdownload.do?num=${dto.notice_num}">
					<!-- 난수 값 잘라내고 저장 파일명만 화면에 출력 -->
					${fn:substringAfter(dto.notice_file,"_")} 
				</a>
			</c:if> 
			<c:if test="${empty dto.notice_file}">
				<c:out value="첨부파일 없음" />
			</c:if>
			</td>
			<td width="150px">작성자 : ${dto.notice_writer}</td>
			<td width="150px"><fmt:formatDate value="${dto.notice_regdate}" pattern="yyyy.MM.dd" /></td>
		</tr>
		
		<tr height="30px">
			<td colspan="6"></td>
		</tr>
		
		<tr height="200px">
			<td colspan="5">${dto.notice_content}</td>
		</tr>
	</table>

	<form name="frm" id="frm" method="get">
		<input type="hidden" name="num" value="${dto.notice_num}" /> 
		<input type="hidden" name="currentPage" id="currentPage" value="${currentPage}" /> 
		 
		<div id="multibutton">
			<input type="button" id="list" value="목록" />
			
			<!-- 수정, 삭제 관리자 권한 -->
			<c:if test="${dto.notice_writer == sessionScope.mem_id}">
				<input type="button" id="update" value="수정" />
				<input type="button" id="delete" value="삭제" />
			</c:if>
		</div>
	</form>
	<hr/>
	</div>
</div>
</body>
</html>







