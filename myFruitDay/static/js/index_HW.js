// var imG = document.getElementById('ba');
// function timerId(){	
// 	var imG = document.getElementById('ba');
// 	for (i = 0; i < 3; i++){
// 		imG.setAttribute('src',imgArray[i]);
// 	}
// }

// // 請教老師此種解法
// window.onload =function(){	
// 	var timer;
// 	imG = document.getElementById('ba');
// 	imgArray = new Array("images/banner2.jpg", "images/banner3.jpg", "images/banner1.jpg")
// 	console.log(imgArray);
// 	imG.setAttribute('src',imgArray[1]);
// 	for (var i = 0; i < 3; i++){
// 		setTimeout(function(){ console.log(i,'abc1000',i); }, (i+1)*2000);

// 	}
// }


window.onload = function (){
	// 1. 獲取元素節點
	var currentAddr = document.getElementsByClassName('currentAddress')[0];
	var select = document.getElementsByClassName('select')[0];
	// ---------------下拉式選單-----------------
	// 獲取 包含各城市的ul列表
	var address = select.children;
	for (var i =0; i < address.length; i++){
		address[i].onclick = function(){
			// 傳值
			currentAddr.innerHTML = this.innerHTML;
		};
	}

	// ---------------圖片輪播----------------
	// 多設置一個div標籤 以設置獲取所有圖片子節點
	var banner = document.getElementsByClassName('wrapper')[0];
	var imgs = banner.children; //圖片array object
	var imgNav = document.getElementById('circle');
	var spanInfo = imgNav.children; // 索引數組
	var timer = setInterval(autoPlay,1000); // 定時器
	var imgIndex = 0;
	function autoPlay(){
		// 設置圖片元素的隱藏 和顯示

		imgs[imgIndex].style.display = "none";
		imgIndex++;
		if (imgIndex==imgs.length-1){
			imgIndex = 0;
		}
		// imgIndex = imgIndex++ == imgs.length ? 0 : imgIndex;
		imgs[imgIndex].style.display = "block";

		// 切換索引 切換被景色
		for (var i=0; i < spanInfo.length; i++){
			spanInfo[i].style.background = "grey";
		}
		spanInfo[imgIndex].style.background = "red"
	}

	// 鼠標移入時切換
	banner.onmouseover = function (){
		// 停止計時器
		clearInterval(timer);
	}

	banner.onmouseout = function (){
		// 因為imgIndex是全局變量 故當前索引不會重來
		timer = setInterval(autoPlay, 1000);
	}
};




// 異步向服務器發送請求 檢查用戶是否處於登錄狀態
function check_login(){
	$.get('/check-login/',function(data){
		var html = "";
		console.log('check_login ing~');
		if(data.loginStatus == 0){
			html += "<a href='/login'>[登錄]</a>";
			html += "<a style='margin-left:5px' href='/register'>[註冊, 有驚喜]</a>";
		}else{
			html += "歡迎: "+data.uname;
			html += "<a style='margin-left:5px' href='/logout'>| 退出</a>";
		}
		$("#login").html(html);
	},'json');
}


// 自動加載各個商品種類及其商品
function loadGoods(){
  $.get('/load_type_goods/',function(data){
    // data 為響應回來的json數據
    var show = "";
    $.each(data, function(i,obj){

      // 從obj中取出type, 並轉換為json物件
      var good_type_json = JSON.parse(obj.type);
      var good_json = JSON.parse(obj.goods);
      // console.log(good_type_json ,good_type_json.title);
	  
      // 加載商品類型
      show += "<div class='item' style='height:30px;width:100%;overflow:hidden;'>"
        show += "<p>"
        show += good_type_json.title
        show += "</p>"
        show += "<a href=''>"
        show += '更多'
        show += "</a>"       
      show += "</div>"
      show += "<ul>"
	  $.each(good_json, function(i,obj){
	  	  show += "<li "
	  	  if ((i+1)%5==0){
	  	  	show += "class='no-margin'";
	  	  }
	  	  show += ">"
	  	    show += "<p>"
	  	      show += "<img src='/"+obj.fields.picture+"'>"
	  	    show += "</p>"

	  	    show += "<div class='content'>"
	  	    // 拼參數時要注意單雙引號
	  	      show += "<a href='javascript:add_cart("+ obj.pk + ', "'+obj.fields.title+'");' +"'>"
	  	        show += "<img src='/static/images/cart.png'>"
	  	      show += "</a>"
	  	      show += "<p>"+obj.fields.title
	  	      show += "</p>"
	  	      show += "<span>$"+obj.fields.price+'/'+obj.fields.spec
	  	      show += "</span>"
	  	    show += "</div>"
	  	  show += "</li>"
      });
      show += "</ul>"

    });
    
    $('#index_main').html(show);
  }, 'json');
}

// 點擊後添加購物商品到購物車內並將相關資訊儲存在資料庫
function add_cart(good_id,good_title){
  $.get('/check-login/',function(data){
		var html = "";

		// 判斷用戶是否登錄
		if(data.loginStatus == 0){
			alert('請先登入');
		}else{
			$.ajaxSettings.async = false;
			$.get('/check_carts/',{'good_id': good_id},function(save){
				alert(save.uname+'保存'+good_title+'到購物車');
			},'json');
		}
		cart_status();
	},'json');
}	


// 異步向服務器發送請求 拼接出購物車狀態
function cart_status(){
	$.get('/check_cart/',function(data){
		var html = "";
		html += "<b></b>";
		html += "<a href='/carts_render'>購物車("+data.carts_total+")</a>";

		$("#cart").html(html);
	},'json');
}











$(function(){
	// 加載登錄狀態訊息
	check_login();
	// 加載購物車狀態訊息
	cart_status();
	// 加載所有商品類型和商品
	loadGoods();

});



















