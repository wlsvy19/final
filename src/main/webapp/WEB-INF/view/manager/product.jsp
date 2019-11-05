<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
         <div id="menu" style="font-family: 나눔바른펜">상품 관리</div>
         <hr />
         
         <!-- 새로운 상품 등록버튼 -->
         <!-- 새로운 상품 등록버튼 -->
         <!-- 새로운 상품 등록버튼 -->
         <div>
            <div id = "setTitle"><img id = "setImg" src="./images/set_point.png"><span style="font-family: 나눔바른펜; font-size: 20px;">판매 상품 현황</span></div>
            <button id = "addPro" OnClick="location.href ='clickAddProduct.do'"> + add product </button>
         </div>
         
         <!-- 상품리스트, 판매 중지, 상품삭제 -->
         <!-- 상품리스트, 판매 중지, 상품삭제 -->
         <!-- 상품리스트, 판매 중지, 상품삭제 -->
         <div id = "product_div">
            <table id = "product_table">
               <thead>
                  <tr>
                     <td width="10%">상품 번호</td>
                     <td width="35%">상품명</td>
                     <!-- <td width="11%">카테고리</td> -->
                     <td width="11%">가격</td>
                     <td width="11%">별점 평균</td>
                     <td width="11%">판매 중지</td>
                     <td width="11%">재판매</td>
                     <td width="11%">상품 삭제</td>
                  </tr>
               </thead>
               <tbody>
               <c:forEach items="${sList }" var="sdto">
               <c:set value="${sdto.shopInfo_chk }" var="infoChk"/>
               <!-- 판매중지일때 -->
               <c:if test="${sdto.shopInfo_chk == 0}">
                  <tr id = "${sdto.shopInfo_chk }" class = "stop_tr">
                     <td width="10%">${sdto.shopInfo_num }</td>
                     <td width="35%">${sdto.shopInfo_name }</td>
                     <%-- <td width="11%">${sdto.shopInfo_code }</td> --%>
                     <td width="11%">${sdto.shopInfo_price }</td>
                     <td width="11%">${sdto.shopInfo_starcnt }</td>
                     <td width="11%"><button id = "${sdto.shopInfo_num }" class = "stopPro">stop</button></td>
                     <td width="11%"><button id = "${sdto.shopInfo_num }" class = "rePro">resale</button></td>
                     <td width="11%"><button id = "${sdto.shopInfo_num }" class = "delPro">delete</button></td>
                  </tr>
               </c:if>
               
               <!-- 판매중일때 -->
               <c:if test="${sdto.shopInfo_chk == 1}">
                  <tr id = "${sdto.shopInfo_chk }" class = "non_stop_tr">
                     <td width="10%">${sdto.shopInfo_num }</td>
                     <td width="35%">${sdto.shopInfo_name }</td>
                     <%-- <td width="11%">${sdto.shopInfo_code }</td> --%>
                     <td width="11%">${sdto.shopInfo_price }</td>
                     <td width="11%">${sdto.shopInfo_starcnt }</td>
                     <td width="11%"><button id = "${sdto.shopInfo_num }" class = "stopPro">stop</button></td>
                     <td width="11%"><button id = "${sdto.shopInfo_num }" class = "rePro">resale</button></td>
                     <td width="11%"><button id = "${sdto.shopInfo_num }" class = "delPro">delete</button></td>
                  </tr>
               </c:if>
               
               </c:forEach>
               </tbody>
            </table>
         </div>
      
      </div>
      
   </div>

</body>
</html>