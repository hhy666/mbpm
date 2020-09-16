<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>


<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Matrix BPM Client</title>
<jsp:include page="/form/admin/common/taglib.jsp" />
<jsp:include page="/form/admin/common/resource.jsp" />
</head>

<body>
<jsp:include page="/form/admin/common/loading.jsp" />
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
			var url = webContextPath+"/common/menu_forward.action";
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
					contentsURL:"FunctionTreeOfUserPage.rform?treeType=SIconMenu"
			})
		] 
    });
    
	//注销
	function logoff(){
		top.location="<%=request.getContextPath()%>/logon/logon_logoff.action";
	}
	
  </script>
</body>

</html>