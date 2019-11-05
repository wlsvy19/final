<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri = "http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<style type="text/css">
#wrap{
   width: 85%;
   margin-left : 7.5%;
   /* background-color: yellow; */
}

table{
      border-collapse: collapse;
    text-align: left;
    line-height: 2.4;
    margin : auto;
}

table thead th{
      padding: 12px;
    font-weight: bold;
    vertical-align: top;
    color: white;
    border-bottom: 3px solid black;
    background : #323232;
    text-align: center;
}

table tbody tr{
      width: 350px;
    padding: 20px;
    vertical-align: top;
    border-bottom: 1px solid #ccc;
    text-align: left;
}

#discEndBtn{
   width: 250px;
   height: 60px;
   background:#ff3333;
     color:#fff;
     border:none;
     outline:none;
   font-size: medium;
   margin-left: 40%;
   margin-top : 5%;
   margin-bottom : 7%;
   cursor: pointer;
   border-radius: 5px;
}

.discTestImg{
   width: 35%;
   height: 50%;
   size: 100%;
   margin-top : 5%;
   margin-bottom: 5%;
   margin-left : 32.5%;
}
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="js/disctest.js"></script>

</head>
<body>

   <div id = "wrap">
      <img class = "discTestImg" src="./images/disc_test.png" alt = "disc 테스트이미지">

      <table>
         <thead>
            <tr>
               <th width="5%">번호</th>
               <th width="20%">A항목</th>
               <th width="20%">B항목</th>
               <th width="20%">C항목</th>
               <th width="20%">D항목</th>
            </tr>
         </thead>
         <tbody>
         <c:forEach var = "dto" items="${discList }">
         
            <tr>
               <td>&nbsp;&nbsp;&nbsp;&nbsp;${dto.disc_num }</td>
               <c:set var = "subIndex_1" value = "${fn:indexOf(dto.disc_one, ',')+1 }"/>
               <c:set var = "strleng_1" value = "${fn:length(dto.disc_one) }"/>
               <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type = "radio" name = "chk${dto.disc_num }" value = "${fn:substring(dto.disc_one, subIndex_1, strleng_1)}" id = "chkla${dto.disc_num }_1"><label for = "chkla${dto.disc_num }_1">${fn:substring(dto.disc_one, 0, subIndex_1-1)}</label></td>
               
               <c:set var = "subIndex_2" value = "${fn:indexOf(dto.disc_two, ',')+1 }"/>
               <c:set var = "strleng_2" value = "${fn:length(dto.disc_two) }"/>
               <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type = radio name = "chk${dto.disc_num }" value = "${fn:substring(dto.disc_two, subIndex_2, strleng_2)}" id = "chkla${dto.disc_num }_2"><label for = "chkla${dto.disc_num }_2">${fn:substring(dto.disc_two, 0, subIndex_2-1)}</label></td>
               
               <c:set var = "subIndex_3" value = "${fn:indexOf(dto.disc_three, ',')+1 }"/>
               <c:set var = "strleng_3" value = "${fn:length(dto.disc_three) }"/>
               <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type = "radio" name = "chk${dto.disc_num }" value = "${fn:substring(dto.disc_three, subIndex_3, strleng_3)}" id = "chkla${dto.disc_num }_3"><label for = "chkla${dto.disc_num }_3">${fn:substring(dto.disc_three, 0, subIndex_3-1)}</label></td>
               
               <c:set var = "subIndex_4" value = "${fn:indexOf(dto.disc_four, ',')+1 }"/>
               <c:set var = "strleng_4" value = "${fn:length(dto.disc_four) }"/>
               <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type = "radio" name = "chk${dto.disc_num }" value = "${fn:substring(dto.disc_four, subIndex_4, strleng_4)}" id = "chkla${dto.disc_num }_4"><label for = "chkla${dto.disc_num }_4">${fn:substring(dto.disc_four, 0, subIndex_4-1)}</label></td>
               
            </tr>
         </c:forEach>
         </tbody>
      </table>
      
      <input type = "button" id = "discEndBtn" value = "취미 결과보기" />
   </div>
   
</body>
</html>