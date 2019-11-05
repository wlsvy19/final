<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko" xml:lang="ko" xmlns="http://www.w3.org/1999/xhtml">
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js" charset="utf-8"></script>
<head>
<meta charset="UTF-8">
<title>마이 페이지</title>
<link href="css/member/mypageform.css" type="text/css" rel="stylesheet" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.11/handlebars.js"></script>
<script type="text/javascript">

var mem_id = '${sessionScope.mem_id}'; 
//카카오 로그인시 정보 가져옴
var kemail = '${kemail}'; // 카카오 로그인
//네이버 로그인시 정보 가져옴
var nname = '${nname}'; // 네이버 로그인

   $(document).ready(function(){
      
      $('#mygoodsBtn').on('click', goodsBtn);
      $('#mylikeBtn').on('click', likeBtn);
      
   });//end ready()
   
   function goodsBtn(){
      $.ajax({
         type       : 'GET', 
         dataType   : 'json', 
         url        : 'member_purchase.do', 
         success    :  good 
      });
   }
   
   function likeBtn(){
      $.ajax({
         type       : 'GET', 
         dataType   : 'json', 
         url        : 'member_like.do', 
         success    :  write 
      });
   }
   
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
   
   function good(res){
      $('#ajaxarea').empty();
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
               if(value.purchase_condition == 3){
                  source = source + '배송 완료 '
               }
               source = source + '&nbsp;</td>'
               + '</tr>'
               + '<tr style="text-align: center;">'
               + '<td width="23%"></td>'
               + '<td width="23%"></td>'
               + '<td colspan="3" class="sb" width="54%" style="font-weight: bold; text-align: right; padding-right: 10px; height: 50px;">'
               + '<span id = "buttonarea">';
               
               source = source + '</span>'
               + '</td>'
               + '</tr>'
               + '</table>' + '<br/>   ';

               var template = Handlebars.compile(source);
               $('#delete1').append(template(value));

   });//end each()
      
   }
   
   function write(res){
      $('#delete1').empty();
      $('#ajaxarea').empty();
      var source = '';
      
      $.each(res, function(index, value) {
         source = '<tr class = "likelist_tr">'      
          + '<td class = "likelist"><img src="'+value.likeList.shop_imgpath+'/0.jpg" style = "width : 100px; height : 100px; padding-top : 5px;"></td>'
          + '<td>[<a href="shoppingView.do?shop_num='+ value.likeList.shop_num+'" id="title">'+value.likeList.shop_name+'</a>]<br/>'+ value.likeList.shop_code +'<br/>'+value.likeList.shop_price+'원 </td>'
          + '</tr>';   
         
         
            var template = Handlebars.compile(source);
            $('#ajaxarea').append(template(value));
      });
   }
   
</script>
</head>
<body>
<c:set var="joodo" value="주도형"/>
<c:set var="an" value="안정형"/>
<c:set var="boon" value="신중형"/>
<c:set var="sagyo" value="사교형"/>
   <div id = "myall">
      <div class="header">마이페이지</div>
      <hr/>
      <table id="mytable">
         <tr>
         <c:if test="${aList.mem_hobby == joodo}">
            <td><img src="images/joodo.png" width="80px" height="80px"><br>${aList.mem_hobby}</td>
         </c:if>
         <c:if test="${aList.mem_hobby == an}">
            <td><img src="images/an.png" width="80px" height="80px"><br>${aList.mem_hobby}</td>
         </c:if>
         <c:if test="${aList.mem_hobby == boon}">
            <td><img src="images/boon.png" width="80px" height="80px"><br>${aList.mem_hobby}</td>
         </c:if>
         <c:if test="${aList.mem_hobby == sagyo}">
            <td><img src="images/sagyo.png" width="80px" height="80px"><br>${aList.mem_hobby}</td>
         </c:if>
            <td>아이디<br>${sessionScope.mem_id}</td>
            <td>포인트<br>${aList.mem_point}점</td>
            <td>주문 조회<br><input type="image" id="mygoodsBtn" src="images/btn_mymore.gif" width="20px" height="20px" style="padding-top: 10px;"></td>
            <td>관심 상품<br><input type="image" id="mylikeBtn" src="images/btn_mymore.gif" width="20px" height="20px" style="padding-top: 10px;"></td>
            <td>개인 정보 수정<br><a href="membermodifyform.do"><input type="image" src="images/btn_mymore.gif" width="20px" height="20px" style="padding-top: 10px;"></a></td>
            <td>회원 탈퇴<br><a href="memberdelete.do"><input type="image" src="images/btn_mymore.gif" width="20px" height="20px" style="padding-top: 10px;"></a></td>
         </tr>
      </table>
      <hr/>
      
      <table id="ajaxarea"></table>
       <div id="delete1"></div>
   </div>
</body>
</html>