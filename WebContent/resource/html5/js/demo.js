

function Matrix(){}

function GetUrlParam(name)
{
     var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
     var r = window.location.search.substr(1).match(reg);
     if(r!=null)return  unescape(r[2]); return null;
}
/*
Matrix.closeLayerWindow = function(data,operationType){
	var iframewindowid = GetUrlParam("iframewindowid");
	var closeFunction;
	closeFunction = eval("parent.on"+iframewindowid+"Close");
	if(closeFunction){
		   var result = closeFunction(data,operationType);
		   if( result == null || result == true){
	 var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
	 parent.layer.close(index);
		   }
	}else{
		 var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
	     parent.layer.close(index);
	}
	
}*/
Matrix.closeLayerWindow = function(data,operationType){
	var iframewindowid = GetUrlParam("iframewindowid");
	var closeFunction;
	closeFunction = eval("parent.on"+iframewindowid+"Close");
	var targetWindow=parent.layer.target;
	if(targetWindow!=null&&typeof(targetWindow) != "undefined"){
		targetWindow.eval("on"+iframewindowid+"Close")(data,operationType);
		 if( result == null || result == true){
			 var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
			 parent.layer.close(index);
		 }
	}else{
	if(closeFunction){
		   var result = closeFunction(data,operationType);
		   if( result == null || result == true){
	 var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
	 parent.layer.close(index);
		   }
	}else{
		 var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
	     parent.layer.close(index);
	}
	}
	
}