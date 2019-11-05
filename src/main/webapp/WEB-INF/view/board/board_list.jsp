<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="java.util.Date" %>
<%@page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>NANA 게시판</title>
<link href="css/board/board_list.css" type="text/css" rel="stylesheet" />
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="js/board_list.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.11/handlebars.js"></script>
<script type="text/javascript">
var str = "";
   $(document).ready(function() {
      /* 카테고리 */
      $('#whole').on('click', whole);
      $('#delivery').on('click', Run);
      $('#order').on('click', Run);
      
      $('#cancle').on('click', Run);
      $('#other').on('click', Run);
      
      /* Q&A 이동*/
      $('#qna').on('click', function(){
         location.href='list.do?&currentPage = ${pv.currentPage}';
      });
      /* 공지사항 이동*/
      $('#notice').on('click', function(){
         location.href='notice.do?&currentPage = ${pv.currentPage}';
      });
      
      /* 검색 버튼 클릭 */
      $('#btn').click(function() {
        /* 검색 내용이 없는 경우 return */
        if($('#data').val() == ''){
           alert('검색할 내용을 입력하세요.');
           return location.href='list.do?&currentPage = ${pv.currentPage}';
        }
         location.href='board_search.do?&board_writer=' + $('#data').val() + '&board_title=' + $('#data').val() + '&currentPage = ${pv.currentPage}';
      });
   });//end ready()////////////////////////////////////////////////////
   
   /* 카테고리 클릭 시 발생하는 함수 */   
   function Run(){
      str = $(this).val();
      location.href='categoryList.do?board_type=' + str + '&currentPage = ${pv.currentPage}';
      $('#data').val('');
      $('#data').focus();
   }//end Run()/////////////////////////////////////////////////
   
   /* 카데고리 == 전체 클릭시 발생*/
   function whole(){
      str = $(this).val();
      location.href='list.do?&currentPage = ${pv.currentPage}';
   }//end Run()/////////////////////////////////////////////////
</script>
</head>
<body>
<%
//nana홈페이지 로그인
Object mem_id = session.getAttribute("mem_id");
//카카오 로그인시 정보 가져옴
Object kemail = session.getAttribute("kemail");
//네이버 로그인시 정보 가져옴
Object nname = session.getAttribute("nname");
%>
   <!-- 게시판 안내문 -->
   <div id="intro"><img src = "./images/board_intro.png" width="450px" height="180px"/></div>

   <!-- 검색 영역 -->
   <div id ="search">
      <span class="qna">
         <input type="button" name="qna" id="qna" value="나나랜드 질문" /> 
      </span>
      
      <span class="notice">
         <input type="button" name="notice" id="notice" value="공지사항"/>
      </span>
      
      <span class = "search">
         <input type="text" name="data" id="data" placeholder="궁금한 내용을 검색해보세요." /> 
         <input type="submit" value="검색" id="btn" />
      </span>
   </div>
   
   <!-- 게시글 선택 영역 -->
   <div id = "selectMenu">
      <span class="qna">
         <input type="button" name="whole" id="whole" value="전체" />
      </span>
      <span class="notice">
         <input type="button" name="delivery" id="delivery" value="배송"/> 
      </span>
      <span class="notice">
         <input type="button" name="order" id="order" value="주문/결제"/>
      </span>
      <span class="notice">
         <input type="button" name="cancle" id="cancle" value="취소/교환"/>
      </span>
      <span class="notice">
         <input type="button" name="other" id="other" value="기타"/>
      </span>
      
      <c:set var="mem_id" value="${sessionScope.mem_id}" />
     <c:set var="nanaland" value="nanaland" />
     <%    
            if(mem_id != null || kemail != null || nname != null){
      %>
      <form id="frm" name="frm" method="get" action="write.do">
         <input type="submit" id="btnWrite" value="문의 작성하기" />
      </form>
      <%
            }
      %>
   </div>
   <hr/>
   
   

<div id="bodywrap">
   <!-- 리스트 출력 -->
   <table id = "wrap">
      <tr>
         <th width="150px">날짜</th>
         <th width="150px">카테고리</th>
         <th width="400px">제목</th>
         <th width="150px">작성자</th>
         <th width="150px">조회수</th>
      </tr>

      <c:forEach var="dto" items="${aList}">
         <tr class="board_list">
            <td><fmt:formatDate value="${dto.board_regdate}" pattern="yyyy.MM.dd" /></td>
            <td>${dto.board_type}</td>
            <td>
            <c:url var="path" value="view.do">
               <c:param name="currentPage" value="${pv.currentPage}" />
               <c:param name="num" value="${dto.board_num}" />
            </c:url> 
            <c:if test="${dto.board_re_level!=0}">
               <img src="images/level.gif" width="${20*dto.board_re_level}" height="15" />
               <img src="images/board_answer.png" width="15px" height="15px" id = "board_answer"/>
            </c:if>
               <a href="${path}">${dto.board_title}</a>
            <c:if test="${today == dto.board_regdate}">
               <img src="images/board_answer.png" width="15px" height="15px"/>
            </c:if> 
            </td>
            <td>${dto.board_writer}</td>
            <td>${dto.board_count}</td>
         </tr>
      </c:forEach>

   </table>
   <!-- 페이지 번호 영역-->
   <div class="pagelist">
      <!-- 현재 페이지 구분 비교 값 설정 -->
      <c:set var="avg" value="${param.board_type}" />
      <c:set var="a" value="배송" />
      <c:set var="b" value="주문/결제" />
      <c:set var="c" value="취소/교환" />
      <c:set var="d" value="기타" />
            
      <!-- 이전 --><!-- 이전 --><!-- 이전 --><!-- 이전 --><!-- 이전 --><!-- 이전 --><!-- 이전 -->
      <!-- 이전 --><!-- 이전 --><!-- 이전 --><!-- 이전 --><!-- 이전 --><!-- 이전 --><!-- 이전 -->
      <!-- 이전 --><!-- 이전 --><!-- 이전 --><!-- 이전 --><!-- 이전 --><!-- 이전 --><!-- 이전 -->
      <c:if test="${pv.startPage > 1}">
         <c:choose>
            <c:when test="${avg == a}">
               <a href="categoryList.do?currentPage=${pv.startPage - pv.blockPage}&board_type=${a}">이전</a>
            </c:when>
            
            <c:when test="${avg == b}">
               <a href="categoryList.do?currentPage=${pv.startPage - pv.blockPage}&board_type=${b}">이전</a>
            </c:when>
            
            <c:when test="${avg == c}">
               <a href="categoryList.do?currentPage=${pv.startPage - pv.blockPage}&board_type=${c}">이전</a>
            </c:when>
            
            <c:when test="${avg == d}">
               <a href="categoryList.do?currentPage=${pv.startPage - pv.blockPage}&board_type=${d}">이전</a>
            </c:when>
            
            <c:when test="${board_title == board_title && board_writer == board_writer}">
               <a href="board_search.do?currentPage=${pv.startPage - pv.blockPage}&board_title=${board_title}&board_writer=${board_writer}">이전</a>
            </c:when>
            
            <c:otherwise>
               <a href="list.do?currentPage=${pv.startPage - pv.blockPage}">이전</a>
            </c:otherwise>
         </c:choose>
      </c:if>
      
      
      <!-- 페이지 번호 --><!-- 페이지 번호 --><!-- 페이지 번호 --><!-- 페이지 번호 --><!-- 페이지 번호 -->
      <!-- 페이지 번호 --><!-- 페이지 번호 --><!-- 페이지 번호 --><!-- 페이지 번호 --><!-- 페이지 번호 -->
      <!-- 페이지 번호 --><!-- 페이지 번호 --><!-- 페이지 번호 --><!-- 페이지 번호 --><!-- 페이지 번호 -->
      <c:forEach var="i" begin="${pv.startPage}" end="${pv.endPage}">
            <span>
            
            <!-- 카테고리별 페이지 번호 url 설정 --> 
            <c:url var="currPage" value="list.do">
               <c:param name="currentPage" value="${i}" />
            </c:url>
            <c:url var="delivery" value="categoryList.do">
               <c:param name="currentPage" value="${i}" />
               <c:param name="board_type" value="배송" />
            </c:url>  
            <c:url var="order" value="categoryList.do">
               <c:param name="currentPage" value="${i}" />
               <c:param name="board_type" value="주문/결제" />
            </c:url>
            <c:url var="cancle" value="categoryList.do">
               <c:param name="currentPage" value="${i}" />
               <c:param name="board_type" value="취소/교환" />
            </c:url>
            <c:url var="other" value="categoryList.do">
               <c:param name="currentPage" value="${i}" />
               <c:param name="board_type" value="기타" />
            </c:url>
            
            <!-- 검색 url -->
            <c:url var="board_url" value="board_search.do">
               <c:param name="currentPage" value="${i}" />
               <c:param name="board_title" value="${param.board_title}" />
               <c:param name="board_writer" value="${param.board_writer}" />
            </c:url>
            
            <!-- 현재 페이지 구분 비교 값 설정 -->
            <c:set var="avg" value="${param.board_type}" />
            <c:set var="a" value="배송" />
            <c:set var="b" value="주문/결제" />
            <c:set var="c" value="취소/교환" />
            <c:set var="d" value="기타" />
            
            <c:set var="board_title" value="${param.board_title}" />
            <c:set var="board_writer" value="${param.board_writer}" />
            
            <!-- 바깥 choose -->
            <c:choose>
               <c:when test="${avg == a}">
                  <c:choose>
                     <c:when test="${i==pv.currentPage}"> 
                        <a href="${delivery}" class="pagecolor"> <c:out value="${i}" /></a>
                     </c:when>
                     <c:otherwise>
                        <a href="${delivery}"> <c:out value="${i}" /></a>
                     </c:otherwise>
                  </c:choose>
               </c:when>
               
               <c:when test="${avg == b}">
                  <c:choose>
                     <c:when test="${i==pv.currentPage}"> 
                        <a href="${order}" class="pagecolor"> <c:out value="${i}" /></a>
                     </c:when>
                     <c:otherwise>
                        <a href="${order}"> <c:out value="${i}" /></a>
                     </c:otherwise>
                  </c:choose>
               </c:when>
               
               <c:when test="${avg == c}">
                  <c:choose>
                     <c:when test="${i==pv.currentPage}"> 
                        <a href="${cancle}" class="pagecolor"> <c:out value="${i}" /></a>
                     </c:when>
                     <c:otherwise>
                        <a href="${cancle}"> <c:out value="${i}" /></a>
                     </c:otherwise>
                  </c:choose>
               </c:when>
               
               <c:when test="${avg == d}">
                  <c:choose>
                     <c:when test="${i==pv.currentPage}"> 
                        <a href="${other}" class="pagecolor"> <c:out value="${i}" /></a>
                     </c:when>
                     <c:otherwise>
                        <a href="${other}"> <c:out value="${i}" /></a>
                     </c:otherwise>
                  </c:choose>
               </c:when>
               
               <c:when test="${board_title == board_title && board_writer == board_writer}">
                  <c:choose>
                     <c:when test="${i==pv.currentPage}"> 
                        <a href="${board_url}" class="pagecolor"> <c:out value="${i}" /></a>
                     </c:when>
                     <c:otherwise>
                        <a href="${board_url}"> <c:out value="${i}" /></a>
                     </c:otherwise>
                  </c:choose>
               </c:when>
               
               <c:otherwise>
                  <c:choose>
                     <c:when test="${i==pv.currentPage}"> 
                        <a href="${currPage}" class="pagecolor"> <c:out value="${i}" /></a>
                     </c:when>
                     <c:otherwise>
                        <a href="${currPage}"> <c:out value="${i}" /></a>
                     </c:otherwise>
                  </c:choose>
               </c:otherwise>
            </c:choose>
            <!-- 바깥 choose -->   
            </span>
         </c:forEach>



      <!-- 다음 --><!-- 다음 --><!-- 다음 --><!-- 다음 --><!-- 다음 --><!-- 다음 --><!-- 다음 -->
      <!-- 다음 --><!-- 다음 --><!-- 다음 --><!-- 다음 --><!-- 다음 --><!-- 다음 --><!-- 다음 -->
      <!-- 다음 --><!-- 다음 --><!-- 다음 --><!-- 다음 --><!-- 다음 --><!-- 다음 --><!-- 다음 -->
      
      
      <c:if test="${pv.endPage < pv.totalPage}">
         <c:choose>
            <c:when test="${avg == a}">
               <a href="categoryList.do?currentPage=${pv.startPage + pv.blockPage}&board_type=${a}">다음</a>
            </c:when>
            
            <c:when test="${avg == b}">
               <a href="categoryList.do?currentPage=${pv.startPage + pv.blockPage}&board_type=${b}">다음</a>
            </c:when>
            
            <c:when test="${avg == c}">
               <a href="categoryList.do?currentPage=${pv.startPage + pv.blockPage}&board_type=${c}">다음</a>
            </c:when>
            
            <c:when test="${avg == d}">
               <a href="categoryList.do?currentPage=${pv.startPage + pv.blockPage}&board_type=${d}">다음</a>
            </c:when>
            
            <c:when test="${board_title == board_title && board_writer == board_writer}">
               <a href="board_search.do?currentPage=${pv.startPage + pv.blockPage}&board_title=${board_title}&board_writer=${board_writer}">다음</a>
            </c:when>
            
            <c:otherwise>
               <a href="list.do?currentPage=${pv.startPage + pv.blockPage}">다음</a>
            </c:otherwise>
         </c:choose>
         
      </c:if>
   </div>
</div>
</body>
</html>





