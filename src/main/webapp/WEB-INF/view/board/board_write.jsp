<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="css/board/board_write.css" type="text/css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>

<script type="text/javascript">
  $(document).ready(function(){
	  $('#btnList').bind('click',function(){
		  $('#frm').attr('action','list.do');		
		  $('#frm').submit();
	  });
	  
	  $('#btnSave').bind('click',function(){
		  
		  if ($('#board_title').val() == '') {
				alert('제목을 입력하세요.');
				return false;
		  }else if ($('#board_content').val() == '') {
			  	alert('내용을 입력하세요.');
				return false;
		  }
		  
		  $('[name=board_content]').val($('[name=board_content]').val().replace(/\n/gi, '<br/>'));
		  $('#frm').attr('action','write.do').submit();
		  
		  alert('게시글 작성이 완료되었습니다.');
	  });
	  
	  //첨부파일 용량체크
	  $('#filepath').on('change',function(){						 
			 if(this.files && this.files[0]){				 
				if(this.files[0].size>1000000000){
					alert("1GB바이트 이하만 첨부할 수 있습니다.");				
					$('#filepath').val('');				
					return false;
				}				
			 }
		 });
  });
</script>

</head>
<body>
<div id = all>
	<div class = "writeintro">
	<c:if test="${dto==null}">
		<h3 class = "qnawrite">문의 작성하기</h3>
	</c:if>
	<c:if test="${dto!=null}">
		<h3 class = "qnawrite">답변 작성하기</h3>
	</c:if>
	<hr/>
	</div>
	
	<!-- 첨부파일이 있는 경우 인코딩을 multipart/form-data 타입으로 해야하며 -->
	<!-- multipart/form-data 타입인 경우 메소드는 post 타입으로 해야한다. -->
	<form name="frm" id="frm" method="post" enctype="multipart/form-data">
		<table>
			<tr>
				<td>카테고리</td>
				<c:if test="${dto==null}">
					<td>
						<select id = "category" name="board_type">
  							<option>배송</option>
  							<option>주문/결제</option>
  							<option>취소/교환</option>
  							<option>기타</option>
						</select>
					</td>
				</c:if>
				<c:if test="${dto!=null}">
					<td>
						<input name = "board_type"  readonly="readonly" style="border : 0px;" value="답변" />
					</td>
				</c:if>
			</tr>
			<tr>
				<td width="20%" >작성자</td>
		 <%
         //nana홈페이지 로그인
         Object mem_id = session.getAttribute("mem_id");
         //카카오 로그인시 정보 가져옴
         Object kemail = session.getAttribute("kemail");
         //네이버 로그인시 정보 가져옴
         Object nname = session.getAttribute("nname");
      	%>
            
         <%    
            if(mem_id != null){
         %>
            <td width="80%"><input type="text" value="${sessionScope.mem_id}" name="board_writer" size="10" maxlength="10" readonly="readonly" style="border : 0px;" /></td>
         <%
            }else if(kemail != null){
         %>   
            <td width="80%"><input type="text" value="${kemail}" name="board_writer" size="10" maxlength="10" readonly="readonly" style="border : 0px;" /></td>
         <%
            } else if(nname != null){
         %>
               <td width="80%"><input type="text" value="${nname}" name="board_writer" size="10" maxlength="10" readonly="readonly" style="border : 0px;" /></td>
         <%
            }
         %>
			</tr>

			<tr>
				<td width="20%" >제목</td>
				<td width="80%">				 			 
				<input type="text" name="board_title" size="40" id="board_title" /></td>
			</tr>

			<tr>
				<td width="20%">내용</td>
				<td width="80%"><textarea name="board_content" rows="13" cols="40" id="board_content" style="resize: none;"></textarea></td>
			</tr>

			<tr>
				<td width="20%">첨부파일</td>
				<td width="80%"><input type="file" name="filename" id="filepath"/></td>
			</tr>
		</table>
		
		<!-- 답변글일때.... -->
		<c:if test="${dto!=null}">
			<input type="hidden" name="board_num" id="board_num" value="${dto.board_num}" />
			<input type="hidden" name="currentPage" id="currentPage" value="${currentPage}" />
			<input type="hidden" name="board_ref" value="${dto.board_ref}" />
			<input type="hidden" name="board_re_step" value="${dto.board_re_step}" />
			<input type="hidden" name="board_re_level" value="${dto.board_re_level}" />
		</c:if> 
		
		<div class = "button">
			<span class = "button1">
				<input type="button" id="btnList" value="목록" />
			</span>
			<span class = "button2"> 
				<c:if test="${dto==null}">
					<input type="button" id="btnSave" value="문의 작성하기" />
				</c:if>
				<c:if test="${dto!=null}">
					<input type="button" id="btnSave" value="답변 작성하기" />
				</c:if>
			</span>
		</div>
	</form>
</div>
</body>
</html>










