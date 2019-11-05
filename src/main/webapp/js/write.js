$(document).ready(function(){
	  $('#btnList').bind('click',function(){
		  $('#frm').attr('action','list.do');		
		  $('#frm').submit();
		  // $('#frm').attr('action','list.do').submit();
	  });
	  
	  $('#btnSave').bind('click',function(){
		  
		  if ($('#board_title').val() == '') {
				alert('제목을 입력하세요.');
				return false;
		  }else if ($('#board_content').val() == '') {
			  	alert('내용을 입력하세요.');
				return false;
		  }
		  
		  $('[name=board_content]').val($('[name=board_content]').val().replace(/\n/gi, '<br/>'));
		  $('#frm').attr('action','write.do').submit();
		  
		  alert('게시글 작성이 완료되었습니다.');
	  });
	  
	  //첨부파일 용량체크
	  $('#filepath').on('change',function(){						 
			 if(this.files && this.files[0]){				 
				if(this.files[0].size>1000000000){
					alert("1GB바이트 이하만 첨부할 수 있습니다.");				
					$('#filepath').val('');				
					return false;
				}				
			 }
		 });
  });