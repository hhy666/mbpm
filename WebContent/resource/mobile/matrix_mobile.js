
//定义Matrix对象
function matrix(){}

/*****config*****/
// 指定服务器信息
matrix.SERVER = "192.168.1.103";
//matrix.SERVER = "202.4.130.184";
matrix.PORT = "9090";
matrix.WEB_CONTEXT_PATH = "mofficeV3.1";
matrix.DEFAULT_PAGE_SIZE = 20;
matrix.IS_MOBILE_REQUEST = "is_mobile_request";

matrix.SERVER_PATH;

/*****config end*****/

//定义接口------------------------------------
matrix.getServerPath = function(){
 
	/*
	if(matrix.serverPath != "none")
	
			var url="http://"+location.host+"/"+matrix.WEB_CONTEXT_PATH;
			alert(url);
			return url;
	*/
	return 	matrix.SERVER_PATH;	 
}

matrix.getInnerServerPath = function(){
   var ipValue = matrix.getIpValue();
	if(ipValue == null || ipValue == "null")
	   ipValue = matrix.SERVER;
	var serverPath = "http://";
	serverPath += ipValue;
	serverPath += ":";
	serverPath += matrix.PORT;
	serverPath += "/";
	serverPath += matrix.WEB_CONTEXT_PATH;
	return serverPath;
}

matrix.convertRequestUrl = function(url){
//	var serverPath = matrix.getServerPath();
/*	var serverPath = matrix.getServerPath();
	if(url.indexOf(serverPath)!=0){
		if(url.indexOf("/")!=0){
			url = serverPath+"/"+url;
		}else{
			url = serverPath + url;
		}
	}
*/	
	if(url.indexOf("?")!=-1){
		url+="&"+matrix.IS_MOBILE_REQUEST+"=true";
	}else{
		url+="?"+matrix.IS_MOBILE_REQUEST+"=true";
	}
	
	return url;
}

matrix.sendRequest = function(url,data,successFun,errorFun,dataType,method){
	url = matrix.convertRequestUrl(url);
	if(dataType==null){
		dataType="json";
	}
	if(method==null){
		method = "post";
	}
	if(data==null){
		data = {};
	}
	if (method === 'get') {
		if (dataType === 'json') {
			mui.getJSON(url, data, successFun);
		} else {
			mui.get(url, data, successFun, dataType);
		}
	} else if (method === 'post') {
		mui.post(url, data, successFun, dataType);
	}
}

matrix.log = function(str){
	console.log("******************"+str);
}


/******menu******/
var mshowIndexMenu = false,mindexMenu = null,mindexMask = null;
matrix.initIndexMenu = function(){
	//处理侧滑导航，为了避免和子页面初始化等竞争资源，延迟加载侧滑页面
	setTimeout(function () {
		mindexMenu= mui.preload({
			id: 'mindex-menu',
			url: '../app/index-menu.html',
			styles: {
				left: 0,
				width: '70%',
				zindex: 1
			},
			show:{
				aniShow:'none'
			}
		});
		
		//创建遮罩页面，使用透明webview解决index页面、list页面创建div遮罩不同步的问题；
		//android 4.0以下版本不支持透明webview，故4.0以下暂不遮罩；
		if(parseFloat(mui.os.version)>4.0){
			mindexMask = mui.preload({
				id:"mindex-mask",
				url:"../app/index-mask.html",
				styles:{
					left:'70%',
					width:'30%',
					zindex:2,
					opacity:0.1,
					popGesture:"none"
				}
			});
			matrix.log(mindexMask==null);
		}
		
		//点击左上角侧滑图标，打开侧滑菜单；
		document.querySelector('.mui-icon-bars').addEventListener('tap', function () {
			if(mshowIndexMenu){
				matrix.closeIndexMenu();
			}else{
				matrix.openIndexMenu();
			}
		});
		
		//主界面向右滑动，若菜单未显示，则显示菜单；否则不做任何操作
		window.addEventListener("swiperight",matrix.openIndexMenu);
		//主界面向左滑动，若菜单已显示，则关闭菜单；否则，不做任何操作；
		window.addEventListener("swipeleft",matrix.closeIndexMenu);
		//侧滑菜单触发关闭菜单命令
		window.addEventListener("menu:close",matrix.closeIndexMenu);
		window.addEventListener("menu:open",matrix.openIndexMenu);
		
		//重写mui.menu方法，Android版本menu按键按下可自动打开、关闭侧滑菜单；
		mui.menu = function () {
			if(mshowIndexMenu){
				matrix.closeIndexMenu();
			}else{
				matrix.openIndexMenu();
			}
		}
			
	},200);
}

//显示侧滑菜单
matrix.openIndexMenu = function(){
	if(!mshowIndexMenu){
		//侧滑菜单处于隐藏状态，则立即显示出来；
		mindexMenu.show('none',0,function () {
			//主窗体开始侧滑；
			mui.currentWebview.setStyle({
				left:'70%',
				transition: {
					duration: 150
				}
			});
			mshowIndexMenu = true;
		});
		//显示遮罩
		setTimeout(function () {
			matrix.log("show mask!!");
			mindexMask&&(mindexMask.show('none'));	
		},150);
	}
}



//关闭菜单
matrix.closeIndexMenu = function(){
	if(mshowIndexMenu){
		//关闭遮罩；
		mindexMask&&(mindexMask.hide());
		//主窗体开始侧滑；
		mui.currentWebview.setStyle({
			left: '0',
			transition: {
				duration: 200
			}
		});
		mshowIndexMenu = false;
		//等动画结束后，隐藏菜单webview，节省资源；
		setTimeout(function () {
			mindexMenu.hide();
		},300);	
	}
}
/*****menu end******/


//重写接口------------------------------------
matrix.getParam = function(paramName){

			var url=location.search; 
			var Request = new Object(); 
			if(url.indexOf("?")!=-1) 
			{ 
			var str = url.substr(1); 
			strs= str.split("&"); 
			for(var i=0;i < strs.length; ++i)
			{ 
			Request[strs[i].split("=")[0]]=(strs[i].split("=")[1]); 
			} 
			} 
			var  paramValue = Request[paramName];
			return paramValue;
		}

matrix.getIpValue = function(){
   //return matrix.getCookie('ipValue');
   return "192.168.1.103";
}

matrix.getCookie = function(name){
var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
if(arr=document.cookie.match(reg))
return unescape(arr[2]);
else
return null;
}

//写cookies
matrix.setCookie = function(name,value){
var Days = 30;
var exp = new Date();
exp.setTime(exp.getTime() + Days*24*60*60*1000);
document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString();
}

// 显示按钮提交遮罩
matrix.showMask=function(){
    if(document.getElementById("matrixMask"))
		document.getElementById("matrixMask").style.display="";
	
}
// 隐藏按钮提交遮罩
matrix.hideMask=function(){
	if(document.getElementById("matrixMask"))
		document.getElementById("matrixMask").style.display="none";
}
