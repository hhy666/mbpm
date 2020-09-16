<!DOCTYPE html>
<%@page import="com.matrix.api.identity.MFUser"%>
<%@page import="com.matrix.engine.foundation.config.MFSystemProperties"%>
<%@page import="com.matrix.client.ClientConstants"%>
<%@page import="com.matrix.api.MFExecutionService"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page
	import="com.matrix.client.foundation.function.action.FunctionHelper"%>
<%@ page import="java.util.*"%>
<%@ page import="commonj.sdo.*"%>

<html>


<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<link
	href="<%=request.getContextPath()%>/form/admin/main/css/bootstrap.css"
	rel="stylesheet">
<link
	href="<%=request.getContextPath()%>/form/admin/main/css/font-awesome.min.css"
	rel="stylesheet">
<link
	href="<%=request.getContextPath()%>/form/admin/main/css/animate.min.css"
	rel="stylesheet">
<link
	href="<%=request.getContextPath()%>/form/admin/main/css/style.min.css"
	rel="stylesheet">

<link href="<%=request.getContextPath()%>/form/admin/main/css/menu.css"
	rel="stylesheet">
</head>

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resource/css/reset.css" />
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resource/css/style.css" />
<link href='<%=request.getContextPath() %>/resource/html5/css/skin/mCustom_<%=session.getAttribute("skin") %>.css' rel="stylesheet"></link>
<title>Matrix BPM</title>

<jsp:include page="/form/admin/common/taglib.jsp" />
<jsp:include page="/form/admin/common/resource.jsp" />
</head>
<script src="<%=request.getContextPath()%>/resource/html5/js/jquery.min.js"></script>
<style>
.msg_system_box_main:hover {
	background: rgb(252, 240, 193);
}

#message:hover {
	background: url(<%= request.getContextPath ()%>/resource/images/index_message_hover.png)
		no-repeat;
}

#message {
	width: 42px;
	height: 41px;
	position: absolute;
	right: 15px;
	bottom: 40px;
	background: url(<%= request.getContextPath ()%>/resource/images/index_message.png)
		no-repeat;
	z-index: 200;
	cursor: pointer;
	-moz-border-top-left-radius: 1000px;
	-khtml-border-top-left-radius: 1000px;
	-webkit-border-top-left-radius: 1000px;
	border-top-left-radius: 1000px;
}

.msg_remind {
	width: 11px;
	height: 11px;
	background: url(<%= request.getContextPath ()%>/resource/images/msg_remindIco.png)
		no-repeat;
	display: inline-block;
	position: absolute;
	top: 6px;
	left: 30px;
}

.bottom_msg {
	bottom: 0;
}

.pop_msg {
	width: 302px;
	height: auto;
	background: #fff;
	padding: 1px;
	position: absolute;
	right: 15px;
	z-index: 99999;
	display: none;
	-moz-box-shadow: 0px 0px 10px #333;
	-webkit-box-shadow: 0px 0px 10px #333;
	box-shadow: 0px 0px 10px #333;
}

/*
.pop_msg_top {
	width: 302px;
	height: 45px;
	background: #5ba0d0;
	overflow: hidden;
	position: relative;
}
*/

.pop_msg_top span {
	margin-top: 13px;
	font-size: 12px;
	color: #fff;
}

.pop_top_title {
	width: 120px;
	height: 20px;
	text-align: center;
	display: inline-block;
	line-height: 20px;
	cursor: pointer;
}

.margin_l_5 {
	margin-left: 5px;
}

.margin_l_5 {
	margin-left: 5px;
}

.pop_msg_top_sm {
	width: 80px;
	height: 80px;
	background:
		url("<%=request.getContextPath()%>/resource/images/message_close.png");
	border-radius: 50px;
	-moz-border-radius: 50px;
	position: absolute;
	right: -40px;
	top: -40px;
	cursor: pointer;
}

.pop_msg_top_sm span {
	filter: alpha(opacity = 70);
	-moz-opacity: 0.7;
	opacity: 0.7;
	position: absolute;
	top: 40px;
	left: 15px;
	display: inline-block;
	width: 16px;
	height: 3px;
	border-bottom: 3px solid #fff;
}

.pop_msg_top span {
	margin-top: 13px;
	font-size: 12px;
	color: #fff;
}

.msg_pop_titlecurrent {
	color: #fff;
	font-size: 36px;
	position: absolute;
	top: 27px;
	left: 37px;
	overflow: hidden;
}

.msg_system_box {
	width: 300px;
	height: auto;
}

.msg_main_box {
	width: 100%;
	height: auto;
	max-height: 280px;
	overflow-x: hidden;
	overflow-y: auto;
	position: relative;
}

.msg_system_box_main {
	height: auto;
	padding: 8px 16px;
	cursor: pointer;
}

.msg_ca_7, .msg_ca_8, .msg_ca_9, .msg_ca_10 {
	width: 24px;
	height: 24px;
	display: inline-block;
	background: url("<%=request.getContextPath()%>/resource/images/icon24.png")
		no-repeat;
	background-position: -96px -192px;
}

.msg_ca_6, .msg_ca_29 {
	width: 24px;
	height: 24px;
	display: inline-block;
	background: url("<%=request.getContextPath()%>/resource/images/icon24.png")
		no-repeat;
	background-position: -72px -192px;
}

.msg_ca_1 {
	width: 24px;
	height: 24px;
	display: inline-block;
	background: url("<%=request.getContextPath()%>/resource/images/icon24.png")
		no-repeat;
	background-position: 0px -192px;
}

.msg_ca_2 {
	width: 24px;
	height: 24px;
	display: inline-block;
	background: url("<%=request.getContextPath()%>/resource/images/icon24.png")
		no-repeat;
	background-position: -24px -192px;
}

.msg_ca_4, .msg_ca_16, .msg_ca_19, .msg_ca_20, .msg_ca_21, .msg_ca_22,
	.msg_ca_23, .msg_ca_24, .msg_ca_34 {
	width: 24px;
	height: 24px;
	display: inline-block;
	background: url("<%=request.getContextPath()%>/resource/images/icon24.png")
		no-repeat;
	background-position: -48px -192px;
}

.msg_ca_6, .msg_ca_29 {
	width: 24px;
	height: 24px;
	display: inline-block;
	background: url("<%=request.getContextPath()%>/resource/images/icon24.png")
		no-repeat;
	background-position: -72px -192px;
}

.msg_ca_7, .msg_ca_8, .msg_ca_9, .msg_ca_10 {
	width: 24px;
	height: 24px;
	display: inline-block;
	background: url("<%=request.getContextPath()%>/resource/images/icon24.png")
		no-repeat;
	background-position: -96px -192px;
}

.msg_ca_26 {
	width: 24px;
	height: 24px;
	display: inline-block;
	background: url("<%=request.getContextPath()%>/resource/images/icon24.png")
		no-repeat;
	background-position: -120px -192px;
}

.msg_ca_31 {
	width: 24px;
	height: 24px;
	display: inline-block;
	background: url("<%=request.getContextPath()%>/resource/images/icon24.png")
		no-repeat;
	background-position: -168px -192px;
}

.msg_ca_32 {
	width: 24px;
	height: 24px;
	display: inline-block;
	background: url("<%=request.getContextPath()%>/resource/images/icon24.png")
		no-repeat;
	background-position: -192px -192px;
}

.msg_ca_u8 {
	width: 24px;
	height: 24px;
	display: inline-block;
	background: url("<%=request.getContextPath()%>/resource/images/icon24.png")
		no-repeat;
	background-position: -216px -192px;
}

.msg_ca_nc {
	width: 24px;
	height: 24px;
	display: inline-block;
	background: url("<%=request.getContextPath()%>/resource/images/icon24.png")
		no-repeat;
	background-position: -240px -192px;
}

.msg_ca_3 {
	width: 24px;
	height: 24px;
	display: inline-block;
	background: url("<%=request.getContextPath()%>/resource/images/icon24.png")
		no-repeat;
	background-position: -264px -192px;
}

.msg_ca_11, .msg_ca_30 {
	width: 24px;
	height: 24px;
	display: inline-block;
	background: url("<%=request.getContextPath()%>/resource/images/icon24.png")
		no-repeat;
	background-position: -288px -192px;
}

.msg_ca_5 {
	width: 24px;
	height: 24px;
	display: inline-block;
	background: url("<%=request.getContextPath()%>/resource/images/icon24.png")
		no-repeat;
	background-position: -288px -192px;
}

.msg_ca_12, .msg_ca_13, .msg_ca_14, .msg_ca_15, .msg_ca_17, .msg_ca_27,
	.msg_ca_35 {
	width: 24px;
	height: 24px;
	display: inline-block;
	background: url("<%=request.getContextPath()%>/resource/images/icon24.png")
		no-repeat;
	background-position: 0px -216px;
}

.msg_system_main_right {
	width: 230px;
	height: auto;
	float: left;
	margin-left: 10px;
	color: #010101;
	font-size: 12px;
}

.msg_system_main_right_main {
	width: 230px;
	height: auto;
	/* max-height: 65px; */
	position: relative;
	overflow: hidden;
	table-layout: fixed;
	word-break: break-all;
	overflow: hidden;
	line-height: 18px;
}

.msg_ico_1 {
	width: 26px;
	height: 18px;
	background: url(<%= request.getContextPath ()%>/resource/images/msg_sm_1.png);
	position: absolute;
	top: 0px;
	right: 0px;
	display: none;
}

.msg_system_main_right_info {
	width: 230px;
	height: 14px;
	text-align: right;
	color: #a3a3a3;
	margin-top: 5px;
}

.left {
	float: left;
}

.msg_date {
	margin-left: 15px;
}

.right {
	float: right;
}

.clear {
	clear: both;
}

.msg_line {
	width: 270px;
	height: 1px;
	border-bottom: 1px solid #d9d9d9;
	margin-left: 16px;
}

.msg_setting {
	width: 302px;
	height: 35px;
	background: #d1d1d1;
}

.msg_setting_look {
	margin-top: 10px;
	margin-right: 20px;
	float: right;
	text-align: right;
}

.msg_setting_font {
	color: #111111;
	font-size: 12px;
	width: 70px;
	height: 15px;
	text-shadow: 1px 1px 1px #fff;
	cursor: pointer;
}

.msg_setting_ignore {
	margin-top: 10px;
	float: left;
}

.msg_setting_font {
	color: #111111;
	font-size: 12px;
	width: 70px;
	height: 15px;
	text-shadow: 1px 1px 1px #fff;
	cursor: pointer;
}

.msg_ico_2 {
	width: 26px;
	height: 18px;
	background: url(<%= request.getContextPath ()%>/resource/images/msg_sm_2.png);
	position: absolute;
	top: 0px;
	right: 0px;
	display: none;
}

.msg_ico_1 {
	width: 26px;
	height: 18px;
	background: url(<%= request.getContextPath ()%>/resource/images/msg_sm_1.png);
	position: absolute;
	top: 0px;
	right: 0px;
	display: none;
}
.dropdown-menu {
    min-width: 100px;
    border: medium none;
    display: none;
    float: left;
    font-size: 12px;
    left: 0;
    list-style: none outside none;
    padding: 0;
    position: absolute;
    text-shadow: none;
    top: 100%;
    z-index: 1000;
    border-radius: 0;
    box-shadow: 0 0 3px rgba(86,96,117,.3);
    background-color: white;
}
.dropdown-menu> li > a:hover, .dropdown-menu> li > a:focus {
    color: #262626;
    text-decoration: none;
    background-color: rgba(13,179,166,.1);
}
</style>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resource/js/office.js"></script>
<script>
	function showhul(obj){
	var nodes=obj.getElementsByTagName("div");
	obj.style.backgroundColor='rgb(252, 240, 193)';
	for(var i=0;i<nodes.length;i++){
	if(nodes[i].className=='msg_ico_1'){
	nodes[i].style.display="block";
	break;
	}
	}
	}
		function hidehul(obj){
	var nodes=obj.getElementsByTagName("div");
	obj.style.backgroundColor='#FFFFFF';
	for(var i=0;i<nodes.length;i++){
	if(nodes[i].className=='msg_ico_1'){
	nodes[i].style.display="none";
	break;
	}
	}
	}
	//显示忽略小图标滑过样式
	function showhul2(obj,event){
	 if (event) //停止事件冒泡
     event.stopPropagation();
    else
     window.event.cancelBubble = true;
     var nextobj = obj.nextSibling;
     nextobj.style.display = "block";
     obj.style.display = "none";
	}
	//隐藏忽略小图标划过样式
	function hidehul2(obj,event){
	 if (event) //停止事件冒泡
     event.stopPropagation();
    else
     window.event.cancelBubble = true;
     var preobj = obj.previousSibling;
     preobj.style.display = "block";
     obj.style.display = "none";
	}

	//初始
	function initLoadFunc(){
		//初始默认加载个人空间(设置底色)
		//document.getElementById('personcontent').style.background  = "#7abee1";
		//消息
		refreshMessage();
	}
	function updateMessageState(messageId){
		if(messageId!=null && messageId.length>0){
				// 更新状态
				var updateStatusUrl = "<%=request.getContextPath()%>/foundation/message_updateMessageStatus.action?messageId="+messageId;
				Matrix.sendRequest(updateStatusUrl,null,function(){});
			}
	}
	function allReaded(){
	var updateStatusUrl = "<%=request.getContextPath()%>/foundation/message_updateAllReaded.action";
				Matrix.sendRequest(updateStatusUrl,null,function(){
					document.getElementById("bottom_msg").style.display="none";
					document.getElementById('msgremind').style.display="none";
					});
	}
	//function newColl(){
//sysType  1 系统类型 2 应用类型  协同中发起的全部选择应用类型
//var forwardUrl ="<%=request.getContextPath()%>/CreateSynProcess.rform?type=3&sysType=2&fromportal=1"; 
//var title = "新建事项";
//openCtpWindow({'url':forwardUrl,'title':title});

//}
function newColl(){
var plateId = "402881895690ce5e015691bc164000c3";
var isInitLoad = 0;
var newData={};
newData["plateId"] = plateId;

var url = '<%=request.getContextPath()%>/portal/portalAction_getDefaultPlateAction.action?matrix_send_request=true';
Matrix.sendRequest(url,newData,function(data){
     if(data!=null&&data.data!=null){
  if("error1"==data.data){
Matrix.warn("该模板的所在的流程版本未发布或者不存在！");
return false;
}
       var returnObj = isc.JSON.decode(data.data);
       var formId = returnObj.formId;
       var pdid = returnObj.pdid;
       var adid = returnObj.adid;
       var authId = returnObj.authId;
  var forwardUrl = "<%=request.getContextPath()%>/CreateSynProcess.rform?mHtml5Flag=true&formId="+formId+"&isInitLoad="+isInitLoad+"&mBizId="+plateId+"&pdid="+pdid+"&type=3&sysType=2&fromportal=1&adid="+adid+"&authId="+authId;
//var forwardUrl = "<%=request.getContextPath()%>/CreateSynProcess.rform?formId="+formId+"&isInitLoad="+isInitLoad+"&mBizId="+plateId+"&pdid="+pdid+"&type=3&sysType=2&fromportal=1&adid="+adid+"&authId="+authId;
openCtpWindow({'url':forwardUrl,'title':'新建事项'});
}
});
}
	function forwardFrame(tree, node, recordNum){
	
		if(node.href!=null && node.href.trim().length>0){
	
			var src = node.href;
		    src = handTreeNodeHref(node,src);
			Matrix.getMatrixComponentById("ContentTarget").setContentsURL(src);
			}
		
	}
	var setTime;
	var setUndisPlay;
	function selectClose(){
		var checked = document.getElementById("checkbox").checked;
		if(checked){
			clearTimeout(setUndisPlay);
			clearTimeout(setTime);
			closeDiv();
		}else{
			closeDiv();
		}
	}
	
	function readClickContent(messageId,urlValue){
		/*
		var urlStr = urlValue.substr(0,1);
		var httpStr = urlValue.substr(0,8);
		var wwwStr = urlValue.substr(0,3);
		if(urlStr!='/'&&httpStr!='http://'&&wwwStr!='www'){
			urlValue="<%=request.getContextPath()%>/"+urlValue;
		}else if(urlStr=='/'&&httpStr!='http://'&&wwwStr!='www'){
			urlValue="<%=request.getContextPath()%>"+urlValue;
		}else if(urlStr!='/'&&httpStr!='http://'&&wwwStr=='www'){
			urlValue='http://'+urlValue;
		}
		*/
		debugger;
		if(urlValue!=null && urlValue.length>0){
			if(urlValue.indexOf("FlowFrame")>=0){
				try{
					var tindex = urlValue.indexOf("taskId=");
					var mindex = urlValue.indexOf("&mBizId");
					var value = urlValue.substring(tindex+7,mindex);
					var getStatusUrl = "<%=request.getContextPath()%>/foundation/message_getByTaskId.action?taskId="+value;
					Matrix.sendRequest(getStatusUrl,null,function(data){
					if(data!=null&&data.data!="")
					if(data.data==1){
						urlValue = "<%=request.getContextPath()%>/"+urlValue+"&mHtml5Flag=true";
						openCtpWindow({'url':urlValue,'title':'消息内容'});
					}if(data.data==2){
						Matrix.warn("该任务正在被别人处理！");
						return false;
					}if(data.data==3){
						Matrix.warn("该任务已被处理！");
						return false;
					}if(data.data==4){
							Matrix.warn("该任务已被别人处理！");
					return false;
					}if(data.data==5){
							Matrix.warn("该任务不存在！");
					return false;
					}
					});
				}catch(error){
				Matrix.warn("该任务不存在！");
				return false;
				}
			}else if(urlValue.indexOf("readMessage=true")>=0){
				var iWidth=550;                          //弹出窗口的宽度; 
	           var iHeight=450;                         //弹出窗口的高度; 
	           //获得窗口的垂直位置 
	           var iTop = (window.screen.availHeight - 30 - iHeight) / 2; 
	           //获得窗口的水平位置 
	           var iLeft = (window.screen.availWidth - 10 - iWidth) / 2; 
			   urlValue = "<%=request.getContextPath()%>/"+urlValue+"&messageId="+messageId;
			   openCtpWindow({'url':urlValue,'title':'消息内容','top':iTop,'left':iLeft,'width':iWidth,'height':iHeight});
			}
			else{
			    urlValue = "<%=request.getContextPath()%>/"+urlValue;
				openCtpWindow({'url':urlValue,'title':'消息内容'});
			}
			
			//	if(messageId!=null && messageId.length>0){
					// 更新状态
				//	var updateStatusUrl = "<%=request.getContextPath()%>/foundation/message_updateMessageStatus.action?messageId="+messageId;
				//	Matrix.sendRequest(updateStatusUrl,null,function(){});
				//}
				closeDiv();
		}
		
		//var mhtmlHeight = window.screen.availHeight;//获得窗口的垂直位置;
		//var mhtmlWidth = window.screen.availWidth; //获得窗口的水平位置; 
		//var iTop = 0; //获得窗口的垂直位置;
		//var iLeft = 0; //获得窗口的水平位置;
		
	}
		//删除元素
	function deleteElement(obj){
     var node = document.getElementById(obj);
     node.parentNode.removeChild(node);
     }
	function updateReadById(messageId){
	 if (event) //停止事件冒泡
     event.stopPropagation();
    else
     window.event.cancelBubble = true;
	var messageDiv = "sysMsgDiv"+messageId;
	deleteElement(messageDiv);
	var sysMsgTotalCount1 = document.getElementById('sysMsgTotalCount1').innerHTML;
	document.getElementById('sysMsgTotalCount1').innerHTML = parseInt(sysMsgTotalCount1)-1;
	updateMessageState(messageId);
	
	}
	function updateIsRemind(){
		var mhtmlHeight = window.screen.availHeight;//获得窗口的垂直位置;
		var mhtmlWidth = window.screen.availWidth; //获得窗口的水平位置; 
		var iTop = 0; //获得窗口的垂直位置;
		var iLeft = 0; //获得窗口的水平位置;
		document.getElementById("bottom_msg").style.display="none";
		var src="<%=request.getContextPath()%>/foundation/message_listMessage.action";
		openCtpWindow({'url':src,'title':'消息列表'});
		//window.open(src,'消息列表','height='+mhtmlHeight+',width='+mhtmlWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=yes,scrollbars=no,resizable=yes, location=no,status=no');
	}
	function closeDiv(){
		document.getElementById("bottom_msg").style.display="none";
	}

	function refreshMessage(){
	
		var url1 = '<%=request.getContextPath()%>/foundation/message_queryUnreadCount.action';
		Matrix.sendRequest(url1,null,
			function(data){
			  		var unReadMsgNum =  data.data;
			  		if(unReadMsgNum>0){
       				document.getElementById('msgremind').style.display="block";
       				}
			  	});
		var url = '<%=request.getContextPath()%>/foundation/message_queryUnreadMessage.action';
		Matrix.sendRequest(url,null,
			function(data){
			  	var result = data.data;
			  	if(result && result.length>0){
	       			var json =isc.JSON.decode(result).result;
	       			var arr = json.split(',');
	       			
       				var unRemindMsgNum = parseInt(arr.get(0));
       				var subjectNameArr = [];
       				var messageIdArr = [];
       				var urlValueArr=[];
       				var userNameArr = [];
       				var createDateArr = [];
       				for(var i=1;i<arr.length;i++){
       					subjectNameArr.add(arr.get(i).split(';').get(0));
       					messageIdArr.add(arr.get(i).split(';').get(1));
       					urlValueArr.add(arr.get(i).split(";").get(2));
       					userNameArr.add(arr.get(i).split(";").get(3));
       					createDateArr.add(arr.get(i).split(";").get(4));
       				}
       				//document.getElementById("messageNum").style.height=(120+unReadMsgNum*15)+"px";
       				
       				
       			
       					//head
       					var style="  <div class=\"pop_msg_top\">";
       					
	  style+="<span class=\"pop_top_title systemMsg margin_l_5\">";
	  style+="系统消息（<label id=\"sysMsgTotalCount1\">"+unRemindMsgNum+"</label>）</span>";
	 style+=" <div class=\"pop_msg_top_sm\" onclick=\"document.getElementById('bottom_msg').style.display='none';\"><span></span>";
	 style+=" </div>";
	  style+="<div class=\"msg_pop_titlecurrent\" style=\"\">◆</div>";
	  style+="</div>";
	    style+="<div id=\"msg_system_box\" class=\"msg_system_box\">";
	    style+="<div class=\"msg_main_box\">";
       				
       					for(var i=0;i<subjectNameArr.length;i++){
       						var name = subjectNameArr.get(i);
//       						if(name.length>30){
//       							name=name.substring(0,30)+"……";
//       						}
       						var curUserName = userNameArr[i];
       						var createTime = createDateArr[i];
       						
       						
       						style+="  <div id=\"sysMsgDiv"+messageIdArr[i]+"\" class=\"msg_remove\" msgcategory=\"8\" userhistorymessageid=\""+messageIdArr[i]+"\" onmouseover=\"showhul(this);\" onmouseout=\"hidehul(this);\">";
		 if(urlValueArr[i]==''||urlValueArr[i]==null||urlValueArr[i]=='null'){
	 style+="<div class=\"msg_system_box_main\" style=\"cursor: default; background: rgb(255, 255, 255);\" onmouseover=\"this.style.backgroundColor='rgb(252, 240, 193)'\" onmouseout=\"this.style.backgroundColor='#FFFFFF'\" onclick=\"updateMessageState('"+messageIdArr[i]+"');\">";
	
	}else{
	  
	   style+="<div class=\"msg_system_box_main\" style=\"cursor: default; background: rgb(255, 255, 255);\" onmouseover=\"this.style.backgroundColor='rgb(252, 240, 193)'\" onmouseout=\"this.style.backgroundColor='#FFFFFF'\"  onclick=\"updateMessageState('"+messageIdArr[i]+"');readClickContent('"+messageIdArr[i]+"','"+urlValueArr[i]+"')\">";
	}
	 style+=" <div class=\"left msg_ca_8\"></div>";
	 style+=" <div class=\"msg_system_main_right\">";
	  style+="<div class=\"msg_system_main_right_main\">"+name;
	 style+=" <div class=\"msg_ico_1\" onmouseover=\"showhul2(this,event);\"></div>";
	 style+="<div title=\"忽略\" class=\"msg_ico_2\" style=\"cursor: pointer;\" onmouseout=\"hidehul2(this,event);\" onclick=\"updateReadById('"+messageIdArr[i]+"');\"></div>";
	  style+="</div>";
	  style+="<div class=\"msg_system_main_right_info\">";
	   style+="<div title="+curUserName+" class=\"left\">";
	  if(curUserName != null && curUserName != undefined && curUserName != "null"){
	  	style += curUserName;
	  }
	  style+="</div>";
	  if(createTime == undefined || createTime == null){
		  createTime = "";
	  }
	 style+=" <div class=\"msg_date right\">"+createTime+"</div>";
	 style+=" </div></div><div class=\"clear\"></div></div>";
	  if(i<subjectNameArr.length-1&&subjectNameArr.length>2)
	 style+="<div class=\"msg_line\"></div>";
	 else
	  style+="<div></div>";
       				  style+=" </div>";	
       					
       					}
       						
	    style+="</div>";
	    style+="</div>";
  style+="<div class=\"msg_setting\">";
  style+="<div class=\"msg_setting_font msg_setting_ignore\" onclick=\"allReaded();\">忽略全部</div>";
  style+="<div class=\"msg_setting_font msg_setting_look\" onclick=\"updateIsRemind();\">查看全部</div></div>";
	   style+="</div></div>";
	  document.getElementById("bottom_msg").innerHTML=style;
       				
       					document.getElementById("bottom_msg").style.display="block";
       					 document.getElementById('bottom_msg').style.opacity=1;
       					 //有未读未提醒消息时，执行淡出方法
       					 setUndisPlay = setTimeout('fadeOut()',10000);
       					 val=100;//执行完一次fadeOut后，还原val值
      if(unRemindMsgNum==0){
       				document.getElementById('msgremind').style.display="none";
       				}
       				
       			 }
       			 
       			
			},
			function(){
			  	
			}
		);
	}
	function refreshInfo(){
	var url = '<%=request.getContextPath()%>/foundation/message_queryUnreadMessage.action';
		Matrix.sendRequest(url,null,
			function(data){
			  	var result = data.data;
			  	if(result && result.length>0){
	       			var json =isc.JSON.decode(result).result;
	       			var arr = json.split(',');
       				var unReadMsgNum = parseInt(arr.get(0));
       			
       				var subjectNameArr = [];
       				var messageIdArr = [];
       				var urlValueArr=[];
       				var userNameArr = [];
       				var createDateArr = [];
       				for(var i=1;i<arr.length;i++){
       					subjectNameArr.add(arr.get(i).split(';').get(0));
       					messageIdArr.add(arr.get(i).split(';').get(1));
       					urlValueArr.add(arr.get(i).split(";").get(2));
       					userNameArr.add(arr.get(i).split(";").get(3));
       					createDateArr.add(arr.get(i).split(";").get(4));
       				}
       				//document.getElementById("messageNum").style.height=(120+unReadMsgNum*15)+"px";
       			
       				//if(unReadMsgNum>0){
       					document.getElementById('msgremind').style.display="block";
       					 document.getElementById('bottom_msg').style.opacity=1;
       					//head
       					var style="  <div class=\"pop_msg_top\">";
       					
	  style+="<span class=\"pop_top_title systemMsg margin_l_5\">";
	  style+="系统消息（<label id=\"sysMsgTotalCount1\">"+unReadMsgNum+"</label>）</span>";
	 style+=" <div class=\"pop_msg_top_sm\" onclick=\"document.getElementById('bottom_msg').style.display='none';\"><span></span>";
	 style+=" </div>";
	  style+="<div class=\"msg_pop_titlecurrent\" style=\"\">◆</div>";
	  style+="</div>";
	    style+="<div id=\"msg_system_box\" class=\"msg_system_box\">";
	    style+="<div class=\"msg_main_box\">";
       				
       					for(var i=0;i<subjectNameArr.length;i++){
       						var name = subjectNameArr.get(i);
//       						if(name.length>30){
//       							name=name.substring(0,30)+"……";
//       						}
       						var curUserName = userNameArr[i];
       						var createTime = createDateArr[i];
       						
       						
       						style+="  <div id=\"sysMsgDiv"+messageIdArr[i]+"\" class=\"msg_remove\" msgcategory=\"8\" userhistorymessageid=\""+messageIdArr[i]+"\" onmouseover=\"showhul(this);\" onmouseout=\"hidehul(this);\">";
	 if(urlValueArr[i]==''||urlValueArr[i]==null||urlValueArr[i]=='null'){
	 style+="<div class=\"msg_system_box_main\" style=\"cursor: default; background: rgb(255, 255, 255);\" onmouseover=\"this.style.backgroundColor='rgb(252, 240, 193)'\" onmouseout=\"this.style.backgroundColor='#FFFFFF'\" onclick=\"updateMessageState('"+messageIdArr[i]+"');\">";
	
	}else{
	  
	   style+="<div class=\"msg_system_box_main\" style=\"cursor: default; background: rgb(255, 255, 255);\" onmouseover=\"this.style.backgroundColor='rgb(252, 240, 193)'\" onmouseout=\"this.style.backgroundColor='#FFFFFF'\"  onclick=\"updateMessageState('"+messageIdArr[i]+"');readClickContent('"+messageIdArr[i]+"','"+urlValueArr[i]+"')\">";
	}
	 style+=" <div class=\"left msg_ca_8\"></div>";
	 style+=" <div class=\"msg_system_main_right\">";
	  style+="<div class=\"msg_system_main_right_main\">"+name;
	   style+=" <div class=\"msg_ico_1\" onmouseover=\"showhul2(this,event);\" ></div>";
	 style+="<div title=\"忽略\" class=\"msg_ico_2\" style=\"cursor: pointer;\" onmouseout=\"hidehul2(this,event);\" onclick=\"updateReadById('"+messageIdArr[i]+"');\"></div>";
	
	  style+="</div>";
	  style+="<div class=\"msg_system_main_right_info\">";
	  style+="<div title=\""+curUserName+"\" class=\"left\">";
	  if(curUserName != null && curUserName != undefined && curUserName != "null"){
	  	style += curUserName;
	  }
	  style+="</div>";
	  if(createTime == undefined || createTime == null){
		  createTime = "";
	  }
	 style+=" <div class=\"msg_date right\">"+createTime+"</div>";
	 style+=" </div></div><div class=\"clear\"></div></div>";
	
	 if(i<subjectNameArr.length-1&&subjectNameArr.length>2)
	 style+="<div class=\"msg_line\"></div>";
	 else
	  style+="<div></div>";
       				  style+=" </div>";	
       					}
       						 
	    style+="</div>";
	    style+="</div>";
  style+="<div class=\"msg_setting\">";
  style+="<div class=\"msg_setting_font msg_setting_ignore\" onclick=\"allReaded();\">忽略全部</div>";
  style+="<div class=\"msg_setting_font msg_setting_look\" onclick=\"updateIsRemind();\">查看全部</div></div>";
	   style+="</div></div>";
	  document.getElementById("bottom_msg").innerHTML=style;
       				
       					document.getElementById("bottom_msg").style.display="block";
       				if(unReadMsgNum==0){
       				document.getElementById('msgremind').style.display="none";
       				}
       			//	}else{result
       			//		document.getElementById("bottom_msg").style.display="none";
       			//		document.getElementById('msgremind').style.display="none";
       			//	}
       			 }else{
       				 document.getElementById('msgremind').style.display="none";
       			}
			},
			function(){
			  	
			}
		);
	}
	function refreshInvalid(){
	var url = '<%=request.getContextPath()%>/foundation/message_queryUnreadMessage.action';
		Matrix.sendRequest(url,null,
			function(data){
			  	var result = data.data;
			  	var unReadMsgNum = 0;
			  	if(result && result.length>0){
	       			var json =isc.JSON.decode(result).result;
	       			var arr = json.split(',');
       				unReadMsgNum = parseInt(arr.get(0));
       			
       				var subjectNameArr = [];
       				var messageIdArr = [];
       				var urlValueArr=[];
       				var userNameArr = [];
       				var createDateArr = [];
       				var flag = 0;
       				for(var i=1;i<arr.length;i++){
       					subjectNameArr.add(arr.get(i).split(';').get(0));
       					messageIdArr.add(arr.get(i).split(';').get(1));
       					urlValueArr.add(arr.get(i).split(";").get(2));
       					userNameArr.add(arr.get(i).split(";").get(3));
       					createDateArr.add(arr.get(i).split(";").get(4));
       					
       					//新消息弹出消息框     flag判断是否弹出，弹出后不需要再次弹出
       					if(flag == 0){//消息框还没有弹出
	       					var thatDate = arr.get(i).split(";").get(4);
       						if(!thatDate){
       							return;
       						}
	       					var dateLength = thatDate.split('-').length;
	    					var thisDate = new Date();
	    					var thisTimeSeconds = thisDate.getSeconds();
	    					var thisTime = Date.parse(thisDate);//获取当前时间戳
	    					thisTime = thisTime - thisTimeSeconds*1000;//去掉秒的影响
	       					if(dateLength == 2){//是当前年份
	       						var thisYear = thisDate.getFullYear();
	       						var thatFullDate = thisYear+"-"+thatDate;
	       						var thattimestamp = Date.parse(new Date(thatFullDate));//消息时间戳
	       						if(thisTime - thattimestamp < 65000){
	       							//弹出
	       							refreshInfo();
	       							flag = 1;//不再弹出
	       						}
	       					}else if(dateLength == 3){//非当前年份
	       						var thattimestamp = Date.parse(new Date(thatDate));//消息时间戳
	       						if(thisTime - thattimestamp < 65000){
	       							//弹出
	       							refreshInfo();
	       							flag = 1;//不再弹出
	       						}
	       					}
       					}
       				}
       				if(unReadMsgNum>0){
       					document.getElementById('msgremind').style.display="block";
       				}else{
       					document.getElementById("bottom_msg").style.display="none";
       					document.getElementById('msgremind').style.display="none";
       				}
       				//document.getElementById("messageNum").style.height=(120+unReadMsgNum*15)+"px";
       			 }else{document.getElementById("bottom_msg").style.display="none";
					document.getElementById('msgremind').style.display="none";
				}
			},
			function(){
			  	
			}
		);
	}
	//获取流程申请信息通知
	function refreshAcceptMsgInfo(){
	 	var url = '<%=request.getContextPath()%>/foundation/message_queryMessage.action';
		Matrix.sendRequest(url,null,
			function(data){
			  	var result = data.data;
			  	if(result && result.length>0){
	       			var json =isc.JSON.decode(result).result;
	       			var arr = json.split(',');
       				var unReadMsgNum = parseInt(arr.get(0));
       				var subjectNameArr = [];
       				var messageIdArr = [];
       				var urlValueArr=[];
       				var userNameArr = [];
       				for(var i=1;i<arr.length;i++){
       					subjectNameArr.add(arr.get(i).split(';').get(0));
       					messageIdArr.add(arr.get(i).split(';').get(1));
       					urlValueArr.add(arr.get(i).split(";").get(2));
       					userNameArr.add(arr.get(i).split(";").get(3));
       				}
       				//document.getElementById("messageNum").style.height=(120+unReadMsgNum*15)+"px";
       				
       				if(unReadMsgNum>0){
       					var s = "您有新未读消息:";
       					//head
       					var style="<div style=height:30px;width:300px;;><span style=float:left;padding-left:5px;line-height:30px;>消息提醒</span><a id='a' style=width:32px;float:right;padding-right:0px;line-height:30px;text-decoration:none; href='javascript:selectClose();' title='关闭'>X</a></div>";
       					//body
       					style+="<div id='body' style=width:100%;;>";
       					style+="<img src='<%=request.getContextPath()%>/resource/images/matrix/chat.png' style=width:25px;height:25px;line-height:50px;padding-right:30px;padding-top:5px;/><span style=float:right;color:red;padding-right:20px;line-height:30px;>"+unReadMsgNum+"</span><span style=float:right;padding-right:100px;;line-height:30px;font-family: 黑体;>"+s+"</span><br>";
       					for(var i=0;i<subjectNameArr.length;i++){
       						var name = subjectNameArr.get(i);
       						if(name.length>30){
       							name=name.substring(0,30)+"……";
       						}
       						var curUserName = userNameArr[i];
       						if(urlValueArr[i]==''||urlValueArr[i]==null||urlValueArr[i]=='null'){
       							style+="<div style='padding-left:60px;text-align:left;width:100%;'><label style='text-decoration:none;width:100%;' title="+name+">"
       						}else{
       							style+="<div style='padding-left:60px;text-align:left;width:100%;'><a style='text-decoration:none;width:100%;' title="+name+" href=javascript:readClickContent('"+messageIdArr[i]+"','"+urlValueArr[i]+"');>";
       						}
       						if(curUserName!=null&&curUserName!=''&&curUserName!='null'){
       							style += name+"("+curUserName+")</label></div>";
       						}else{
       							style += name+"</label></div>";
       						}
       					}
       					style+="</div><hr style='width:300px;background-color:#ffffff;margin-bottom:0px;margin-top:0px;color:gray;'>";
       					//foot
       					style+="<div style=height:28px;width:300px;background-color:#ffffff;line-height:30px;text-align:left;vertical-align:middle;><input type=checkbox id=checkbox name=checkbox style='float:left;line-height:30px;vertical-align:middle;margin-top:9px;margin-bottom:9px;'><label  for=checkbox>不再提醒</label></input><a style=float:right;line-height:30px;text-decoration:none;padding-right:5px; href='javascript:updateIsRemind();' style=text-decoration:none;>查看更多……</a></div>";
       					document.getElementById("messageNum").innerHTML=style;
       					document.getElementById("body").style.height=(60+unReadMsgNum*15)+"px";
       					document.getElementById("messageNum").style.display="block";
       					 document.getElementById('messageNum').style.opacity=1;
       					 //有未读未提醒消息时，执行淡出方法
       					 setUndisPlay = setTimeout('fadeOut()',10000);
       					 val=100;//执行完一次fadeOut后，还原val值
       				}else{
       					document.getElementById("messageNum").style.display="none";
       					
       				}
       			 }
       			 
       			 /*********去掉注释，启动定时***************/
			    //setTime = setInterval("refreshAcceptMsgInfo()",20000);
			    /*********去掉注释，  提示框直接消失**********/
			    //document.getElementById('messageNum')='none';
			},
			function(){
			  	//刷新失败
			}
		);
	}
	

	
    function fadeOut(){
 	
		/*
		 * 参数说明
	 	 * elem==>需要淡入的元素
	 	 * speed==>淡入速度,正整数(可选)
	 	 * opacity==>淡入到指定的透明度,0~100(可选)
		 */
    	var speed =  200;//0.2秒调用一次本方法
    	//提示框对象
    	var div = document.getElementById('bottom_msg');
		div.filters ? div.style.filter = 'alpha(opacity=' + val + ')' : div.style.opacity = val / 100;
		val -= 4;//val控制透明度
   		if (val > 0) {
			//定时调用fadeOut方法
        	setTimeout(arguments.callee, speed);
    	}else if (val <= 0) {
			//元素透明度为0后隐藏元素
        	div.style.display = 'none';
    	} 
    	
 	}
setInterval('refreshInvalid()',60000);
</script>
<script>

	function setContent(url){
		//alert("url.substring(0,21):"+url.substring(0,21));
		//alert("javascript:"+'<%=request.getContextPath()%>/javascript');
		if(url.indexOf("javascript")>=0){

		var p = url.split(":");
			eval(p[1]);
		}else{
			document.getElementById('iframe0').src = url;
	 	}
	}
	
	function changePortlet(id,portalId){
		if(id=='dep'){
			$('#personcontent').removeClass("select-bgColor");
			$('#depcontent .btn').addClass("select-bgColor");
			$('#companycontent').removeClass("select-bgColor");
		 	document.getElementById('iframe0').src = "<%=request.getContextPath()%>/portal/portalAction_previewOfficePortal.action?portalId="+portalId+"&isDep=true";
		}else if(id=='company'){
			$('#personcontent').removeClass("select-bgColor");
			$('#depcontent .btn').removeClass("select-bgColor");
			$('#companycontent').addClass("select-bgColor");
		 	document.getElementById('iframe0').src = "<%=request.getContextPath()%>/portal/portalAction_previewOfficePortal.action?portalId=402881895846def101584792cc4e001d";
		}else if(id=='person'){
			$('#personcontent').addClass("select-bgColor");
			$('#depcontent .btn').removeClass("select-bgColor");
			$('#companycontent').removeClass("select-bgColor");
		 	//document.getElementById('iframe0').src = "<%=request.getContextPath()%>/portal/portalAction_previewOfficePortal.action?portalId=402881895846def1015847888d250018";
		 	document.getElementById('iframe0').src = "<%=request.getContextPath()%>/portal/portalAction_previewPersionOfficePortal.action";
		}
	}
	
	var openwin = new Array();
	//注销
	function logoff(){
		if(openwin.length>0){    //关闭所有已经打开的窗口
			for(var i=0;i<openwin.length;i++){
		    	openwin[i].close();
		    }
		}
		top.location="<%=request.getContextPath()%>/logon/logon_logoff.action";
	}
	
	//获得打开窗口的winodw对象
	function getWindow(windobj){
		openwin.push(windobj);
	}
	
	//关闭标签页时清除session
	window.onbeforeunload=function(){
		var operation = $("#operation").val();
		if(operation!='noLogOut'){ 
			$.ajax({ 
				 url: '<%=request.getContextPath()%>/logon/logon_logoff.action',
		         type: "post", 
		         dataType: "json", 
		         success: function(data){ 
	            } 
	        });
		}
	};

</script>

<%
	//登录方式  logon直接登录  switch 切换视图登录
	String logonMode = (String)request.getAttribute("logonMode");
	FunctionHelper helper = new FunctionHelper();
	List list = helper.loadChildrenFunctionByCustom(logonMode);

	/*for(Iterator iter = list.iterator(); iter.hasNext(); ){
		DataObject data = (DataObject)iter.next();
		out.println("id:"+data.getString("functionId")+",name:"+data.getString("functionName"));
		
		List children = data.getList("children");
		for(Iterator iter2 = children.iterator(); iter2.hasNext(); ){
			DataObject data2 = (DataObject)iter2.next();
			out.println("subid:"+data2.getString("functionId")+",subname:"+data2.getString("functionName"));
			
		}
	}
	 */
	 MFExecutionService executionService = (MFExecutionService)request.getSession().getAttribute(ClientConstants.EXECUTION_SERVICE);
	 if(executionService == null){
%>
		<script>
		 window.location.href = "<%=request.getContextPath()%>/";
		</script>
<%
		return;
	 }
	 MFUser user = executionService.getMFUser();
	 List<String> roleIds = user.getTotalRoleIds();
	 
	 String designerRole = MFSystemProperties.getInstance().getSystemDesigner();  //设计开发人员角色编码
	 String adminRole = MFSystemProperties.getInstance().getSystemAdmin();
	
	 boolean isDesigner = false;    //是否是deisgner
	 boolean isAdmin = false;  //是否是admin
	 if(roleIds.contains(designerRole)) { // 是设计开发角色
		 isDesigner = true;
	 }
	 if(roleIds.contains(adminRole) || roleIds.contains("SubSysAdmin")){  //是管理员角色
		 isAdmin = true;
	 }	 
%>

<body class="fixed-sidebar full-height-layout pace-done"
	style="overflow: hidden; background-color: #fff;"
	onload="initLoadFunc()">
	<input type="hidden" id="operation" name="operation"/>  <!-- 是否注销 -->
	<input type="hidden" id="logonMode" name="logonMode" value="${logonMode}"/>  <!-- 登录方式  user直接登录默认是普通用户视图      admin切换管理员视图登录   user切换普通用户视图登录 -->
	<div class="shouye-title">
		<div class="logo">
			<img src="<%=request.getContextPath()%>/resource/images/logo.png">
		</div>
		<div id="topMenuContr" class="topMenuContr">
			<div style="padding-top:8px;position:absolute;width:100%;">
			<img src="<%=request.getContextPath()%>/form/admin/main/menu_14.png" width="16px" height="16px" style="vertical-align:middle;" id="closeTop">
		   </div>
		</div>
		<script type="text/javascript">
		//展开缩放按钮
		$('#topMenuContr').click(function(){
			var width = $('#navigation').width();
			if(width == '220'){
				//$('#topMenuContr').css('background-color','rgb(122, 190, 225)');
				$('#navigation').css('display','none');
				$('#navigation').css('width','0px');
				$('#page-wrapper').css('margin-left','0px');
			}else{		
				//$('#topMenuContr').css('background-color','rgb(6,131,229)');
				$('#page-wrapper').css('margin-left','220px');
				$('#navigation').css('width','220px');
				$('#navigation').css('display','');
			}
		});
		</script>
		<div class="dropdown" id="viewType" style="top: 10px; left:10px; height: 35px;float: left;position: relative;display:none;">
			<button class="btn btn-primary dropdown-toggle btn-bgcolor" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true" id="changeView">
				普通视图 <span class="caret"></span>
			</button>
			<ul class="dropdown-menu">		
				<li id="designer_view"><a href="javascript:changeView('designer');">设计开发</a></li>
				<li id="admin_view"><a href="javascript:changeView('admin');">管理实施</a></li>
			</ul>
		</div>
		<script type="text/javascript">
			$(function(){
				$('#designer_view').hide();
				$('#admin_view').hide();
				
				var isChrome = false;
			    var userAgent = navigator.userAgent.toLowerCase();  //取得浏览器的userAgent字符串   
			    if ((userAgent.indexOf('mozilla') == 0 && 
			        userAgent.indexOf('applewebkit') > 0 && 
			        userAgent.indexOf("edge") == -1 && 
			            userAgent.toLowerCase().indexOf("chrome/") > 0) 
			            || userAgent.indexOf("mac")>0){
			    	isChrome = true;      //是谷歌内核的浏览器
			    }
				
			    if(isChrome){
			    	var isDesigner = <%=isDesigner %>;
					var isAdmin = <%=isAdmin %>;
					
					var flag = false;
					if(isDesigner){
					   $('#designer_view').show();
					   flag = true;
					}
					if(isAdmin){
					   $('#admin_view').show();
					   flag = true;
					}
					if(flag){    //是管理员或者设计开发人员
						$('#viewType').show();
					}
			    }
			})
			function changeView(viewType){
				if(openwin.length>0){    //关闭所有已经打开的窗口
					for(var i=0;i<openwin.length;i++){
				    	openwin[i].close();
				    }
				}
				$("#operation").val('noLogOut');
				window.location.href = '<%=request.getContextPath()%>/logon/logon_switchView.action?viewType='+viewType;
			}
		</script>
		<!-- 选择操作空间 -->
		<div id="controlType" class="btn-group" style="top:10px;left:30%;height: 35px;" role="group">
			<button id="personcontent" type="button" class="btn btn-primary btn-bgcolor select-bgColor" onclick="javascript:changePortlet('person',null)">
				<i class="fa fa-user fa-fw"></i>个人空间
			</button>
			<div id="depcontent" type="button" class="btn-group" role="group">
				<button type="button" class="btn btn-primary dropdown-toggle btn-bgcolor" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					部门空间 <span class="caret"></span>
				</button>
				<ul class="dropdown-menu">
					<%
						List<Object[]> portalList = (List<Object[]>) request.getAttribute("portals");
						for (int i = 0; i < portalList.size(); i++) {
					%>
					<li><a
						href="javascript:changePortlet('dep','<%=(portalList.get(i))[0].toString()%>')"><%=(portalList.get(i))[1].toString()%></a></li>
					<%
						}
					%>
					<!-- 	      <li><a href="#">Dropdown link</a></li> -->
				</ul>
			</div>
			<button id="companycontent" type="button" class="btn btn-primary btn-bgcolor" onclick="javascript:changePortlet('company',null)">公司空间</button>
		</div>
		<div class="shouye-title-right">
			<h2>
				<img src="<%=request.getContextPath()%>/resource/images/user.png"> <span>欢迎您: ${userName}</span>
			</h2>
			<div class="right0"><a href="javascript:logoff();"><img
				src="<%=request.getContextPath()%>/resource/images/grid.png"></a></div>
			</div>
		</div>
	</div>

	<div class="pace  pace-inactive">
		<div class="pace-progress" data-progress-text="100%"
			data-progress="99" style="width: 100%;">
			<div class="pace-progress-inner"></div>
		</div>
		<div class="pace-activity"></div>
	</div>
	<div id="wrapper" style="overflow: hidden;">
		<!--左侧导航开始--> 
		<nav class="navbar-default navbar-static-side" role="navigation" id="navigation" style="height: calc(100% - 53px);padding-top:10px">
			<div class="nav-close">
				<i class="fa fa-times-circle"></i>
			</div>
			<div class="slimScrollDiv"
				style="position: relative; width: auto; height: 100%;overflow: auto;">
				<div class="sidebar-collapse">
					<div class="bback" style="display:none;">
						<span style="line-height: 25px; color: #FFFFFF">在线人数:<%=session.getAttribute("Logon_User_Num")%></span>
					</div>
					<ul class="nav" id="side-menu">
						<!--   <li class="nav-header">
                        <div class="dropdown profile-element">
                            <span><img alt="image" class="img-circle" src="<%=request.getContextPath()%>/form/admin/main/profile_small.jpg"></span>
                            <a data-toggle="dropdown" class="dropdown-toggle" href="http://www.zi-han.net/theme/hplus/#">
                                <span class="clear">
                               <span class="block m-t-xs"><strong class="font-bold">Beaut-zihan</strong></span>
                                <span class="text-muted text-xs block">超级管理员</span>
                                </span>
                            </a>
                           
                        </div>
                        <div class="logo-element">H+
                        </div>
                    </li>
                     -->
						<%
							for (Iterator iter = list.iterator(); iter.hasNext();) {
								DataObject data = (DataObject) iter.next();
								//		out.println("id:"+data.getString("functionId")+",name:"+);
								String sIconUrl = data.getString("sIconUrl");   //小图标URL
						%>
						<li><a href="" class="menu-title">
							<%
							if(sIconUrl!=null && sIconUrl.trim().length()>0){
								%>
								<img src="<%=request.getContextPath()%><%=sIconUrl%>"
							<%	
							}else{
							%>
								<img src="<%=request.getContextPath()%>/form/admin/main/mmenu.png"
							<%	
							}
							%>
								style="widht: 18px; height: 18px; padding-right: 10px; margin: 0px; float: left;">
								<span style="height: 18px; line-height: 18px; display: block;"><%=data.getString("functionName")%></span>
							    <span class="fa arrow" style="margin-top:-16px;"></span>
						</a>
							<ul class="nav nav-second-level collapse">

								<%
									List children = data.getList("children");
										for (Iterator iter2 = children.iterator(); iter2.hasNext();) {
											DataObject data2 = (DataObject) iter2.next();
											//out.println("subid:"+data2.getString("functionId")+",subname:"+data2.getString("functionName"));
											String url = request.getContextPath() + "/" + data2.getString("functionValue");
								%>
								<li><a
									class="J_menuItem" href="<%
										if(data2.getString("functionValue")!=null && !"".equals(data2.getString("functionValue"))){
											%>
											javascript:setContent('<%=url%>')
											<%
										}else{
											%>
											javascript:setContent('<%=request.getContextPath() %>/empty.jsp')
											<%
										}
									%>"
									data-index="0"><img
										src="<%=request.getContextPath()%>/resource/images/right-arrow.png"
										style="height: 9px; width: 9px;"><%=data2.getString("functionName")%></a>
										<%
											List children2 = data2.getList("children");
											if(!children2.isEmpty()){
												%>
												<ul class="nav nav-third-level collapse">
											<%
											for(Iterator iter3 = children2.iterator(); iter3.hasNext();){
												DataObject data3 = (DataObject)iter3.next();
												String url1 = request.getContextPath() + "/" + data3.getString("functionValue");
												%>
													<li>
														<a href="<%
																	if(data3.getString("functionValue")!=null && !"".equals(data3.getString("functionValue"))){
																		%>
																		javascript:setContent('<%=url1%>')
																		<%
																	}else{
																		%>
																		javascript:setContent('<%=request.getContextPath() %>/empty.jsp')
																		<%
																	}
																%>"
														data-index="0">
															<span style="height: 18px; line-height: 18px; display: block;">
															<img src="<%=request.getContextPath()%>/resource/images/right-arrow.png"
																	style="height: 9px; width: 9px;"><%=data3.getString("functionName")%>
																	
															</span>
														</a>
														<%
															List children3 = data3.getList("children");
															if(!children3.isEmpty()){
														%>
															<ul class="nav nav-fourth-level collapse" >
															<%
																for(Iterator iter4 = children3.iterator(); iter4.hasNext();){
																	DataObject data4 = (DataObject)iter4.next();
																	String url2 = request.getContextPath() + "/" + data4.getString("functionValue");
															%>
																	<li style="font-family: Microsoft Yahei; font-weight: normal; font-size: 12px;">
																		<a style="padding-left:72px" href="<%
																			if(data4.getString("functionValue")!=null && !"".equals(data4.getString("functionValue"))){
																				%>
																				javascript:setContent('<%=url2%>')
																				<%
																			}else{
																				%>
																				javascript:setContent('<%=request.getContextPath() %>/empty.jsp')
																				<%
																			}
																		%>"
																	data-index="0">
																			<span style="height: 18px; line-height: 18px; display: block;">
																			<img src="<%=request.getContextPath()%>/resource/images/right-arrow.png"
																					style="height: 9px; width: 9px;"><%=data4.getString("functionName")%>
																					
																			</span>
																		</a>
																	</li>
																<%
																	}
																%>
															</ul>
														<%
															}
														%>
													</li>
											<%
											}
											%>
											</ul>
											<%
										}
										%>
										</li>
								<%
									}
								%>

							</ul></li>
						<%
							}
						%>
					</ul>
				</div>
				<div class="slimScrollBar"
					style="width: 4px; position: absolute; top: 0px; opacity: 0.4; display: none; border-radius: 7px; z-index: 99; right: 1px; height: 799px; background: rgb(0, 0, 0);"></div>
				<div class="slimScrollRail"
					style="width: 4px; height: 100%; position: absolute; top: 0px; display: none; border-radius: 7px; opacity: 0.9; z-index: 90; right: 1px; background: rgb(51, 51, 51);"></div>
			</div>
		</nav>
		<!--左侧导航结束-->
		<!--右侧部分开始-->
		<div id="page-wrapper" class="gray-bg dashbard-1"
			style="height: 100%;">


			<div class="row J_mainContent" id="content-main"
				style="height: 100%;">
				<iframe class="J_iframe" style="overflow: hidden;" id="iframe0"
					name="iframe0" width="100%" height="100%"
					src="<%=request.getContextPath()%>/portal/portalAction_previewPersionOfficePortal.action"
					frameborder="0" data-id="index_v1.html" seamless=""></iframe>
			</div>
			<!--   <div class="footer">
                <div class="pull-right">© 2004-2015 <a href="" target="_blank">华创动力科技</a>
                </div>
            </div>
           -->
		</div>
		<div id="message" class="ui-draggable"
			style="z-index: 2000; display: block;" onclick="refreshInfo();">
			<span class="msg_remind" id="msgremind" style="display: none;"></span>
		</div>
		<!-- 消息提示div start-->
		<!-- 
  <div id="messageNum" name="messageNum" style="z-index:999999999;border: 1px solid #41B1E2;width:300px;position:absolute;display:none;
	 right:1px;bottom:1px;text-align:center;background-color:#B5DBEB;border-radius:5px;"></div>
	  -->
		<div class="pop_msg bottom_msg" id="bottom_msg"
			style="display: block;"></div>

		<!-- 消息提示div  end-->
		<!--右侧部分结束-->
		<script
			src="<%=request.getContextPath()%>/form/admin/main/js/jquery.min.js"></script>
		<script
			src="<%=request.getContextPath()%>/form/admin/main/js/bootstrap.min.js"></script>
		<script
			src="<%=request.getContextPath()%>/form/admin/main/js/jquery.metisMenu.js"></script>
		<script 
			src='<%=request.getContextPath() %>/resource/html5/js/layer.min.js'></script>
		<script
			src="<%=request.getContextPath()%>/form/admin/main/js/hplus.min.js"></script>
		<script
			src="<%=request.getContextPath()%>/form/admin/main/js/jquery.slimscroll.min.js"></script>


		<button id="btn01"
			class="navbar-minimalize minimalize-styl-2 btn btn-primary "
			type="button" style="widht: 0px; height: 0px;" />
</body>

</html>