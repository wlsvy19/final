//기본값 저장
var keyword;
var pageNo;
var totalPage;
var num;
var total;

function Pagesearch(totalPage, total, blocksize, blockpage) {
	displayPagination(totalPage, total, blocksize, blockpage);
	if (keyword != '') {
		// alert(keyword);
		$.ajax({

			type : 'POST',
			dataType : 'json',
			data : {
				'pageNo' : blockpage,
				'pageSize' : total,
				'keyword' : keyword
			},
			url : 'libmap.do',
			success : function(result) {
				var search = result.aList;
				pageNo = result.pageNo;
				totalPage = result.totalPage;
				displayPlaces(search);

			},
			error : function(error) {
				alert(error);
			}
		});
	}
}
// 마커를 담을 배열입니다
var markers = [];

var mapContainer = document.getElementById('map'), // 지도를 표시할 div
mapOption = {
	center : new daum.maps.LatLng(37.499110, 127.032930), // 지도의 중심좌표
	level : 5
// 지도의 확대 레벨
};



// 지도를 생성합니다
var map = new daum.maps.Map(mapContainer, mapOption);

//마커가 표시될 위치입니다 
var markerPosition  = new daum.maps.LatLng(37.499110, 127.032930); 

// 마커를 생성합니다
var marker = new daum.maps.Marker({
    position: markerPosition
});

// 마커가 지도 위에 표시되도록 설정합니다
marker.setMap(map);

var iwContent = '<div style="padding:5px; padding-left : 47px;">나나랜드 <br>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
    iwPosition = new daum.maps.LatLng(37.499110, 127.032930); //인포윈도우 표시 위치입니다

// 인포윈도우를 생성합니다
var infowindow = new daum.maps.InfoWindow({
    position : iwPosition, 
    content : iwContent 
});
  
// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
infowindow.open(map, marker); 

// 지도타입 컨트롤의 지도 또는 스카이뷰 버튼을 클릭하면 호출되어 지도타입을 바꾸는 함수입니다
function setMapType(maptype) {
	var roadmapControl = document.getElementById('btnRoadmap');
	var skyviewControl = document.getElementById('btnSkyview');
	if (maptype === 'roadmap') {
		map.setMapTypeId(daum.maps.MapTypeId.ROADMAP);
		roadmapControl.className = 'selected_btn';
		skyviewControl.className = 'btn';
	} else {
		map.setMapTypeId(daum.maps.MapTypeId.HYBRID);
		skyviewControl.className = 'selected_btn';
		roadmapControl.className = 'btn';
	}
}



// 지도 확대, 축소 컨트롤에서 확대 버튼을 누르면 호출되어 지도를 확대하는 함수입니다
function zoomIn() {
	map.setLevel(map.getLevel() - 1);
}

// 지도 확대, 축소 컨트롤에서 축소 버튼을 누르면 호출되어 지도를 확대하는 함수입니다
function zoomOut() {
	map.setLevel(map.getLevel() + 1);
}

// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
var infowindow = new daum.maps.InfoWindow({
	removable : true,
	zIndex : 1
});

// 키워드로 장소를 검색합니다
// searchPlaces();
/*
// 키워드 검색을 요청하는 함수입니다
function searchPlaces() {
	keyword = document.getElementById('keyword').value;
	if (!keyword.replace(/^\s+|\s+$/g, '')) {
		alert('키워드를 입력해주세요!');
		return false;
	} else {
		infowindow.close();
		
		Searchkeyword(keyword);
	}

}*/


function Searchkeyword(keyword) {
	//alert(keyword);
	// 한페이지당 표시될 화면 계산
	num = 1;
	total = 15;
	keyword = keyword;
	// keyword = document.getElementById('keyword').value;
	// 디비값을 불러 지도에 뿌림
	$.ajax({
		type : 'POST',
		dataType : 'json',
		data : {
			'pageNo' : num,
			'pageSize' : total,
			'keyword' : keyword
		},
		url : 'libmap.do',
		success : function(result) {
			var search = result.aList;
			pageNo = result.pageNo;
			totalPage = result.totalPage;
			displayPlaces(search);
			keyword = document.getElementById('keyword').value;
			
		},
		error : function(error) {
			alert(error);
		}
	});
} // end f_Searchkeyword()


//회원 수 좋아요수 상품수 애니매이션 효과 주기
function fn_serviceMbrCnt(mem_id, shop_starcnt,sales_cnt ) {
   var $el = $("#count_number");
   $({ val : 0 }).animate({ val : mem_id }, {
      duration: 200,
      step: function() {
         $el.text(Math.floor(this.val));
      },
      complete: function() {
         $el.text(Math.floor(this.val));
      }
   });
   
   var $eld = $("#count_like");
   $({ val : 0 }).animate({ val : shop_starcnt }, {
      duration: 200,
      step: function() {
         $eld.text(Math.floor(this.val));
      },
      complete: function() {
         $eld.text(Math.floor(this.val));
      }
   });
   
   var $elf = $("#count_product");
   $({ val : 0 }).animate({ val : sales_cnt }, {
      duration: 200,
      step: function() {
         $elf.text(Math.floor(this.val));
      },
      complete: function() {
         $elf.text(Math.floor(this.val));
      }
   });
   
   
}

