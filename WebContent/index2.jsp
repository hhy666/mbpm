<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>


<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Matrix BPM Office</title>
<jsp:include page="/form/admin/common/taglib.jsp" />
<jsp:include page="/form/admin/common/resource.jsp" />
<script src="/moffice/office/resources/js/jquery-1.8.3.js"></script>
<script src="/moffice/js/office.js"></script>
<style type="text/css"> 
	#body{ 
		height: 300px; 
		width:100px; 
		margin:0px auto; 
		background-image: -moz-linear-gradient(top, #e9e9e9, #ffffff); /*火狐*/
		background: -o-linear-gradient(top, #e9e9e9 0%,white 100%);/*Opera*/
		background-image: -webkit-gradient(linear, left top, left bottom, color-stop(0, #e9e9e9), color-stop(1,#ffffff)); /*Chrome*/
		filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#e9e9e9', endColorstr='#ffffff', GradientType='0'); /*IE*/
	} 
	#a:hover{
		background-color:#8dc8fb;
	}
</style>
</head>

<body onload="">
<jsp:include page="/form/admin/common/loading.jsp" />
<script>
	//setInterval("refreshAcceptMsgInfo()",60000);
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
	
	function readClickContent(name,urlValue){
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
		var mhtmlHeight = window.screen.availHeight;//获得窗口的垂直位置;
		var mhtmlWidth = window.screen.availWidth; //获得窗口的水平位置; 
		var iTop = 0; //获得窗口的垂直位置;
		var iLeft = 0; //获得窗口的水平位置;
		MMainDialog.initSrc=urlValue;
		Matrix.showWindow('MainDialog');
		window.open(urlValue,'','height='+mhtmlHeight+',width='+mhtmlWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=yes,scrollbars=no,resizable=yes, location=no,status=no');
		//Matrix.getMatrixComponentById("ContentTarget").setContentsURL(urlValue);
		closeDiv();
	}
	function updateIsRemind(){
		var mhtmlHeight = window.screen.availHeight;//获得窗口的垂直位置;
		var mhtmlWidth = window.screen.availWidth; //获得窗口的水平位置; 
		var iTop = 0; //获得窗口的垂直位置;
		var iLeft = 0; //获得窗口的水平位置;
		document.getElementById("messageNum").style.display="none";
		var src="<%=request.getContextPath()%>/foundation/message_listMessage.action";
		window.open(src,'消息列表','height='+mhtmlHeight+',width='+mhtmlWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=yes,scrollbars=no,resizable=yes, location=no,status=no');
	}
	function closeDiv(){
		document.getElementById("messageNum").style.display="none";
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
       				document.getElementById("messageNum").style.height=(120+unReadMsgNum*15)+"px";
       				
       				if(unReadMsgNum>0){
       					var s = "您有新未读消息:";
       					//head
       					var style="<div style=height:30px;width:300px;;><span style=float:left;padding-left:5px;line-height:30px;>消息提醒</span><a id='a' style=width:32px;float:right;padding-right:0px;line-height:30px;text-decoration:none; href='javascript:selectClose();' title='关闭'>X</a></div>";
       					//body
       					style+="<div id='body' style=width:100%;;>";
       					style+="<img src='<%=request.getContextPath()%>/resource/images/matrix/chat.png' style=width:25px;height:25px;line-height:50px;padding-right:30px;padding-top:5px;/><span style=float:right;color:red;padding-right:20px;line-height:30px;>"+unReadMsgNum+"</span><span style=float:right;padding-right:100px;;line-height:30px;>"+s+"</span><br>";
       					for(var i=0;i<subjectNameArr.length;i++){
       						var name = subjectNameArr.get(i);
       						if(name.length>30){
       							name=name.substring(0,30)+"……";
       						}
       						var curUserName = userNameArr[i]==null?'':userNameArr[i];
       						if(urlValueArr[i]==''||urlValueArr[i]==null||urlValueArr[i]=='null'){
       							style+="<div style='padding-left:60px;text-align:left;width:100%;'><label style='text-decoration:none;width:100%;' title="+name+" >"+"&nbsp;&nbsp;"+name+"("+curUserName+")</label></div>";
       						}else{
       							style+="<div style='padding-left:60px;text-align:left;width:100%;'><a style='text-decoration:none;width:100%;' title="+name+" href=javascript:readClickContent('"+name+"','"+urlValueArr[i]+"'); >"+"&nbsp;&nbsp;"+name+"("+curUserName+")</a></div>";
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
       					 //setUndisPlay = setInterval('fadeOut()',5000);
       					 val=100;//执行完一次fadeOut后，还原val值
       				}else{
       					document.getElementById("messageNum").style.display="none";
       				}
       			 }
       			 
       			 /*********去掉注释，启动定时***************/
			  //setTime = setTimeout("refreshAcceptMsgInfo()",10000);
			    /*********去掉注释，  提示框直接消失**********/
			    //document.getElementById('messageNum')='none';
			},
			function(){
			  	//刷新失败
			}
		);
	}
	
		
	 var val = 100;
    function fadeOut(){
 	
		/*
		 * 参数说明
	 	 * elem==>需要淡入的元素
	 	 * speed==>淡入速度,正整数(可选)
	 	 * opacity==>淡入到指定的透明度,0~100(可选)
		 */
    	var speed =  200;//0.2秒调用一次本方法
    	//提示框对象
    	var div = document.getElementById('messageNum');
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
</script>
<script>
	
	//获得功能分割符
	function getFunctionSeparator(){
		var sep = isc.ToolStripSeparator.create({
		width:10,
		backgroundImage:Matrix.getSkinIcon("/matrix/user/matrix/header_menu_bg.png"),
		height:'100%'});
		return sep;
	}
	
	//获得切换风格按钮
	function getSkinButton(skin){
		var btn = null;
		if(skin!=null){
			var icon = "[SKIN]/matrix/skins/"+skin+".png";
			btn = isc.ImgButton.create({
			    src:icon, autoDraw:false,
			    width:18,height:18,   
			    actionType: "radio",
			    radioGroup: "skinBtn",
		        layoutAlign:"bottom",
			    click:"changeSkinFun('"+skin+"')"
			})
		}
		return btn;
	}
	function changeSkinFun(skinValue){
		if(skinValue!=null){
			var data = {};
			data["command"]="skinMgr";
			data["skinValue"]=skinValue;
			var url = webContextPath+"/skinAction.action";
			Matrix.sendRequest(url,data,
				function(data){
					if(data && "true"==data.data){
						window.location.reload(true);
					}
				}
			);
		}
	}
	
	//获得菜单项
	function getFunctionItems(){
		var items = new Array();
		items.add(
			isc.Img.create({orientation: "vertical", autoDraw:false,
		                   	width:377, height:60,
			        		src:"[SKIN]/matrix/user/matrix/logo.png"
			})
		);
		
		items.add(
		    isc.HLayout.create({
		        width:"*",height:'100%',
		        align: "center",
			    backgroundImage:"[SKIN]/matrix/user/matrix/header_bg.png",
		        members:[
		        		getSkinButton("Enterprise"),
		        		getSkinButton("EnterpriseBlue"),
		        		getSkinButton("Graphite")
		         ]
      		 })
		);
		items.add(
	        isc.VLayout.create({
	        	  ID:"MUserInfoLayout",
	              width:300,   
	              height:'100%',    
	              align: "right",top:0,   
	              layoutAlign :"bottom",
			      backgroundImage:"[SKIN]/matrix/user/matrix/header_bg.png",
	              members:[
	                         isc.Label.create({align: "right", height:20,contents:'欢迎您，'+"${userName}"+"&nbsp;&nbsp;"}),
	                         isc.Label.create({align: "right", height:20,contents:"<a href='javascript:logoff();'>注销</a>&nbsp;&nbsp;"})
	              ]
	         })
		);
		return items;
	}
	
	
    isc.VLayout.create({
        ID: "MFrameLayout",
        position: "relative",
        height: "100%",
        width: "100%",
        align: "center",
        overflow: "auto",
        resizeBarSize:1,
        defaultLayoutAlign: "center",
        members: [
			isc.ToolStrip.create({
			    ID: "insertGroup",
			    showTitle:false, height:60,overflow:'hidden',
	            width:'100%',
			    backgroundImage:"[SKIN]/matrix/user/matrix/header_bg.png",
			    members:getFunctionItems()
			}),
			isc.HTMLPane.create({
					ID:"MContentPane",
					height: "100%",
					overflow: "hidden",
					showEdges:false,
					contentsType:"page",
					contentsURL:"MainContent.rform?treeType=SIconMenu"
			})
		] 
    });
    
	//注销
	function logoff(){
		top.location="<%=request.getContextPath()%>/logoffAction_logoff.action";
	}

	
  </script>
  <!-- 消息提示div start-->
  <div id="messageNum" name="messageNum" style="z-index:999999999;border: 1px solid #e9e9e9;width:300px;position:absolute;display:none;
	 right:1px;bottom:1px;text-align:center;background-color:#e9e9e9;"></div>
  <!-- 消息提示div  end-->
</body>
	<script>
	function getParamsForDialog2(){
		var params='&';
		var value;
		return params;
	}
	isc.Window.create({
		ID:"MMainDialog",
		id:"MainDialog",
		name:"MainDialog",
		autoCenter: true,
		position:"absolute",
		height: "800px",
		width: "600px",
		title: "文档内容",
		canDragReposition: false,
		showMinimizeButton:true,
		showMaximizeButton:true,
		showCloseButton:true,
		showModalMask: false,
		modalMaskOpacity:0,
		isModal:true,
		autoDraw: false,
		headerControls:["headerIcon","headerLabel","closeButton"],
		
		});
		</script>
		<script>MMainDialog.hide();
		</script>
		<script>null;</script>

</html>