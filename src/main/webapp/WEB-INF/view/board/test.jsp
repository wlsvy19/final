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
<link href="css/board/board_view.css" type="text/css" rel="stylesheet" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.11/handlebars.js"></script>
<script type="text/javascript">
	
	var urno = '';
	var fileList = [];
	
	var session = '${sessionScope.mem_id}'; // 일반 로그인한 내 ID
	//권한준거
	
	//nana홈페이지 로그인
	var mem_id = '${mem_id}'; // 일반 로그인
	//카카오 로그인시 정보 가져옴
	var kname = '${sessionScope.kname}'; // 카카오 로그인
	//네이버 로그인시 정보 가져옴
	var nname = '${sessionScope.nname}'; // 네이버 로그인
	
	$(document).ready(function() {
		$('#list').on('click', listRun);
		$('#replay').on('click', replayRun);
		$('#update').on('click', updateRun);
		$('#delete').on('click', deleteRun);
		$('#delete2').on('click', deleteRun2);
		
		$('#modifyModal').addClass('modifyHide');
		//선택자에 class속성을 넣는다.
					
		$('#replyAddBtn').on('click', reply_list);
		//댓글 추가하기 위한 이벤트
					
		$(document).on('click', '.timeline button', reply_update_delete);
		//댓글 수정,삭제 버튼에 click이벤트 연결
					
		//모달창에 닫기버튼
		$('#btnClose').on('click', function() {					
			$('#updateReplyText').val('');
			$('#modifyModal').removeClass('modifyShow');
			$('#modifyModal').addClass('modifyHide');
			$(document).on('click','.timeline button',reply_update_delete);
			urno = '';					
		})
					
		//모달창에 수정버튼
		$('#btnModify').on('click', reply_update_send);
		
		
		
	});//end ready()/////////////////////////////////////////////////////
	/* ------------------------- 버튼기능 ------------------------- */
	function listRun() {
		$('#frm').attr('action', 'list.do').submit();
	}

	function replayRun() { 
		$('#frm').attr('action', 'write.do').submit();
	}

	function updateRun() {
		$('#frm').attr('action', 'update.do').submit();
	}

	function deleteRun() {
		alert('게시글이 삭제되었습니다.');
		$('#frm').attr('action', 'delete.do').submit();
	}
	
	function deleteRun2() {
		alert('게시글이 삭제되었습니다.');
		$('#frm').attr('action', 'delete2.do').submit();
	}
	
	/* ------------------------- 버튼기능 ------------------------- */
	
	/* ------------------------- 댓글기능 ------------------------- */
	
				
	function reply_update_send() {
		if ($('#updateReplyText').val() == '') {
			alert('수정할 내용을 작성하세요.');
			return false;
		}
		alert('댓글이 수정되었습니다.');
		
		$.ajax({
		type 		: 'GET', 
		dataType 	: 'json', 
		url 		: 'replyUpdateList.do?board_num=${dto.board_num}&reply_content=' + $("#updateReplyText").val() + '&reply_num=' + urno,
		success 	:  reply_list_result 
		});
					
		$('#updateReplyText').val('');
		$('#modifyModal').removeClass('modifyShow').addClass('modifyHide');
		$(document).on('click','.timeline button',reply_update_delete); 
		urno='';
		
	}//end end reply_update_send()///////////////////////////////
				
	function reply_update_delete() {
		if ($(this).text() == 'delete') {
			alert('댓글이 삭제되었습니다.');
			var drno = $(this).prop("id");
			//delete버튼의 id값 변수선언
			$.ajax({
			type 		: 'GET', 
			dataType 	: 'json',  
			url 		: 'replyDelete.do?board_num=${dto.board_num}&reply_num=' + drno, 
			success 	: reply_list_result 
			});
		} else if ($(this).text() == 'update') {
			urno=$(this).prop("id");
			var stop=$(window).scrollTop();		
			$('#modifyModal').css('top',50+stop);
			$('#modifyModal').removeClass('modifyHide');
			$('#modifyModal').addClass('modifyShow');
			$(document).off('click','.timeline button');
		}				
	}//end reply_update_delete()///////////////
	
	/* 댓글 추가 시 발생하는 함수 */
	/* 댓글 추가 시 발생하는 함수 */
	/* 댓글 추가 시 발생하는 함수 */
	/* 댓글 추가 시 발생하는 함수 */
	function reply_list() {

		if ($('#newReplyWriter').val() == '') {
			alert('로그인 이후 사용 가능합니다.');
			return false;
		}
					
		if ($('#newReplyText').val() == '') {
			alert('내용을 입력하세요.');
			return false;
		}
		
		var form_data = new FormData();
		form_data.append('board_num', $('[name=num]').val());
		form_data.append('reply_writer', $("#newReplyWriter").val());
		form_data.append('reply_content', $("#newReplyText").val());
		
		/* 
		//다중첨부파일
		if(fileList){
			for(var index in fileList){
				form_data.append('filename', fileList[index]);
			}
		}
				 */	
		$.ajax({
		// 첨부파일이 있을때는 data, contentType, enctype, processData가 이런 폼으로 있어야한다.
			type 		: 'POST', 
			dataType 	: 'json', 
			url 		: 'replyInsertList.do', 
			data 		: form_data, 
			contentType : false, 
			enctype 	: 'multipart/form-data', 
			processData : false, 
			success 	: reply_list_result 
		});
					
		fileList = [];
					
	}//end reply_list()/////////////////////////////////////////////
				
	Handlebars.registerHelper("newDate", function(timeValue) { //timeValue : 받아온 regdate의 변수명
		
		var sdate = new Date(timeValue);
		var year = sdate.getFullYear();
		var month = sdate.getMonth() + 1;
		var date = sdate.getDate();
					
		return year + "/" + month + "/" + date;
	});
				
	function reply_list_result (res) {
	$('.timeline .time_sub').remove();
	
	$.each(res, function(index, value) {
	//handlebarsjs
	
	var source 	= 	'<div class="time_sub" id="{{reply_num}}">'
			+		'<div>'
			+			'<p class = "writer11">작성자 : {{reply_writer}}&nbsp;&nbsp;&nbsp;{{newDate reply_regdate}}</p>'
			+			'<p class = "content11" id="{{reply_num}}text">{{reply_content}}</p>'
			+		'</div>';
				if(value.reply_writer == session){ 		/* 댓글작성자 == 로그인ID */
					source = source + '<div>'
					+				'<button id="{{reply_num}}" class = "deletebutton" style = "margin-right : 6px;">delete</button>'
					+				'<button id="{{reply_num}}" class = "updatebutton">update</button>'
					+			'</div>'
					+ 		'</div>';
				}else if(value.reply_writer == kname){
					source = source + '<div>'
					+				'<button id="{{reply_num}}" class = "deletebutton" style = "margin-right : 6px;">delete</button>'
					+				'<button id="{{reply_num}}" class = "updatebutton">update</button>'
					+			'</div>'
					+ 		'</div>';
				}else if(value.reply_writer == nname){
					source = source + '<div>'
					+				'<button id="{{reply_num}}" class = "deletebutton" style = "margin-right : 6px;">delete</button>'
					+				'<button id="{{reply_num}}" class = "updatebutton">update</button>'
					+			'</div>'
					+ 		'</div>';
				}else{
					source = source +'</div>';	
				}
	
	var template = Handlebars.compile(source);
	$('.timeline').append(template(value));
						
	});
					
	$("#newReplyText").val('');
	$('.fileDrop').empty();
					
	}
	/* ------------------------- 댓글기능 ------------------------- */
</script>
</head>
<body>
<div id = all>
<%
//nana홈페이지 로그인
Object mem_id = session.getAttribute("mem_id");
//카카오 로그인시 정보 가져옴
Object kname = session.getAttribute("kname");
//네이버 로그인시 정보 가져옴
Object nname = session.getAttribute("nname");
%>
	<div class = "viewintro">
	<c:if test="${dto.board_re_step == 0}">
				<h3 class = "qnawrite">문의 내역</h3>
	</c:if>
	<c:if test="${dto.board_re_step != 0}">
				<h3 class = "qnawrite">답변 내역</h3>
	</c:if>
	<hr/>
			
	<table id = "table">
		<tr height="50px">
			<td class = "category" width="100px"> <p class = "pcategory">${dto.board_type}</p></td>
			<td>${dto.board_title}</td>
			<td width="150px"><c:if test="${!empty dto.board_file}">
				<a href="contentdownload.do?num=${dto.board_num}">
					<!-- 난수 값 잘라내고 저장 파일명만 화면에 출력 -->
					${fn:substringAfter(dto.board_file,"_")} 
				</a>
			</c:if> 
			<c:if test="${empty dto.board_file}">
				<c:out value="첨부파일 없음" />
			</c:if>
			</td>
			<td width="150px">작성자 : ${dto.board_writer}</td>
			<td width="150px"><fmt:formatDate value="${dto.board_regdate}" pattern="yyyy.MM.dd" /></td>
		</tr>
		
		<tr height="30px">
			<td colspan="5"></td>
		</tr>
		
		<tr height="200px">
			<c:if test="${dto.board_re_step == 0}">
				<td width="100px"><img src = "./images/board_q.png" width="60px" height="60px"/></td>
			</c:if>
			<c:if test="${dto.board_re_step != 0}">
				<td width="100px"><img src = "./images/board_a.png" width="60px" height="60px"/></td>
			</c:if>
			<td colspan="4">${dto.board_content}</td>
		</tr>
	</table>

	<form name="frm" id="frm" method="get">
		<input type="hidden" name="num" value="${dto.board_num}" /> 
		<input type="hidden" name="currentPage" id="currentPage" value="${currentPage}" /> 
				 
		<div id="multibutton">
			<input type="button" id="list" value="목록" />
			
			<!-- 답변 작성 권한 ======> 관리자 ( nanaland ) -->
			<!-- 답변 작성 권한 ======> 관리자 ( nanaland ) -->
			<!-- 게시글 답변 => O, 답변글 답변 => X -->
			<c:set var="mem_id" value="${sessionScope.mem_id}" />
			<c:set var="nanaland" value="nanaland" />
			<c:if test="${mem_id == nanaland}">
				<c:if test="${dto.board_re_step == 0}"> 
					<input type="button" id="replay" value="답변" />
				</c:if>
			</c:if>
			
			<!-- 작성자 == 로그인ID ====> 수정 버튼 활성화 -->
			<!-- 작성자 == 로그인ID ====> 수정 버튼 활성화 -->
			<%    
            if(mem_id != null){ 		//일반 로그인일 때
         	%>	
			<c:if test="${dto.board_writer == sessionScope.mem_id}">
				<input type="button" id="update" value="수정" />
			</c:if>
			<%
            }else if(kname != null){ 	//카카오 로그인일 때
         	%>	
         	<c:if test="${dto.board_writer == kname}">
				<input type="button" id="update" value="수정" />
			</c:if>
			<%
            } else if(nname != null){	//네이버 로그인일 떄
         	%>
         	<c:if test="${dto.board_writer == nname}">
				<input type="button" id="update" value="수정" />
			</c:if>
			<%
            }
         	%>	
				
				
			<!-- 작성자 == 로그인ID  ||  ====> 삭제 버튼 활성화 -->
			<%    
            if(mem_id != null){ 		//일반 로그인일 때
         	%>
			<c:if test="${dto.board_writer == sessionScope.mem_id}">
				<c:if test="${dto.board_re_step == 0}">  
					<input type="button" id="delete" value="삭제" />
				</c:if>
				<c:if test="${dto.board_re_step != 0}">  
					<input type="button" id="delete2" value="삭제" />
				</c:if>
			</c:if>
			<%
            }else if(kname != null){ 	//카카오 로그인일 때
         	%>
         	<c:if test="${dto.board_writer == kname}">
				<c:if test="${dto.board_re_step == 0}">  
					<input type="button" id="delete" value="삭제" />
				</c:if>
				<c:if test="${dto.board_re_step != 0}">  
					<input type="button" id="delete2" value="삭제" />
				</c:if>
			</c:if>
			<%
            } else if(nname != null){	//네이버 로그인일 떄
         	%>
         	<c:if test="${dto.board_writer == nname}">
				<c:if test="${dto.board_re_step == 0}">  
					<input type="button" id="delete" value="삭제" />
				</c:if>
				<c:if test="${dto.board_re_step != 0}">  
					<input type="button" id="delete2" value="삭제" />
				</c:if>
			</c:if>
         	<%
            }
         	%>
		</div>
	</form>
	
	<hr/>
	
	<!-- 댓글 리스트 출력 시작 -->
	<div class = "timeline">   
						
	<!-- box box-success 시작 -->
	<div class="box box-success">
		<div class="box-body">
		
			<!-- 댓글 작성자 == 로그인ID -->
			<%    
         	   if(mem_id != null){ 		//일반 로그인일 때
         	%>
				<input type="hidden" placeholder="USER ID" id="newReplyWriter" value = "${sessionScope.mem_id}">
			<%
            	}else if(kname != null){ 	//카카오 로그인일 때
         	%> 
         		<input type="hidden" placeholder="USER ID" id="newReplyWriter" value = "${kname}">
         	<%
            	} else if(nname != null){	//네이버 로그인일 떄
         	%>
         		<input type="hidden" placeholder="USER ID" id="newReplyWriter" value = "${nname}">
         	<%
            	}
         	%>
			<textarea rows="8" cols="100%" placeholder="주제와 무관한 댓글, 악플은 삭제될 수 있습니다." id="newReplyText" style="resize: none;"></textarea> 
			<button type="button" class="btn btn-primary" id="replyAddBtn">등 록</button>
		</div>		
	</div>
	<!-- box box-success 끝 -->
	  
	<!-- 댓글 -->
	<c:forEach items="${boardDTO.replyList}" var="replyDTO">
		<div class = "time_sub" id = "${replyDTO.reply_num}">
			<p class = "writer11">작성자 : ${replyDTO.reply_writer}&nbsp;&nbsp;&nbsp;<fmt:formatDate pattern="yyyy/MM/dd" dateStyle="short" value="${replyDTO.reply_regdate}"/></p>
			<p class = "content11" id="${replyDTO.reply_num}">${replyDTO.reply_content}</p>
				
			<!-- 댓글 작성자 == 로그인ID ==> 댓글 수정, 삭제 권한 -->	
		<%    
            if(mem_id != null){ 		//일반 로그인일 때
         %>
			<c:if test="${replyDTO.reply_writer == sessionScope.mem_id}">
				<div>
					<button id = "${replyDTO.reply_num}" class = "deletebutton">delete</button>
					<button id = "${replyDTO.reply_num}" class = "updatebutton">update</button>
				</div>
			</c:if>
		<%
            }else if(kname != null){ 	//카카오 로그인일 때
         %>  
         	<c:if test="${replyDTO.reply_writer == kname}">
				<div>
					<button id = "${replyDTO.reply_num}" class = "deletebutton">delete</button>
					<button id = "${replyDTO.reply_num}" class = "updatebutton">update</button>
				</div>
			</c:if>
		<%
            } else if(nname != null){	//네이버 로그인일 떄
         %>
         	<c:if test="${replyDTO.reply_writer == nname}">
				<div>
					<button id = "${replyDTO.reply_num}" class = "deletebutton">delete</button>
					<button id = "${replyDTO.reply_num}" class = "updatebutton">update</button>
				</div>
			</c:if>
         <%
            }
         %>
		</div> 
	</c:forEach>
      				
    </div>
	<!-- 댓글 리스트 출력 끝 -->
      		
		
	<!-- Modal -->
	<div id="modifyModal">			
		<p> 
			<textarea rows="10" cols="59" placeholder="수정할 내용을 입력하세요." id="updateReplyText" style="border:0px; resize: none;"></textarea>
		</p>
		
		<p>			    
			<button id="btnModify">수정</button>
			<button id="btnClose">닫기</button>
		</p>
	</div>	
</div>
</body>
</html>
