
var matrixMonitorXmlHttp;

// 构造getXmlHttpObject方法
function getXmlHttpObject(){
	var tempXmlHttp;
	try{
		tempXmlHttp = new XMLHttpRequest();
	}catch (e){
		try{
			tempXmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
		}catch (e){
			try{
				tempXmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}catch (e){
				alert("您的浏览器不支持AJAX！");
				return false;
			}
		}
	}
	return tempXmlHttp;
}


// 构造getNewMonitor方法
function showMatrixMonitorLayer(monitorDivId,monitorLayerId,url){
	matrixMonitorXmlHttp = getXmlHttpObject();
	if(!matrixMonitorXmlHttp){
		alert("你的浏览器不支持AJAX！");
		return;
	}
	var monitorLayer = document.getElementById(monitorLayerId);
	if(monitorLayer){
		// 如当前监控图已存在则直接显示
		monitorLayer.style.display = "";
		return;
	}
	matrixMonitorXmlHttp.onreadystatechange = function(){createMatrixMonitorLayer(monitorDivId);};
	matrixMonitorXmlHttp.open("POST",url,true);
	matrixMonitorXmlHttp.send(null);
}

// 构造createMatrixMonitorLayer方法
function createMatrixMonitorLayer(monitorDivId){
	if(matrixMonitorXmlHttp.readyState==4){
		if(matrixMonitorXmlHttp.status == 200){
			var monitorDiv = document.getElementById(monitorDivId);
			var result = matrixMonitorXmlHttp.responseText;
			monitorDiv.innerHTML = monitorDiv.innerHTML + result; 
		}else{
			alert("HTTP 错误，状态码：" + matrixMonitorXmlHttp.status);
		}
	}
}

// 构造hideMatrixMonitorLayer方法
function hideMatrixMonitorLayer(monitorLayerId){
	var monitorLayer = document.getElementById(monitorLayerId);
	if(monitorLayer){
		// 隐藏监控层
		monitorLayer.style.display = "none";
	}
}