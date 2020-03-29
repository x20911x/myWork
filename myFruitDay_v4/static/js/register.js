// method $.ajax 
// $(function(){
// 	$("#uphon").click(function(){
// 		console.log('uuuuuu');
// 		var url ="http://127.0.0.1:8000/loginname-check?loginname=" + $("[name='uphone']").val()
// 		// console.log(url);
// 		$.ajax({
//           url : url,
//           type : 'GET',
//           dataType : 'jsonp',
//           // jsonp : "callback",
//           // jsonCallback : "successCallback",
//           success:function(data){
//           	$('#prompt').html(data.msg)
//           }
//         });
// 	});
// });


$(function(){
	// 判斷註冊號碼是否重複
	$("[name='uphone']").blur(function(){
		window.registerStatus = 1;
		// 如果文本框內沒有任何東西
		if ($(this).val().trim().length == 0){
			return;
		}
		// 發送ajax請求判斷是否重複uphone
		$.get(
		  '/loginname-check/',
		  {'loginname' :$(this).val()},
		  function(data){

		  	$('#prompt').html(data.msg);
		  	// 獲取是否可以的註冊的認證碼
		  	window.registerStatus = data.status;
		  	console.log(data.status)
		  }, 'jsonp'
		);
    });
	// 判斷email是否重複
	$("[name='uemail']").blur(function(){
		console.log('detecting');
		window.emailStatus = 1;
		// 如果文本框內沒有任何東西
		if ($(this).val().trim().length == 0){
			return;
		}
		// 發送ajax請求判斷是否重複email
		$.get(
		  '/email-check/',
		  {'uemail' :$(this).val()},
		  function(data){

		  	$('#prompt-email').html(data.msg);
		  	// 獲取是否可以的註冊的認證碼
		  	window.emailStatus = data.status;
		  }, 'json'
		);
    });









	// 為#formReg表單元入綁定submit事件
    $("#formReg").submit(function(){

    	window.length = 0;
    	window.emailStatus=1;
    	$.ajaxSettings.async = false;
    	$.get(
		  '/email-check/',
		  {'uemail' :$("[name='uemail']").val()},
		  function(data){
		  	$('#prompt-email').html(data.msg);
		  	// 獲取是否可以的註冊的認證碼
		  	window.emailStatus = data.status;
		  	console.log('window.emailStatus',window.emailStatus);
		  }, 'json'
		);

	// 根據Status的值決定表單是否可以被提交
		if (window.registerStatus == 1){
			console.log('you cannot submit');
			alert('此號碼已經有人註冊')
			return false;}
		if (window.emailStatus == 1){
			console.log('you cannot submit');
			alert('此Email已經有人註冊')
			return false;}
		// 判斷兩次密碼是否為一致
		if ($('[name=upwd]').val() != $('[name=upwd2]').val()){
			console.log('you cannot submit');
			alert('密碼不一致');
			return false;}
		// 判斷兩次密碼是否為一致
		if ($('[name=upwd]').val().length < 8 ){
			console.log('you cannot submit');
			alert('密碼長度不可以小於8個字符');
			return false;}


		// 查看是否有欄位為空
		$('input[class=input1]').each(function(i){
			if ($(this).val() == null || $(this).val() == ''){
				window.length += 1;
			} 	
		})
		if (window.length >0){
			alert('欄位不可為空')
			return false;		
		} else {
			console.log('else')
			return true;
		}	

    })
});