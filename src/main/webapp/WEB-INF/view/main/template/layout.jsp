<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix = "tiles" uri = "http://tiles.apache.org/tags-tiles" %>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>NANA LAND - 취미를 만나 일상이 아름다워지다.</title>
<link rel="shortcut icon" href="http://localhost:8090/myfinal/images/faviconImg.png">

<style>
* {
   margin: 0px;
}

header {
   width: 100%;
   /* position: fixed; */
}

section {
   width: 100%;
   /* height: 1500px; */
   display: block;
   padding-top:161px;
}

footer {
   background-color: #1f1f2e;
   width : 100%;
   clear: both;
}

chat{
   width : 100%;
   height: 200px;
}
</style>

</head>
<body>

   <header style="z-index : 200; position: fixed;">
      <p>
         <!-- tiles.xml에서 put-attribute의 name이 header인 태그의 value를 넣어줌 -->
         <!-- jsp를 넣어줄 때는 : insertAttribut -->
         <tiles:insertAttribute name = "header"/>
      </p>
   </header>
   
   <section>
      <p>
         <tiles:insertAttribute name = "body"/>
      </p>
   </section>
   
   <footer>
      <p>
         <tiles:insertAttribute name = "footer"/>
      </p>
   </footer>
   
   <chat>
      <p>
         <tiles:insertAttribute name = "chat"/>
      </p>
   </chat>

</body>
</html>