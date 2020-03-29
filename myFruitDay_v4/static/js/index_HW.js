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
	// var currentAddr = document.getElementsByClassName('currentAddress')[0];
	// var select = document.getElementsByClassName('select')[0];
	// // ---------------下拉式選單-----------------
	// // 獲取 包含各城市的ul列表
	// var address = select.children;
	// for (var i =0; i < address.length; i++){
	// 	address[i].onclick = function(){
	// 		// 傳值
	// 		currentAddr.innerHTML = this.innerHTML;
	// 	};
	// }

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


// 向服務器發送請求 檢查用戶是否處於登錄狀態
function check_login(){
	console.log('function checking')
	// 使用同步以確保購物車狀態符合實際
	$.ajaxSettings.async = false;
	$.get('/check-login/',function(data){
		var html = "";
		console.log('check_login ing~');
		// 若狀態碼為0 ： 未登錄,1 : 使用者登錄
		if(data.loginStatus == 0){
			html += "<a href='/login'>[登錄]</a>";
			html += "<a style='margin-left:5px' href='/register'>[註冊, 有驚喜]</a>";
		}else{
			html += "歡迎: "+data.uname;
			html += "<a style='margin-left:5px' href='/logout'>| 退出</a>";
		}
		$("#login").html(html);
		// 確認登錄狀態後更新購物車顯示數量
		cart_status();
	},'json');
}


// 自動加載各個商品種類及其商品
function loadGoods(){
  $.get('/type_goods/',function(data){
    // data 為響應回來的json數據
    var show = "";
    $.each(data, function(i,obj){

      // 從obj中取出type, 並轉換為json物件
      var good_type_json = JSON.parse(obj.type);
      var good_json = JSON.parse(obj.goods);
      // console.log(good_type_json ,good_type_json.title);
	  
      // 加載商品類型
      show += "<div id='good_type_div"+ good_type_json.type_id +
      "' class='item' style='overflow:hidden;'>"
        show += "<p>"
        show += good_type_json.title
        show += "</p>"
        // show += "<p>"
	        show += "<table>"
			
	          show += "<tr>"

	          	show += "<th id='my-mouse-type_id"+ good_type_json.type_id + "_desc'" + 
				  ' onmouseover=mymouse(' + good_type_json.type_id + ",'desc');" +
				  " onclick=get_goods_order(" + good_type_json.type_id + ",'desc');" + ">"

	          	  show += "價格由高至低"

	          	show += "</th>"

	          	show += "<th id='my-mouse-type_id"+ good_type_json.type_id + "_asc'" + 
				  ' onmouseover=mymouse(' + good_type_json.type_id + ",'asc');" +
				  " onclick=get_goods_order(" + good_type_json.type_id + ",'asc');" + ">"
	          	  show += "價格由低至高"

	          	show += "</th>"

			  show += "</tr>"

			show += "</table>"
		// show += "</p>"
       
        show += "<a href='javascript:add_other_goods(" + good_type_json.type_id + ")'>"
        show += '更多'
        show += "</a>"       
      show += "</div>"

      show += "<ul id='good_type_ul_top"+ good_type_json.type_id+ "'>"
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

      // 添加下半部商品欄位骨架
      show += "<ul id='good_type_ul_bottom"+ good_type_json.type_id+ "'>"
      show += "</ul>"

    });
    // 將文本轉換為標籤加入元素節點
    $('#index_main').html(show);
  }, 'json');
}

// 加載此商品類型原本加載的其餘所有商品
function add_other_goods(type_id){
  console.log('click~~~')
  $.get('/other_goods/',
  	
  	{'type_id': type_id},
  	
  	function(goods_json){
  	  console.log(goods_json);
  	  
  	  var show = '';
	  $.each(goods_json, function(i,obj){


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
	  // show += "</ul>"

      // jQuery創建對象
	  $show = $(show);
  	
	// 將jQuery對象添加到元素節點裡面
  	$('#good_type_ul_bottom'+type_id).html($show);

  	var more_nav = '';
  	more_nav += '<a href="javascript:add_other_goods(' + type_id + ')">'
    more_nav += '更多'
    more_nav += "</a>"

    var less_nav = '';
  	less_nav += '<a href="javascript:hide_other_goods(' + type_id + ')">'
    less_nav += '隱藏'
    less_nav += "</a>"
    console.log(more_nav);

    // 將更多替換為縮小 同時改變連結觸發的js函數
  	var before = $('#good_type_div'+type_id).html();
  	console.log(before);
  	var after = before.replace(more_nav,less_nav);
  	console.log(after);

  	$('#good_type_div'+type_id).html(after);
  	console.log('click more >>> type_id:', type_id);

  }, 'json');
}

// 隱藏新的添加顯示的商品
function hide_other_goods(type_id){
  console.log('hiding')

  // 隱藏 "更多" 及底部生成的商品元素
  // $('#good_type_ul_bottom'+type_id).remove()
  $('#good_type_ul_bottom'+type_id).css('display','none')

  // 獲取商品類型導航條元素節點內容
  var less_nav = '';
  less_nav += '<a href="javascript:hide_other_goods(' + type_id + ')">'
  less_nav += '隱藏'
  less_nav += "</a>"

  var more_nav = '';
  more_nav += '<a href="javascript:recover_other_goods(' + type_id + ')">'
  more_nav += '更多'
  more_nav += "</a>"

  // 將'縮小'替換為'更多' 同時改變連結觸發的js函數
  var before = $('#good_type_div'+type_id).html();

  var after = before.replace(less_nav,more_nav);

  $('#good_type_div'+type_id).html(after);
}

// 將隱藏的商品恢復回來
function recover_other_goods(type_id){
	// 恢復 "隱藏" 及底部生成的商品元素
	$('#good_type_ul_bottom'+type_id).css('display','block');
  	// 獲取商品類型導航條元素節點內容
  	var more_nav = '';
  	more_nav += '<a href="javascript:recover_other_goods(' + type_id + ')">'
    more_nav += '更多'
    more_nav += "</a>"

    var less_nav = '';
  	less_nav += '<a href="javascript:hide_other_goods(' + type_id + ')">'
    less_nav += '隱藏'
    less_nav += "</a>"

    // 將更多替換為縮小 同時改變連結觸發的js函數
  	var before = $('#good_type_div'+type_id).html();
  	var after = before.replace(more_nav,less_nav);

  	$('#good_type_div'+type_id).html(after);
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
		// 添加完商品後更新購物車顯示數量
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

// 滑鼠移入則執行變色

function mymouse(type_id, desc_or_asc){
	$("#my-mouse-type_id"+ type_id + '_' + desc_or_asc).css('cursor', 'pointer');
}

// # 加載此依照價格排序的所有商品
function get_goods_order(type_id, desc_or_asc){

	// 按下後轉換顏色
  $("#my-mouse-type_id"+ type_id + '_' + desc_or_asc).css('backgroundColor', '#ccc');
  if (desc_or_asc == 'desc'){
  	exchange = 'asc';
  } else{
  	exchange = 'desc';
  }
  $("#my-mouse-type_id"+ type_id + '_' + exchange).css('backgroundColor', 'white');

  // 將更多替換成隱藏
  var more_nav = '';
  more_nav += '<a href="javascript:add_other_goods(' + type_id + ')">'
  more_nav += '更多'
  more_nav += "</a>"

  var less_nav = '';
  less_nav += '<a href="javascript:hide_other_goods(' + type_id + ')">'
  less_nav += '隱藏'
  less_nav += "</a>"


// 將更多替換為縮小 同時改變連結觸發的js函數
  var before = $('#good_type_div'+type_id).html();
  var after = before.replace(more_nav,less_nav);

  $('#good_type_div'+type_id).html(after);

  $.get('/goods_price_order/',
  	{
  		'type_id': type_id,
  		'desc_or_asc': desc_or_asc,
  	},
  	function(goods_json){
    // goods_json 為響應回來的json數據
    var show_top = "";
    var show_bottom = "";

	  $.each(goods_json, function(i,obj){
	  	if (i< 5){
	  	// --------------------------------上半部份--------------------------------
	  	  show_top += "<li "
	  	  if ((i+1)%5==0){
	  	  	show_top += "class='no-margin'";
	  	  }
	  	  show_top += ">"
	  	    show_top += "<p>"
	  	      show_top += "<img src='/"+obj.fields.picture+"'>"
	  	    show_top += "</p>"

	  	    show_top += "<div class='content'>"
	  	    // 拼參數時要注意單雙引號
	  	      show_top += "<a href='javascript:add_cart("+ obj.pk + ', "'+obj.fields.title+'");' +"'>"
	  	        show_top += "<img src='/static/images/cart.png'>"
	  	      show_top += "</a>"
	  	      show_top += "<p>"+obj.fields.title
	  	      show_top += "</p>"
	  	      show_top += "<span>$"+obj.fields.price+'/'+obj.fields.spec
	  	      show_top += "</span>"
	  	    show_top += "</div>"
	  	  show_top += "</li>"
	  	}
	  	// --------------------------------下半部份--------------------------------
	  	else{
      	  

	  	  show_bottom += "<li "
	  	  if ((i+1)%5==0){
	  	  	show_bottom += "class='no-margin'";
		  	  }
		  	  show_bottom += ">"
		  	    show_bottom += "<p>"
		  	      show_bottom += "<img src='/"+obj.fields.picture+"'>"
		  	    show_bottom += "</p>"

		  	    show_bottom += "<div class='content'>"
		  	    // 拼參數時要注意單雙引號
		  	      show_bottom += "<a href='javascript:add_cart("+ obj.pk + ', "'+obj.fields.title+'");' +"'>"
		  	        show_bottom += "<img src='/static/images/cart.png'>"
		  	      show_bottom += "</a>"
		  	      show_bottom += "<p>"+obj.fields.title
		  	      show_bottom += "</p>"
		  	      show_bottom += "<span>$"+obj.fields.price+'/'+obj.fields.spec
		  	      show_bottom += "</span>"
		  	    show_bottom += "</div>"
		  	  show_bottom += "</li>"
	  	}
      });
    // 將文本轉換為標籤加入元素節點
    $('#good_type_ul_top'+type_id).html(show_top);
    $('#good_type_ul_bottom'+type_id).html(show_bottom);
  }, 'json');
}




$(function(){
	// 加載登錄狀態訊息
	check_login();
	// 加載購物車狀態訊息
	cart_status();
	// 加載所有商品類型和商品
	loadGoods();

});



















