<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>disc start page</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
   $('#disdiscStartBtn').on('click', function(){
      alert('NANALAND 회원에게만 제공되는 서비스입니다.');
      location.href="memberloginform.do";
   });
});
</script>
<style type="text/css">
#discStart_warp{
   /* border: 2px solid black; */
   margin : auto;
   margin-top : 5%;
   margin-bottom: 10%;
   width: 80%;
   height: 550px;
}

.discStartImg{
   width: 40%;
   height: 60%;
   size: 100%;
   margin-left: 30%;
}

.discStartBtnBox{
   width: 20%;
   height: 10%;
   background:#ff3333;
     color:#fff;
     border:none;
     outline:none;
   font-size: medium;
   margin-left: 40%;
   margin-top : 8%;
   cursor: pointer;
   border-radius: 5px;
}

</style>


</head>
<body>

   <%
         //nana홈페이지 로그인
         Object mem_id = session.getAttribute("mem_id");
         //카카오 로그인시 정보 가져옴
         Object kemail = session.getAttribute("kemail");
         //네이버 로그인시 정보 가져옴
         Object nemail = session.getAttribute("nemail");
      %>
   
   <div id = "discStart_warp">
      <img class = "discStartImg" src="./images/disc_start.png" alt = "disc 시작이미지">
      <% if(mem_id == null && nemail == null && kemail == null){ %>
         <input type = "button" id = "disdiscStartBtn" class = "discStartBtnBox" value = "취미 테스트 시작하기"/>
      <%}else{ %>
         <input type = "button" id = "discStartBtn"  class = "discStartBtnBox" value = "취미 테스트 시작하기" onClick="location.href='discTest.do'"/>
      <%} %>
   </div>
</body>
</html>