<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
* {
   margin: 0;
   padding: 0;
}

#readyWrap {
   width: 80%;
   height: 100%;
   margin: auto;
   margin-top: 5%;
   margin-bottom: 5%;
}

#payinfoTable {
   width: 100%;
   height: 100%;
   text-align: center;
   margin: auto;
   border-top: 1px solid #ccc;
   border-bottom: 1px solid #ccc;
   border-collapse: collapse;
   line-height: 2.7;
   border-top: none;
   border-bottom: 2px solid #4d4d4d;
   margin-top: 4%;
}

#payinfoTable th {
   border-top: none;
   border-bottom: 2px solid #4d4d4d;
}

#payinfoTable td {
   border-bottom: 1px solid #ccc;
   border-collapse: collapse;
   padding: 8px;
}

#payinfoTable thead tr {
   font-size: large;
}



#payinfoAll{
   width: 100%;
   height: 500px;
   /* margin-top: 5%; */
}

#payinfoLeft{
   clear : both;
   width: 60%;
   height: 100%;
   padding-top : 5%;
   display: inline-block;
   float : left;
}

#payinfoRight{
   width: 38%;
     height: 100%;
     padding-left : 2%;
     padding-top : 5%;
     border-left : 1px dashed #ccc;
   display: inline-block; 
   float : right;
   background-color: #f5f5f0;
}






#kakaopaymentBtn {
   width : 250px; 
    height : 50px; 
    size : 90%;
    cursor: pointer;
    margin-top: 10%;
    margin-left: 40%;
    border-radius: 5px;
}
</style>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- 부트스트랩 -->
<link rel="stylesheet" href="css/bootstrap.min.css">
<!-- daum 도로명주소 찾기 api -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
$(document).ready(function(){
   $(document).on('input', '#point', function(){
      var sum = $('#sellSum').val()-$('#point').val();
      var a = $('#point').val()-$('#memPoint').val();
      
      if(a > 0){
         alert('사용가능한 포인트를 다시 확인해주시기 바랍니다.');
         $('#payChk').attr('value', false);
      }else{
         if(sum >= 100){
            $('#sum').empty();
            /* $('#sum').append('<div>'+ sum +'원</div>'); */
            $('#sum').append('결제금액<div style="font-weight: 1000; font-size: x-large;">'+String(sum).replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,')+'원</div>');
            $('#usePoint').empty();
            $('#usePoint').append('<div>포인트 사용금액(-)&emsp;&emsp;&emsp;' + String($('#point').val()).replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,') + 'P</div>');
            $('#payChk').attr('value', true);
            if($('#point').val() == ""){
               /* $('#pointform').empty(); */
               $('#usePoint').empty();
               $('#sum').empty();
               /* $('#sum').append('<div>'+ $('#sellSum').val() +'원</div>'); */
               $('#sum').append('결제금액<div style="font-weight: 1000; font-size: x-large;">'+ String($('#sellSum').val()).replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,') +'원</div>');
               $('#point').attr('value', 0);
               /* $('#pointform').append('<input type="text" id="point" value="0"><button id="allPoint">전액사용</button><span>&nbsp;&nbsp;(사용가능 포인트: ' + $('#memPoint').val() +'P)</span>'); */
               $('#usePoint').append('<div>포인트 사용금액(-)&emsp;&emsp;&emsp;0P</div>');
            }
         }else{
            alert('사용가능한 포인트를 다시 확인해주시기 바랍니다.');
            $('#sum').empty();
            /* $('#sum').append('<div>'+ $('#sellSum').val() +'원</div>'); */
            $('#sum').append('결제금액<div style="font-weight: 1000; font-size: x-large;">'+ String($('#sellSum').val()).replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,') +'원</div>');
            $('#payChk').attr('value', false);
            /* $('#pointform').empty(); */
            $('#usePoint').empty();
            $('#point').attr('value', 0);
            /* $('#pointform').append('<input type="text" id="point"><button id="allPoint">전액사용</button><span>&nbsp;&nbsp;(사용가능 포인트: ' + $('#memPoint').val() +'P)</span>'); */
            $('#usePoint').append('<div>포인트 사용금액(-)&emsp;&emsp;&emsp;0P</div>');
            return false;
         }
      }
      
   });
   
   $(document).on('click', '#allPoint', function(){
      var memp = $('#memPoint').val();
      var sell = $('#sellSum').val();
      var ssum = sell-memp;
      var sellm = sell-100;
      if(ssum >= 100){
         $('#sum').empty();
         /* $('#sum').append('<div>'+ ssum +'원</div>'); */
         $('#sum').append('결제금액<div style="font-weight: 1000; font-size: x-large;">'+ String(ssum).replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,') +'원</div>');
         $('#usePoint').empty();
         $('#usePoint').append('<div>포인트 사용금액(-)&emsp;&emsp;&emsp;' + String(memp).replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,') + 'P</div>');
         $('#payChk').attr('value', true);
         $('#pointform').empty();
         $('#pointform').append('<input type="text" id="point" value="' + memp + '"><button id="allPoint">전액사용</button><span>&nbsp;&nbsp;(사용가능 포인트: ' + String($('#memPoint').val()).replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,') +'P)</span>');
      }else{
         $('#sum').empty();
         /* $('#sum').append('<div>100원</div>'); */
         $('#sum').append('결제금액<div style="font-weight: 1000; font-size: x-large;">100원</div>');
         $('#usePoint').empty();
         $('#usePoint').append('<div>포인트 사용금액(-)&emsp;&emsp;&emsp;' + String(sellm).replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,') + 'P</div>');
         $('#payChk').attr('value', true);
         $('#pointform').empty();
         $('#pointform').append('<input type="text" id="point" value="' + sellm + '"><button id="allPoint">전액사용</button><span>&nbsp;&nbsp;(사용가능 포인트: ' + String($('#memPoint').val()).replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,') +'P)</span>');
      }
   });
   
   
   $('#kakaopaymentBtn').on('click', function(){
      var radioVal = $('input[name="address"]:checked').val();
      var usePoint = $('#point').val();
      
      if(radioVal == '신규배송지'){
         var person = $('#person').val();
         var phone = $('#phone').val();
         var oaddress = $('#mem_oaddress').val();
         var address = $('#mem_address').val();
         var daddress = $('#mem_detailaddress').val();
         var add = oaddress+"@"+address+"@"+daddress;
         
         if(person != '' && phone != '' && oaddress != '' && address != '' && daddress != ''){
            if($('#payChk').val() == 'true'){
               var sellSum = $('#sellSum').val()-$('#point').val();
               location.href = "kakaopay.do?sellSum="+sellSum+"&usePoint="+usePoint+"&person="+encodeURI(person)+"&phone="+encodeURI(phone)+"&address="+encodeURI(add);
            }else{
               alert('포인트를 다시 확인해주시기 바랍니다.');
            }
         }else{
            alert('입력하신 개인정보를 다시 확인해주시기 바랍니다.');
         }
      }else{
         if($('#payChk').val() == 'true'){
            var sellSum = $('#sellSum').val()-$('#point').val();
            location.href = "kakaopay.do?sellSum="+sellSum+"&usePoint="+usePoint+"&person="+$('#memName').val()+"&phone="+$('#memPhone').val()+"&address="+$('#memOadd').val()+ "@" +$('#memAdd').val() + "@" + $('#memDadd').val();
         }else{
            alert('포인트를 다시 확인해주시기 바랍니다.');
         }
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
           // document.getElementById('mem_detailaddress').value = data.jibunAddress; 
        }
     }).open();
 }


function newadr(){
   $('#userinfo').empty();
   $('#userinfo').append('<div style="margin-top: 2%;"><span style="font-style: italic; font-weight: bold; margin-right: 3%; margin-bottom: 3%;">수령인</span><input type="text" class="form-control" id="person" style="width: 25%; display: inline;" placeholder="수령인">'
         +'<br/></div><div style="margin-top: 2%;"><span style="font-style: italic; font-weight: bold; margin-right: 3%; margin-bottom: 3%;">연락처</span><input type="text" class="form-control" id="phone" style="width: 25%; display: inline;" placeholder="연락처">'
         +'<br/></div><div style="margin-top: 2%;"><span style="font-style: italic; font-weight: bold;">배송지 주소</span><div class="form-group"><input class="form-control" style="width: 40%; display: inline;" placeholder="우편번호" name="mem_oaddress" id="mem_oaddress" type="text" readonly="readonly" >'
         +'<button type="button" class="btn btn-default" onclick="execPostCode();"><i class="fa fa-search"></i> 우편번호 찾기</button></div></div><div class="form-group"><input class="form-control" style="top: 5px;" placeholder="도로명 주소" name="mem_address" id="mem_address" type="text" readonly="readonly" />'
         +'</div><div class="form-group"><input class="form-control" placeholder="상세주소" name="mem_detailaddress" id="mem_detailaddress" type="text"  />   </div>');
}


function oldadr(){
   $('#userinfo').empty();
   $('#userinfo').append('<div style="margin-top: 2%;"><span style="font-style: italic; font-weight: bold; margin-right: 3%; margin-bottom: 3%;">수령인</span><input type="text" class="form-control" id="person" style="width: 25%; display: inline;" placeholder="수령인" readonly="readonly" value="'+ $('#memName').val() + '">'
         +'<br/></div><div style="margin-top: 2%;"><span style="font-style: italic; font-weight: bold; margin-right: 3%; margin-bottom: 3%;">연락처</span><input type="text" class="form-control" id="phone" style="width: 25%; display: inline;" placeholder="연락처" readonly="readonly" value="'+ $('#memPhone').val() + '">'
         +'<br/></div><div style="margin-top: 2%;"><span style="font-style: italic; font-weight: bold;">배송지 주소</span><div class="form-group"><input class="form-control" style="width: 40%; display: inline;" placeholder="우편번호" name="mem_oaddress" id="mem_oaddress" value = "'+ $('#memOadd').val() + '" type="text" readonly="readonly" >'
         +'</div></div><div class="form-group"><input class="form-control" style="top: 5px;" placeholder="도로명 주소" name="mem_address" id="mem_address" value="'+ $('#memAdd').val() +'" type="text" readonly="readonly" />'
         +'</div><div class="form-group"><input class="form-control" placeholder="상세주소" name="mem_detailaddress" id="mem_detailaddress" readonly="readonly" value="'+ $('#memDadd').val() +'" type="text"/></div>');
} 
</script>
</head>
<body>
   <div id="readyWrap">
      <div>
         <span style="font-size: 30px; font-weight: 500;">주문/결제</span>
      </div>

      <div>
         <div>
            <table id="payinfoTable">
               <thead>
                  <tr>
                     <th style="width: 10%; text-align: center;">이미지</th>
                     <th style="width: 30%; text-align: center;">상품정보</th>
                     <th style="width: 10%; text-align: center;">배송비</th>
                     <th style="width: 10%; text-align: center;">가격</th>
                     <th style="width: 10%; text-align: center;">수량</th>
                     <th style="width: 10%; text-align: center;">주문금액</th>
                  </tr>
               </thead>
               
               <tbody>
                  <c:forEach items="${cartinfoList}" var="dto">
                     <tr>
                        <td style="width: 10%"><img src="${dto.shop_imgpath}/0.jpg" width="70%" height="80px"></td>
                        <td style="width: 35%">${dto.shop_name}</td>
                        <td style="width: 10%">Free</td>
                        <td style="width: 10%"><fmt:formatNumber value="${dto.shop_price}" type="number" />원</td>
                        <td style="width: 10%">${dto.cartList.cart_buycount}개</td>
                        <td style="width: 10%"><fmt:formatNumber value="${dto.shop_price*dto.cartList.cart_buycount}" type="number" />원</td>
                     </tr>
                  </c:forEach>
               </tbody>
            </table>
         </div>
      
         <div id="payinfoAll">
            <div id="payinfoLeft">
               <div style="font-size: large; margin-bottom: 3%; font-weight: 500;">배송지정보</div> 
               <div>
                  <span style="font-style: italic; font-weight: bold; margin-right: 3%; margin-bottom: 3%;">배송지 선택</span>
                  <input type="radio" name="address" value="신규배송지" id="newadr" checked="checked" onclick="newadr()">신규배송지
                  <input type="radio" name="address" value="기존배송지" onclick="oldadr()">기존배송지
                  <br/>
                  <div id="userinfo">
                     <div style="margin-top: 2%;">
                        <span style="font-style: italic; font-weight: bold; margin-right: 3%; margin-bottom: 3%;">수령인</span>
                        <input type="text" class="form-control" id="person" style="width: 25%; display: inline;" placeholder="수령인">
                        <br/>
                     </div>
                     <div style="margin-top: 2%;">
                        <span style="font-style: italic; font-weight: bold; margin-right: 3%; margin-bottom: 3%;">연락처</span>
                        <input type="text" class="form-control" id="phone" style="width: 25%; display: inline;" placeholder="연락처">
                        <br/>
                     </div>
                     <div style="margin-top: 2%;">
                        <span style="font-style: italic; font-weight: bold;">배송지 주소</span>
                        <div class="form-group">
                        <input class="form-control" style="width: 40%; display: inline;" placeholder="우편번호" name="mem_oaddress" id="mem_oaddress" type="text" readonly="readonly" >
                            <button type="button" class="btn btn-default" onclick="execPostCode();"><i class="fa fa-search"></i> 우편번호 찾기</button>                               
                        </div>
                     </div>
                     
                     <div class="form-group">
                         <input class="form-control" style="top: 5px;" placeholder="도로명 주소" name="mem_address" id="mem_address" type="text" readonly="readonly" />
                     </div>
                     
                     <div class="form-group">
                         <input class="form-control" placeholder="상세주소" name="mem_detailaddress" id="mem_detailaddress" type="text"  />
                     </div>
                  </div>
               </div>
            </div>

            <div id="payinfoRight">
               <div style="font-size: large; margin-bottom: 5%;">주문자정보</div>
               <div>${memInfo.mem_name}</div>
               <div>${memInfo.mem_phone}</div>
               <div>${memInfo.mem_email}</div>
               <input type="hidden" id="memName" value="${memInfo.mem_name}">
               <input type="hidden" id="memPhone" value="${memInfo.mem_phone}">
               <input type="hidden" id="memOadd" value="${memInfo.mem_oaddress}">
               <input type="hidden" id="memAdd" value="${memInfo.mem_address}">
               <input type="hidden" id="memDadd" value="${memInfo.mem_detailaddress}">
               <hr>
               <div style="color: green;">주문자 정보로 결제관련 정보가 제공됩니다.</div>
               <div style="color: green;">정확한 정보로 등록되어 있는지 확인해주세요.</div>
            </div>
            
            
         </div>

         <div style="border-top : 1px dashed #ccc;">
            <div>
               <div style="font-size: large; font-weight: 500; margin-top: 4%;">할인 및 포인트</div>
               <span style="margin-top: 5px;">NANALAND 포인트</span>
               <input type="hidden" id="memPoint" value="${memInfo.mem_point}">
               <div id="pointform"><input type="text" id="point" value="0"><button id="allPoint">전액사용</button><span>&nbsp;&nbsp;(사용가능 포인트: <fmt:formatNumber value="${memInfo.mem_point}" type="number" />P)</span></div>
            </div>
            <div>
               <input type="hidden" id="sellSum" value="${sellSum}">
               <input type="hidden" id="payChk" value="true">
               <div style="color: red;">최소 결제 금액은 100원입니다.</div>
               <div style="margin-top : 4%; padding-left : 2%; border-top : 1px dashed #ccc; background-color: #f5f5f0;">
               <div style="margin-top : 2%;"><div>총 상품금액(+)&emsp;&emsp;&emsp;&emsp;&emsp;<fmt:formatNumber value="${sellSum}" type="number" />원</div></div>
               <div id="usePoint"><div>포인트 사용금액(-)&emsp;&emsp;&emsp;0P</div></div>
               <div id="sum" style="font-weight: bold; margin-top: 3%; padding-bottom: 40px;">결제금액<div style="font-weight: 1000; font-size: x-large;"><fmt:formatNumber value="${sellSum}" type="number" />원</div></div>
               </div>
            </div>
         </div>
         <span>
            <input type="image" id="kakaopaymentBtn" src="images/kakaopay.png">
         </span>
      </div>

      
   </div>
</body>
</html>