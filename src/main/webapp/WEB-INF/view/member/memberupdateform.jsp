   <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>개인정보수정</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- 부트스트랩 -->
<link rel="stylesheet" href="css/bootstrap.min.css">
<!-- daum 도로명주소 찾기 api -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<style type="text/css">

</style>
 
 <script type="text/javascript">

//모든 공백 체크 정규식
var empJ = /\s/g;
//아이디 정규식
var idJ = /^[a-z0-9][a-z0-9_\-]{4,19}$/;
// 비밀번호 정규식
var pwJ = /^[A-Za-z0-9]{4,12}$/;
// 이름 정규식
var nameJ = /^[가-힣]{2,6}$/;
// 이메일 검사 정규식
var mailJ = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
// 휴대폰 번호 정규식
var phoneJ = /^01([0|1|6|7|8|9]?)?([0-9]{3,4})?([0-9]{4})$/;

$(document).ready(function() {
   var address = $('#mem_detailaddress');
   
     $('form').on('submit',function(){
         var inval_Arr = new Array(4).fill(false);
         // 비밀번호가 같은 경우 && 비밀번호 정규식
         if (($('#mem_pw').val() == ($('#mem_pw2').val()))
               && pwJ.test($('#mem_pw').val())) {
            inval_Arr[0] = true;
         } else {
            inval_Arr[0] = false;
            alert('비밀번호를 확인하세요.');
            return false;
         }
         // 이메일 정규식
         if (mailJ.test($('#mem_email').val())){
            console.log(phoneJ.test($('#mem_email').val()));
            inval_Arr[1] = true;
         } else {
            inval_Arr[1] = false;
            alert('이메일을 확인하세요.');
            return false;
         }
         // 휴대폰번호 정규식
         if (phoneJ.test($('#mem_phone').val())) {
            console.log(phoneJ.test($('#mem_phone').val()));
            inval_Arr[2] = true;
         } else {
            inval_Arr[2] = false;
            alert('핸드폰 번호를 확인하세요.');
            return false;   
         }
         
         //주소확인
            if(address.val() == ''){
               inval_Arr[3] = false;
               alert('주소를 확인하세요.');
               return false;
            }else
               inval_Arr[3] = true;
         
          //전체 유효성 검사
         var validAll = true;
         for(var i = 0; i < inval_Arr.length; i++){
            if(inval_Arr[i] == false){
               validAll = false;
            }
         }
         if(validAll == true){ // 유효성 모두 통과
            alert('수정완료. 다시 로그인하세요.');
         } else{
            alert('정보를 다시 확인하세요.')
         }
       });

   $('#mem_pw').blur(function() {
      if (pwJ.test($('#mem_pw').val())) {
         console.log('true');
         $('#pw_check').text('');
      } else {
         console.log('false');
         $('#pw_check').text('4~12자의 숫자 , 문자로만 사용 가능합니다.');
         $('#pw_check').css('color', 'red');
      }
   });

   //1~2 패스워드 일치 확인
   $('#mem_pw2').blur(function() {
      if ($('#mem_pw').val() != $(this).val()) {
         $('#pw2_check').text('비밀번호가 일치하지 않습니다.');
         $('#pw2_check').css('color', 'red');
      } else {
         $('#pw2_check').text('');
      }
   });

   //이름에 특수문자 들어가지 않도록 설정
   $("#mem_name").blur(function() {
      if (nameJ.test($(this).val())) {
         console.log(nameJ.test($(this).val()));
         $("#name_check").text('');
      } else {
         $('#name_check').text('한글과 영문 대 소문자를 사용하세요. (특수기호, 공백 사용 불가)');
         $('#name_check').css('color', 'red');
      }
   });
   $("#mem_email").blur(function() {
      if (mailJ.test($(this).val())) {
         $("#email_check").text('');
      } else {
         $('#email_check').text('이메일 양식을 확인해주세요.');
         $('#email_check').css('color', 'red');
      }
   });
   

     // 휴대전화
   $('#mem_phone').blur(function(){
       if(phoneJ.test($(this).val())){
           console.log(nameJ.test($(this).val()));
           $("#phone_check").text('');
           } else {
              $('#phone_check').text('휴대폰번호를 확인해주세요 ');
              $('#phone_check').css('color', 'red');
           }
        });
});

//우편번호 찾기 버튼 클릭시 발생 이벤트
function execPostCode() {
     new daum.Postcode({
         oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
            var extraRoadAddr = ''; // 도로명 조합형 주소 변수

            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if(data.buildingName !== '' && data.apartment === 'Y'){
               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }
            // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
            if(fullRoadAddr !== ''){
                fullRoadAddr += extraRoadAddr;
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            console.log(data.zonecode);
            console.log(fullRoadAddr);
            
            
            $("[name=mem_oaddress]").val(data.zonecode);
            $("[name=mem_address]").val(fullRoadAddr);
            
            document.getElementById('mem_oaddress').value = data.zonecode; //5자리 새우편번호 사용
            document.getElementById('mem_address').value = fullRoadAddr;
            //document.getElementById('mem_detailaddress').value = data.jibunAddress; 
        }
     }).open();
 }

</script> 
</head>
<body>

   <article class="container">
            <div class="page-header">
                <div class="col-md-6 col-md-offset-3">
                <h3>개인정보수정</h3>
                </div>
              
            </div>
            <div class="col-sm-6 col-md-offset-3">
                <form action="memberupdatepro.do" method="post" role="form" id="usercheck" name="member">
                
                    <div class="form-group">
                        <label for="id">아이디</label>
                        <input type="text" class="form-control" id="mem_id" name="mem_id"  value="${sessionScope.mem_id}" readonly="readonly">
                        <div class="eheck_font" id="id_check"></div>
                    </div>
                    
                    <div class="form-group">
                        <label for="pw">비밀번호 재설정</label>
                        <input type="password" class="form-control" id="mem_pw" name="mem_pw" placeholder="PASSWORD" >
                        <div class="eheck_font" id="pw_check"></div>
                    </div>
                    <div class="form-group">
                        <label for="pw2">비밀번호 재설정 확인</label>
                        <input type="password" class="form-control" id="mem_pw2" name="mem_pw2" placeholder="Confirm Password">
                          <div class="eheck_font" id="pw2_check"></div>
                    </div>
                    
                       <div class="form-group">
                        <label for="mem_name">이름</label>
                        <input type="text" class="form-control" id="mem_name" name="mem_name"  value="${sessionScope.mem_name}">
                         <div class="eheck_font" id="name_check"></div>
                    </div>
                    
                    
                    <div class="form-group">
                        <label for="mem_email">이메일 주소</label>
                        <input type="email" class="form-control" id="mem_email" name="mem_email"  value="${sessionScope.mem_email}">
                       <div class="eheck_font" id="email_check"></div>
                    </div>
                    
             
                    <div class="form-group">
                        <label for="mem_phone">휴대폰 번호('-'없이 번호만 입력해주세요)</label>
                        <input type="tel" class="form-control" id="mem_phone" name="mem_phone" value="${sessionScope.mem_phone}">
                         <div class="eheck_font" id="phone_check"></div>
                    </div>

                    
<div class="form-group">                   
<input class="form-control" style="width: 40%; display: inline;" placeholder="우편번호" name="mem_oaddress" id="mem_oaddress" type="text" readonly="readonly" value="${sessionScope.mem_oaddress}" >
    <button type="button" class="btn btn-default" onclick="execPostCode();"><i class="fa fa-search"></i> 우편번호 찾기</button>                               
</div>

<div class="form-group">
    <input class="form-control" style="top: 5px;" placeholder="도로명 주소" name="mem_address" id="mem_address" type="text" readonly="readonly" value="${sessionScope.mem_address}"/>
</div>

<div class="form-group">
    <input class="form-control" placeholder="상세주소" name="mem_detailaddress" id="mem_detailaddress" type="text" value="${sessionScope.mem_detailaddress}"  />
</div>


                    <div class="form-group text-center">
                         <button type="submit" class="btn btn-primary">
                                  수정하기<i class="fa fa-check spaceLeft"></i>
                        </button>                      
                    </div>
                </form>
            </div>
        </article>

</body>
</html>