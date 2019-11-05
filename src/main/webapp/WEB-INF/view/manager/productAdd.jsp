<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="css/manager/product.css" type="text/css" rel="stylesheet" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="js/product.js"></script>
<title>Insert title here</title>
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
         <div id="menu" style="font-family: 나눔바른펜"><button id = "backPro" onclick="history.back()">back</button>새로운 상품 추가</div>
         <hr />
         
         <!-- <form action="#" id = "frm"> -->
            <div id = "infoBox">
               <div class = "inputNewInfo">카테고리
                  <select name="inputcate" id = "combo">
                      <option value="">DISC 유형</option>
                      <option name = "shopInfo_code" value="주도형">주도형(Dominance)</option>
                      <option name = "shopInfo_code" value="사교형">사교형(Influence)</option>
                      <option name = "shopInfo_code" value="안정형">안정형(Steadiness)</option>
                      <option name = "shopInfo_code" value="신중형">신중형(Conscientiousness)</option>
                  </select>
               </div>
               <div class = "inputNewInfo">상품명<input name = "shopInfo_name" id = "newName" type="text" style="margin-left : 6%; width: 60%; height: 90%; border: none; border : 1px solid #f0f0f5; border-radius: 6px;" placeholder="상품명을 입력하세요."/></div>
               <div class = "inputNewInfo">가격<input name = "shopInfo_price" id = "newPrice" type="text" style="margin-left : 7.5%; width: 20%; height: 90%; border: none; border : 1px solid #f0f0f5; border-radius: 6px;" placeholder="상품 가격"/>&nbsp;&nbsp;원</div>
               <div class = "inputNewInfo">재고<input name = "shopInfo_starcnt" id = "newStock" type="text" style="margin-left : 7.5%; width: 20%; height: 90%; border: none; border : 1px solid #f0f0f5; border-radius: 6px;" placeholder="상품의 현재 재고"/>&nbsp;&nbsp;개</div>
               <div class = "inputNewInfo">이미지
                  <input name = "shopInfo_imgpath" id = "newPath" type="text" style="margin-left : 6%; width: 60%; height: 90%; border: none; border : 1px solid #f0f0f5; border-radius: 6px; padding-left: 1%; color : #ccc; overflow: auto;" value="/nanaland/"/>
                  <div class = "fileDrop" ></div>
               </div>
               
            </div>
            
            <div><button id = "addNewPro"> + Add </button></div>
         <!-- </form> -->

      </div>
      
   </div>

</body>
</html>