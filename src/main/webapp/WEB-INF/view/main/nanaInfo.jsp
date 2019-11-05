<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/map.css?after">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">

<script type="text/javascript"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=31a91b3131d8ac0ef598e70018388b20"></script>
 <script src='https://cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.3/modernizr.min.js'></script>
    
 <script type="text/javascript">
 
 $(document).ready(function(){
    count();
    
var memcnt
var likent
var product
 

   setInterval(function(){
      count();
   }, 3000);
   
   
   //회원 수 좋아요수 상품수 애니매이션 효과 주기
    function count(memcnt , likecnt , productcnt) {
      var $el = $("#count_number");
      $({ val : 0 }).animate({ val : ${memcnt} }, {
         duration: 300,
         step: function() {
            $el.text(Math.floor(this.val));
         },
         complete: function() {
            $el.text(Math.floor(this.val));
         }
      });
      
      var $eld = $("#count_like");
      $({ val : 0 }).animate({ val : ${likecnt} }, {
         duration: 300,
         step: function() {
            $eld.text(Math.floor(this.val));
         },
         complete: function() {
            $eld.text(Math.floor(this.val));
         }
      });
      
      var $elf = $("#count_product");
      $({ val : 0 }).animate({ val : ${productcnt} }, {
         duration: 300,
         step: function() {
            $elf.text(Math.floor(this.val));
         },
         complete: function() {
            $elf.text(Math.floor(this.val));
         }
      });
   } 
 });
 </script>
 
</head>
<body>
   <div class = "wrap" id="wrap">
      
      <div class="Introduce-wrap" id="Introduce-wrap">
         <div class="Introduce-area1" id="Introduce-area1" >

         </div>
         
         <div class="Introduce-area2" id="Introduce-area2">
            <div class = "Introduc-area2-tit">
            브랜드 소개
            </div>
            
            <div class = "Introduc-area2-subtit">
            나나랜드를 소개 합니다.
            </div>
            <div class=divblokc>
              <hr class=block>
            </div>
            <ul>
               <li class = "Introduce-area2-img3">
            </ul>
            
            <div class = "Introduce-area2-img4">
               
            </div>
            
              <div class="container-relative" >
                <!-- Counters -->
                <div class="row">
                 <div class="row-tit">저희와 함께 해주신 분들</div>
                  <div class="col">
                    <div id= "count_number" class="count-numbers">${memcnt}</div>
                    <div class="count-descr">
                      <i class="fa fa-suitcase"></i>
                      <span class="count-title">MEMBER</span>
                    </div>
                  </div>
                  <div class="col">
                    <span id="count_like" class="count-numbers">${likecnt}</span>
                    <div class="count-descr">
                      <i class="fa  fa-heart"></i>
                      <span class="count-title">LIKE</span>
                    </div>
                  </div>
                  <div class="col">
                    <span id="count_product" class="count-numbers">${productcnt}</span>
                    <div class="count-descr">
                      <i class="fa fa-coffee"></i>
                      <span class="count-title">PRODUCTS</span>
                    </div>
                  </div>
                </div>
              </div>
            
            
            
            <ul class="Introduc-area2-img-area">
               <li class="Introduc-area2-img-area-tit1">당신의 취미를 찾아드립니다.</li>
               <li class="Introduc-area2-img-area-subtit1">간단한 테스트를 통해 당신의 취미를 알아 볼 수 있습니다</li>
               <li class="Introduc-area2-img1"></li>
            </ul>
            <ul>
               <li class="Introduc-area2-img-area-tit2">마음에 드는 취미를 배달해 드립니다.</li>
               <li class="Introduc-area2-img-area-subtit2">고르신 취미와 관련된 재료 혹은 수업을 체험해 보실 수 있습니다</li>
               <li class="Introduc-area2-img2"></li>
            </ul>   
                  
         </div>
         <div class="Introduce-area3" id="Introduce-area3">
            <div class = "Introduc-area2-tit">
            나나랜드에서 필요한 3단계
            </div>
            
            <hr class=block>
            
            <div class = test1  style="text-align: center;">
               <hr></hr>
               <a>
               DISC 테스트를 통해 자신의 취미를 찾아보세요!
               <br>
               자신이 몰랐던 취미를 찾아가는 즐거움을 느껴보실 수 있습니다.
               </a>
            </div>
            <div class = test2 style="text-align: center;">
               <hr/>
               <a>
               자신이 원하는 취미와 관련된 컨텐츠를 선택하여 구매하실 수 있습니다.
               <br>
               나나랜드에는 당신이 원하는 취미를 즐기기 위한 재료들이 준비되어 있거든요.               
               </a>
            </div>
            <div class = test3 style="text-align: center;">
               <hr>
               <a>
               고르신 취미를 즐겨주시면 됩니다!<br>
               평소에 즐기시지 못했던 것들을 마음껏 즐기세요!
               </a>
            </div>
         </div>
         
            <div class = "Introduce-area2-img5">            
            </div>         
            <div style="font-size: 22px; font-weight: bolder; text-align: center; margin: 50px 0">
            나나랜드의 모든 제품은 어르신들의 손길을 거쳐 여러분에게 전달됩니다.
            </div>
            <a style="display: block; text-align: center; margin: 50px 0">
            나나랜드는 도움이 필요한 어르신에게 안정적인 일자리를 드리고자하는 사회적인 목표를 가지고 있습니다.
            <br>
            저희 나나랜드는 앞으로도 여러분들의 취미를 통해 사회적인 미션을 실현해 나갈 수 있도록 노력하겠습니다.
            </a>
      <div class = bottom-area style="background: #f8f8fa" >
            <div class = "Introduce-area2-img6">
               
            </div>
         <!-- *******************map******************** -->
   <div class="map_wrap">
   <div class="map_wrap-cont1"><br><br>본사 위치
   </div>
   <div id="map"
      style="margin:auto; width: 400px; height: 250px; 
      position: relative; overflow: hidden;"></div>
   <div class="map_wrap-cont1">
      역삼역 3번출구에서 200m 직진후 좌회전 오른쪽 건물
   </div>   

   
   
   <!-- 지도타입 컨트롤 div 입니다 -->
<!--       <div class="custom_typecontrol radius_border">
      <span id="btnRoadmap" class="selected_btn"
         onclick="setMapType('roadmap')">지도</span> 
         <span id="btnSkyview"
         class="btn" onclick="setMapType('skyview')">
          스카이뷰</span>
      </div> -->
      
      <!-- 지도 확대, 축소 컨트롤 div 입니다 -->
<!--       <div class="custom_zoomcontrol radius_border">
         <span onclick="zoomIn()"><img
            src="http://i1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_plus.png"
            alt="확대"></span> <span onclick="zoomOut()"><img
            src="http://i1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_minus.png"
            alt="축소"></span>
      </div> -->
      
<!--       <div id="menu_wrap" class="bg_white">
         <div class="option">
            <form onsubmit="searchPlaces(); return false">
               <span>지역명:</span> <input type="text" value=" ex) 서울" id="keyword"
                  size="15" />
               <button type="submit">검색하기</button>
            </form>
         </div>
         <hr />
         <ul id="placesList"></ul>
         <div id="pagination"></div>
         
         
         
      </div> -->
      
   
   </div>
   <script src="js/map.js"></script>
   
         <!-- *******************map******************** -->
         
      </div>   
      </div>
   </div>


</body>
</html>