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
<link href="css/board/notice_list.css" type="text/css" rel="stylesheet" />
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.11/handlebars.js"></script>
<script type="text/javascript">

var str = "";
	$(document).ready(function() {
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
				return location.href='notice.do?&currentPage = ${pv.currentPage}';
			}
			location.href='notice_search.do?&notice_writer=' + $('#data').val() + '&notice_title=' + $('#data').val() + '&currentPage = ${pv.currentPage}';
		});
	});//end ready()////////////////////////////////////////////////////
</script>
</head>
<body>
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
			<input type="text" name="data" id="data" placeholder="궁금한 내용을 검색해보세요."/> 
			<input type="submit" value="검색" id="btn" />
		</span>
	</div>
	
	<!-- 공지 작성하기 영역 -->
	<!-- 공지 작성 권한 ======> 관리자 ( nanaland ) --> 
	<c:set var="mem_id" value="${sessionScope.mem_id}" />
	<c:set var="nanaland" value="nanaland" />
	<c:if test="${mem_id == nanaland}">
	<div id = "selectMenu">	
			<form id="frm" name="frm" method="get" action="notice_write.do">
				<input type="submit" id="btnWrite" value="공지 작성하기" />
			</form>
	</div>
	</c:if>
	<hr/>
	
	

<div id="bodywrap">
	<!-- 리스트 출력 -->
	<table id = "wrap">
		<tr>
			<th width="200px">날짜</th>
			<th width="400px">제목</th>
			<th width="200px">작성자</th>
			<th width="200px">조회수</th>
		</tr>

		<c:forEach var="dto" items="${aList}">
			<tr class="board_list">
				<td><fmt:formatDate value="${dto.notice_regdate}" pattern="yyyy.MM.dd" /></td>
				<td>
				<c:url var="path" value="notice_view.do">
					<c:param name="currentPage" value="${pv.currentPage}" />
					<c:param name="num" value="${dto.notice_num}" />
				</c:url> 
					<a href="${path}">[ ${dto.notice_title} ]</a>
				</td>
				<td>${dto.notice_writer}</td>
				<td>${dto.notice_count}</td>
			</tr>
		</c:forEach>

	</table>
	<!-- 페이지 번호 영역-->
	<div class="pagelist">
	
	<!-- 검색 url -->
	<c:url var="board_url" value="notice_search.do">
		<c:param name="currentPage" value="${i}" />
		<c:param name="notice_title" value="${param.notice_title}" />
		<c:param name="notice_writer" value="${param.notice_writer}" />
	</c:url>
	
	<!-- 현재 페이지 구분 비교 값 설정 -->
	<c:set var="notice_title" value="${param.notice_title}" />
	<c:set var="notice_writer" value="${param.notice_writer}" />
	
		<!-- 이전 --><!-- 이전 --><!-- 이전 -->
		<!-- 이전 --><!-- 이전 --><!-- 이전 -->
		<c:if test="${pv.startPage > 1}">
			<c:choose>
				<c:when test="${notice_title == notice_title && notice_writer == notice_writer}">
					<a href="notice_search.do?currentPage=${pv.startPage - pv.blockPage}&notice_title=${notice_title}&notice_writer=${notice_writer}">이전</a>
				</c:when>
				<c:otherwise>
					<a href="notice.do?currentPage=${pv.startPage - pv.blockPage}">이전</a>
				</c:otherwise>
			</c:choose>
		</c:if>
		

		<!-- 페이지 번호 --><!-- 페이지 번호 -->
		<!-- 페이지 번호 --><!-- 페이지 번호 -->
		<c:forEach var="i" begin="${pv.startPage}" end="${pv.endPage}">
			<span>
				
			<!-- 카테고리별 페이지 번호 url 설정 --> 
			<c:url var="currPage" value="notice.do">
				<c:param name="currentPage" value="${i}" />
			</c:url>
			
			<c:choose>
				<c:when test="${i==pv.currentPage}"> 
					<a href="${currPage}" class="pagecolor"> <c:out value="${i}" /></a>
				</c:when>
				
				<c:otherwise>
					<a href="${currPage}"> <c:out value="${i}" /></a>
				</c:otherwise>
			</c:choose>

			</span>
		</c:forEach>

		<!-- 다음 --><!-- 다음 --><!-- 다음 -->
		<!-- 다음 --><!-- 다음 --><!-- 다음 -->
		<c:if test="${pv.endPage < pv.totalPage}">
			
			<c:choose>
				<c:when test="${notice_title == notice_title && notice_writer == notice_writer}">
					<a href="notice_search.do?currentPage=${pv.startPage + pv.blockPage}&notice_title=${notice_title}&notice_writer=${notice_writer}">이전</a>
				</c:when>
				<c:otherwise>
					<a href="notice.do?currentPage=${pv.startPage + pv.blockPage}">다음</a>
				</c:otherwise>
			</c:choose>
		</c:if>
	</div>
</div>
</body>
</html>







