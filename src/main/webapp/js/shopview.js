//전역변수 선언
var fileList = [];

$(document).ready(function(){
	/*alert("js 연결됨");*/
	//후기 작성창 열고 닫기 버튼
	$('#commBtn').on('click', function(){
		$('#commentWrite').toggle();
	});
	
	
	//후기 작성 완료 버튼
	$('#commWriteBtn').on('click', reply_list);
	
	
	//내PC에서 가져오기 처리
	$('#userpc').on('click', function() {
		/*alert("내PC 클릭");*/
		//첨부파일 창이 뜨도록
		userfile = $('<input type="file" />');
		
		//강제적으로 발생시키기 위해 이벤트 함수를 호출
		userfile.click();
		
		//첨부파일을 선택하면
		userfile.change(function() {						
		   console.log($(userfile[0]).val());
		   //선택한 첨부파일 값 가지고 옴
		   //제일 마지막에 있는 역슬래쉬 인덱스값을 가지고 오고, 그 다음에 있는 값부터 가지고 오고 싶은거니까 +1해줌
		   var partname = $(userfile[0]).val().substring($(userfile[0]).val().lastIndexOf("\\")+1);
		   console.log(partname);
		   
		   var str = '<p><input type="checkbox" />' + partname + '</p>';
		   $('.fileDrop').append(str);		
		   $('.fileDrop').css('border', '2px solid #99bbff');
		   fileList.push(userfile[0].files[0]);
		   
		});
		
	});//내 PC 처리 끝
	
	
	//첨부파일 드래그 시작
	var obj = $('.fileDrop');
	var win=$('body');
	win.on('dragover', function(e) {
		//dragover, dragenter은 되지만 drop이 안되므로 preventDefault() 메소드를 호출한다.
		e.preventDefault();
		obj.css('border', '2px solid #99bbff');
	});
	
	win.on('drop', function(e) {
		e.preventDefault();
		var files = e.originalEvent.dataTransfer.files;
		for(i=0; i<files.length;i++){
			obj.append('<p><input type="checkbox" />' + files[i].name + '</p>');
			fileList.push(files[i]);
		}
		console.log(fileList);
	});//첨부파일 드래그 끝
	
	
	//별점 선택하는 버튼
	$('.starCnt').on('click', function(){
		var clickStar = $(this).prop('name'); //선택한 별점의 점수를 받음
		$('#sreply_star').val(clickStar); //별점의 값을 저장해둘 요소의 value값에 넣어줌
		//선택한별점보다 작은값까지 색상이 변하도록 처리
		$('.starCnt').prop('src', $('.starCnt').prop('src').replace("on.png","off.png")); //이미지 초기화
		for(var i = 1; i <= clickStar; i++){
			$('.starCnt[name="'+i+'"]').prop('src', $('.starCnt[name="'+i+'"]').prop('src').replace("off.png","on.png"));
		}
		
	});
});


//후기작성 완료 버튼을 눌렀을떄 실행될 메소드
function reply_list(){
	//예외처리
	if($("#sreply_content").val() == '')
		alert("내용을 입력해주세요.");
	if($('#sreply_star').val() == '')
		alert("별점을 선택해주세요.");
	
	
	//첨부파일 처리 과정
	//var form_data = new FormData(); //form_data라는 객체 생성
	
	var form_data = new FormData();
	
	form_data.append('shop_num', $("#shop_num").val());
	form_data.append('sreply_writer', $("#sreply_writer").text());
	form_data.append('sreply_content', $("#sreply_content").val());
	form_data.append('sreply_star', $("#sreply_star").val());
	
	//다중첨부파일
	if(fileList){
		for(var index in fileList){
			form_data.append('filename', fileList[index]);
		}
	}
	
	
	
	//첨부파일의 경우 인코딩타입(enctype)을 'multipart/form-data'로 지정해주어야 하는데 , 지정해주지 않으면 application이다
	//contentType, processData를 false로 지정해주어야 함, 두 속성의 기본값은 true인데 true일 경우 일반적인 방법으로 파라미터 값이 넘어가 버림
	$.ajax({
		type 		: 'POST', 
		dataType 	: 'json', 
		url 		: 'commWrite.do', 
		data 		: form_data, 
		contentType : false, 
		enctype 	: 'multipart/form-data', 
		processData : false, 
		success 	: reply_list_result 
	});
	
	//첨부파일과 상관없이 다음 입력을 위해서 초기화해주는 과정
	$("#sreply_content").val('');
	$("#sreply_star").val('');
	$('.starCnt').prop('src', $('.starCnt').prop('src').replace("on.png","off.png"));
	$('.fileDrop').empty();
	fileList = [];
	
	
}//end reply_list()


//newDate 변수로 컬럼에서 받아온값을 timevalue로 넘겨서 값을 반환해준다.
Handlebars.registerHelper("newDate", function(timeValue){
	var dateObj = new Date(timeValue);
	var year = dateObj.getFullYear();
	var month = dateObj.getMonth()+1;
	var date = dateObj.getDate();
	return year+"/"+month+"/"+date;
});


//후기 작성이 성공적으로 이루어 졌을떄 실행될 메소드
function reply_list_result(res){
	
	//초기화(자식요소 제거)
	$('#commentMain').empty();
	
	//총 댓글개수 출력, span 요소임 val인지 text인지 한번 확인하기
	$('#replyListCnt').text(res.length);
	
	//첨부파일이 있는 경우와 없는 경우에 각각 후기 리스트가 생성될 수 있도록 처리
	$.each(res, function(index, value){
		//첨부파일이 있는 경우
		
		//첨부파일이 없는 경우
		
		$('#commentMain').text('성공');
	});
	
	
}//end reply_list_result()
