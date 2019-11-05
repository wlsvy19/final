var fileList = [];

$(document).ready(function() {
   //alert("js 연결");
   
   //판매 중지 버튼
   $(document).on('click', '#allarea_right #product_div #product_table .stopPro', function(){
      //alert("판매 중지 버튼");
      var sno = $(this).prop('id');
      
      $.ajax({
         type : 'GET',
         dataType : 'json',
         url : 'productStop.do?shop_num='+sno,
         success : reply_list_result
      });
      
   });
   
   //재판매 버튼
   $(document).on('click', '#allarea_right #product_div #product_table .rePro', function(){
      //alert("재판매 버튼");
      var rno = $(this).prop('id');
      
      $.ajax({
         type : 'GET',
         dataType : 'json',
         url : 'productResale.do?shop_num='+rno,
         success : reply_list_result
      });
   });
   
   //상품 삭제 버튼
   $(document).on('click', '#allarea_right #product_div #product_table .delPro', function(){
      //alert("상품 삭제 버튼");
      var dno = $(this).prop('id');
      
      if(confirm("선택한 상품을 삭제하시겠습니까?") == true){
         proDelete(dno);
      }else{
          alert("취소되었습니다.");
      }
   });
   
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
   
   //카테고리값 변할 때
   $('#combo').on('change', function(){
      var path = "/nanaland/"+$('#combo option:selected').val()+"/";
      $('.inputNewInfo #newPath').attr('value', path);
   });
   
   //상품명이 변할 떄
   $('#newName').on('change', function(){
      var path = "/nanaland/"+$('#combo option:selected').val()+"/"+$('#newName').val()+" ";
      $('.inputNewInfo #newPath').attr('value', path);
   });
   
   //가격이 변할 때
   $('#newPrice').on('change', function(){
      var path = "/nanaland/"+$('#combo option:selected').val()+"/"+$('#newName').val()+" "+$('#newPrice').val();
      $('.inputNewInfo #newPath').attr('value', path);
   });
   
   //상품 추가 버튼
   $('#addNewPro').on('click', function(){
      
      var shop_name = $('#newName').val();
      var shop_code = $('#combo option:selected').val();
      var shop_price = $('#newPrice').val();
      var shop_stock = $('#newStock').val();
      var shop_imgpath = $('#newPath').val();
      
      //첨부파일이 있는 경우의 파일 추가
      var form_data = new FormData();
      
      form_data.append('shop_name', shop_name);
      form_data.append('shop_code', shop_code);
      form_data.append('shop_price', shop_price);
      form_data.append('shop_stock', shop_stock);
      form_data.append('shop_imgpath', shop_imgpath);
      
      // 다중첨부파일 -> 가지고 가서 별도의 매개변수로 받고 DB로 가지고 갈 필요는 없다, 파일에만 복사해서 넣어주고 DB에는 경로만 저장해주면 된다.
      if (fileList) {
         for ( var index in fileList) {
            form_data.append('filename', fileList[index]);
         }
      }
      
      $.ajax({
         // 첨부파일이 있을때는 data, contentType, enctype, processData가 이런 폼으로 있어야한다.
         type : 'POST',
         /*dataType : 'json',*/
         url : 'productInsert.do',
         data : form_data,
         contentType : false,
         enctype : 'multipart/form-data',
         processData : false,
         success : resale
      });

      fileList = [];
      
   });
   
});//end ready

function resale(res){
   location.href = "product.do";
}

//상품 삭제하기
function proDelete(dno){
   //alert("dno : " + dno);
   
   $.ajax({
      type : 'GET',
      dataType : 'json',
      url : 'productDelete.do?shop_num='+dno,
      success : reply_list_result
   });
}


//테이블 다시 그리기
function reply_list_result(res){
   alert("처리 되었습니다.");
   
   //초기화 -> 테이블의 tbody의 tr을 제거
   $('#product_div #product_table tbody .stop_tr').remove();
   $('#product_div #product_table tbody .non_stop_tr').remove();
   
   //테이블 다시 그리기
   $.each(res, function(index, value){
      if(value.shopInfo_chk == 0){
         var source = '<tr id = "'+value.shopInfo_chk+'" class = "stop_tr">'
            +'<td width="10%">'+value.shopInfo_num+'</td>'
            +'<td width="35%">'+value.shopInfo_name+'</td>'
            +'<td width="11%">'+value.shopInfo_price+'</td>'
            +'<td width="11%">'+value.shopInfo_starcnt+'</td>'
            +'<td width="11%"><button id = "'+value.shopInfo_num+'" class = "stopPro">stop</button></td>'
            +'<td width="11%"><button id = "'+value.shopInfo_num+'" class = "rePro">resale</button></td>'
            +'<td width="11%"><button id = "'+value.shopInfo_num+'" class = "delPro">delete</button></td></tr>';
      }else if(value.shopInfo_chk == 1){
         var source = '<tr id = "'+value.shopInfo_chk+'" class = "non_stop_tr">'
         +'<td width="10%">'+value.shopInfo_num+'</td>'
         +'<td width="35%">'+value.shopInfo_name+'</td>'
         +'<td width="11%">'+value.shopInfo_price+'</td>'
         +'<td width="11%">'+value.shopInfo_starcnt+'</td>'
         +'<td width="11%"><button id = "'+value.shopInfo_num+'" class = "stopPro">stop</button></td>'
         +'<td width="11%"><button id = "'+value.shopInfo_num+'" class = "rePro">resale</button></td>'
         +'<td width="11%"><button id = "'+value.shopInfo_num+'" class = "delPro">delete</button></td></tr>';
      }
      
      $('#product_div #product_table tbody').append(source);
      
   });
}

