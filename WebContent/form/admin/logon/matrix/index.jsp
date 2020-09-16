<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.matrix.form.admin.common.utils.CommonUtil"%>
<html>


<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Matrix BPM</title>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resource/css/reset.css" />
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resource/css/style.css" />
<jsp:include page="/form/admin/common/taglib.jsp" />
<jsp:include page="/form/admin/common/resource.jsp" />
</head>

<body onload="setHeadBackgroundStyle()">
<jsp:include page="/form/admin/common/loading.jsp" />
<script>
	var mfunctions = ${mfunctions};
	
	//获得功能按钮
	function getFunctionButton (command) {
		var btn = null;
		if(command!=null){
			var btnTitle = "";
			var icon="";
			if(command=="requirement"){
				btnTitle = "需求建模";
				icon = Matrix.getComponentIcon('EditForm');
			}else if(command=="implement"){
				btnTitle = "设计开发";
				icon = Matrix.getComponentIcon('EditForm');
			}else if(command=="insMgr"){
				btnTitle = "实例监控";
				icon = Matrix.getComponentIcon('EditForm');
			}else if(command=="customize"){
				btnTitle = "调整优化";
				icon = Matrix.getComponentIcon('EditForm');
			}
		    btn = isc.IconButton.create({
			            title:btnTitle,
			            orientation:"vertical",
			            width:80, autoDraw:false,
			            backgroundImage:"[SKIN]/matrix/user/matrix/header_menu_bg.png",
			            largeIcon:icon,
			            click: "forwardURL('"+command+"');",
			            showDisabledIcon:false,
			            disabled:!mfunctions.contains(command)
			        });
		}
	 	return btn;
	}
	
	//跳转
	function forwardURL(command){
		if(command!=null){
			var url = "";
			if(command=="insMgr"){
				url = webContextPath+"/instance/processInstance_loadProcessInsMain.action";
			}else if(command=="calendarMgr"){
				url = webContextPath+"/calendar/calendarAction_getBusinessCalendars.action";
			}else if(command=="serialNumMgr"){
				url = webContextPath+"/number/serialNumber_getSerialNumbers.action";
			}else{
				url = webContextPath+"/common/menu_forward.action?command="+command;
			}
			MContentLayout.setContentsURL(url);
		}
	}
	
	//获得功能菜单按钮
	function getFunctionMenuButton(command) {
		var btn = null;
		if(command!=null){
			var btnTitle = "";
			var icon="";
			var menu = null;
			if(command=="sysMgr"){
				btnTitle = "管理";
				icon = Matrix.getComponentIcon('EditForm');
				menu = {
			    	 _constructor: "Menu",
			   		 autoDraw: false,
			    	 showShadow: true,
			    	 shadowDepth: 10,
			   	 	 data: [
				        {title: "业务日历管理",icon:Matrix.getSkinIcon("/matrix/user/matrix/calendarMgr.gif"),
				        	click: "forwardURL('calendarMgr');"
				        },
				        {title: "流水号管理",icon:Matrix.getSkinIcon("/matrix/user/zr/serialNumMgr.gif"),
				        	click: "forwardURL('serialNumMgr');"
				        },
				        {title: "代码管理", icon:Matrix.getSkinIcon("/matrix/user/matrix/codeMgr.gif"),
				        	click: "forwardURL('codeMgr');"}
					  ]
				 };
			}
			
		    btn = isc.IconMenuButton.create({
		            title:btnTitle,
		            menu:menu, autoDraw:false,
		            showBorder:true,
		            orientation: "vertical",
			        backgroundImage:"[SKIN]/matrix/user/matrix/header_menu_bg.png",
		            showMenuIcon:false,width:80,
		            largeIcon:icon,
		            click: "this.menuIconClick()",
		            showDisabledIcon:false,
		            disabled:!mfunctions.contains(command)
		        });
		}
	    return btn;
	}
	
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
			    //click:"changeSkinFun('"+skin+"')"
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
			        		src:""
			})
		);
		//items.add(
		//	getFunctionSeparator()
		//);
		//items.add(
      	// 	getFunctionButton("requirement")
		//);
		//items.add(
		//	getFunctionSeparator()
		//);
		//items.add(
       	//	getFunctionButton("implement")
		//);
		//items.add(
		//	getFunctionSeparator()
		//);
		//items.add(
        //	getFunctionButton("insMgr")
		//);
		//分隔符
		//items.add(
		//	getFunctionSeparator()
		//);
		//调整优化
		//items.add(
        //	getFunctionButton("customize")
		//);
		//items.add(
		//	getFunctionSeparator()
		//);
		//items.add(
        //	getFunctionMenuButton("sysMgr")
		//);
		items.add(
		    isc.HLayout.create({
		        width:"*",height:'100%',
		        align: "center",
			    backgroundImage:"",
		        members:[
		        		getSkinButton("Enterprise"),
		        		getSkinButton("EnterpriseBlue"),
		        		getSkinButton("Graphite")
		         ]
      		 })
		);
		/*items.add(
      		 isc.HLayout.create({
		       	 width:'*',height:45
	      	 })
		);
		*/
		items.add(
	        isc.VLayout.create({
	        	  ID:"MUserInfoLayout",
	              width:300,   
	              height:'100%',    
	              align: "right",top:0,   
	              layoutAlign :"bottom",
			      backgroundImage:"",
	              members:[
	                         isc.Label.create({align: "right", height:20,contents:'欢迎您，'+"${userName}"+"&nbsp;&nbsp;"}),
	                         isc.Label.create({align: "right", height:20,contents:"<a href='javascript:logoff();'>注销</a>&nbsp;&nbsp;"})
	              ]
	         })
		);
		return items;
	}

    isc.VLayout.create({
        ID: "MHeaderLayout",
        position: "relative",
        height: "100%",
        width: "100%",
        align: "center",
        overflow: "auto",
        //animateMembers:true,
        //resizeBarClass:'border:1px;',
        resizeBarSize:1,
        defaultLayoutAlign: "center",
        members: [
			isc.ToolStrip.create({
			    ID: "insertGroup",
			    showTitle:false, height:'60px',overflow:'hidden',
	            width:'100%',
	            backgroundRepeat:'no-repeat',
			    backgroundImage:"<%=request.getContextPath()%>/resource/images/top.png",
			    members:getFunctionItems()
			}),
			isc.HTMLPane.create({
				ID:"MContentLayout",
				height: "100%",
				overflow: "hidden",
				showEdges:false,
				contentsType:"page",
				contentsURL:"<%=request.getContextPath()%>/form/admin/catalog/catalog.jsp"
			})
		] 
    });
    
	//注销
	function logoff(){
		top.location="<%=request.getContextPath()%>/logon/logon_logoff.action";
	}
	//设置head背景
	function setHeadBackgroundStyle(){
		var head = document.getElementById('isc_B');
		head.style.backgroundSize="100% 100%";
	}
  </script>
</body>

</html>