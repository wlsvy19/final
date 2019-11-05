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
