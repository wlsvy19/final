<%@page import="java.util.List"%>
<%@page import="controller.ChatWebSocketHandler"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="java.util.Date" %>
<%@page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="css/chatting/openchat.css" type="text/css" rel="stylesheet" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="js/sockjs.js"></script>
<script>
   //웹 소켓 객체를 저장할 변수를 선언
   var websocket;
   
   var arrNumber = new Array();
   var num = 0;
   
   // 일반 로그인ID
    var mem_id = '${sessionScope.mem_id}'; 
   //카카오 로그인시 정보 가져옴
   var kemail = '${kemail}'; // 카카오 로그인
   //네이버 로그인시 정보 가져옴
   var nname = '${nname}'; // 네이버 로그인
   
   $(document).ready(function() {
      
         //웹 소켓 연결
         websocket = new WebSocket("ws://192.168.0.16:8090/myfinal/chatws.do");

         //웹 소켓 이벤트 처리
         websocket.onopen = onOpen;
         websocket.onmessage = onMssage;
         websocket.onclose = onClose;
		
 		
         //현재 시간 가져오기
         var Now = new Date();

         var hour = Now.getHours();
         var min = Now.getMinutes();
         var sec = Now.getSeconds();
         
         if((hour+"").length < 2){
            hour = "0" + hour;
         }else if((min+"").length < 2){
            min = "0" + min;
         }else if((sec+"").length < 2){
            sec = "0" + sec;
         }
         
         var time = hour + ':' + min + ':' +sec;

      //전송 버튼을 누를 때 이벤트 처리
      $('#sendBtn').on('click', function() {
         
         /* 전송할 내용이 있는 경우에만 전송 기능 활성화 */
         if($('#message').val() != ''){
            
         //nickname과 message에 입력된 내용을 서버에 전송
         var nick = $('#nickname').val();
         var msg = $('#message').val();
         
         
         if(nick == 'nanaland'){
        	 var aa = '<p style = "font-size : 13px; float:right;">'+nick +'</p>' + '<p style = "font-size : 13px; background-color: white; display : inline-block; border-radius: 5px; margin-left: 2px; padding-left: 2px; padding-right: 2px; float:right;">'+ msg+'</p>' + '<p style = "font-size : 10px; display : inline; margin-left : 2px; float:right;">' + time + '</p>';	 
         }else{
        	 var aa = '<p style = "font-size : 13px;">'+nick +'</p>' + '<p style = "font-size : 13px; background-color: white; display : inline-block; border-radius: 5px; margin-left: 2px; padding-left: 2px; padding-right: 2px; ">'+ msg+'</p>' + '<p style = "font-size : 10px; display : inline; margin-left : 2px;">' + time + '</p>';
         }
         
         
         //메시지 전송
         websocket.send(aa);

         //메시지 입력창 초기화
         $('#message').val('');
         $("#chatMessageArea").scrollTop($("#chatMessageArea")[0].scrollHeight);
         }
      });

      //message창에서 Enter를 눌렀을 때도 메시지를 전송
      //키보드를 누를 때 이벤트 처리
      $('#message').keypress(function(event) {
         
         //keyCode == 13 ==> enter인 경우
         if (event.keyCode == 13) {
            
            /* 전송할 내용이 있는 경우에만 전송 기능 활성화 */
            if($('#message').val() != ''){
               
            //nickname과 message에 입력된 내용을 서버에 전송
            var nick = $('#nickname').val();
            var msg = $('#message').val();
            
            if(nick == 'nanaland'){
           	 var aa = '<p style = "font-size : 13px; float:right;">'+nick +'</p>' + '<p style = "font-size : 13px; background-color: white; display : inline-block; border-radius: 5px; margin-left: 2px; padding-left: 2px; padding-right: 2px; float:right;">'+ msg+'</p>' + '<p style = "font-size : 10px; display : inline; margin-left : 2px; float:right;">' + time + '</p>';	 
            }else{
           	 var aa = '<p style = "font-size : 13px;">'+nick +'</p>' + '<p style = "font-size : 13px; background-color: white; display : inline-block; border-radius: 5px; margin-left: 2px; padding-left: 2px; padding-right: 2px; ">'+ msg+'</p>' + '<p style = "font-size : 10px; display : inline; margin-left : 2px;">' + time + '</p>';
            }
            
            //메시지 전송
            websocket.send(aa);

            //메시지 입력창 초기화
            $('#message').val('');
            $("#chatMessageArea").scrollTop($("#chatMessageArea")[0].scrollHeight);
            }
         }
      })

      

		//브라우저 창 닫는 경우 소켓 연결 해제
		$(window).on('close', function() {
		//퇴장 안내 메시지 출력
		var nick = $('#nickname').val();
		websocket.send(nick + "님이 퇴장하셨습니다.");

		websocket.close();

		});
      
      
      
   })//end ready()/////////////////////////////////////////////////////////////////////////////////////////

   //WebSocket이 연결된 경우 호출되는 함수
   function onOpen(evt) {
      console.log("웹 소켓에 연결 성공");
      var nick = $('#nickname').val();
      var chk = 0;
      var text = "";
      
      for(var i = 0; i < arrNumber.length; i++){
    	  if(arrNumber[i] == mem_id){
    		  chk = 1;
    	  }
      }
      
      if(chk != 1){
    	  arrNumber[num] = mem_id;
    	  num++;
      }
      $('#aaa').empty();
      for(var j = 0; j < arrNumber.length; j++){
    	  text += arrNumber[j];
    	  console.log(arrNumber[j]);
      }
      $('#aaa').append('<p>'+text+'</p>');
      
	  websocket.send(nick + "님이 입장하셨습니다.");
	  $("#chatMessageArea").scrollTop($("#chatMessageArea")[0].scrollHeight);
   }//end onOpen()/////////////////////////////////////////////////////////////////////////////////////////

   //WebSocket이 연결 해제된 경우 호출되는 함수
   function onClose(evt) {
      console.log("웹 소켓에 연결 해제");
      var nick = $('#nickname').val();
	  websocket.send(nick + "님이 퇴장하셨습니다.");
	  $("#chatMessageArea").scrollTop($("#chatMessageArea")[0].scrollHeight);
   }//end onOpen()/////////////////////////////////////////////////////////////////////////////////////////

   //서버에서 메시지가 왔을 때 호출되는 함수
   function onMssage(evt) {
      //서버가 전송한 메시지 가져오기
      var data = evt.data;

      //메시지를 출력
      $('#chatMessageArea').append(data + "<br/>");
      $("#chatMessageArea").scrollTop($("#chatMessageArea")[0].scrollHeight);
   }//end onOpen()/////////////////////////////////////////////////////////////////////////////////////////
   

</script>
</head>
<body>
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
   <div id = "chatarea">
         <%    
            if(mem_id != null){
         %>
            <input type="hidden" id="nickname" name="chat_sendid"  value="${sessionScope.mem_id}"/>
         <%
            }else if(kemail != null){
         %>   
            <input type="hidden" id="nickname" name="chat_sendid" value="${kemail}"/>
         <%
            } else if(nname != null){
         %>
         <input type="hidden" id="nickname" name="chat_sendid" value="${nname}"/>         
         <%
            }
         %>
         <!-- 채팅 영역 -->
         <div id = "chatnotice">나나랜드 회원들을 위한 소통 공간입니다.</div>
         <div id = "chatMessageArea"></div>
      
         <!-- 채팅 입력 영역 -->
         <span id = "inputarea">
      
            <!-- 채팅 내용 -->
            <input type="text" id="message" name="chat_content"/> 
       
             <!-- 전송 버튼 -->
            <span id = "sendarea">
               <input type="button" id="sendBtn" value="전송" />
            </span>
         </span>
      </div>
</body>
</html>