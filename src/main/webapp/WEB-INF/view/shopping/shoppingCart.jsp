<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#hobbyTable{
   width: 100%;
   height: 100%;
   text-align: center;
   margin: auto;
   border-top: 1px solid #ccc;
   border-bottom: 1px solid #ccc;
   border-collapse: collapse;
   line-height: 2.7;
   border-top : none;
   border-bottom: 2px solid #4d4d4d;
   margin-top : 4%;
}

#hobbyTable th{
   border-top : none;
   border-bottom: 2px solid #4d4d4d;
}

#hobbyTable td{
   border-bottom: 1px solid #ccc;
   border-collapse: collapse;
    padding: 8px;
}

#cartpay{
   margin-top: 3%;
   margin-bottom: 1%;
}

#cartpayTable{
   width: 100%;
   height: 100%;
   text-align: center;
   margin: auto;
   border: 3px solid #ccc;
   border-collapse: collapse;
   /* line-height: 3; */
}

.cartDel{
   width : 55px; 
      height : 25px; 
      border : 1px solid #b3b3b3;
      background-color : white;
      color : #b3b3b3; 
      font-size: 12px;
      cursor: pointer;
      display: inline-block;
      float: right;
      margin-right: 100px;
}

#morehobbyBtn{
   width : 250px; 
      height : 50px; 
      border : 1px solid #4d4d4d;
      background-color : white;
      color : #4d4d4d; 
      font-size: 17px;
      cursor: pointer;
      display: inline-block;
      margin-left: 33%;
      margin-right: 1%;
}

#hobbypaymentBtn{
   width : 250px; 
      height : 50px; 
      border : 1px solid white;
      background-color : #ff4d4d;
      border : 1px solid #ff4d4d;
      color : white; 
      font-size: 17px;
      cursor: pointer;
      display: inline-block;
}

#title{
   text-decoration: none;
   color: black;
}

#title:hover{
   color:  #d580ff;
}

#minus, #plus{
   background-color: white;
   color: black;
   border: 2px solid #b3b3b3;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
   
   //동적 페이지 처리
   $(document).on('click', '.cartDel', deletefunction);
   $(document).on('click', '.plus', plusfunction);
   $(document).on('click', '.minus', minusfunction);
   
   
   $('#hobbypaymentBtn').on('click', function(){
	  var stockList =  $('#stockChk').val().split('*');
	  var payList = $('#payChk').val().split('*');
	  
	  for(var i = 0; i < stockList.length; i++){
		  var sp = stockList[i] - payList[i];
		  if(sp < 0){
			  alert('재고가 부족한 상품이 존재합니다. 확인해주시기 바랍니다.');
			  return false;
		  }
	  }
	  
	  location.href = "kakaoPayReady.do";
	  
   });
   
});


function deletefunction(){
	$('#size').attr('value', $('#size').val()-1);
	
   $.ajax({
      type : 'GET',
      dataType : 'json',
      url : 'shoppingCartDel.do?shop_num='+$(this).val(),
      success : viewMessage
   });
}

function plusfunction(){
   var uptdata = $(this).val().split('*');
   
   var count = uptdata[1];
   var st = uptdata[2] - count;
   if(st > 0){
   count++;

   $.ajax({
      type : 'GET',
      dataType : 'json',
      url : 'shoppingCartPlusMinus.do?shop_num='+uptdata[0]+'&cart_buycount='+count,
      success : viewMessage
   });
   }else{
	   alert('재고가 부족합니다.');
   }
}


function minusfunction(){
   var uptdata = $(this).val().split('*');
   
   var count = uptdata[1];
   if(count != 1){
      count--;
      
      $.ajax({
         type : 'GET',
         dataType : 'json',
         url : 'shoppingCartPlusMinus.do?shop_num='+uptdata[0]+'&cart_buycount='+count,
         success : viewMessage
      });
   }
}


function viewMessage(res) {
   $('#hobbyTbody').empty();
   $('#hobbyallTbody').empty();
   $('#stock').empty();
   $('#pay').empty();
   
   var scount = 0;
   var ssum = 0;
   var sstock = "";
   var spay = "";
   
   
   $.each(res, function(index,value){
      $('#hobbyTbody').append('<tr><td style="width: 15%"><img src="' + value.shop_imgpath 
            + '/0.jpg" width="70%" height="80px" style="padding-top : 20px;"></td><td style="width: 40%"><a href="shoppingView.do?shop_num=' + value.shop_num + '" id="title">'
            + value.shop_name + '</a></td><td style="width: 20%">' + String(value.shop_price*value.cartList.cart_buycount).replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,') 
            +'원</td><td><button class="minus" value="' + value.shop_num+'*'+value.cartList.cart_buycount+'">-</button><input type="text" class="count" size="1" value="'+value.cartList.cart_buycount+'" style="text-align: center; border-left: none; border-right: none; border-top:2px solid #b3b3b3; border-bottom: 2px solid #b3b3b3;"><button class="plus" value="' + value.shop_num +'*'+ value.cartList.cart_buycount+'*'+value.shop_stock+'">+</button></td><td><button class="cartDel" value="' 
            + value.shop_num + '">삭제</button></td></tr>');
      
      scount += 1;
      ssum = ssum + (value.shop_price*value.cartList.cart_buycount);
      
      if(index == res.length-1) {
    	  sstock = sstock + value.shop_stock;
    	  spay = spay + value.cartList.cart_buycount;
	  }else {
		  sstock = sstock + value.shop_stock + "*";
		  spay = spay + value.cartList.cart_buycount + "*";
	  }
      
   });
   $('#stock').append('<input type="hidden"  id="stockChk" value="'+ sstock +'">');
   $('#pay').append('<input type="hidden"  id="payChk" value="'+spay+'">');
   
   ssum = String(ssum);
   
   $('#hobbyallTbody').append('<tr><th style="padding-bottom: 30px;">' + scount + '종류</th><th style="border-right: 2px solid #ccc; padding-bottom: 30px;">'
                        + String(ssum*0.01).replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,') + 'P</th><th style="padding-bottom: 30px;">' + ssum.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,') + '원</th></tr><tr style="background-color: #f2f2f2; line-height: 2.5;"><td colspan="3" style="color: #ff3333; font-size: 14px; padding : 4px;"> NANA LAND 제품을 구매해 주셔서 감사합니다.</td></tr>');
   
  
   if($('#size').val() == 0){
 	  $('#paybutton').empty();
 	  $('#paybutton').append('<a href="shoppingMain.do"><button id = "morehobbyBtn">취미 고르기</button></a>');
   }
   
   
}// end viewMessage()////////////
</script>
</head>
<body>
   <div style="width: 100%;  margin-top: 3%; margin-bottom: 5%;">
      <div style="width: 80%; height: 100%; padding-left: 10%;">
         <div>
            <p style="text-align: center;font-size: xx-large; margin-bottom: 3%; font-weight: bold;">취미바구니</p>
            <div>
               <table id="hobbyTable">
                  <thead>
                     <tr style="font-size: large;">
                        <th>이미지</th>
                        <th>취미 상품 정보</th>
                        <th>결제 예정 금액</th>
                        <th>구매 수량</th>
                        <th>&nbsp;&nbsp;&nbsp;&nbsp;</th>
                     </tr>
                  </thead>
                  <tbody id="hobbyTbody">
                     <c:forEach items="${cartinfoList}" var="dto">
                        <tr>
                           <td style="width: 15%"><img src="${dto.shop_imgpath}/0.jpg" width="70%" height="80px" style="padding-top : 20px;"></td>
                           <td style="width: 40%"><a href="shoppingView.do?shop_num=${dto.shop_num}" id="title">${dto.shop_name}</a></td>
                           <td style="width: 20%"><fmt:formatNumber value="${dto.shop_price*dto.cartList.cart_buycount}" type="number" />원</td>
                           <td><button class="minus" value="${dto.shop_num}*${dto.cartList.cart_buycount}">-</button><input type="text" class="count" size="1" value="${dto.cartList.cart_buycount}" style="text-align: center; border-left: none; border-right: none; border-top:2px solid #b3b3b3; border-bottom: 2px solid #b3b3b3;"><button class="plus" value="${dto.shop_num}*${dto.cartList.cart_buycount}*${dto.shop_stock}">+</button></td>
                           <td><button class="cartDel" value="${dto.shop_num}">삭제</button></td>
                        </tr>
                        </c:forEach>
                  </tbody>
               </table>
            </div>
         </div>
         
        <div id="stock">
        	<input type="hidden"  id="stockChk" value="${stockpro}">
        </div>
        <div id="pay">
        	<input type="hidden"  id="payChk" value="${paypro}">
        </div>
         
         
         <div id="cartpay">
               <table id="cartpayTable">
                  <thead>
                     <tr>
                        <th style="width: 30%; font-size: small; color: #808080; padding-top: 30px;">총 상품 종류</th>
                        <th style="width: 55%; border-right: 2px solid #ccc; font-size: small; color: #808080; padding-top: 30px;">적립 포인트</th>
                        <th style="width: 20%; font-size: small; color: #808080; padding-top: 30px;">총 결제금액</th>
                     </tr>
                  </thead>
                  <tbody id="hobbyallTbody">
                     <tr>
                        <th style="padding-bottom: 30px;">${sellCount}종류</th>
                        <th style="border-right: 2px solid #ccc; padding-bottom: 30px;"><fmt:formatNumber value="${sellPoint}" type="number" />P</th>
                        <th style="padding-bottom: 30px;"><fmt:formatNumber value="${sellSum}" type="number" />원</th>
                     </tr>
                     <tr style="background-color: #f2f2f2; line-height: 2.5;">
                        <td colspan="3" style="color: #ff3333; font-size: 14px; padding : 4px;"> NANA LAND 제품을 구매해 주셔서 감사합니다.</td>
                     </tr>
                  </tbody>
               </table>
         </div>
         
         <div>
            <ul style="color: #bfbfbf; font-size: small;">
               <li>결제는 월별로 진행됩니다. 각 클래스의 결제예정일 및 결제금액을 확인해주세요.</li>
               <li>결제일은 배송일 기준 D-2 입니다.</li>
               <li>배송출발일이 휴일인 경우 이전 영업일에 발송됩니다.</li>
               <li>신청하신 구독 기간 종료 후에는 자동 결제되지 않습니다.</li>
            </ul>
         </div>
         <div style="margin-top: 3%; margin-right: 15%;" id="paybutton">
         	<input type="hidden" id="size" value="${size}">
	         <c:if test="${size != 0}">
	            <a href="shoppingMain.do"><button id = "morehobbyBtn">취미 더 고르기</button></a>
	            <!-- <a href="kakaoPayReady.do"><button id = "hobbypaymentBtn">취미 결제하기</button></a> -->
	            <button id = "hobbypaymentBtn">취미 결제하기</button>
	         </c:if>
	         <c:if test="${size == 0}">
	         	<a href="shoppingMain.do"><button id = "morehobbyBtn">취미 고르기</button></a>
	         </c:if>
         </div>
         
         
      </div>
   </div>
</body>
</html>