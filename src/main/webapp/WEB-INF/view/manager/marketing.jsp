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
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.11/handlebars.js"></script>

<script type="text/javascript">
   $(document).ready(function() {
      
      /* 배송 준비 중 버튼 클릭 */
      $(document).on('click', '.prepare', function() {
         var condition = $(this).prop('name');
         var num = $(this).prop('id');
         
         alert('배송 준비 처리되었습니다.');
         ButtonClick(condition, num);
      });
      /* 배송 중 버튼 클릭 */
      $(document).on('click', '.ready', function() {
         alert('배송 중 처리되었습니다.');
         var condition = $(this).prop('name');
         var num = $(this).prop('id');
         ButtonClick(condition, num);
      });
      /* 배송 완료  버튼 클릭 */
      $(document).on('click', '.complete', function() {
         alert('배송 완료 처리되었습니다.');
         var condition = $(this).prop('name');
         var num = $(this).prop('id');
         ButtonClick(condition, num);
      });

   });//end ready())

   /* 배송 처리 버튼 클릭 후 발생 */
   function ButtonClick(condition, num) {
      $.ajax({
         type : 'GET',
         dataType : 'json',
         url : 'purchase_update.do?purchase_condition=' + condition + '&purchase_num=' + num,
         success : update_list
      });
   }//end ButtonClick()

   /* 날짜, 시간 handlebars 사용 표현 */
   Handlebars.registerHelper("newDate", function(timeValue) {
      //timeValue : 받아온 regdate의 변수명
      var sdate = new Date(timeValue);
      var year = sdate.getFullYear();
      var month = sdate.getMonth() + 1;
      var date = sdate.getDate();

      if ((month + "").length < 2) {
         month = "0" + month;
      } else if ((date + "").length < 2) {
         date = "0" + date;
      }

      return year + "." + month + "." + date;
   });
   
   /* 배송 현황 업데이트 */
   function update_list(res) {
      $('#delete1').empty();

      $.each(res,function(index, value) {
            var source = '<table id = "purchaselist">'
                  + '<tr style="height: 20px;">'
                  + '<td class="sb" colspan="5" style="height: 20px;"></td>'
                  + '</tr>'
                  + '<tr style="text-align: center; vertical-align: top;">'
                  + '<td rowspan="5" width="20%"><img src="'+ value.shop.shop_imgpath + '/0.jpg" style="width: 210px; height: 180px; text-align: center; margin-left: 10px;"></td>'
                  + '<td style="font-size: 20px; text-align: left; font-weight: bold;">&nbsp;주문자 : '
                  + value.mem_id
                  + '<br/>&nbsp;수령인 : '
                  + value.purchase_name
                  + '</td>'
                  + '<td colspan="2" style="text-align: left; color: #A6A6A6;">&nbsp;주소 : '
                  + value.purchase_oaddress
                  + '&nbsp;'
                  + value.purchase_address
                  + '&nbsp;'
                  + value.purchase_detailaddress
                  + '&nbsp;<br/>&nbsp;주문자 번호 : '
                  + value.purchase_phone
                  + '&nbsp;</td>'
                  + '<td class="sb" style="text-align: center; color: #A6A6A6;">주문 일자 : {{newDate purchase_regdate}}</td>'
                  + '</tr>'
                  + '<tr>'
                  + '<td colspan="5" style="padding-left: 35px; font-weight: bold;">구매상품내용</td>'
                  + '</tr>'
                  + '<tr>'
                  + '<td colspan="5" style="color: #A6A6A6; padding-left: 35px;">구매 상품 : '
                  + value.shop.shop_name
                  + ' '
                  + value.purchase_cnt
                  + '개</td>'
                  + '</tr>'
                  + '<tr style="text-align: right;">'
                  + '<td colspan="5" id="condition" style="font-size: 20px; font-weight: bold;">결제 금액 : <b style="color: red; font-size: 25px; font-weight: bold;">'
                  + value.purchase_totalprice
                  + '</b>원 | ';
                  if(value.purchase_condition == 0){
                     source = source + '결제 완료 '
                  }
                  if(value.purchase_condition == 1){
                     source = source + '배송 준비 중 '
                  }
                  if(value.purchase_condition == 2){
                     source = source + '배송 중 '
                  }
                  source = source + '&nbsp;</td>'
                  + '</tr>'
                  + '<tr style="text-align: center;">'
                  + '<td width="23%"></td>'
                  + '<td width="23%"></td>'
                  + '<td colspan="3" class="sb" width="54%" style="font-weight: bold; text-align: right; padding-right: 10px; height: 50px;">'
                  + '<span id = "buttonarea">';
                  if(value.purchase_condition == 0){
                  source = source + '<input type="button" id="'+ value.purchase_num+'" style = "margin-left:4.2px;" name="1" class="prepare" value="배송 준비 중  처리">'
                  }
                  if(value.purchase_condition == 1){
                  source = source + '<input type="button" id="'+ value.purchase_num+'" style = "margin-left:4.2px;" name="2" class="ready" value="배송 중  처리">'
                  }
                  if(value.purchase_condition == 2){
                  source = source + '<input type="button" id="'+ value.purchase_num+'" style = "margin-left:4.2px;" name="3" class="complete" value="배송 완료  처리">'
                  }
                  source = source + '</span>'
                  + '</td>'
                  + '</tr>'
                  + '</table>' + '<br/>   ';

                  var template = Handlebars.compile(source);
                  $('#delete1').append(template(value));

      });//end each()

   }//end update_listupdate_listupdate_listupdate_listupdate_listupdate_listupdate_listupdate_listupdate_list
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
         <div id="menu" style="font-family: 나눔바른펜">판매 관리</div>
         <hr />
         <!-- 그래프 -->
         <!-- 그래프 -->
         <!-- 그래프 -->
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
   
   
         <!-- 판매 목록 -->
         <!-- 판매 목록 -->
         <!-- 판매 목록 -->
         <br />
         <div class="delivery">
            <span><a href="marketing.do">처리 중</a></span> 
            <span>/</span>
            <span><a href="complete.do">배송 완료</a></span>
         </div>
         <hr />
   
         <div id="delete1">
            <c:forEach var="dto" items="${aList}">
               <table id="purchaselist">
                  <tr style="height: 20px;">
                     <td class="sb" colspan="5" style="height: 20px;"></td>
                  </tr>
   
                  <tr style="text-align: center; vertical-align: top;">
                     <td rowspan="5" width="20%"><img src="${dto.shop.shop_imgpath}/0.jpg" style="width: 210px; height: 180px; text-align: center; margin-left: 10px;"></td>
                     <td style="font-size: 20px; text-align: left; font-weight: bold;">&nbsp;주문자 : ${dto.mem_id} <br />&nbsp;수령인 : ${dto.purchase_name}</td>
                     <td colspan="2" style="text-align: left; color: #A6A6A6;">&nbsp;주소 : ${dto.purchase_oaddress}&nbsp;${dto.purchase_address}&nbsp;${dto.purchase_detailaddress}&nbsp;<br />&nbsp;주문자 번호 : ${dto.purchase_phone}&nbsp;</td>
                     <td class="sb" style="text-align: center; color: #A6A6A6;">주문 일자 : <fmt:formatDate value="${dto.purchase_regdate}" pattern="yyyy.MM.dd" /> </td>
                  </tr>
                  
                  <tr>
                     <td colspan="5" style="padding-left: 35px; font-weight: bold;">구매상품내용</td>
                  </tr>
                  
                  <tr>
                     <td colspan="5" style="color: #A6A6A6; padding-left: 35px;">구매 상품 : ${dto.shop.shop_name} ${dto.purchase_cnt}개</td>
                  </tr>
                  
                  <tr style="text-align: right;">
                     <td colspan="5" id="condition" style="font-size: 20px; font-weight: bold;">결제 금액 : <b style="color: red; font-size: 25px; font-weight: bold;">${dto.purchase_totalprice}</b>원 |
                     
                     <c:set var="condition" value="${dto.purchase_condition}"></c:set>
                     <c:choose>
                        <c:when test="${condition == 0}">결제 완료</c:when>
                        <c:when test="${condition == 1}">배송 준비 중</c:when>
                        <c:when test="${condition == 2}">배송 중</c:when>                  
                     </c:choose>
                     
                     &nbsp;</td>
                  </tr>
                  
                  <tr style="text-align: center;">
                     <td width="23%"></td>
                     <td width="23%"></td>
                     <td colspan="3" class="sb" width="54%" style="font-weight: bold; text-align: right; padding-right: 10px; height: 50px;">
                        <span id="buttonarea" style="text-align: center;">
                        <c:set var="regcondition" value="0"></c:set>
                        <c:set var="regcondition1" value="1"></c:set>
                        <c:set var="regcondition2" value="2"></c:set>
                        <c:if test="${dto.purchase_condition == regcondition}"> 
                           <input type="button" id="${dto.purchase_num}" name="1" class="prepare" value="배송 준비 중 처리">
                        </c:if>
                        <c:if test="${dto.purchase_condition == regcondition1}">
                           <input type="button" id="${dto.purchase_num}" name="2" class="ready" value="배송 중 처리">
                        </c:if>
                        <c:if test="${dto.purchase_condition == regcondition2}">
                           <input type="button" id="${dto.purchase_num}" name="3" class="complete" value="배송 완료 처리">
                        </c:if>
                        </span>
                     </td>
                  </tr>
               </table>
               <br /> 
            </c:forEach>
         </div>
         
      </div>
      
   </div>
   
</body>
</html>