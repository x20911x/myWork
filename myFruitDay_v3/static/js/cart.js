$(function(){

  // 加載登錄狀態訊息
  check_login();
  // 加載購物車狀態訊息
  cart_status();
  // 進入購物車頁面的時候發起ajax請求加載購物車頁面
  orders();

  // $('input[name="'+cart_id+ '"]').change(function(){

  //   var ccount = $('input[name="'+cart_id+ '"]').val();
  //   console.log('ccount:',ccount);

  //   // 如果文本框內沒有任何東西
  //   if ($(this).val().trim().length == 0){
  //     return;
  //   }
  // });
});

// 進入購物車頁面的時候發起ajax請求加載購物車頁面
function orders(){
  $.ajaxSettings.async = false;
  $.get('/carts_order/',function(data){
    // data 為響應回來的json數據
    
    var show = ""
    show += '<div class="title">';
      show += '<p class="check-box">圖片</p>';
        // show += '<input type="checkbox" id="checkall">';
      show += '<p class="goods">商品</p>';
      show += '<p class="price">單價</p>';
      show += '<p class="quantity">數量</p>';
      show += '<p class="t-sum">小計</p>';
      show += '<p class="action">操作</p>';

    show += '</div>';
    show += '<div id="good-content">';
    $.each(data, function(i,obj){
    // 從obj中取出good和cart, 並轉換為json物件
      var good_json = JSON.parse(obj.good);
      var cart_json = JSON.parse(obj.cart);
        show += '<div class="g-item"' + '>'
          show += '<p class="check-box">'
            show += '<img src="/' + good_json.picture + '" width='+'"80px">'
          show += '</p>';

          show += '<p class="goods">' + good_json.title+'</p>';
          show += '<p class="price"' + ' id="single_price_' + cart_json.cart_id + '">' + good_json.price+'</p>';
          show += '<p class="quantity"' + ' name="'+ cart_json.cart_id + '">'+cart_json.ccount+'</p>';
          show += '<p class="t-sum"' + ' id="total_cost_'+ cart_json.cart_id + '"' + '>' + obj.total_cost + '</p>';

          show += '<p class="action">'

            show += '<input ' + "type='button' value='修改' " + "onclick=modify_cart(" + cart_json.cart_id + ")>"+
            '</input>'
            show += '<input '+"type='button' value='移除' " + "onclick=delete_cart(" + cart_json.cart_id + ")>"+
            '</input>'

          show += '</p>'; 
        show += '</div>';  
  
    });
    show += '<div id="cart_bottom" class="g-item">'
    
    show += '<p class="check-box"></p>'
    show += '<p class="goods">您的消費金額一共是: </p>'
    show += '<p class="t-sum"><b id="all_cost">$169</b></p>'
    show += '<p class="action"><input type="button"' + 'value="匯出csv"' +
    ' onclick="javascript:location.href=' +"'/csv'"+'"></p>'

    show += '</div>'

    // 將文本轉換為標籤加入元素節點
    $('#main').html(show);;
    // 計算總金額
    getTotalCost()
  }, 'json');  
}

// 點擊按鈕時觸發 刪除購物車項目
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


// 點擊按鈕時觸發 修改購物車數量
// function modify_cart(cart_id){
//   var url = '/modify_cart/' + cart_id + '/';
//   $.get(url, {'cart_id':cart_id}, function(data_from_backend){
//     console.log('正在修改的cart_id:',cart_id,'數量為',data_from_backend.ccount);
//     var before = $('#main').html();

//     var modifying_element = $('.quan_text').get();
//     console.log('modifying_element>>>', modifying_element);
    
//     var after = before.replace(
//       // 原本的商品數量標籤
//       '<p class="quantity"'+ ' name="'+ cart_id + '"' +'>'+ data_from_backend.ccount +'</p>',

//       // 取代後的商品數量標籤
//       '<p class="quantity"'+ ' name="'+ cart_id + '"' +'>' + 

//       // 加法按鈕的文本框
//       '<input class="button" type="button" style="width:20px" value="+" onclick="plusFunc(' + cart_id + ')">' +

//       // 中間的商品數量文本框
//       '<input id="ccount"' + ' name="' + cart_id + '"' + ' oninput="modifyDetect();"'+

//       ' class="quan_text" type="text" value="' + 

//       data_from_backend.ccount +'" style="width:20px">' +

//       // 加法按鈕的文本框
//       '<input class="button" type="button" style="width:20px" value="-" onclick="minusFunc(' + cart_id + ')">' +

//       '</p>');
      
//     if (before != after){
//       $('#main').html(after); 
//     }
      
//     console.log('正在修改的cart_id:',cart_id,'數量為',data_from_backend.ccount);

//     console.log(before==after);
//   },'json' );
// }

// --------------------------------------------------
// 點擊按鈕時觸發 修改購物車數量
function modify_cart(cart_id){
  var modifying_element = $('.quan_text');
  console.log(modifying_element);
  // 遍歷所有修改中元素
      // 如果非正在修改的 則替換回不可更動的數字
      if(modifying_element.attr('name')!=cart_id){
          var url = '/modify_cart/' + modifying_element.attr('name') + '/';

          $.get(url,{'cart_id':modifying_element.attr('name')},function(data_from_backend){
              console.log(data_from_backend);
              console.log("不為正在修改的商品為:",modifying_element.attr('name'),"數量為:",data_from_backend.ccount);
              var before = $('#main').html();
              var after = before.replace(
                  '<p class="quantity"' + ' name="' + modifying_element.attr('name') + '"' + '>' +
                    '<input class="button" type="button" value="+" onclick="plusFunc('+ modifying_element.attr('name') +')">' +
                   '<input' + ' name="' + modifying_element.attr('name')+ '"' + ' id="ccount" class="quan_text" type="text" oninput="modifyDetect();" value="' + modifying_element.attr('value') +'">' +
                   '<input class="button" type="button" value="-" onclick="minusFunc(' + modifying_element.attr('name') + ')">' +
                   '</p>',
                   '<p class="quantity"'+ ' name="'+ modifying_element.attr('name') + '"' +'>'+ data_from_backend.ccount +'</p>'
                );

              $('#main').html(after);
          },'json');

      }
      // 如果元素為正在更改的 則修改為資料庫更新後最新的數據
      // else if($(obj).attr('name')==cart_id){
      //   var url = '/modify_cart/' + cart_id + '/';
      //   $.get(url,{'cart_id':cart_id},function(data_from_backend){
      //     //console.log("正在修改而且增加或減少數量的商品為:",cart_id,"數量為:",data_from_backend.ccount);
      //     var before = $('#main').html();
      //     var after = before.replace(
      //         '<input' + ' name="' + $(obj).attr('name')+ '"' + ' id="ccount" class="quan_text" type="text" value="' + $(obj).attr('value') +'" style="width:20px">',
      //         '<input' + ' name="' + $(obj).attr('name')+ '"' + ' id="ccount" class="quan_text" type="text" value="' + data_from_backend.ccount +'" style="width:20px">'
      //       );
      //     $('#main').html(after);

      //   },'json');
      // }

  
  var not_modifying_element = $('.quantity').get();
  var changeNotList = [];
  $.each(not_modifying_element,function(i,obj){
      var url = '/modify_cart/' + cart_id + '/';
      // if($(obj).attr('name')==cart_id & changeNotList.indexOf($(obj).attr('name'))<=-1){
          $.get(url,{'cart_id':cart_id},function(data_from_backend){

            console.log('<p class="quantity"'+ ' name="'+ cart_id + '"' +'>'+ $(obj).text() +'</p>');
              // console.log("正在修改的商品為:",cart_id,"數量為:",data_from_backend.ccount);
              var before = $('#main').html();
              var after = before.replace(
            '<p class="quantity"'+ ' name="'+ cart_id + '"' +'>'+ $(obj).text() +'</p>',

            '<p class="quantity"'+ ' name="'+ cart_id + '"' +'>' + 
            '<input class="button" type="button" value="+" onclick="plusFunc(' + cart_id + ')">' +
            '<input' + ' name="' + cart_id + '"' + ' id="ccount" class="quan_text" type="text" oninput="modifyDetect();" value="' + data_from_backend.ccount +'">' +
            '<input class="button" type="button" value="-" onclick="minusFunc(' + cart_id + ')">' +
            '</p>');
            $('#main').html(after);
          },'json');

      changeNotList.push($(obj).attr('name'));
      
  });
}
// -------------------------------------------------------

// 在前端計算總金額
function getTotalCost(){
  var total_cost_list = $('[id^=total_cost_]');
  var total_cost = 0;

  $('[id^=total_cost_]').each(function(i){

    total_cost += Number($(this).html());
    // console.log(i,':',$(this).html())
  });

  $('#all_cost').html(total_cost.toFixed(1));
}






// 購物車數量加法
function plusFunc(cart_id){
  // 將修改資訊存入資料庫
  modify_cart_account_in_database(cart_id, 'A',1)
  console.log('plus~~~~~');
  console.log('cart_id:',cart_id);
  // 若點擊則數量顯示+1

  // 為商品數量文本框+1
  $('input[name="'+cart_id+ '"]').val(Number($('input[name="'+cart_id+ '"]').val())+1);

  // 修改總價格的欄位  商品數量 * 價格

  // 商品單價
  var price = Number($('#single_price_'+cart_id).html());
  // 商品數量 
  var ccount = $('input[name="'+cart_id+ '"]').val();

  // 商品數量 * 價格
  var total_cost = ccount * price;
  
  // 找到該筆訂單的價格 將它更新為新的價格
  console.log('total_cost:', total_cost);
  // 將價格欄位修改維新的價格
  $('#total_cost_'+cart_id).html(total_cost.toFixed(1));

  getTotalCost()

}
// 購物車數量減法
function minusFunc(cart_id){

  console.log('minus~~~~');
  // 若點擊則數量顯示-1
  if (Number($('input[name="'+cart_id+ '"]').val()) > 1) {
    // 將修改資訊存入資料庫
    modify_cart_account_in_database(cart_id, 'M',-1)

    $('input[name="'+cart_id+ '"]').val(Number($('input[name="'+cart_id+ '"]').val())-1);

    // 修改總價格的欄位  商品數量 * 價格
    // 商品單價
    var price = Number($('#single_price_'+cart_id).html());
    // 商品數量 
    var ccount = $('input[name="'+cart_id+ '"]').val();
    // 總價格
    var total_cost = ccount * price;
    
    // 找到該筆訂單的價格 將它更新為新的價格
    // console.log('total_cost:', total_cost);
    // 將價格欄位修改維新的價格
    $('#total_cost_'+cart_id).html(total_cost.toFixed(1));
    getTotalCost()
    }
}

// 增減數量時 發送請求修改資料庫購物車數量
function modify_cart_account_in_database(cart_id, add_minus,value){
  var url = '/modify_cart/' + cart_id + '/';
  $.ajaxSettings.async = false;
  $.get(url,

    {'add_minus':add_minus,
      'value':value
  },

    function(data){
    console.log('add');
    },
   'json');
}

function modifyDetect(){
  var inputvalue = $('#ccount').val();
  var cart_id = $('#ccount').attr('name');
  modify_cart_account_in_database(cart_id, 'I',inputvalue);
  
  var url = '/modify_cart/' + cart_id + '/';
  $.get(url,{'cart_id':cart_id},function(data_from_backend){
      var ccount = data_from_backend.ccount;
      var price = Number($('#single_price_'+cart_id).html());
      var total_cost = price * ccount;
      $('#total_cost_'+cart_id).html(total_cost.toFixed(1));
      getTotalCost();
  },'json');
}