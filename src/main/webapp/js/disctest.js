$(document).ready(function(){
   var discResult = "";
   
   /*alert("js 연결");*/
   //테스트 결과보기를 클릭했을때
   $('#discEndBtn').on('click', function(){
      var acnt = 0; //24개를 모두 선택했는지 확인하기 위한 변수
      var dcnt = 0, icnt = 0, scnt = 0, ccnt = 0; //disc 각각의 유형의 선택된 개수를 저장할 변수들
      
      //각요소별 카운팅 & 총개수 카운팅
      for(var i = 1 ; i < 25; i++){
         var obj = document.getElementsByName("chk"+i);
         for(var j = 0; j< obj.length; j++){
            if(obj[j].checked == true){
               if(obj[j].value == 'd'){
                  dcnt++;
                  acnt++;
               }else if(obj[j].value == 'i'){
                  icnt++;
                  acnt++;
               }else if(obj[j].value == 's'){
                  scnt++;
                  acnt++;
               }else if(obj[j].value == 'c'){
                  ccnt++;
                  acnt++;
               }
            }
         }
      }
      
      /*alert("dcnt = " + dcnt + " icnt = " + icnt + "scnt = " + scnt + "ccnt = " + ccnt + " acnt = " + acnt);*/
      
      if(acnt == 24){
         //disc 유형중 가장 많이 선택된 항목을 찾아주는 메소드 호출
         discMax(dcnt, icnt, scnt, ccnt);
      }else{
         alert("선택되지 않은 항목이 있습니다. \n모든 항목을 선택한 후 다시 버튼을 눌러주세요.");
      }
      
      
      
   }); //end click event
   
   function discMax(dcnt, icnt, scnt, ccnt){
      //가장 큰 값을 찾아냄
      //var res = {dcnt, icnt, scnt, ccnt}; //undefined로 값이 제대로 들어가지 않음
      var res = new Array(dcnt, icnt, scnt, ccnt);
      var maxIndex = 0;
      var maxCnt = 0;
      /*var discResult = "";*/
      
      for(var k = 0; k < res.length; k++) {
         if(maxCnt < res[k]) {
            maxCnt = res[k];
            maxIndex = k;
         }
      }
      
      
      if(maxIndex == 0) {
         discResult = "d";
      }else if(maxIndex == 1) {
         discResult = "i";
      }else if(maxIndex == 2) {
         discResult = "s";
      }else if(maxIndex == 3) {
         discResult = "c";
      }
      
      //alert("res[0] = " + res[0] + " res[1] = " + res[1] + " res[2] = " + res[2] + " res[3] = " + res[3]);
      //alert("discResult = " + discResult + " maxIndex = " + maxIndex + " maxCnt = " + maxCnt);
      ///////////////////////////////////////////////////////////////
      //자식요소 제거하고 결과화면 띄워주기
      $('html, body').scrollTop(0);
      $('#wrap').empty();
      $('#wrap').append('<img id = "resultImg" src = "./images/result_'+discResult+'.png" style = "width : 50%; heigth : 20%; size : 100%; margin-left : 25%; margin-top : 5%;">');
      $('#wrap').append('<input type = "button" id = "myDiscShop" value = "취미 구경가기" style = "width: 250px; height: 60px; background:#ff3333; color:#fff; border:none; outline:none; font-size: medium; margin-left: 40%; margin-top : 5%; margin-bottom : 7%; cursor: pointer; border-radius: 5px;">');
      
      
	$.ajax({
		type : 'GET',
		dataType : 'text',
		url : 'discInput.do?discResult='+discResult,
		success : viewMessage
	});
   }
   
   
   //내 취미 바로가기 버튼 동적 이벤트 처리
   $(document).on('click', '#myDiscShop', function(){
      location.href="shoppingMain.do";
   });
   
});


function viewMessage(res){
	
}