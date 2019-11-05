<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
* {
   margin: 0;
}

#bxslider_box {
   width: 100%;
   height: 500px;
   /* background-color: #ccb; */
   margin-bottom: 70px;
}

#bxslider_box #test {
   width: 80%;
   padding-top: 3%;
   padding-left: 10%;
}

#bxslider_box #test .bxImage {
   width: 100%;
   height: 380px;
   size: 100%;
}

#menubar {
   text-align: center;
   margin-bottom: 80px;
}

#menubar a {
   text-align: center;
   text-decoration: none;
   color: black;
   cursor: pointer;
}

#wrap {
   /* margin: 2%; */
   /* padding-left: 200px; */
   padding-left: 200px;
}

#menulistline {
   padding: 50px;
   margin-bottom: 50px;
   /* background-color: yellow; */
}

#title {
   text-decoration: none;
   color: black;
}

#title:hover {
   color: #d580ff;
}

#menuOption {
   margin-left: 84%;
   position: relative;
   box-sizing: border-box;
   width: 23%;
   overflow: hidden;
}

#selectOpt {
   -webkit-appearance: none;
   -moz-appearance: none;
   appearance: none;
   width: 23%;
   padding: 9px 9px 11px 13px;
   background-color: #ffcc66;
   border: none;
   border-radius: 5px;
   outline: none;
   font: 300 15px 'Open Sans', sans-serif;
   color: black;
   cursor: pointer;
}

select:-moz-focusring {
   color: transparent;
   text-shadow: 0 0 0 #000;
}
</style>


<!-- 추가 -->
<link
   href="https://cdnjs.cloudflare.com/ajax/libs/bxslider/4.2.15/jquery.bxslider.min.css"
   rel="stylesheet" />
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/bxslider/4.2.15/jquery.bxslider.min.js"></script>

<script type="text/javascript">
   $(document).ready(
         function() {
            var selectCategory = "전체";
            var selectOption = "등록";

            $('#menubar a').css('color', 'black');
            $('#all').css('color', '#cc00ff');

            $('.bxslider').bxSlider({
               mode : "horizontal", // 가로 수평으로 슬라이드 됩니다.
               speed : 500, // 이동 속도를 설정합니다.
               pager : true, // 현재 위치 페이징 표시 여부 설정.(false->true 하면 아래에 현재페이지 위치 보임)
               moveSlides : 1, // 슬라이드 이동시 갯수 설정.
               slideWidth : 1500, // 슬라이드 마다 너비 설정. (90->500)
               minSlides : 1, // 최소 노출 개수를 설정합니다. (4->3->1)
               maxSlides : 1, // 최대 노출 개수를 설정합니다. (4->3->1)   
               slideMargin : 10, // 슬라이드간의 간격을 설정합니다.
               auto : true, // 자동으로 흐를지 설정합니다. (false로 바꾸면 안움직임)
               autoHover : true, // 마우스 오버시 정시킬지 설정합니다.
               controls : false,// 이전 다음 버튼 노출 여부 설정합니다.(false로바꾸면, 이전 다음이 있으면 표시가 안됨)
               captions : true
            //이미지 위애 텍스트 올리기 설정
            });

            $('#menubar a').click(
                  function() {
                     var category = $(this).text().split('(');

                     if (category[0] != selectCategory) {
                        $('#menubar a').css('color', 'black');
                        $(this).css('color', '#cc00ff');
                        selectCategory = category[0];
                     }

                     $.ajax({
                        type : 'GET',
                        dataType : 'json',
                        url : 'shoppingList.do?category=' + category[0]
                              + '&selectOption=' + selectOption,
                        success : viewMessage
                     });
                  });

            $('#selectOpt').on(
                  'change',
                  function() {
                     selectOption = $('#selectOpt option:selected')
                           .val();

                     $.ajax({
                        type : 'GET',
                        dataType : 'json',
                        url : 'shoppingList.do?category='
                              + selectCategory + '&selectOption='
                              + selectOption,
                        success : viewMessage
                     });
                  });

         });

   function viewMessage(res) {
      $('#wrap').empty();
      $
            .each(
                  res,
                  function(index, value) {
                     $('#wrap')
                           .append(
                                 '<div id="menulistline" style="float: left; width: 30%; padding:1px;"><a href="shoppingView.do?shop_num='
                                       + value.shop_num
                                       + '"><img src="'
                                       + value.shop_imgpath
                                       + '/0.jpg" width="90%" height="280px"></a><p><a href="shoppingView.do?shop_num='
                                       + value.shop_num
                                       + '" id="title">'
                                       + value.shop_name
                                       + '</a></p><p>'
                                       + String(value.shop_price)
                                             .replace(
                                                   /(\d)(?=(?:\d{3})+(?!\d))/g,
                                                   '$1,')
                                       + '원</p></div>');
                  });
   }// end viewMessage()////////////
</script>
</head>
<body>
   <div id="bxslider_box">
      <div id="test">
         <ul class="bxslider">
            <li><img class="bxImage" src="./images/main_bx1.png"
               alt="bxslider 이미지"></li>
            <li><img class="bxImage" src="./images/main_bx2.png"
               alt="bxslider 이미지"></li>
            <li><img class="bxImage" src="./images/main_bx3.png"
               alt="bxslider 이미지"></li>
         </ul>
      </div>
   </div>

   <div id="menubar">
      <a id="all">전체</a>&nbsp;&nbsp;&nbsp; <a>주도형(Dominance)</a>&nbsp;&nbsp;&nbsp;
      <a>사교형(Influence)</a>&nbsp;&nbsp;&nbsp; <a>안정형(Steadiness)</a>&nbsp;&nbsp;&nbsp;
      <a>신중형(Conscientiousness)</a>
   </div>

   <div id="menuOption">
      <select name="menu" id="selectOpt" style="margin-bottom: 10%; text-align: center;">
         <option value="등록" selected>등록순</option>
         <option value="별점">별점순</option>
         <option value="구매">구매순</option>
      </select>
   </div>

   <div id="wrap">
      <c:forEach items="${aList}" var="dto">
         <div id="menulistline" style="float: left; width: 30%; padding: 1px;">
            <a href="shoppingView.do?shop_num=${dto.shop_num }"><img
               src="${dto.shop_imgpath}/0.jpg" width="90%" height="280px"></a>
            <p>
               <a href="shoppingView.do?shop_num=${dto.shop_num }" id="title">${dto.shop_name}</a>
            </p>
            <p>
               <fmt:formatNumber value="${dto.shop_price}" type="number" />
               원
            </p>
         </div>
      </c:forEach>
   </div>
</body>
</html>