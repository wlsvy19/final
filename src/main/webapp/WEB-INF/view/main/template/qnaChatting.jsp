<%@page import="java.util.List"%>
<%@page import="controller.ChatWebSocketHandler"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>qnaChatting.jsp</title>
<link href="css/chatting/userchat.css" type="text/css" rel="stylesheet" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.11/handlebars.js"></script>
<style type="text/css">
*{
	margin : 0;
}

#qna_chatting{
	width : 180px;
	height: 60px;
	size: 100%;
	position : fixed;
	right : 3%;
	bottom : 0;
	margin-bottom: 2%;
}
</style>
<script>
	var nanaland = 'nanaland';
	
	$(document).ready(function() {
		/* 채팅창 처음에 숨기기 */
		$('#userchatarea').hide();
		
		$('#qna_chatting').on('click', function(){
			
			$.ajax({
			      type       : 'GET', 
			      dataType   : 'json', 
			      url        : 'userchat.do',
			      success    :  insert_success 
			});
		});
		
		/* x 버튼 클릭  == 채팅창 출력*/
		$('.x_button').on('click', function(){
			$('#userchatarea').hide();
		});
		
		/* 채팅 전송 버튼 클릭 시 발생하는 함수 */
		$('#chat_insert').on('click', function(){
			var content = $('#chat_content').val();
			var send_id = $('#chat_sendid').val();
			
			$.ajax({
			      type       : 'GET', 
			      dataType   : 'json', 
			      url        : 'userchat_insert.do?chat_content=' + content +'&chat_sendid =' + send_id,
			      success    :  insert_success 
			});
		});
		
		/* 채팅 전송 버튼 엔터 이벤트 발생 함수 */
		$('#chat_content').keypress(function(event){
			if (event.keyCode == 13) {
				if($('#chat_content').val() != ''){
					var content = $('#chat_content').val();
					var send_id = $('#chat_sendid').val();
					
					$.ajax({
					      type       : 'GET', 
					      dataType   : 'json', 
					      url        : 'userchat_insert.do?chat_content=' + content +'&chat_sendid =' + send_id,
					      success    :  insert_success 
					});
				}
			}
		})
		
		
		$("#tablearea").scrollTop($("#tablearea")[0].scrollHeight);
	})//end ready()/////////////////////////////////////////////////////////
	
	/* 날짜 가져오기 */
	Handlebars.registerHelper("newDate", function(timeValue) {
	//timeValue : 받아온 regdate의 변수명
	var sdate = new Date(timeValue);
	var year = sdate.getFullYear();
	var month = sdate.getMonth() + 1;
	var date = sdate.getDate();
    var hour = sdate.getHours();
    var min = sdate.getMinutes();
    var sec = sdate.getSeconds();
    
	if((hour+"").length < 2){
		hour = "0" + hour;
	}
	if((min+"").length < 2){
		min = "0" + min;
	}
	if((sec+"").length < 2){
		sec = "0" + sec;
	}	

	return hour + ":" + min + ":" + sec;
	});
	/* 채팅 전송, 리스트 출력 ajax 함수 */
	function insert_success(res){
		$('#chat_list_table').empty();
		
		$.each(res, function(index, value) {
		var source = ''; 
		if(value.chat_sendid != nanaland){
			source = source + '<tr>'	
			+ '<td class="user_send" width="15%">'+value.chat_sendid+'</td>'
			+ '<td class="user_send" width="15%" style="text-align: left;">{{newDate chat_regdate}}</td>'
			+ '<td></td>'
			+ '<td></td>'
			+ '</tr>'
			+ '<tr>'
			+ '<td colspan="4" style="text-align: left; padding-left: 10px;"><b class="contentarea">'+value.chat_content+'</b></td>'
			+ '</tr>';
		}else if (value.chat_sendid == nanaland){
			source = source + '<tr>'
			+ '<td></td>'
			+ '<td></td>'
			+ '<td class="user_send" width="15%" style="text-align: right;">{{newDate chat_regdate}}</td>'
			+ '<td class="user_send" width="15%">nanaland</td>'
			+ '</tr>'
			+ '<tr>'
			+ '<td colspan="4" style="text-align: right; padding-right: 10px;"><b class="contentarea">'+value.chat_content+'</b></td>'
			+ '</tr>';
		}

		var template = Handlebars.compile(source);
		$('#chat_list_table').append(template(value));
		                  
		});//end each//////////////////////////////
		
		/* input 내용 클리어 후 포커스 주기 */
		$('#chat_content').val('');
		$('#chat_content').focus();
		$('#userchatarea').show();
		$("#tablearea").scrollTop($("#tablearea")[0].scrollHeight);
	}
</script>
</head>
<body>
	<%
		//nana홈페이지 로그인
		Object mem_id = session.getAttribute("mem_id");
		//카카오 로그인시 정보 가져옴
		Object kemail = session.getAttribute("kemail");
		//네이버 로그인시 정보 가져옴
		Object nname = session.getAttribute("nname");
	%>
	
	<!-- 전체 영역 -->
	<div id="userchatarea">
	
	
	<c:set var="nanaland" value="nanaland"/>
	
	<!-- 제목 영역 -->
	<div class="table_header" style="color: white; font-size: 20px;">
		<b>나나랜드 채팅문의</b><input type="button" class = "x_button" value="X">
	</div>
	
	<!-- 테이블 영역 -->
	<div id="tablearea">
	
	<!-- 채팅 리스트 출력 -->
	<!-- 채팅 리스트 출력 --> 
	<table id="chat_list_table">
		<c:forEach var="dto" items="${chatlist}">
			<c:choose>
				<c:when test="${dto.chat_sendid != nanaland}">
				<tr>
					<td class="user_send" width="15%">${dto.chat_sendid}</td>
					<td class="user_send" width="15%" style="text-align: left;"><fmt:formatDate value="${dto.chat_regdate}" pattern="HH:mm:ss" /></td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td colspan="4"  style="text-align: left; padding-left: 10px;"><b class="contentarea">${dto.chat_content}</b></td>
				</tr>
				</c:when>
			
				<c:when test="${dto.chat_sendid == nanaland}">
				<tr>
					<td></td>
					<td></td>
					<td class="user_send" width="15%" style="text-align: right;"><fmt:formatDate value="${dto.chat_regdate}" pattern="HH:mm:ss" /></td>
					<td class="user_send" width="15%">nanaland</td>
				</tr>
				<tr>
					<td colspan="4"  style="text-align: right; padding-right: 10px;"><b class="contentarea">${dto.chat_content}</b></td>
				</tr>
				</c:when>
			</c:choose>
				
			
		</c:forEach>
	</table>
	</div>
	
		<!-- 채팅 입력 -->
		<!-- 채팅 입력 -->
		<div class="table_header">
		<div class="table_header_child">
			<input type="text" name="chat_content" id="chat_content"/>
			<input type="button" name="chat_insert" id="chat_insert" value="전송"/>
			<input type="hidden" id="chat_sendid" value = "${sessionScope.mem_id}">
		</div>
		</div>
	</div>	
	
	<c:set var="mem_id" value="${sessionScope.mem_id}" />
	<c:set var="nanaland" value="nanaland" />
	
	<!-- 채팅 문의하기 권한 == 사용자 + 나나랜드x -->
	<c:if test="${mem_id != null && mem_id != nanaland}">
		<input type = "image" id = "qna_chatting" src = "./images/qna_chatting.png" alt = "채팅 문의하기"/>
	</c:if>
</body>
</html>