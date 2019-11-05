<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>LoginTest</title>

<script type="text/javascript"
   src="http://code.jquery.com/jquery-1.11.3.min.js"></script>

<script type="text/javascript"
   src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js"
   charset="utf-8"></script>   
   
<link href="css/bootstrap.min.css" rel="stylesheet">

<script type="text/javascript">
$(document).ready(function(){
   $('form').on('submit',function(){
      var mem_id = $("#mem_id").val();
      var mem_pw = $("#mem_pw").val();
      
      if(mem_id == ""){
         alert("아이디를 입력하세요.");
         $("#mem_id").focus();//아이디입력란으로 커서 이동
         location.href='memberloginform.do';
         return false; //다음으로 안넘어가도록, 이거하니까 밑에 msg안뜨네
      }
      if(mem_pw == ""){
         alert("비밀번호를 입력하세요.");
         $("mem_pw").focus();
         return false;
      }
   });
   
   //아이디나 비밀번호가 틀렸을경우
   //아이디나 비밀번호가 틀렸을경우
   var chk = '${msg}';
   if ('${msg}' != '') {
	  alert('입력하신 정보를 확인해주세요.');
	  $('#mem_id').val('');
	  $('#mem_pw').val('');
      /* location.href='memberloginform.do'; */
   }
   
   /////////////////////////////////////////////////////////
   // 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백으로 들어감.
    var userInputId = getCookie("userInputId");
    $("input[name='mem_id']").val(userInputId); 
     
    if($("input[name='mem_id']").val() != ""){ // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
        $("#idSaveCheck").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
    }
     
    $("#idSaveCheck").change(function(){ // 체크박스에 변화가 있다면,
        if($("#idSaveCheck").is(":checked")){ // ID 저장하기 체크했을 때,
            var userInputId = $("input[name='mem_id']").val();
            setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
        }else{ // ID 저장하기 체크 해제 시,
            deleteCookie("userInputId");
        }
    });
     
    // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
    $("input[name='mem_id']").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,
        if($("#idSaveCheck").is(":checked")){ // ID 저장하기를 체크한 상태라면,
            var userInputId = $("input[name='mem_id']").val();
            setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
        }
    });
   
});


function setCookie(cookieName, value, exdays){
    var exdate = new Date();
    exdate.setDate(exdate.getDate() + exdays);
    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
    document.cookie = cookieName + "=" + cookieValue;
}
 
function deleteCookie(cookieName){
    var expireDate = new Date();
    expireDate.setDate(expireDate.getDate() - 1);
    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
}
 
function getCookie(cookieName) {
    cookieName = cookieName + '=';
    var cookieData = document.cookie;
    var start = cookieData.indexOf(cookieName);
    var cookieValue = '';
    if(start != -1){
        start += cookieName.length;
        var end = cookieData.indexOf(';', start);
        if(end == -1)end = cookieData.length;
        cookieValue = cookieData.substring(start, end);
    }
    return unescape(cookieValue);
}
</script>

<style type="text/css">
.col-md-3{
   margin-left: 440px;
}

.page-header{
   margin-left : 440px;
}

.idSaveCheck{
   text-align: center;
}

</style>
</head>
<body>
   <div class="container">
      <div class="row">
         <div class="page-header">
            <h2>NANA LAND 로그인</h2>
         </div>
         <div class="col-md-3">
            <div class="login-box well">
               <form accept-charset="UTF-8" role="form" method="post"
                  action="memberloginpro.do">

                  <div class="form-group">
                     <label for="username-email">아이디</label> 
                     <input name="mem_id" id="mem_id" placeholder="ID" type="text" class="form-control" />
                  </div>

                  <div class="form-group">
                     <label for="password">비밀번호</label> 
                     <input name="mem_pw" id="mem_pw" placeholder="Password" type="password" class="form-control" />
                  </div>

                  <div class="form-group">
                     <input type="submit" class="btn btn-default btn-login-submit btn-block m-t-md"value="Login" />
                     <input type="checkbox" id="idSaveCheck" >아이디 저장
                  </div>
                           
                  <span class='text-center'><a href="idsearch.do"
                     class="text-sm">아이디 찾기</a></span> 
                     
                     <span>/</span> 
                     
                  <span class='text-center'><a href="pwsearch.do" 
                     class="text-sm">비밀번호 찾기</a></span>
                  <hr />
                  
                  <div id="kakao_id_login" style="text-align: center">
                     <a href="${kakao_url}">
                     <img width="223" 
                        src="images/kakao_account_login_btn_medium_narrow.png" /></a>
                  </div>
                  
                  <br/>
                  
                  <div id="naver_id_login" style="text-align: center">
                     <a href="${naver_url}"><img width="223" 
                        src="${pageContext.request.contextPath}/images/naver_Bn_Green.PNG" /></a>
                  </div>
                  
               </form>
            </div>
         </div>
      </div>
   </div>
</body>
</html>
