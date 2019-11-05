<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="css/manager/stock.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.11/handlebars.js"></script>
<script type="text/javascript">
   $(document).ready(function() {
      
      /* 입고 버튼 클릭 */
      $('#stock_update').on('click', function(){
         var s_num = $('td#shop_num').length;
         var s_stock = $('input#stock_cnt').length;
         
         var stArr = new Array(); //입고수량
         var snArr = new Array(); //상품번호
         
         for (var i = 0; i < s_stock; i++) {
            if ($('input#stock_cnt:eq('+i+')').val() != '') {
               var ss = $('input#stock_cnt:eq('+i+')').val();
               var vv = $('input#stock_cnt:eq('+i+')').parents().prev().prev().prev().html();
               snArr.push(vv);
               stArr.push(ss);
            }
         }
         
          $.ajax({
            type : 'GET',
            dataType : 'json',
            url : 'stock_update.do?snArr='+ snArr +'&stArr=' + stArr,
            success : stock_update_method
         }); 
      })
   });//end ready())
   
   function stock_update_method(res){
      alert('입고 처리가 완료되었습니다.');
      
      $('#stock_table #tablelist').remove();
      
      $.each(res,function(index, value) {
         var source = '<tr id="tablelist">' 
            + '<td style="font-weight: bold;" id="shop_num">'+value.shop_num+'</td>'
            + '<td style="font-weight: bold; text-align: left; padding-left: 10px;">'+value.shop_name+'</td>'
            + '<td style="font-weight: bold;">'+value.shop_stock+'</td>'
            + '<td><input type="text" id="stock_cnt" width="100%"/></td>';
            + '</tr>';
            
         var template = Handlebars.compile(source);
         $('#stock_table').append(template(value));

   });//end each()
      
   }//end stock_update_method()

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
</script>
<title>stock management</title>
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
         <div id="menu" style="font-family: 나눔바른펜">입/출고, 재고 관리</div>
         <hr />
         <!-- 재고 현황 -->
         <!-- 재고 현황 -->
         <!-- 재고 현황 -->
            <table id = "stock_table">
                  <tr>
                     <td colspan="4" style="height: 50px;"><b style="font-size: 20px;">재고 현황</b></td>
                  </tr>
                  <tr>
                     <td width="15%"><b>상품 번호</b></td>
                     <td width="55%"><b>상품명</b></td>
                     <td width="15%"><b>재고 수량</b></td>
                     <td width="15%"><b><input type="button"  id="stock_update" value="입고" style="background-color: white; border: none; font-family: 나눔바른펜; font-weight: bold; font-size: 17px;"></b></td>
                  </tr>
               <c:forEach items="${aList}" var="dto">
                  <tr id="tablelist">
                        <td style="font-weight: bold;" id="shop_num">${dto.shop_num}</td>
                        <td style="font-weight: bold; text-align: left; padding-left: 10px;">${dto.shop_name}</td>
                        <td style="font-weight: bold;">${dto.shop_stock}</td>
                        <td><input type="text" id="stock_cnt" width="20px;"/></td>
                  </tr>
               </c:forEach>
            </table>
      </div>
      

   </div>
</body>
</html>