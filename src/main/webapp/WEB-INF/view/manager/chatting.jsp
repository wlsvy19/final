<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="css/manager/chatting.css" type="text/css" rel="stylesheet" />
<link href="css/manager/managerchat.css" type="text/css" rel="stylesheet" />
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.11/handlebars.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var sender = '';
	
	$('.listBox').on('click', function(){
       //alert('click');
       sender = $(this).children('input').val(); //아이디값 받는 부분
       
       $.ajax({
           type : 'GET',
           dataType : 'json',
           url : 'managerChattingList.do?chat_receiver='+ sender,
           success : viewMessage
        });
	});
   
     
      
      $('#sendBtn').on('click', function(){
    	 if(sender != ''){
	         	if($('#message').val() != ''){
	            	$.ajax({
	                  	type : 'GET',
	                  	dataType : 'json',
	                  	url : 'managerChattingInsert.do?chat_content='+$('#message').val()+'&chat_receiver='+sender,
	                	success : viewMessage2()
					});
	         	}
    	 }else{
    		 alert('채팅방을 선택해주세요.');
    	 }
      });
      
      $('#message').keypress(function(event) {
            
            //keyCode == 13 ==> enter인 경우
            if (event.keyCode == 13) {
               /* 전송할 내용이 있는 경우에만 전송 기능 활성화 */
               if($('#message').val() != ''){
                  $.ajax({
                      type : 'GET',
                      dataType : 'json',
                      url : 'managerChattingInsert.do?chat_content='+$('#message').val()+'&chat_receiver='+sender,
                      success : viewMessage2()
                   });
               }
            }
      });
      
});

Handlebars.registerHelper("newDate", function(timeValue) {
      //timeValue : 받아온 regdate의 변수명
      var sdate = new Date(timeValue);
      var year = sdate.getFullYear();
      var month = sdate.getMonth() + 1;
      var date = sdate.getDate();
      var hour = sdate.getHours();
      var min = sdate.getMinutes();
      var sec = sdate.getSeconds();
       
      if((month+"").length < 2){
         month = "0" + month;
      }

      if((date+"").length < 2){
         date = "0" + date;
      }   

      return hour + ":" + min + ":" + sec;
});

   function viewMessage(res) {
      $("#chatMessageArea").empty();
      
      $.each(res, function(index,value){
         var aa = '';
         if(value.chat_sendid == 'nanaland'){
              aa = '<p style = "font-size : 13px; float : right; clear: both; margin-right : 5px; ">'+value.chat_sendid +'</p>' + '<p style = "font-size : 13px; background-color: white; display : inline-block; border-radius: 5px; margin-left: 2px; padding-left: 2px; padding-right: 2px; float : right; clear: both; margin-right : 5px; margin-bottom : 3px;">'+ value.chat_content+'</p>' + '<p style = "font-size : 10px; display : inline; margin-left : 2px; margin-right : 2px; float : right;">{{newDate chat_regdate}}</p><br>'; 
         }else{
              aa = '<p style = "font-size : 13px;">'+value.chat_sendid +'</p>' + '<p style = "font-size : 13px; background-color: white; display : inline-block; border-radius: 5px; margin-left: 2px; padding-left: 2px; padding-right: 2px; margin-bottom : 3px;">'+ value.chat_content+'</p>' + '<p style = "font-size : 10px; display : inline; margin-left : 2px;">{{newDate chat_regdate}}</p><br>';
         }
         
         var template = Handlebars.compile(aa);
         $('#chatMessageArea').append(template(value));
      });
      
      $("#chatMessageArea").scrollTop($("#chatMessageArea")[0].scrollHeight);
      $("#message").focus();
      
   }// end viewMessage()////////////
   
   function viewMessage2() {
      var Now = new Date();

       var hour = Now.getHours();
       var min = Now.getMinutes();
       var sec = Now.getSeconds();
       
       if((hour+"").length < 2){
          hour = "0" + hour;
       }
       
       if((min+"").length < 2){
          min = "0" + min;
       }
       
       if((sec+"").length < 2){
          sec = "0" + sec;
       }
       
       var time = hour + ':' + min + ':' + sec;
       
      var bb = '<p style = "font-size : 13px; float : right; clear: both; margin-right : 5px; ">nanaland</p>' + '<p style = "font-size : 13px; background-color: white; display : inline-block; border-radius: 5px; margin-left: 2px; padding-left: 2px; padding-right: 2px; float : right; clear: both; margin-right : 5px; margin-bottom : 3px;">'+ $('#message').val() +'</p>' + '<p style = "font-size : 10px; display : inline; margin-left : 2px; margin-right : 2px; float : right;">' + time + '</p><br>';
      
      $('#message').val('');
      $('#chatMessageArea').append(bb);
      $("#chatMessageArea").scrollTop($("#chatMessageArea")[0].scrollHeight);
      $("#message").focus();
   }// end viewMessage2()////////////

   
</script>
</head>
<body>
   <div id="allarea">
      <div id = "allarea_left">
         <img src="./images/manager_logo.png" id = "manager_logo">
         <hr style="width: 85%; height: 1px; background-color: white; margin: auto; margin-bottom: 15%;"/>
         <!-- 네비게이터 설정 -->
         <!-- 네비게이터 설정 -->
         <!-- 네비게이터 설정 -->
         <div id="menuarea">
            <input OnClick="location.href ='marketing.do'" type="image" src="./images/manager_menu1.png" class = "managerImgBtn"/>
            <input OnClick="location.href ='stock.do'" type="image" src="./images/manager_menu2.png" class = "managerImgBtn2"/>
            <input OnClick="location.href ='product.do'" type="image" src="./images/manager_menu3.png" class = "managerImgBtn"/>
            <input OnClick="location.href ='chatting.do'" type="image" src="./images/manager_menu4.png" class = "managerImgBtn3"/>
         </div>
      </div>
      
      <div id = "allarea_right">
         <div id="menu" style="font-family: 나눔바른펜">채팅 문의</div>
         <hr />
         
         <!-- 전체 -->
         <div id = "chattingBox">
            <!-- 채팅 리스트 전체 -->
            <div id = "chattingList">
               <c:forEach items="${chattingList }" var="dto">
                  <div class = "listBox" >
                     <input type="hidden" value="${dto.chat_sendid }" id = "${dto.chat_sendid }"/>
                     <div class = "list_left"><img class = "listImg" src="./images/chatting_user.png"></div>
                     <div class = "list_right">
                        <table class = "listResultTable">
                           <tr>
                              <td style="font-weight: bold; font-size: large;">${dto.chat_sendid }</td>
                              <td style="text-align: right;"><fmt:formatDate value="${dto.chat_regdate }" pattern="yyyy/MM/dd hh:mm" /></td>
                           </tr>
                           <tr>
                              <td style="color : gray;">${dto.chat_content }</td>
                           </tr>
                        </table>
                     </div>
                  </div>
               </c:forEach>
            </div>
            
		<!-- 채팅 화면 전체 -->
		<div id = "chattingArea">
         
		<div id = "chatarea">

			<!-- 채팅 영역 -->
			<div id="chatMessageArea"></div>
      
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
		</div>
        
   
            
            
            
            
 
            
        </div>
      </div>
     </div>
</body>
</html>