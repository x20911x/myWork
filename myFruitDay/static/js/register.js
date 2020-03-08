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
		console.log('success');

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
		  	console.log('abc');
		  	$('#prompt').html(data.msg);
		  	window.registerStatus = data.status;
		  	console.log(data.status)
		  }, 'json'
		);

    });

	// 為#formReg表單元入綁定submit事件
    $("#formReg").submit(function(){
    // 	// 根據registerStatus的值決定表單是否可以被提交
		if (window.registerStatus == 1){
			console.log('you cannot submit');
			alert('此號碼已經有人註冊')
			return false;}
    	console.log('submit success');
    	return true;
    })
});