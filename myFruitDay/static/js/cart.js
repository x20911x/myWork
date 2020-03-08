$(function(){
  // 進入購物車頁面的時候發起ajax請求加載購物車頁面
  // orders();
});




function orders(){
  $.get('/carts_order/',function(data){
    // data 為響應回來的json數據
    
    var show = ""
    show += '<div class="title">';
      show += '<p class="check-box">';
        show += '<input type="checkbox" id="checkall">';
      show += '</p>';

      show += '<p class="goods">商品</p>';
      show += '<p class="price">單價</p>';
      show += '<p class="quantity">數量</p>';
      show += '<p class="t-sum">小計</p>';
      show += '<p class="action">操作</p>';

    show += '</div>';
    show += '<div id="good-content">';
    $.each(data, function(i,obj){
    // 從obj中取出good, 並轉換為json物件
      var good_json = JSON.parse(obj.good);
      var cart_json = JSON.parse(obj.cart);
        show += '<div class="g-item"' + '>'
          show += '<p class="check-box">'
            show += '<img src="/' + good_json.picture + '" width='+'"80px">'
          show += '</p>';

          show += '<p class="goods">'+good_json.title+'</p>';
          show += '<p class="price">'+good_json.price+'</p>';
          show += '<p class="quantity"'+' name="'+ cart_json.cart_id + '"'+'>'+cart_json.ccount+'</p>';

          show += '<p class="t-sum">'+obj.total_cost+'</p>';
          show += '<p class="action">'
          show += '<span>'
          show += '<input ' + "type='button' value='修改' " + "onclick=modify_cart(" + cart_json.cart_id + ")>"+
          '</input>'
          show += '<input '+"type='button' value='移除' " + "onclick=delete_cart(" + cart_json.cart_id + ")>"+
          '</input>'
          show += '</span>'
          // show += '<a '+"href='javascript:delete_cart(" + cart_json.cart_id + ")'>"+
          // "<button>移除</button>"+'</a>'
          show += '</p>'; 
        show += '</div>';   
    });
    show += '</div>'
    $('#main').html(show);
  }, 'json');  
}



// 刪除購物車項目
function delete_cart(cart_id){
  $.ajaxSettings.async = false;
  if (confirm('確定要刪除?')){
    $.get('/delete_cart/', {'cart_id': cart_id}, function(data){
        console.log('delete successfully');
        alert('刪除成功');
    },'json');

    $.ajaxSettings.async = true;
    // 刪除單項商品後重新刷新訂單欄位
    orders();
    // 重新刷新購物車小圖標的數量
    cart_status();
  }
}


// 修改購物車數量
function modify_cart(cart_id){
  var url = '/modify_cart/' + cart_id + '/';
  $.get(url, {'cart_id':cart_id}, function(data_from_backend){
    console.log('okkkk');
    var html = $('#main').html().replace('<p class="quantity"'+ ' name="'+ cart_id + '"' +'>'+ data_from_backend.ccount +'</p>',
      '<p class="quantity"'+ ' name="'+ cart_id + '"' +'>' + '<input type="text" value="' + data_from_backend.ccount +'" style="width:20px">' + '</p>');
    
    $('#main').html(html);
    
  },'json' );
}