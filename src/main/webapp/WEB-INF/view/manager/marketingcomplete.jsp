<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="css/manager/marketing.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
      $(document).ready(function(){
        $('.prepare').on('click', function(){
         var id = $(this).prop('id');
         $.ajax({
               type       : 'GET', 
               dataType    : 'json',  
               url       : 'replyDelete.do?board_num=${dto.board_num}&reply_num=' + drno, 
               success    : reply_list_result 
          });
        });//end prepareprepareprepareprepareprepareprepareprepareprepareprepareprepareprepareprepare 
      });//end readyreadyreadyreadyreadyreadyreadyreadyreadyreadyreadyreadyreadyreadyreadyreadyready
</script>
<title>marketing management</title>
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
      <div id = "menu">판매 관리</div>
   <hr/>
   
   <!-- 그래프 -->
   <!-- 그래프 -->
   <!-- 그래프 -->
   <div id="chart_div" style="width: 800px; height: 500px;">
         <table id = "chart_table">
               <tr>
               <td width="10%"></td>
               <td width="80%"><b style="font-size: 20px;">나나랜드 월별 전 품목 판매량</b></td>
               <td width="10%"></td>
               </tr>
            <c:forEach items="${list}" var="list" varStatus="status">
               <tr>
                  <td width="10%" style="font-weight: bold;">${status.count}월</td>
                  <td width="80%" style="text-align: left;"><img src="./images/chart123.PNG" width="${list * 15}" height="26px;" style="margin-top: 4px;"></td>
                  <td width="10%" style="font-weight: bold;">${list}</td>
               </tr>
            </c:forEach>
         </table>
   </div>
   
   
   
   <!-- 판매 목록 -->
   <!-- 판매 목록 -->
   <!-- 판매 목록 -->
   <br/>
   <div class = "delivery">
      <span><a href = "marketing.do">배송 중</a></span>
      <span>/</span>
      <span><a href = "complete.do">배송 완료</a></span>
   </div>
   <hr/>
   <c:forEach var="dto" items="${aList}">
   <table id = "purchaselist">
      <tr style="height: 20px;">
         <td class="sb" colspan="5" style="height: 20px;"></td>
      </tr>
      
      <tr style="text-align: center; vertical-align: top;">
         <td rowspan="5" width="20%"><img src="${dto.shop.shop_imgpath}/0.jpg" style="width:210px; height:180px; text-align: center;"></td> 
         <td style="font-size: 20px; text-align: left; font-weight: bold;">&nbsp;주문자 : ${dto.mem_id} <br/>&nbsp;수령인 : ${dto.purchase_name}</td>
         <td colspan="2" style="text-align: left; color: #A6A6A6;">&nbsp;주소 : ${dto.purchase_oaddress}&nbsp;${dto.purchase_address}&nbsp;${dto.purchase_detailaddress}&nbsp;<br/>&nbsp;주문자 번호 : ${dto.purchase_phone}&nbsp;</td>
         <td class="sb" style="text-align: center; color: #A6A6A6;">주문 일자 : <fmt:formatDate value="${dto.purchase_regdate}" pattern="yyyy.MM.dd" /></td>
         
      </tr>
      <tr>
         <td colspan="5" style="padding-left: 35px; font-weight: bold;">구매상품내용</td>
      </tr>
      <tr>
         <td colspan="5" style="color: #A6A6A6; padding-left: 35px;">구매 상품 : ${dto.shop.shop_name} ${dto.purchase_cnt}개</td>
      </tr>
      <tr style="text-align: right;">
         <td colspan="5" style="font-size: 20px; font-weight: bold;">결제 금액 : <b style="color: red; font-size: 25px; font-weight: bold;">${dto.purchase_totalprice}</b>원&nbsp;&nbsp;</td>
      </tr>
      <tr style="text-align: center;">
         <td width="25%"></td>
         <td width="25%"></td>
         <td colspan="3" class="sb" width="50%" style="font-size: 20px; font-weight: bold; text-align: right;"> 배송완료 &nbsp;&nbsp;</td>
      </tr>
   </table>
   <br/>
   </c:forEach>
   </div>

</div>

</body>
</html>