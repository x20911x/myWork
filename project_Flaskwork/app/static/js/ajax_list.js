function loadTopic(pid){
  $.ajax({
    url:'http://127.0.0.1:5000/list_data?pid='+pid,
    type:'get',
    dataType:'jsonp',
    // 這個地方使用同步 確保獲取json數據後再往下執行,
    async:false,

    success:function(data){
      var html="";
      console.log('loadfuncing');
      $.each(data,function(i,obj){
        var html_list1 = ('<div class="blogs" data-scroll-reveal="enter bottom over 1s">'+
      
        '<h3 class="blogtitle"><a href="info?topic_id='+
        obj.id+'" target="_blank">'+ obj.title + '</a></h3>');

        var html_list2 = ('<span class="blogpic">'+
        '<a href="info?topic_id='+
        obj.id+
        '" title="">'+
        '<img src="/static/'+
        obj.images +
        '" alt=""></a></span>');

        var html_list3 = ('<p class="blogtext">'+obj.content.substring(0,200) + '...</p>'+
          '<div class="bloginfo"><ul><li class="author"><a href="info.html">'+
          obj.user_uname+
          '</a></li>' + '<li class="lmname"><a href="info.html">' +
          obj.category_cate_name +
          '</a></li>' +
          '<li class="timer">' +
          obj.pub_date.slice(0,11)+
          '</li><li class="view"><span>'+
          obj.read_num+
          '</span>人氣</li>'+
          '</ul></div></div>');


        html += (html_list1+html_list2+html_list3);
        // html += "<p>" + obj.id + "</p>"; 
        // html += "<p>" + obj.blogtype_id + "</p>";
        // html += "<p>" + obj.category_id + "</p>";
        // html += "<p>" + obj.user_id + "</p>";
        // html += "<p>" + obj.content + "</p>";
        // html += "<p>" + obj.pub_date + "</p>";
      });  
      console.log(html);
      $("#topic_list").html(html);
      console.log(html);
    }   
  });
};


$(function(){

      $("#category").change(function(){
        // console.log('success');
        // console.log(this.value, typeof this.value);
        loadTopic(this.value);
      });
    });