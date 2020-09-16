function StartBrowserBeforeCheck(aurl)	
{
			$.ajax({  
				type: "get",  
				async: false,  
				url: "http://127.0.0.1:9588/LongListen?id=111", 
				jsonp: "hookback",
				dataType: "jsonp",  
				success: function(data){
					Link(aurl, 4);
					//StartBrowser(aurl,4);
				},  
				error: function(){  
					alert('金格浏览器没有安装');  
				}  
			}); 
			
			// ie 8+, chrome and some other browsers
			var head = document.head || $('head')[0] || document.documentElement;// code from jquery
			var script = $(head).find('script')[0];
			script.onerror = function(evt) 
			{ 
				alert('金格浏览器没有安装');  
				// do some clean  
				// delete script node  
				if (script.parentNode) 
				{     
					script.parentNode.removeChild(script);
				}
				// delete jsonCallback global function
				var src = script.src || '';  
				var idx = src.indexOf('hookback='); 
				if (idx != -1) 
				{
					var idx2 = src.indexOf('&');
					if (idx2 == -1)
					{     
						idx2 = src.length;
					}      
					var hookback = src.substring(idx + 13, idx2);
					delete window[hookback];
				}
			}; 					
			 
}
function Link(url,skin) {
	var link = "KGBrowser://$link:"+url+"$skin="+skin+"$tabshow=1" + "$single=1";   // skin  0灰色 1蓝色 2黄色 3绿色 4红色 
	location.href = link;
	connect();
}
function StartBrowser(weburl, skin){
	urlString = "http://127.0.0.1:9588/StartBrowser?weburl="+ weburl + "$skin=" + skin;

	$.ajax({
		type : "get",
		async : false,
		url : urlString,
		jsonp : "hookback",
		dataType : "jsonp",
		success : function(data) {
			var jsonobj = eval(data);
			connect();
		},
		error : function() {
		}
	});
}
function connect() //与金格浏览器页面通讯使用
{
	$.ajax({
		type : "get",
		async : false,
		url : "http://127.0.0.1:9588/LongListen?id=111", //此代码ip固定，端口号与Edit页面该方法一致，其他固定。
		jsonp : "hookback",
		dataType : "jsonp",
		success : function(data) {
			var jsonobj = eval(data);
			if (jsonobj.ret == "save") { //此判断处理Edit页面Msg传过来的值，判断之后下面做响应处理即可
				//	alert("save");
				setTimeout("location.reload();", 100);
			}
			if (jsonobj.ret == "returnlist") { //此判断处理Edit页面Msg传过来的值，判断之后下面做响应处理即可
				//alert("returnlist");
				setTimeout("location.reload();", 100);
			} else if (jsonobj.ret == "none") {
				connect(); //这里一定要调用，不可删除
			}
		},
		error : function(a, b, c) {
		}
	});
}