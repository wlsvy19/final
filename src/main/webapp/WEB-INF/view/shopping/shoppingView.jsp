<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나나랜드쇼핑</title>
<link href="css/shopview.css" type="text/css" rel="stylesheet" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- handlebars.js를 사용하기 위해서  -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.11/handlebars.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script src="js/shopview2.js"></script>
<script type="text/javascript">
$(document).ready(function(){
   var count = $('#count').val();
   var modal = document.getElementById('id01');
   
   // 모달창 닫기
   window.onclick = function(event) {
      if (event.target == modal) {
         modal.style.display = "none";
      }
   }
   
   $('#likebtn').on('click', function(){
      
      /* 조건문 추가: 세션아이디값이 공백이 아닐때(로그인 된 상태에서만 실행) */
      /* 로그인된상태에서만 modal창 띄워주기 */
      
      if($(this).attr('src') == "./images/like_on.png"){
         $(this).attr('src', "./images/like_off.png");
         
         $.ajax({
               type : 'GET',
               dataType : 'text',
               url : 'shoppingLike.do?&like=off&shop_num=${shopInfo.shop_num}',
               success : viewMessage
            });
         
         
      }else if($(this).attr('src') == "./images/like_off.png"){
         $(this).attr('src', "./images/like_on.png");
         
         $.ajax({
               type : 'GET',
               dataType : 'text',
               url : 'shoppingLike.do?&like=on&shop_num=${shopInfo.shop_num}',
               success : viewMessage
            });
      }
      
   });
   
   $('#minus').on('click', function(){
      if($('#count').val() != 1){
         count--;
         $('#count').val(count);
      }
   });   
   
   $('#plus').on('click', function(){
   var st = $('#stock').val() - $('#count').val();
   
   if(st > 0){
      count++;
      $('#count').val(count);
   }else{
      alert('재고가 부족합니다.');
   }
   });
   
   
   $('#putBtn').on('click', function(){
      $.ajax({
            type : 'GET',
            dataType : 'text',
            url : 'shoppingCartPro.do?&shop_num=${shopInfo.shop_num}&cart_buycount='+$('#count').val(),
            success : viewMessage
         });
   });
   
   
   
   $( window ).scroll( function() {
      if ( $( this ).scrollTop() > 500 ) {
         $( '#topBtn' ).fadeIn();
      } else {
         $( '#topBtn' ).fadeOut();
      }
   });
   
   $( '#topBtn' ).click( function() {
      $( 'html, body' ).animate( { scrollTop : 0 }, 400 );
      return false;
   } );
   
   
   $('#disputBtn').on('click', function(){
      alert('NANALAND 회원에게만 제공되는 서비스입니다.');
      location.href = "memberloginform.do";
   });
   
   $('#dislikebtn').on('click', function(){
      alert('NANALAND 회원에게만 제공되는 서비스입니다.');
      location.href = "memberloginform.do";
   });
   
   $('#knputBtn').on('click', function(){
      alert('NANALAND의 회원만 사용 가능한 서비스입니다.');
      return false;
   });
   
   //////////3월19일 이후 추가한것/////////
   $(document).on('click', '.tempImg', showModal01); 
   //ajax 처리 후 생기는 이미지에 대해서도 적용을 시키기 위해서는 동적으로 처리해주어야 한다.
});

function viewMessage(res) {

}// end viewMessage()////////////


//이미지 상세보기 모달창
function showModal01(){
   var imgNamePath = $(this).prop("src");
   $('#modal01').css('display', 'block');
   $('#modal01Img').prop('src', imgNamePath); 
}
</script>
</head>
<body>

    <%
         //nana홈페이지 로그인
         Object mem_id = session.getAttribute("mem_id");
         //카카오 로그인시 정보 가져옴
         Object kemail = session.getAttribute("kemail");
         //네이버 로그인시 정보 가져옴
         Object nemail = session.getAttribute("nemail");
      %>

<div id="shoppingWrap">
   <div id="shoppingInfo">
      <div>
         <div class="infoLeft">
            <div id="productPic">
               <img src="${shopInfo.shop_imgpath}/0.jpg" width="100%" height="100%">
            </div>
         </div>
         <div class="infoRight">
            <div style="margin-top: 15px;">
               <p id="category">취미 쇼핑하기 > ${shopInfo.shop_code}</p>
            </div>
            <div id="title">
               <span style="font-size: medium; border: 1px solid #99bbff; background-color: #99bbff; color : white; padding : 2px;">오늘부터 정기배송 시작</span>
               <p>${shopInfo.shop_name}</p>
               <p><fmt:formatNumber value="${shopInfo.shop_price}" type="number" />원</p>
            </div>
            <div id="delivery">
               <p style="padding-bottom: 5px;">적립 마일리지 최대<fmt:formatNumber value="${point}" type="number" />p</p>
               <p>배송비 무료배송(도서산간지역 포함)</p>
               <p style="color: red;">재고 수량 : ${shopInfo.shop_stock}개</p>
               <input type="hidden" id="stock" value="${shopInfo.shop_stock}">
            </div>
            <div id = "star">
                  <img id = "starImage" src="./images/star_on.png" alt = "star아이콘">
                  <span style="font-size: large; float: left; padding-top: 10px;">총 평점 : <fmt:formatNumber value="${shopInfo.shop_starcnt}" pattern="0.0" /></span>
                  <div id="amount">
                     <span id="countBtn"><button id="minus">-</button><input type="text" id="count" size="1" value="1" style="text-align: center; border-left: none; border-right: none; border-top:2px solid #b3b3b3; border-bottom: 2px solid #b3b3b3;"><button id="plus">+</button></span>
                  </div>
                  <span style="font-size: large; float: right; margin-top: 10px;">수량 &nbsp;&nbsp;</span>
            </div> 
            <div id = "btnBox">
               <% if(mem_id == null && nemail == null && kemail == null){ %>
                  <input type="image" class="likebtnBox" id="dislikebtn" src="./images/like_off.png" width="100%" height="100%" size="100%"/>
               <%}else{ %>
               <c:set var = "likeChk" value = "${likeChk}"/>
               <c:if test="${likeChk == true}">
                  <input type="image" class="likebtnBox" id="likebtn" src="./images/like_on.png" width="100%" height="100%" size="100%"/>
               </c:if>
               <c:if test="${likeChk == false}">
                  <input type="image" class="likebtnBox" id="likebtn" src="./images/like_off.png" width="100%" height="100%" size="100%"/>
               </c:if>
               <%} %>
               <% if(mem_id == null && nemail == null && kemail == null){ %>
                     <c:if test="${shopInfo.shop_stock != 0}">
                        <button class = "putBtnBox" id="disputBtn">취미장바구니에 담기</button>
                     </c:if>
                     <c:if test="${shopInfo.shop_stock == 0}">
                        <button class = "putBtnBox" >일시 품절되었습니다.</button>
                     </c:if>
               <%}else if(mem_id != null){ %>
                <c:if test="${shopInfo.shop_stock != 0}">
               		<button class = "putBtnBox" id="putBtn" onclick="document.getElementById('id01').style.display='block'" class="w3-button w3-black">취미장바구니에 담기</button>
            	</c:if>
            	<c:if test="${shopInfo.shop_stock == 0}">
                    <button class = "putBtnBox" >일시 품절되었습니다.</button>
                </c:if>
            <div id="id01" class="w3-modal">
               <div class="w3-modal-content w3-animate-zoom w3-card-4" style="margin-top: 15%; width: 35%; height: 25%;">
                     <div class="w3-container">
                        <div>
                           <h5 class="modal-title" style="font-weight: bold; color: #4d4d4d;">쇼핑을 계속 하시겠습니까?</h5>
                        </div>
                        <div style="text-align: center; margin-top: 6%;">
                           <span><a href="shoppingCart.do"><button class="w3-button w3-white w3-border w3-border-blue w3-round-xlarge">취미장바구니 바로가기</button></a></span>
                           <span><button type="button" class="w3-button w3-white w3-border w3-border-red w3-round-xlarge" onclick="document.getElementById('id01').style.display='none'" style="margin-left: 10%;">계속 쇼핑하기</button></span>
                        </div>
                     </div>
                </div>
              </div>
               <%}else{ %>
                  <c:if test="${shopInfo.shop_stock != 0}">
                     <button id="knputBtn" class="putBtnBox">취미장바구니에 담기</button>
                  </c:if>
                  <c:if test="${shopInfo.shop_stock == 0}">
                        <button class = "putBtnBox" >일시 품절되었습니다.</button>
                  </c:if>
               <%} %>
            </div>
         </div>
      </div>
      <div style="clear : both; width : 100%; height:200px;"></div>
      <div id="infoDetail" style = "clear : both; padding-top : 100px; border-top: 2px solid #ccc;">
         <c:forEach var="i" begin="1" end="${picCount}" step="1">
            <img src="${shopInfo.shop_imgpath}/${i}.jpg" width="70%" height="100%" style="margin-left:15%;">
         </c:forEach>
      </div>
   </div>

   <!-- 상품번호 확인용 -->
   <input id = "shop_num" type="hidden" value="${shopInfo.shop_num}"/>
   <input id = "p_mem_id" type="hidden" value="${sessionScope.mem_id}"/>
   <input id = "p_condi" type="hidden" value="${purCondition}"/>
   
   <div id="shoppingComment">
      <p style="font-weight: bold; font-size: xx-large; margin-top: 30px; display: inline-block;">상품 후기<br/></p>
      <input type="button" id = "commBtn" value="후기 작성하기 "/>
      <div id = "commentWrite">
         <!-- 댓글 내용 입력할 부분, 숨어있다가 작성하기 버튼을 누르면 나타나고, 작성 완료 버튼을 누르면 다시 숨겨짐 -->
         <!-- <p>댓글 작성</p> -->
         <!-- Sessionscope 영역에 저장된 id값을 가지고 와서 사용함 -->
         <p id = "sreply_writer" style="margin-top: 20px; margin-bottom: 25px; display: inline-block; font-weight: bold;">${sessionScope.mem_id}</p>&nbsp;님 
         <div id = "starWrap">
            <img class = "starCnt" src="./images/star_off.png" alt = "별점 off 이미지" name = "1">
            <img class = "starCnt" src="./images/star_off.png" alt = "별점 off 이미지" name = "2">
            <img class = "starCnt" src="./images/star_off.png" alt = "별점 off 이미지" name = "3">
            <img class = "starCnt" src="./images/star_off.png" alt = "별점 off 이미지" name = "4">
            <img class = "starCnt" src="./images/star_off.png" alt = "별점 off 이미지" name = "5">
         </div>
         <!-- 선택한 별점이 저장될 곳, hidden으로 숨겨서 사용 -->
         <input id = "sreply_star" type="hidden" value = ""/>
         <!-- 클릭을 통해 첨부파일 선택할 수 있는 곳 -->
         <div style="margin-bottom: 10px;">
            <span id = "userpc">내 PC에서 가지고 오기</span>
         </div>
         <!-- 첨부파일 드래그하는 곳 -->
         <div class = "fileDrop">
            <!-- <p id = "fileDropText" style="color : #ccc; font-size: small; display: block;">첨부파일을 넣어주세요</p> -->
         </div>
         <!-- <textarea rows="13" cols="200" placeholder="나나랜드 취미  상품을 사용한 후기를 남겨주세요"></textarea> -->
         <textarea id = "sreply_content" rows="13" placeholder="나나랜드 취미  상품을 사용한 후기를 남겨주세요" style="width: 93.25%;"></textarea>
         <input type="button" id = "commWriteBtn" value="작성완료 "/>
      </div>
      
      <!-- 총댓글의 개수가 보이는 곳 -->
      <%-- <div style="font-weight: bold; margin-bottom: 0;">상품 후기 수 : <span id = "replyListCnt" style="font-weight: bold; color : #ff3333;">&nbsp;${fn:length(shopInfo.replyList) }</span> 개</div> --%>
      <div id = "commentMain">
         <div id = "comm_sub">
            <!-- 댓글 내용 출력할 부분 -->
            <c:set value="${shopInfo.replyList[0].sreply_star != 0}" var="replyTrue"/>
            <c:choose>
               <c:when test="${replyTrue == 'true'}">
                  <c:forEach items="${shopInfo.replyList }" var = "replyDTO">
                     <div class = "comm_list">
                        <!-- 별점, 내용, 사진 -->
                        <div class = "comm_left">
                           <div class = "comm_star"><img class = "commStarCntImg" src="./images/starCnt_${replyDTO.sreply_star}.png" alt = "별점 on 이미지"></div>
                           <p class = "comm_content">${replyDTO.sreply_content }</p>
                           <c:if test="${replyDTO.mFileList != null}">
                              <c:forEach items="${replyDTO.mFileList }" var = "fileDTO">
                                 <img class = "tempImg" src="/temp/${fileDTO.shop_file}"/>
                              </c:forEach>
                           </c:if>
                        </div>
                        
                        <!-- 작성자, 작성일, 신고버튼, 수정&삭제버튼 -->
                        <div class = "comm_right">
                           <p id = "commSreply_writer${replyDTO.sreply_num }" style="font-weight: bold;">${replyDTO.sreply_writer}</p>
                              <!-- 날짜 형식 지정 fmt:formatDate -->
                           <p><fmt:formatDate value="${replyDTO.sreply_regdate }" pattern="yyyy/MM/dd" /></p>
                           <p>
                                <c:if test="${replyDTO.sreply_writer == sessionScope.mem_id}">
                              <button id = "${replyDTO.sreply_num }" class = "commUpDelBtn">delete</button>
                              <button id = "${replyDTO.sreply_num }" class = "commUpDelBtn">update</button>
                              </c:if>
                           </p>
                        </div>
                     </div>
                  </c:forEach>
               </c:when>
               
               <c:otherwise>
                  <p style="color: #ccc; text-align : center; margin-top: 100px;">아직 입력된 상품 후기가 없습니다.</p>
               </c:otherwise>
            </c:choose>
            
         </div>
      </div>
   </div>
   
   
   <!-- Modal -->
   <!-- 첨부 사진 상세보기 -->
   <div id="modal01" class="w3-modal" onclick="this.style.display='none'">
      <span class="w3-button w3-hover-red w3-xlarge w3-display-topright">&times;</span>
      <img id = "modal01Img" src=" " style="width:50%; height: 50%; size: 100%; margin-top: 15%; margin-left: 25%;">
   </div>

   <!-- 수정하는 영역 -->
   <div id="modifyModal">
      <div id = "modiFileAdd" style="margin-top : 1.5%;"><span id = "userpc2">사진 추가</span></div>
      <div id = "modifyImgBox" style="margin: auto; margin-top: 5%;">
      </div>
      <div id = "starWrap2">
         <img class = "starCnt2" src="./images/star_off.png" alt = "별점 off 이미지" name = "1">
         <img class = "starCnt2" src="./images/star_off.png" alt = "별점 off 이미지" name = "2">
         <img class = "starCnt2" src="./images/star_off.png" alt = "별점 off 이미지" name = "3">
         <img class = "starCnt2" src="./images/star_off.png" alt = "별점 off 이미지" name = "4">
         <img class = "starCnt2" src="./images/star_off.png" alt = "별점 off 이미지" name = "5">
      </div>
      <input id = "sreply_star2" type="hidden" value = ""/>      
      <p> 
         <input class="form-control" type="text" placeholder="REPLY TEXT" id="updateReplyText">
      </p>
      <p>             
         <button id="btnModify">Modify</button>
         <button id="btnClose">Close</button>
      </p>
   </div>   
      
   <div id = "shoppingPolicy">
      <div style="border-bottom: 1px solid #ccc;">
         <p style="font-weight: bold; font-size: xx-large; margin-top: 30px;">배송 정책<br/></p>
         <br/>
         * 전국 모든 지역에 배송이 가능합니다.<br/>
         * 택배사는 KH대한통운 입니다.<br/>
         * 기본 배송비는 무료입니다.<br/>
         * 도서산간지역의 경우 추가 배송비 결제 요청이 있을 수 있습니다.<br/>
         * 배송기간은 정해진 배송시작일로부터 1~5일이 소요됩니다.<br/>
         <br/>
      </div>
      <div style="border-bottom: 1px solid #ccc;">
         <p style="font-weight: bold; font-size: xx-large; margin-top: 30px;">교환 정책<br/></p>
         <br/>
         * 상품 수령일로부터 7일 이내 교환 신청 가능하며, 7일이 지나면 불가능합니다.<br/>
         * 단순 변심 교환의 경우 왕복배송비를 지불하셔야하며, 제품 및 포장이 재판매 가능한 상태여야 합니다.(포장 훼손 시 교환 불가)<br/>
         * 상품 불량 등 회사의 귀책 사유로 인한 교환의 경우는 배송비를 지불하지 않으셔도 됩니다.<br/>
         * 담당자 확인 후 아래 주소지로 상품을 보내주시면, 상품 회수 후 교환 상품을 발송해드립니다.<br/>
         * [교환 주소지] : (06234) 서울특별시 강남구 강남구 테헤란로14길 6 나나랜드<br/>
         <br/>
      </div>
      <div>
         <p style="font-weight: bold; font-size: xx-large; margin-top: 30px;">환불 정책<br/></p>
         <br/>
         * 상품 수령일로부터 7일 이내 반품 신청 가능하며, 7일이 지나면 불가능합니다.<br/>
         * 단순 변심 반품의 경우 왕복배송비를 차감한 금액이 환불되며, 제품 및 포장이 재판매 가능한 상태여야 합니다.(포장 훼손 시 반품 불가)<br/>
         * 상품 불량 등 회사의 귀책 사유로 인한 반품의 경우는 배송비를 포함한 전액이 환불됩니다.<br/>
         * 담당자 확인 후 아래 주소지로 상품을 보내주시면, 상품 회수 후 환불 진행됩니다.<br/>
         * [반품 주소지] : (06234) 서울특별시 강남구 강남구 테헤란로14길 6 나나랜드<br/>
         <br/>
      </div>
   </div>
   
   
   <div>
      <a id="topScroll" href="#"><img id="topBtn" src="./images/topBtn.png" title="위로 가기"></a>
   </div>
   
</div>
</body>
</html>