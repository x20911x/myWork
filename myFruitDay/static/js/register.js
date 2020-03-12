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
	$("[name='uphone']").blur(function(){
		window.registerStatus = 1;
		// 如果文本框內沒有任何東西
		if ($(this).val().trim().length == 0){
			return;
		}
		// var url ="http://127.0.0.1:8000/loginname-check?loginname=" + $("[name='uphone']").val()
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

	// 為#formReg表單元入綁定submit事件
    $("#formReg").submit(function(){
    	console.log($('[class=input1]'));
    // 	// 根據registerStatus的值決定表單是否可以被提交
		if (window.registerStatus == 1){
			console.log('you cannot submit');
			alert('此號碼已經有人註冊')
			return false;}

		$('input[class=input1]').each(function(i){
			if ($(this).val() == null || $(this).val() == ''){
				alert('欄位不可空白');
				return false;
			}
		})


    	return true;
    })
});