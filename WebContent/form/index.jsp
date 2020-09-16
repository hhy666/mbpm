<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.matrix.form.admin.common.utils.CommonUtil"%>
<!DOCTYPE HTML >
<html>


<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Matrix Form 控制台</title>
<jsp:include page="/form/admin/common/taglib.jsp" />
<jsp:include page="/form/admin/common/resource.jsp" />
</head>

<body>
<jsp:include page="/form/admin/common/loading.jsp" />
<script>
	//获得功能按钮
	function getFunctionButton (command) {
		if(command!=null){
			var btnTitle = "";
			var icon="";
			if(command=="requirement"){
				btnTitle = "需求建模";
				icon = Matrix.getComponentIcon('EditForm');
			}else if(command=="development"){
				btnTitle = "设计开发";
				icon = Matrix.getComponentIcon('EditForm');
			}else if(command=="insMgr"){
				btnTitle = "实例监控";
				icon = Matrix.getComponentIcon('EditForm');
			}
		    btn = isc.IconButton.create({
			            title:btnTitle,
			            valign:'center',
			            orientation:"vertical",
			            width:80,height:50,
			            iconSize:80,
			            largeIcon:icon,
			            click: "forwardURL('"+command+"');"
			        });
		}
	 	return btn;
	}
	
	//跳转
	function forwardURL(command){
		if(command!=null){
			var url = webContextPath+"/common/menu_forward.action?command="+command;
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
				        {title: "业务日历管理",icon:"icons/16/document_plain_new.png",
				        	click: "forwardURL('calendarMgr');"
				        },
				        {title: "代码管理", icon: "icons/16/folder_out.png",
				        	click: "forwardURL('codeMgr');"}
					  ]
				 };
			}
			
		    btn = isc.IconMenuButton.create({
		            title:btnTitle,
		            menu:menu,
		            showBorder:true,
		            orientation: "vertical",
		            showMenuIcon:false,width:80,height:50,
		            valign:'center',
		            largeIcon:icon,
		            click: "this.menuIconClick()"
		        });
		}
	    return btn;
	}
	
	//获得功能分割符
	function getFunctionSeparator(){
		var sep = isc.ToolStripSeparator.create({width:10,height:50});
		return sep;
	}
	
	//获得切换风格按钮
	function getSkinButton(skin){
		var btn = null;
		if(skin!=null){
			var icon = "[SKIN]/matrix/skins/"+skin+".png";
			//btn = isc.ToolStripButton.create({
			// 	 	icon:icon,
			btn = isc.ImgButton.create({
			    src:icon,
			    width:18,height:18,   
			    actionType: "radio",
			    radioGroup: "skinBtn",
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
			isc.Img.create({orientation: "vertical", 
		                   	width:300, height:60,src:"[SKIN]/matrix/header_left.jpg"
			})
		);
		items.add(
			getFunctionSeparator()
		);
		items.add(
      	 	getFunctionButton("requirement")
		);
		items.add(
			getFunctionSeparator()
		);
		items.add(
       		getFunctionButton("development")
		);
		items.add(
			getFunctionSeparator()
		);
		items.add(
        	getFunctionButton("insMgr")
		);
		items.add(
			getFunctionSeparator()
		);
		items.add(
        	getFunctionMenuButton("sysMgr")
		);
		items.add(
		    isc.HLayout.create({
		        width:200,height:60,
		        align: "center",
		         //layoutAlign :"bottom",
		        members:[
		        		getSkinButton("Enterprise"),
		        		getSkinButton("EnterpriseBlue"),
		        		getSkinButton("Graphite")
		         ]
      		 })
		);
		items.add(
      		 isc.HLayout.create({
		       	 width:'*',height:60
	      	 })
		);
		items.add(
	        isc.VLayout.create({
	        	  ID:"MUserInfoLayout",
	              width:300,   
	              height:'100%',    
	              align: "right",         
	              layoutAlign :"bottom",
	              backgroundImage:'[SKIN]/matrix/header_right.jpg',
	              members:[
	                         isc.Label.create({align: "right", height:20,contents:'欢迎：admin'}),
	                         isc.Label.create({align: "right", height:20,contents:"<a href='#'>注销</a>&nbsp;&nbsp;"})
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
			    showTitle:false, height:60,
			    width:'100%',backgroundImage:'[SKIN]/matrix/header_center.jpg',
			    members:getFunctionItems()
			}),
			isc.HTMLPane.create({
				ID:"MContentLayout",
				height: "100%",
				overflow: "hidden",
				showEdges:false,
				contentsType:"page",
				contentsURL:"<%=request.getContextPath()%>/form/admin/logon/matrix/welcome.jsp"
			})
		] 
    });
  </script>
</body>

</html>