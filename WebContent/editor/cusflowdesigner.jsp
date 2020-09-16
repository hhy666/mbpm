<!DOCTYPE html>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<html>
    <!--
    Copyright [2014] [Diagramo]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
    -->
    <head>
        <title>流程设计器</title>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=9" />
        <script type="text/javascript" src="./assets/javascript/dropdownmenu.js"></script>    
        
        <link rel="stylesheet" media="screen" type="text/css" href="./assets/css/style.css" />
        <link rel="stylesheet" media="screen" type="text/css" href="./assets/css/minimap.css" />
        
        <script type="text/javascript" src="./assets/javascript/json2.js"></script>
        <script type="text/javascript" src="./assets/javascript/jquery-1.11.0.min.js"></script>
        <script type="text/javascript" src="./assets/javascript/ajaxfileupload.js"></script>
             
        <script src='<%=request.getContextPath() %>/resource/html5/js/layer.min.js'></script>
        <script src='<%=request.getContextPath() %>/resource/html5/js/matrix_runtime.js'></script>
        
        <link type='text/css' href='./assets/simplemodal/css/diagramo.css' rel='stylesheet' media='screen' />
        <script type="text/javascript" src="./assets/simplemodal/js/jquery.simplemodal.js"></script>
      <%
      String pdid = request.getParameter("pdid");
      String ptid = request.getParameter("ptid");
      String piid = request.getParameter("piid");
      String processType = request.getParameter("processType");   
      String containerType = request.getParameter("containerType");  //流程process  子流程 subProcess
      String containerId = request.getParameter("containerId");
      String mode = "custom";
      %>        
<style>
   .operationDiv {
	height: 140px;
	background: #FFF;
	border: solid 1px #808080;
	position: absolute;
	z-index: 1000;
	left: 0;
	top: 0;
	display: none;
	box-shadow: 0px 0px 12px 0px #666;
	}
	.operation_list {
	height: 140px;
	overflow: hidden;
	}
	.operation_list a:hover {
	background: rgb(215, 217, 218);
	color: #FFF;
	}
	.operationDiv .operation_list a {
	overflow: hidden;
	font-size: 12px;
    color: #111;
	padding: 5px 5px;
	display: block;
	}
	
	.operationDiv.a {
	text-decoration: none;
	cursor: pointer;
	}
	.operationDiv.a {
	outline: none;
	}
	.clearfix {
	zoom: 1;
	display: block;
	}
	.clearfix:after {
	content: ".";
	display: block;
	height: 0;
	clear: both;
	visibility: hidden;
	}
	::-webkit-scrollbar-track-piece {    
	    background-color:#f5f5f5;  
	    border-left:1px solid #d2d2d2;  
	}  
	::-webkit-scrollbar {    
	    width:4px;  
	    height:5px;   
	}  
	::-webkit-scrollbar-thumb {  
	    border-left:1px solid #d2d2d2;  
	    background: rgb(204, 213, 219);
	    border-radius: 4px; 
	    min-height:28px;  
	}  
	::-webkit-scrollbar-thumb:hover {  
	    border-left:1px solid #d2d2d2;  
	    background: rgb(204, 213, 219);
	    border-radius: 4px;
	}
	</style>
	
	        <style>
        * { margin: 0; padding: 0; }
 
 html, body { height: 100%; width: 100%; }
 
 canvas { display: block; }
</style>
<style type="text/css">
.scroll-wrapper {  
    -webkit-overflow-scrolling: touch;  
    overflow-y: scroll;  
    /* 提示: 请在此处加上需要设置的大小(dimensions)或位置(positioning)信息! */  
}  
.scroll-wrapper iframe {  
    /* 你自己指定的样式 */  
}  
.demo-iframe-holder {  
  position: fixed;   
  right: 0;   
  bottom: 0;   
  left: 0;  
  top: 0;  
  -webkit-overflow-scrolling: touch;  
  overflow-y: scroll;  
}  
  
.demo-iframe-holder iframe {  
  height: 100%;  
  width: 100%;  
}  
</style>	
	<style type="text/css">
.scroll-wrapper {  
    -webkit-overflow-scrolling: touch;  
    overflow-y: scroll;  
    /* 提示: 请在此处加上需要设置的大小(dimensions)或位置(positioning)信息! */  
}  
.scroll-wrapper iframe {  
    /* 你自己指定的样式 */  
}  
.demo-iframe-holder {  
  position: fixed;   
  right: 0;   
  bottom: 0;   
  left: 0;  
  top: 0;  
  -webkit-overflow-scrolling: touch;  
  overflow-y: scroll;  
}  
  
.demo-iframe-holder iframe {  
  height: 100%;  
  width: 100%;  
}  
</style>

         <script type="text/javascript">
         var mode = "custom";  //私人定制流程
		 containerType = "process";
         containerId = "<%=pdid%>";  
         piid = "<%=piid%>";  
         

		  //点击隐藏
    document.onclick = function ()
    {
	   	actdiv.style.display = "none";	
    };
  
     document.oncontextmenu = function (event)
	{
		var event = event || window.event;
		if(selectedFigureId != -1){ //编辑流程
			var figure = STACK.figureGetById(selectedFigureId);
			if(figure.name != "StartAct" && figure.name != "StopAct"){
				actdiv.style.display = "block";
				actdiv.style.top = event.clientY + "px";
				actdiv.style.left = event.clientX + "px";
				actdiv.style.position="absolute"; //必须指定这个属性，否则div层无法跟着鼠标动   
			}	 
		}    
		
		return false;
	};
         
            /*Option 1:
             *We can use window.location like this:
             * url = window.location.protocol + window.location.hostname + ":" + window.location.port + ....
             * @see http://www.w3schools.com/jsref/obj_location.asp
             * 
             * Option 2:
             * Use http://code.google.com/p/js-uri/
             **/
            var appURL = '.';
            var figureSetsURL = appURL + '/editor/lib/sets';
            var insertImageURL = appURL + '/editor/data/import/';
            
            /**Run Diagramo in light mode (no server side)*/
            var light = true;
            
            var ptid = "<%=ptid%>";  
            
            function showImport(){
                //alert("ok");
                var r = confirm("Current diagram will be deleted. Are you sure?");
                if(r === true){                    
                    $('#import-dialog').modal(); // jQuery object; this demo
                }                
            }
            
            function initLight(id){
                init(id);
                //fullVersionWarning();
                loadDiagramFromServer();
                
                document.body.onmousemove = displayTransitionName();
            }
            
            /**
             * Shows a warning about feature not present in Light version
             * */
            function fullVersionWarning(){
                alert("Some features like: Save, Load, Print, Share, Export are not present in Light version of Diagramo due to technical reason.\n\
        Please download one of the full server versions like: LAMP or All-In-One to have them.");
            }

             //添加两个活动的连线
			function connectActs(){
				connectTwoActs("0", "1");
			}	
			
			//删除两个活动的连线
			function removeConnectorOfTwoActs(){
				//CONNECTOR_MANAGER.connectorsRemoveOfActivity("0", "1");
				var dx = 100;
				var dy = 100;
				var moveMatrix = [
        [1, 0, dx],
        [0, 1, dy],
        [0, 0, 1]
        ];

				var figure = STACK.figureGetById("0");
			         //   figure.transform(moveMatrix);
				figure.changePosition(200,200);
										state = STATE_NONE;
			   draw();

			}

			//在两个活动中添加一个新活动
			function insertNewAct(){
				removeConnectorOfTwoActs();

			    createFigure(window["figure_HumanTask"] ,"lib/sets/network/m_human_s.png", "HumanTask");
				var cmdCreateFig = new FigureCreateCommand(window.createFigureFunction, 400, 600);
                var newId = cmdCreateFig.execute();

				//var newId = "2";
				connectTwoActs("0", newId);
				connectTwoActs(newId, "1");
			}
			
			function connectTwoActs(startActId, endActId, id, name, points){
				action('connector-jagged');
				//action('connector-straight');
				var startFigure = STACK.figureGetById(startActId);
				var endFigure = STACK.figureGetById(endActId);
				var startPoint = new Point(startFigure.getX() + startFigure.imageWidth/2, startFigure.getY());
				if(startFigure.name == "SplitAct" || startFigure.name == "ConditionAct"){
					if(startFigure.y != endFigure.y)
						startPoint = new Point(startFigure.getX(), startFigure.getY()+startFigure.imageHeight/2);
				}
				
				var endPoint = new Point(endFigure.getX() - endFigure.imageWidth/2, endFigure.getY());
				if(endFigure.name == "JoinAct"){
					if(startFigure.y != endFigure.y)
						endPoint = new Point(endFigure.getX(), endFigure.getY()+endFigure.imageHeight/2);
				}
				var conId = CONNECTOR_MANAGER.connectorCreate(startPoint, endPoint /*fake cp*/, Connector.TYPE_JAGGED,id);

			    var fOverId = startFigure.id;
				//get the ConnectionPoint's id if we are over it (and belonging to a figure)
				var fCpOverId = CONNECTOR_MANAGER.connectionPointGetByXY(startPoint.x, startPoint.y, ConnectionPoint.TYPE_FIGURE); //find figure's CP
				 var con = CONNECTOR_MANAGER.connectorGetById(conId);
				 if(name != null)
				 	con.updateName(name);

				   //1.get CP of the connector
				var conCps = CONNECTOR_MANAGER.connectionPointGetAllByParent(conId);

				//see if we can snap to a figure
				if(fCpOverId != -1){ //Are we over a ConnectionPoint from a Figure?
					var fCp = CONNECTOR_MANAGER.connectionPointGetById(fCpOverId);

					//update connector' cp
					conCps[0].point.x = fCp.point.x;
					conCps[0].point.y = fCp.point.y;

					//update connector's turning point
					con.turningPoints[0].x = fCp.point.x;
					con.turningPoints[0].y = fCp.point.y;

					var g = CONNECTOR_MANAGER.glueCreate(fCp.id, conCps[0].id, false);
					Log.info("First glue created : " + g);
					//alert('First glue ' + g);
				} else if (fOverId !== -1) { //Are we, at least, over the {Figure}?
					
					/*As we are over a {Figure} but not over a {ConnectionPoint} we will switch
					 * to automatic connection*/
					var point = new Point(startPoint.x,startPoint.y);
					var candidate = CONNECTOR_MANAGER.getClosestPointsOfConnection(
						true,    // automatic start
						true,    // automatic end 
						fOverId, //start figure's id
						point,   //start point 
						fOverId, //end figure's id
						point    //end point
					);

					var connectionPoint = candidate[0];

					//update connector' cp
					conCps[0].point.x = conCps[1].point.x = connectionPoint.x;
					conCps[0].point.y = conCps[1].point.y = connectionPoint.y;

					//update connector's turning point
					con.turningPoints[0].x = con.turningPoints[1].x = connectionPoint.x;
					con.turningPoints[0].y = con.turningPoints[1].y = connectionPoint.y;

					var g = CONNECTOR_MANAGER.glueCreate(candidate[2], conCps[0].id, true);
					Log.info("First glue created : " + g);
				}

			  //second
			  connectorPickSecond2(endPoint.x, endPoint.y,conId);

				CONNECTOR_MANAGER.connectionPointsResetColor();

				con.fromActId = startActId;
				con.toActId = endActId;
      
				state = STATE_NONE;
				HandleManager.clear();
				
				var points = [];
				var length = con.turningPoints.length;
				for(var i=0; i<length; ++i){
				    var turningPoint = con.turningPoints[i];
				    points[i] = new Point(turningPoint.x, turningPoint.y);
				}

				con.turningPoints = points;

				if(points != null)
					con.turningPoints = points;

			   draw();

			}
			
 function saveDiagramFromServer2(){
		var url="<%=request.getContextPath() %>/flow.dflow";
		var flowInfo=saveDiagram();
		var flowInfoStr = JSON.stringify(flowInfo); 
		var param="componentType=flow&mode=custom&piid=<%=piid%>&command=publishDiagram&containerType=process&flowContent="+flowInfoStr;
		getUrlData(url,param,function(data){
			//var data = eval(data);
			if("false" != data){
				ptid = data;
				alert("保存流程成功!");
				parent.setPtid(ptid);
				//parent.MOpenDesignWin.hide();
			}
		  }	
		);
	}	
	
	
 function saveDiagramFromServer(){
 		
		var url="<%=request.getContextPath() %>/flow.dflow";
		var flowInfo=getDiagramInfo();
		var flowInfoStr = JSON.stringify(flowInfo); 
		var param="mode=<%=mode%>&componentType=flow&piid=<%=piid%>&command=publishDiagram&containerType=<%=containerType%>";
		var data = {};
        data["flowContent"]=flowInfoStr;
		sendRequest(url,param,data, function(data){
			//var data = eval(data);
			if("false" != data){
				ptid = data;
				alert("保存流程成功!");
				parent.setPtid(ptid);
			}
		  }	
		);
	}		

			function saveDiagram(){
			     var actFigs = STACK.figures;
				 var swimlines = STACK.groups;
				 var connectors = CONNECTOR_MANAGER.connectors;

				 var flowInfo = {};
				 var actInfos = [];
				 for(var i=0 ; i< actFigs.length; ++i){
				    var actFig = actFigs[i];
					var actInfo = {};
					actInfo.x = actFig.getX();
					actInfo.y = actFig.getY();
					actInfo.id = actFig.id;
					actInfo.type = actFig.name;
					actInfos[i] = actInfo;
				 }

                  var transitions = [];
				  for(var i=0 ; i< connectors.length; ++i){
				    var connector = connectors[i];
					var transition = {};
					transition.id = connector.id;
					transition.name = connector.name;
					transition.fromActId = connector.fromActId;
					transition.toActId = connector.toActId;

					var points = [];
					var length = connector.turningPoints.length;
					for(var k=0; k<length; ++k){
						var turningPoint = connector.turningPoints[k];
						var point = {};
						point.x = turningPoint.x;
						point.y = turningPoint.y;
						points[k] = point;
					}
					transition.points = points;
					transitions[i] = transition;
				 }

				  flowInfo.activities = actInfos;
				  flowInfo.transitions = transitions;
				  
				  var swimlines = [];
				  flowInfo.swimlines = swimlines;

				 return flowInfo;
			}


			


	function loadDiagramFromServer2(){
		//var data = {'activities':[{id:'huiqian',name:'会签',x:413,y:235,type:'HumanTask'},{id:'1612207988',name:'结束',x:654,y:98,type:'StopAct'},{id:'fh',name:'行政部复核',x:524,y:84,type:'HumanTask'},{id:'shh',name:'部门意见',x:289,y:82,type:'HumanTask'},{id:'82932263458',name:'申请',x:160,y:230,type:'HumanTask'},{id:'16121584557',name:'开始',x:54,y:96,type:'StartAct'}],'transitions':[{id:'948472629014',name:'',fromActId:'16121584557',toActId:'82932263458',points:[{x:87,y:127},{x:178,y:229}]},{id:'948552247336',name:'',fromActId:'shh',toActId:'huiqian',points:[{x:357,y:139},{x:433,y:234}]},{id:'94855254138',name:'',fromActId:'huiqian',toActId:'fh',points:[{x:478,y:234},{x:547,y:141}]},{id:'948552810540',name:'',fromActId:'fh',toActId:'1612207988',points:[{x:613,y:112},{x:653,y:113}]},{id:'948472923216',name:'部门意见审批',fromActId:'82932263458',toActId:'shh',points:[{x:229,y:229},{x:308,y:139}]}]};
		var data = {'activities':[{id:'huiqian',name:'会签',x:422,y:100,type:'HumanTask'},{id:'1612207988',name:'结束',x:702,y:100,type:'HumanTask'},{id:'fh',name:'行政部复核',x:572,y:100,type:'HumanTask'},{id:'shh',name:'部门意见',x:272,y:100,type:'HumanTask'},{id:'82932263458',name:'申请',x:122,y:100,type:'HumanTask'},{id:'16121584557',name:'开始',x:49,y:100,type:'HumanTask'}],'transitions':[{id:'948472629014',name:'',fromActId:'16121584557',toActId:'82932263458',points:[{x:87,y:127},{x:178,y:229}]},{id:'948552247336',name:'',fromActId:'shh',toActId:'huiqian',points:[{x:357,y:139},{x:433,y:234}]},{id:'94855254138',name:'',fromActId:'huiqian',toActId:'fh',points:[{x:478,y:234},{x:547,y:141}]},{id:'948552810540',name:'',fromActId:'fh',toActId:'1612207988',points:[{x:613,y:112},{x:653,y:113}]},{id:'948472923216',name:'部门意见审批',fromActId:'82932263458',toActId:'shh',points:[{x:229,y:229},{x:308,y:139}]}]};
		//  var data ={'activities':[{id:'82932263458',name:'申请',x:142,y:82,type:'HumanTask'},{id:'huiqian',name:'会签',x:410,y:84,type:'HumanTask'},{id:'1612207988',name:'结束',x:671,y:95,type:'StopAct'},{id:'shh',name:'部门意见',x:289,y:82,type:'HumanTask'},{id:'fh',name:'行政部复核',x:524,y:84,type:'HumanTask'},{id:'16121584557',name:'开始',x:54,y:96,type:'StartAct'}],'transitions':[{id:'948552247336',name:'',fromActId:'shh',toActId:'huiqian',points:[{x:375,y:108},{x:406,y:108}]},{id:'948472923216',name:'部门意见审批',fromActId:'82932263458',toActId:'shh',points:[{x:228,y:107},{x:285,y:107}]},{id:'94855254138',name:'',fromActId:'huiqian',toActId:'fh',points:[{x:495,y:108},{x:519,y:108}]},{id:'948552810540',name:'',fromActId:'fh',toActId:'1612207988',points:[{x:609,y:107},{x:666,y:106}]},{id:'948472629014',name:'',fromActId:'16121584557',toActId:'82932263458',points:[{x:90,y:108},{x:138,y:107}]}]};
		data = eval(data);
		var activities = data.activities;
			var transitions = data.transitions;
			loadDiagram(activities, transitions);
	}
	
	
     function loadDiagramFromServer(){
     showMask();
		var url="<%=request.getContextPath() %>/flow.dflow";
		var param="mode=custom&componentType=flow&command=loadDiagram&fromDB=true&piid=<%=piid%>&ptid=<%=ptid%>&pdid=<%=pdid%>&containerType=process";
		getUrlData(url,param,function(data){
			var data = eval('(' +data+ ')');
			var activities = data.activities;
			var transitions = data.transitions;
			loadDiagram(activities, transitions);
			
			document.getElementById("container").style.display="block";
            document.getElementById("info").style.display="none";
			
			hideMask();
		  }	
		);
	}
	
	function editTransition (){
	}
	
	function editActivity(){
	    if(selectedFigureId == null || selectedFigureId == -1){
	    	alert("请先选中编辑活动!");
	    	return;
	    }
	
		var figure = STACK.figureGetById(selectedFigureId);
		
		var status = figure.status;
	    if(status > 0){  //运行中或者已经完成的环节不允许
	       alert("运行中或者已经完成的环节不修改!");
	       return;
	    }
	    
		if(figure.name == "HumanTask" ){
		
/*		    var width = screen.availWidth * 0.6;  
	        var height = screen.availHeight * 0.6;  
	        var left = parseInt((screen.availWidth/2) - (width/2));//屏幕居中  
	        var top = parseInt((screen.availHeight/2) - (height/2)); 
	        var windowFeatures = "width=" + width + ",height=" + height + ",status,resizable=no,left=" + left + ",top=" + top + "screenX=" + left + ",screenY=" + top;  
			window.open('<%=request.getContextPath() %>/mobile/flowEdit_dealHumanActivity.action?piid=<%=piid%>&adid='+selectedFigureId+'&processType=<%=processType%>','编辑活动',windowFeatures);
*/
			var width = screen.availWidth * 0.7;  
	        var height = screen.availHeight * 0.7;  
	        var left = parseInt((screen.availWidth/2) - (width/2));//屏幕居中  
	        var top = parseInt((screen.availHeight/2) - (height/2)); 

	        var windowFeatures = "width=" + width + ",height=" + height + ",status,resizable=no,left=" + left + ",top=" + top + "screenX=" + left + ",screenY=" + top;  
			
			var processPage = layer.open({
				id:"editProcess",
				type : 2,
				
				title : ['编辑活动'],
				closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
				shadeClose: false, //开启遮罩关闭
				area : [ '90%', '90%' ],
				content : '<%=request.getContextPath() %>/mobile/flowEdit_dealHumanActivity.action?piid=<%=piid%>&adid='+selectedFigureId+'&processType=<%=processType%>'
			});

		}	
	}
	
	function addCurActParallel(){
	    if(selectedFigureId == null || selectedFigureId == -1){
	    	alert("请先选中添加当前会签活动!");
	    	return;
	    }
	
		var figure = STACK.figureGetById(selectedFigureId);
		var status = figure.status;
	    if(status == 3){  
	       alert("已经完成的环节不允许添加当前会签!");
	       return;
	    }
	    
	    if(selectedFigureId == '432375828421'){
	       alert("发起环节不允许添加当前会签!");
	       return;
	    }
	    
		if(figure.name == "StopAct"){
		       alert("不允许在完成活动后加签!");
		       return;
		}

	
/*	    var width = 800;  
        var height = 500;  
        var left = parseInt((screen.availWidth/2) - (width/2));//屏幕居中  
        var top = parseInt((screen.availHeight/2) - (height/2)); 
        var windowFeatures = "width=" + width + ",height=" + height + ",status,resizable=no,left=" + left + ",top=" + top + "screenX=" + left + ",screenY=" + top;  
		window.open('<%=request.getContextPath() %>/mobile/flowEdit_loadActivityInfo.action?processType=<%=processType%>&executeWay=split','选择当前会签人员',windowFeatures);
*/
			var width = screen.availWidth * 0.7;  
	        var height = screen.availHeight * 0.7;  
	        var left = parseInt((screen.availWidth/2) - (width/2));//屏幕居中  
	        var top = parseInt((screen.availHeight/2) - (height/2)); 

	        var windowFeatures = "width=" + width + ",height=" + height + ",status,resizable=no,left=" + left + ",top=" + top + "screenX=" + left + ",screenY=" + top;  
			
			var processPage = layer.open({
				id:"editProcess",
				type : 2,
				
				title : ['编辑活动'],
				closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
				shadeClose: false, //开启遮罩关闭
				area : [ '90%', '90%' ],
				content : '<%=request.getContextPath() %>/mobile/flowEdit_loadActivityInfo.action?processType=<%=processType%>&executeWay=split'
			});

	}
	
	var addType = "1";
		
	function addActivity(){
	    if(selectedFigureId == null || selectedFigureId == -1){
	    	alert("请先选中加签发起活动!");
	    	return;
	    }
	
		var figure = STACK.figureGetById(selectedFigureId);
		var status = figure.status;
	    if(status == 3){  
	       alert("已经完成的环节不允许加签!");
	       return;
	    }
	
		if(figure.name == "StopAct"){
		       alert("不允许在完成活动后加签!");
		       return;
		}
			var width = screen.availWidth * 0.7;  
	        var height = screen.availHeight * 0.7;  
	        var left = parseInt((screen.availWidth/2) - (width/2));//屏幕居中  
	        var top = parseInt((screen.availHeight/2) - (height/2)); 

	        var windowFeatures = "width=" + width + ",height=" + height + ",status,resizable=no,left=" + left + ",top=" + top + "screenX=" + left + ",screenY=" + top;  
			
	    	addType = "1"; //普通加签
			var processPage = layer.open({
				id:"editProcess",
				type : 2,
				
				title : ['编辑活动'],
				closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
				shadeClose: false, //开启遮罩关闭
				area : [ '90%', '90%' ],
				content : '<%=request.getContextPath() %>/mobile/flowEdit_loadActivityInfo.action?processType=<%=processType%>&addType=1'
			});

	}
	
	function addMultiLevelActivity(){
	    if(selectedFigureId == null || selectedFigureId == -1){
	    	alert("请先选中加签发起活动!");
	    	return;
	    }
	
		var figure = STACK.figureGetById(selectedFigureId);
		var status = figure.status;
	    if(status == 3){  
	       alert("已经完成的环节不允许加签!");
	       return;
	    }
	
			var width = screen.availWidth * 0.7;  
	        var height = screen.availHeight * 0.7;  
	        var left = parseInt((screen.availWidth/2) - (width/2));//屏幕居中  
	        var top = parseInt((screen.availHeight/2) - (height/2)); 

	        var windowFeatures = "width=" + width + ",height=" + height + ",status,resizable=no,left=" + left + ",top=" + top + "screenX=" + left + ",screenY=" + top;  
			
	        addType = "2";  //多级会签
			var processPage = layer.open({
				id:"editProcess",
				type : 2,
				
				title : ['编辑活动'],
				closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
				shadeClose: false, //开启遮罩关闭
				area : [ '90%', '90%' ],
				content : '<%=request.getContextPath() %>/mobile/flowEdit_loadActivityInfo.action?processType=<%=processType%>&addType=2'
			});

	}
	
	function setPtid(ptid){
		parent.setPtid(ptid);
	}
		
	function addActivityCallBack(info){
		var userIds = info.userIds;
		var userNames = info.userNames;
		var types = info.types;
		var flowType = info.flowType;
		var authId = info.authId;
		var authName = info.authName;
		var isSetCalendar = info.isSetCalendar;
		var calendarId = info.calendarId;
		var duration = info.duration;
		var durationType = info.durationType;
		var executeWay = info.executeWay;
		
		
		var url="<%=request.getContextPath() %>/flow.dflow";
		var param="mode=custom&componentType=customAct&command=addActs&pdid=<%=pdid%>&flowType="+flowType+"&containerType=process&preActId="+selectedFigureId+"&userIds="+userIds+"&userNames="+userNames+"&executeWay="+executeWay;
		param = param +"&types="+types +"&authId="+authId+"&authName="+authName+"&isSetCalendar="+isSetCalendar+"&calendarId="+calendarId+"&duration="+duration+"&durationType="+durationType+"&piid="+piid+"&addType="+addType;
		param = encodeURI(param);
		getUrlData(url,param,function(data){
			var data = eval('(' +data+ ')');
			var activities = data.activities;
			var transitions = data.transitions;
			var ptid = data.ptid;
			loadDiagram(activities, transitions);

			parent.setPtid(ptid);
		  }	
		);
		
	}
	
	function exit(){
		var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
		parent.layer.close(index);
		//window.close();
		//parent.MOpenDesignWin.hide();
	}

     function deleteActivity(){
	    if(selectedFigureId == null || selectedFigureId == -1){
	    	alert("请先选中删除活动!");
	    	return;
	    }else if(selectedFigureId.indexOf('c_')==-1){
	    	alert("非自定义类型不允许删除!");
	    	return;
	    }
	    
		var selectFigure = STACK.figureGetById(selectedFigureId);
	    var status = selectFigure.status;
	    if(status > 0){  //运行中或者已经完成的环节不允许删除
	    	alert("运行中或者已经完成的环节不允许删除!");
	    	return;
	    }  
	    
		var url="<%=request.getContextPath() %>/flow.dflow";
		var param="mode=custom&componentType=customAct&command=delete&piid=<%=piid%>&pdid=docFlow&containerType=process&componentId="+selectedFigureId;
		getUrlData(url,param,function(data){
			var data = eval('(' +data+ ')');
			var activities = data.activities;
			var transitions = data.transitions;
			var ptid = data.ptid;
			loadDiagram(activities, transitions);
			parent.setPtid(ptid);
		  }	
		);
	}
	
	var scale = parseFloat("1");
	

        </script>
        
        <script type="text/javascript" src="./lib/canvasprops.js"></script>
        <script type="text/javascript" src="./lib/style.js"></script>
        <script type="text/javascript" src="./lib/primitives.js"></script>
        <script type="text/javascript" src="./lib/ImageFrame.js"></script>
        <script type="text/javascript" src="./lib/matrix.js"></script>
        <script type="text/javascript" src="./lib/util.js"></script>
        <script type="text/javascript" src="./lib/key.js"></script>
        <script type="text/javascript" src="./lib/groups.js"></script>
        <script type="text/javascript" src="./lib/stack.js"></script>
        <script type="text/javascript" src="./lib/connections.js"></script>
        <script type="text/javascript" src="./lib/connectionManagers.js"></script>
        <script type="text/javascript" src="./lib/handles.js"></script>
        
        
        <script type="text/javascript" src="./lib/builder.js"></script>        
        <script type="text/javascript" src="./lib/text.js"></script>
        <script type="text/javascript" src="./lib/log.js"></script>
        <script type="text/javascript" src="./lib/text.js"></script>
        <script type="text/javascript" src="./lib/browserReady.js"></script>
        <script type="text/javascript" src="./lib/containers.js"></script>
        <script type="text/javascript" src="./lib/importer.js"></script>
        <script type="text/javascript" src="./lib/main.js"></script>
        
        <script type="text/javascript" src="./lib/sets/basic/basic.js"></script>
        <script type="text/javascript" src="./lib/sets/flow/flow.js" charset="UTF-8" ></script>
        
        <script type="text/javascript" src="./lib/minimap.js"></script>

        <script type="text/javascript" src="./lib/commands/History.js"></script>

        <script type="text/javascript" src="./lib/commands/FigureCreateCommand.js"></script>
        <script type="text/javascript" src="./lib/commands/FigureCloneCommand.js"></script>
        <script type="text/javascript" src="./lib/commands/FigureTranslateCommand.js"></script>
        <script type="text/javascript" src="./lib/commands/FigureRotateCommand.js"></script>
        <script type="text/javascript" src="./lib/commands/FigureScaleCommand.js"></script>
        <script type="text/javascript" src="./lib/commands/FigureZOrderCommand.js"></script>
        <script type="text/javascript" src="./lib/commands/FigureDeleteCommand.js"></script>
        
        <script type="text/javascript" src="./lib/commands/GroupRotateCommand.js"></script>
        <script type="text/javascript" src="./lib/commands/GroupScaleCommand.js"></script>
        <script type="text/javascript" src="./lib/commands/GroupCreateCommand.js"></script>
        <script type="text/javascript" src="./lib/commands/GroupCloneCommand.js"></script>
        <script type="text/javascript" src="./lib/commands/GroupDestroyCommand.js"></script>
        <script type="text/javascript" src="./lib/commands/GroupDeleteCommand.js"></script>
        <script type="text/javascript" src="./lib/commands/GroupTranslateCommand.js"></script>
        
        
        <script type="text/javascript" src="./lib/commands/ContainerCreateCommand.js"></script>
        <script type="text/javascript" src="./lib/commands/ContainerDeleteCommand.js"></script>
        <script type="text/javascript" src="./lib/commands/ContainerTranslateCommand.js"></script>
        <script type="text/javascript" src="./lib/commands/ContainerScaleCommand.js"></script>
        
        <script type="text/javascript" src="./lib/commands/ConnectorCreateCommand.js"></script>
        <script type="text/javascript" src="./lib/commands/ConnectorDeleteCommand.js"></script>                                
        <script type="text/javascript" src="./lib/commands/ConnectorAlterCommand.js"></script>
        
        <script type="text/javascript" src="./lib/commands/ShapeChangePropertyCommand.js"></script>
        
        <script type="text/javascript" src="./lib/commands/CanvasChangeColorCommand.js"></script>
        <script type="text/javascript" src="./lib/commands/CanvasChangeSizeCommand.js"></script>

        <script type="text/javascript" src="./lib/commands/InsertedImageFigureCreateCommand.js"></script>

        
        <script>
		     function addHumanTask(){
			 createFigure(window["figure_HumanTask"] ,"lib/sets/network/m_human_s.png", "HumanTask");
			 }
		</script>
        <!--[if IE]>
        <script src="./assets/javascript/excanvas.js"></script>
        <![endif]-->
       
    </head>
    <body onload="initLight('');" id="body" style="overflow:hidden;">
        

        <div id="actions">
                        
            <a href="javascript:addActivity();"  title="加签"><img src="assets/images/add.png" border="0"/></a>

            <img class="separator" src="assets/images/toolbar_separator.gif" border="0" width="1" height="16"/>
            
 			<a href="javascript:addCurActParallel();"  title="当前会签"><img src="assets/images/vertical_distribute.png" border="0"/></a>

            <img class="separator" src="assets/images/toolbar_separator.gif" border="0" width="1" height="16"/>
            
 			<a href="javascript:addMultiLevelActivity();"  title="多级会签"><img src="assets/images/vertical_distribute.png" border="0"/></a>

            <img class="separator" src="assets/images/toolbar_separator.gif" border="0" width="1" height="16"/>
                        
            <a href="javascript:deleteActivity();" title="减签"><img src="assets/images/delete.png" border="0"/></a>
            
            <img class="separator" src="assets/images/toolbar_separator.gif" border="0" width="1" height="16"/>
            
            <a href="javascript:editActivity();" title="编辑"><img src="assets/images/edit.png" border="0" alt="Organiaaaa"/></a>
            
            <img class="separator" src="assets/images/toolbar_separator.gif" border="0" width="1" height="16"/>
            
<!--           <a href="javascript:saveDiagramFromServer();" title="保存流程"><img src="assets/images/save.png" border="0" alt="保存"/></a>
            
            <img class="separator" src="assets/images/toolbar_separator.gif" border="0" width="1" height="16"/>            
 -->                          
            <a href="javascript:exit();" title="退出"><img src="assets/images/exit.png" border="0" alt="退出"/></a>
            

        </div>
        
<div id="pad" style="padding:0px;margin:0px;width:10px;height:10px;left:0px;top:0px;position:absolute;z-index:100;"></div>

<script>
	//设置流转线名称,main.js中鼠标移动时调用
	function setTransitionName(content){
		var obj = document.getElementById("pad");
		obj.innerHTML = content;
	}
	//显示流转线名称
	function displayTransitionName(){
	
		var obj = document.getElementById("pad");
		obj.style.left = event.clientX+10+'px';
		obj.style.top = event.clientY+10+'px';
	
	}
	
</script>        
        <div class="scroll-wrapper" id="editor" style="width: 100%; height:95%; " >
            
            <!--THE canvas-->
                <div  id="container" class="scroll-wrapper" style="width: 100%; height:100%;display:none;"  onselectstart="return false">
                    <canvas id="a" >
                        Your browser does not support HTML5. Please upgrade your browser to any modern version.
                    </canvas>
                    <div id="text-editor"></div>
                    <div id="text-editor-tools"></div>
                </div>
            <div  id="info" style="width: 100%; height:100%;">
            		
                	<br>
                	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;正在加载,请稍候...
                </div>
           
            
        </div>
        
        <br/>
         
	 <div id="actdiv" class="operationDiv" style="display:none;width:150px;"> 
              <div class="operation_list">
                <a style="height:26px;" href="javascript:addActivity();"><img src="assets/images/add.png" width="16" height="16"/><span style="margin-left:20px;">加签</span></a>
                <a style="height:26px;" href="javascript:addCurActParallel();"><img src="assets/images/add.png" width="16" height="16"/><span style="margin-left:20px;">当前会签</span></a>
                <a style="height:26px;" href="javascript:addMultiLevelActivity();"><img src="assets/images/add.png" width="16" height="16"/><span style="margin-left:20px;">多级会签</span></a>
                <a style="height:26px;" href="javascript:deleteActivity();"><img src="assets/images/delete.png" width="16" height="16"/><span style="margin-left:20px;">减签</span></a>
                <a style="height:26px;" href="javascript:editActivity();"><img src="assets/images/edit.png" width="16" height="16"/><span style="margin-left:20px;">编辑</span></a>
              </div>
         </div>            


    </body>
</html>
