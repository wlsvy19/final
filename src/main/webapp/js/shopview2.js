var urno = ''; //수정할 댓글의 번호를 받을 변수
var fileList = []; //작성할 첨부파일을 담을 list(초기)
var fileList2 = []; //수정할 첨부파일을 담을 list
var oldFileList = []; //삭제하지 않을 기존의 첨부파일명을 담을 list

$(document).ready(function() {
   //alert("shopview2.js로 실행됨");
   
   //후기 작성창 열고 닫기 버튼
   $('#commBtn').on('click', function(){
     var chk = $('#p_condi').val();
     
     if(chk == 'true'){
        $('#commentWrite').toggle();
     }else{
        alert('상품 구입 후 작성할 수 있습니다.');
        return false;
     }
      
   });
   
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
   
   //별점 수정하는 버튼
   $('.starCnt2').on('click', function(){
      var clickStar = $(this).prop('name'); //선택한 별점의 점수를 받음
      $('#sreply_star2').val(clickStar); //별점의 값을 저장해둘 요소의 value값에 넣어줌
      //선택한별점보다 작은값까지 색상이 변하도록 처리
      $('.starCnt2').prop('src', $('.starCnt2').prop('src').replace("on.png","off.png")); //이미지 초기화
      for(var i = 1; i <= clickStar; i++){
         $('.starCnt2[name="'+i+'"]').prop('src', $('.starCnt2[name="'+i+'"]').prop('src').replace("off.png","on.png"));
      }
      
   });
   
   //기존에 있던 이미지 클릭할때
   $(document).on('click', '#modifyModal #modifyImgBox img', modiImgClick);
   
   // 선택자에 class속성을 넣는다.
   $('#modifyModal').addClass('modifyHide');
   
   // 댓글 추가하기 위한 이벤트
   $('#commWriteBtn').on('click', reply_list);

   // 댓글 수정,삭제 버튼에 click이벤트 연결
   $(document).on('click', '.commUpDelBtn', reply_update_delete);

   // 모달창에 닫기버튼
   $('#btnClose').on('click',function(){
      $('#updateReplyText').val('');
      $('#modifyModal').removeClass('modifyShow');
      $('#modifyModal').addClass('modifyHide');
      $(document).on('click', '.comm_list .comm_right button',reply_update_delete);
      urno = '';
   });

   // 모달창에 수정버튼
   $('#btnModify').on('click', reply_update_send);

   // 내PC 첨부파일 시작////////////////////
   var userfile = '';
   $('#userpc').on('click',function() {
      userfile = $('<input type="file" />');
      userfile.click();
      userfile.change(function(){
         console.log($(userfile[0]).val());
         var partname = $(userfile[0]).val().substring($(userfile[0]).val().lastIndexOf("\\") + 1);
         console.log(partname);
         var str = '<p><input type="checkbox" />'+ partname + '</p>';
         // //초기화
         $('.fileDrop').append(str);
         fileList.push(userfile[0].files[0]);
         });
      });
   // 내PC 첨부파일끝///////////////////////
   
   // 내PC2 첨부파일 시작////////////////////
   var userfile2 = '';
   $('#userpc2').on('click',function() {
      userfile2 = $('<input type="file" />');
      userfile2.click();
      userfile2.change(function(){
         var partname2 = $(userfile2[0]).val().substring($(userfile2[0]).val().lastIndexOf("\\") + 1);
         var str2 = '<p style = "font-size : small; margin : 0; margin-right : 3%; float : right;"><input type="checkbox" />'+ partname2 + '</p>';
         $('#modifyModal #modiFileAdd').append(str2);
         fileList2.push(userfile2[0].files[0]);
         });
      });
   // 내PC 첨부파일끝///////////////////////

   // 첨부파일 드래그 시작///////////////
   var obj = $('.fileDrop');
   var win = $('body');
   win.on('dragover', function(e) {
      e.preventDefault();
      obj.css('border', '2px solid #99bbff');
   });
   

   win.on('drop', function(e) {
      e.preventDefault();
      // $(obj).empty();
      var files = e.originalEvent.dataTransfer.files;
      for (i = 0; i < files.length; i++) {
      obj.append('<p><input type="checkbox" />'+ files[i].name + '</p>');
      fileList.push(files[i]);
      }
      console.log(fileList);
   });
   // 첨부파일 드래그 끝///////////////

   // 첨부파일 삭제 시작////
   $(document).on('click', '.fileDrop input', function() {
      if ($(this).prop('checked')) {
         fileList.pop($(this).index());
         $(this).parent().remove();
      }
   });
   // 첨부파일 삭제 끝///////////////////
   
   // 수정 모달창에서 새로 추가한 첨부파일 삭제 시작////
   $(document).on('click', '#modifyModal #modiFileAdd input', function() {
      if ($(this).prop('checked')) {
         fileList2.pop($(this).index());
         $(this).parent().remove();
      }
   });
   // 첨부파일 삭제 끝///////////////////

});// end ready()////////////////////////////

//수정할 이미지를 클릭했을때
function modiImgClick(){
   if(confirm("선택한 사진을 삭제하시겠습니까?") == true){
      $(this).remove();
      alert("삭제되었습니다.")
   }else{
       alert("취소되었습니다.");
   }
}//end modiImgClick()//////////////////////////////////////////

//수정 삭제 버튼 눌렀을때
function reply_update_delete() {
   if ($(this).text() == 'delete') {
      //alert("delete 버튼이 눌렸다!");
      var drno = $(this).prop("id");
      var sn = $("#shop_num").val();
      
      $.ajax({
         type : 'GET',
         dataType : 'json',
         url : 'sreplyDelete.do?shop_num='+sn+'&sreply_num=' + drno,
         success : reply_list_result
      });
      
      
   } else if ($(this).text() == 'update') {
      //alert("update 버튼이 눌렸다!");
      urno = $(this).prop("id");
      
      //선택한 후기의 멀티파일 사진 정보를 가지고 와야함 (멀티파일을 보내는 것이 아니라 받아와야함)
      $.ajax({
         type : 'GET',
         dataType : 'json',
         url : 'sreplyUpdateFile.do?sreply_num=' + urno,
         success : modiImg_list
      });
      
   }
}// end reply_update_delete()///////////////


//수정하려고 선택한 멀티파일의 값을 가지고 와서 처리하는 메소드
function modiImg_list(res){
   //alert("method in");
   //사진 가로 길이 설정 부분
   if(res.length == 1)
      var widthSize = 30;
   else
      var widthSize = 100/res.length - 10;
   
   //초기화 작업
   $('#modifyModal #modifyImgBox').empty();
   $('.starCnt2').prop('src', $('.starCnt2').prop('src').replace("on.png","off.png"));
   fileList2.pop($('#modifyModal #modiFileAdd input').index());
   $('#modifyModal #modiFileAdd input').parent().remove();
   
   var modifile = "";
   $.each(res, function(index, value){
      modifile += '<img src="/temp/'+value.shop_file+'" class = "modiImg" id="modiImg'+index+'" style = "display : inline-block; width : '+widthSize+'%; height : 130px; size : 100%; margin-left : 2%; margin-top:2%;"/>';
   });
   $('#modifyModal #modifyImgBox').append(modifile);
   
   var stop = $(window).scrollTop();
   $('#modifyModal').css('top', 100 + stop);
   $('#modifyModal').removeClass('modifyHide').addClass('modifyShow');
   
   $(document).off('click', '.comm_list .comm_right button');
}


//모달창 수정버튼 눌렀을때
function reply_update_send() {
   //삭제되지 않을 기존의 파일 리스트 -> oldFilename
   for(var j=0; j<3; j++){
      //여기서 값을 이상하게 찍음 -> attr 로 찍으니까 찍힘
      var old = '';
      old = $('#modiImg'+j).attr('src');
      if(old != undefined){ //존재하면
         var start = old.indexOf('_')+1;
          var end = old.length;
          var rup = old.substring(start, end);
          oldFileList.push(rup);
      }
   }
   
   //예외처리
   if ($('#updateReplyText').val() == '') {
      alert('수정할 내용을 입력하세요.');
      return false;
   }
   
   if($('#sreply_star2').val() == ''){
      alert("별점을 선택해주세요.");
      return false;
   }
   
   if(oldFileList.length + fileList2.length == 0){
      alert("후기 사진을 첨부해주세요.");
      return false;
   }
   
   if(oldFileList.length + fileList2.length > 3){
      alert("사진은 최대 3개까지 첨부할 수 있습니다.");
      return false;
   }
   
   if(fileList2.length == 0){
         alert("추가 후기 사진을 첨부해주세요.(필수사항)");
         return false;
      }
   
   //수정할 값 확인
   //alert("$('#updateReplyText').val() : " + $('#updateReplyText').val());
   //alert("$('#sreply_star2').val() : " + $('#sreply_star2').val());
   //alert("fileList2.length : " + fileList2.length);
   
   var form_data2 = new FormData();
   
   form_data2.append('shop_num', $("#shop_num").val()); //상품번호
   form_data2.append('sreply_num', urno); //수정하기 위해 선택한 후기 댓글의 번호값
   form_data2.append('sreply_writer', $("#commSreply_writer"+urno).text()); //작성자
   form_data2.append('sreply_content', $('#updateReplyText').val()); //수정할 내용값
   form_data2.append('sreply_star', $('#sreply_star2').val()); //수정할 별점값

   //다중첨부파일
   if (fileList2) {
      for (var index in fileList2) {
         form_data2.append('filename', fileList2[index]);
      }
   }
   
   //기존다중첨부파일
   if (oldFileList) {
      for (var index in oldFileList) {
         form_data2.append('oldFilename', oldFileList[index]);
      }
   }
   
   $.ajax({
      // 첨부파일이 있을때는 data, contentType, enctype, processData가 이런 폼으로 있어야한다.
      type : 'POST',
      dataType : 'json',
      url : 'commUpdate.do',
      data : form_data2,
      contentType : false,
      enctype : 'multipart/form-data',
      processData : false,
      success : reply_list_result,
      error : function(res){
         
         //수정할때 새로운 수정 사진을 선택하지 않은 경우의 예외처리가 필요함
         
         /*location.href = "shoppingView.do?shop_num="+$("#shop_num").val();
         var offset = $("#shoppingComment" + seq).offset();
         $('html, body').animate({scrollTop : offset.top}, 400);*/
         /*location.href = "shoppingView.do?shop_num="+$("#shop_num").val();*/

      }

   });

   //초기화 작업
   fileList2 = [];
   oldFileList = [];
   $('#updateReplyText').val('');
   $(document).on('click', '.comm_list .comm_right button', reply_update_delete);
   $('#modifyModal').removeClass('modifyShow').addClass('modifyHide');
   $('.starCnt2').prop('src', $('.starCnt2').prop('src').replace("on.png","off.png"));
   urno = '';

}// end end reply_update_send()///////////////////////////////


//후기 작성 버튼을 눌렀을때
function reply_list() {
   //예외처리를 해줌
   if($("#sreply_content").val() == ''){
      alert("내용을 입력해주세요.");
      return false;
   }
      
   if($('#sreply_star').val() == ''){
      alert("별점을 선택해주세요.");
      return false;
   }
      
   if(fileList.length == 0){
      alert("후기 사진을 첨부해주세요.");
      return false;
   }
   
   if(fileList.length > 3){
      alert("사진은 최대 3개까지 첨부할 수 있습니다.");
      return false;
   }
      
   
   // 첨부파일을 보낼때는 이렇게
   var form_data = new FormData();
   
   form_data.append('shop_num', $("#shop_num").val());
   form_data.append('sreply_writer', $("#sreply_writer").text());
   form_data.append('sreply_content', $("#sreply_content").val());
   form_data.append('sreply_star', $("#sreply_star").val());

   // 다중첨부파일
   if (fileList) {
      for ( var index in fileList) {
         form_data.append('filename', fileList[index]);
      }
   }

   $.ajax({
      // 첨부파일이 있을때는 data, contentType, enctype, processData가 이런 폼으로 있어야한다.
      type : 'POST',
      dataType : 'json',
      url : 'commWrite.do',
      data : form_data,
      contentType : false,
      enctype : 'multipart/form-data',
      processData : false,
      success : reply_list_result,
      error : function(res){
         alert("error입니다아아아아앙 ㅠ");
      }

   });

   fileList = [];

}

Handlebars.registerHelper("newDate", function(timeValue) {
   var sdate = new Date(timeValue);
   var year = sdate.getFullYear();
   var month = sdate.getMonth() + 1;
   var date = sdate.getDate();

   return year + "/" + month + "/" + date;
});


function reply_list_result(res) {
   //alert("****reply_list_result 처리됨****");
   
   //초기화(자식요소 제거)
   $('#commentMain #comm_sub').empty();
   
   //총 댓글개수 출력, span 요소임 val인지 text인지 한번 확인하기
   //$('#replyListCnt').text(res.length);
   
   //새로 추가한 댓글까지 포함해서 전체 댓글 다시 그려주기
   $.each(res, function(index, value){
      if(value.mFileList != null || value.mFileList.length > 0){
         var mfile = "";
         for(var i = 0; i < value.mFileList.length; i++){
            mfile += '<img src="/temp/'+value.mFileList[i].shop_file+'" class = "tempImg"/>';
         }
         
         var source = '<div class = "comm_list">'
                     +'<div class = "comm_left">'
                        +'<div class = "comm_star">'
                           +'<img class = "commStarCntImg" src="./images/starCnt_{{sreply_star}}.png" alt = "별점 on 이미지">'
                        +'</div>'
                        +'<p class = "comm_content">{{sreply_content}}</p>'
                        +mfile
                    +'</div>'
                        +'<div class = "comm_right">'
                           +'<p id = "commSreply_writer{{sreply_num}}" style="font-weight: bold;">{{sreply_writer}}</p>'
                           +'<p>{{newDate sreply_regdate}}</p>';
         if(value.sreply_writer == $('#p_mem_id').val()){
            source += '<p><button id = "{{sreply_num}}" class = "commUpDelBtn">delete</button><button id = "{{sreply_num}}" class = "commUpDelBtn">update</button></p>';           
         }
         source += '</div></div>';
         
      }else {
         var source = '<div class = "comm_list">'
                        +'<div class = "comm_left">'
                           +'<div class = "comm_star">'
                              +'<img class = "commStarCntImg" src="./images/starCnt_{{sreply_star}}.png" alt = "별점 on 이미지">'
                           +'</div>'
                           +'<p class = "comm_content">{{sreply_content}}</p>'
                        +'</div>'
                        +'<div class = "comm_right">'
                           +'<p id = "commSreply_writer{{sreply_num}}" style="font-weight: bold;">{{sreply_writer}}</p>'
                           +'<p>{{newDate sreply_regdate}}</p>';
          if(value.sreply_writer == $('#p_mem_id').val()){
             source += '<p><button id = "{{sreply_num}}" class = "commUpDelBtn">delete</button><button id = "{{sreply_num}}" class = "commUpDelBtn">update</button></p>';           
          }
          source += '</div></div>';
      }
      var template = Handlebars.compile(source);
      $('#commentMain #comm_sub').append(template(value));
   });
   
   $("#sreply_content").val('');
   $("#sreply_star").val('');
   $('.starCnt').prop('src', $('.starCnt').prop('src').replace("on.png","off.png"));
   $(document).on('click', '.comm_list .comm_right button',reply_update_delete);
   $('.fileDrop').empty();
   $('#commentWrite').css('display', 'none');

}