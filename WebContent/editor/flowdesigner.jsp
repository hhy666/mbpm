<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.matrix.engine.foundation.config.MFSystemProperties"%>
<%@ page import="com.matrix.form.admin.common.utils.CommonUtil" %>
<%  
		int curPhase = CommonUtil.getCurPhase();
	%>
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
        <link href='<%=request.getContextPath() %>/resource/html5/css/bootstrap/dist/css/bootstrap.min.css' rel="stylesheet"></link>
        <link href='<%=request.getContextPath() %>/resource/html5/css/font-awesome.min.css' rel="stylesheet"></link>
        <link href='<%=request.getContextPath() %>/resource/html5/css/skin/mCustom_<%=session.getAttribute("skin") %>.css' rel="stylesheet"></link>
        
        <script type="text/javascript" src="./assets/javascript/json2.js"></script>
        <script type="text/javascript" src="./assets/javascript/jquery-1.11.0.min.js"></script>
        <script type="text/javascript" src="./assets/javascript/ajaxfileupload.js"></script>
        
        <SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/layer.min.js'></SCRIPT>
        <SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/matrix_runtime.js'></SCRIPT>
        <SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/laydate/laydate.js'></SCRIPT>
        <SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/css/bootstrap/dist/js/bootstrap.min.js'></SCRIPT>
        
        <link type='text/css' href='./assets/simplemodal/css/diagramo.css' rel='stylesheet' media='screen' />

<link href='<%=request.getContextPath() %>/resource/html5/assets/toastr-master/toastr.min.css'  rel="stylesheet"></link>

<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/assets/toastr-master/toastr.min.js'></SCRIPT>
        
<style>
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

/***************************mask***********************************/
#matrixMask{
	width:100%;
	height:100%;
	position:absolute;
	top:1;
	left:1;
	z-index:9999999999999;
}


.matrixMask{
	#background-color:#ffffff;
	background: url(images/opacity.png);
}

   .operationDiv {
	height: 100px;
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
	height: 100px;
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
	padding: 3px 3px;
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
	
	.button2 {
/*		cursor: pointer;
    	background-color: #E5E5E5;
    	text-align: center;*/
    	display:block;width:202px;height:62px;  text-align:center; font-family:arial,verdana,sans-serif, '新宋体';   background:#f3f1f1; text-decoration:none; border: 1px solid #e6e4e4; cursor:pointer}
  .dow:hover{background:#e6e4e4;}
  .dow:active{background:#e6e4e4;
    }

	.nav > li > a {
	    position: relative;
	    display: block;
	    padding: 5px 20px;
	}
	a {
	   color: #333;
	   text-decoration: none;
	}
	
	.x-btn {
		text-decoration: none;
	    -webkit-border-radius: 2px;
	    -moz-border-radius: 2px;
	    border-radius: 2px;
	    cursor: pointer;
	    height: 36px;
	    line-height: 34px;
	    text-align: center;
	    border: 1px solid transparent;
	    overflow: hidden;
	    text-overflow: ellipsis;
	    white-space: nowrap;
	    -webkit-transition: background;
	    -moz-transition: background;
	    -o-transition: background;
	    transition: background;
	    -webkit-transition-duration: .3s;
	    -moz-transition-duration: .3s;
	    -o-transition-duration: .3s;
	    transition-duration: .3s;
	}
	
	.x-btn:hover{
		background-color: #ebebeb;
	}
	.form-control {
	    border-radius: 0;
	}
    .select-pane {
	    border: 1px solid #e0e0e0;
	    border-top: none;
	    position: absolute;
	    height: calc(100% - 40px);
	    left: 0;
	    bottom: 0;
	    right: 0;
	}
	.activity-pane,.process-pane{
		height: 100%;
		padding: 5px 5px 0px 5px;
	    overflow: auto;
	}
	.empty-message{
		padding-top: 150px;
		font-size: 18px;
		color: #989898;
		text-align: center;
	}
	</style>
	        
        <script type="text/javascript" src="./assets/simplemodal/js/jquery.simplemodal.js"></script>
      <%
      //当前容器类型和定义编码,流程为pdid,活动为adid
      String containerType = request.getParameter("containerType");  //流程process  子流程 subProcess
      String containerId = request.getParameter("containerId");
      String processType = request.getParameter("processType");   
      String pdid = request.getParameter("pdid");   
      String ptid = request.getParameter("ptid");
      String piid = request.getParameter("piid");
      String mode = request.getParameter("mode");   // flow 普通方式  custom 业务人员定制方式
      String flowLoadType = request.getParameter("flowLoadType");
      
      String initFlag = request.getParameter("initFlag");  //从数据库加载标识
      %>        
        <style>
        * { margin: 0; padding: 0; }
 
 
canvas { display: block; }
 
 * { margin:0; padding:0;}
body {  height:100%;font:75% Verdana, Arial, Helvetica, sans-serif;font-size:14px}
h1 { font:125% Arial, Helvetica, sans-serif; text-align:left; font-weight:bolder; /*background:#333;*/   display:block; color:#99CC00}
.class1 { width:100%;  position:relative; margin:0 auto; background-color: #e2e2e2;}
span { /*position:absolute; right:10px;*/  cursor: pointer; }
p { text-align:center; line-height:20px; /*background:#333; padding:3px; margin-top:5px;*/ }
#class1content, #class2content,#class3content,#class4content { height:50px;overflow:hidden;display:none;}
span { display:-moz-inline-box; display:inline-block; }
.bujian:hover{/*background:#F5F5F5;*/background:#CEEFFD;}

</style>
         <script type="text/javascript">
         /*
         window.onbeforeunload=function() { 
               if(internalChange){  //如果是进入子流程或返回主流程,不需要做什么
               		internalChange = false;
               		return;
               	}	
               		
				var result = window.event.returnValue="确认要退出当前流程设计页面吗?"; 
		} 
        */
         
         var mode = "<%=mode%>";  //完整流程
         
         
			function use(targetid){
				var d=document.getElementById(targetid);
				if (d.style.display=="block"){
				} else {
					var p = $("span[id^='class']");
					for(var i=0,l=p.length;i<l;i++){
						if(p[i]!=d){
						p[i].style.height=0;
						p[i].style.display="none";
					}
				}
				d.style.height="calc(100% - 144px)";
				d.style.display="block";
			}
		}
		
		
		  //点击隐藏
    document.onclick = function ()
    {
	   	actdiv.style.display = "none";	
		subflowdiv.style.display = "none";	
		flowdiv.style.display = "none";	
    };
  
     document.oncontextmenu = function (event)
	{
	   	actdiv.style.display = "none";	
		subflowdiv.style.display = "none";	
		flowdiv.style.display = "none";	
	
		var event = event || window.event;
		
		var type = document.getElementById('type').value;
		
		if(selectedFigureId == null || selectedFigureId == -1){ //编辑流程
			if(type == "Connector" || selectedContainerId != -1) {  //流转线和泳道不显示右键菜单
				
			}else{
				flowdiv.style.display = "block";
				flowdiv.style.top = event.clientY + "px";
				flowdiv.style.left = event.clientX + "px";
				flowdiv.style.position="absolute"; //必须指定这个属性，否则div层无法跟着鼠标动    
			}
		}else{
			var figure = STACK.figureGetById(selectedFigureId);
			if(figure.name == "BlockAct"){
				subflowdiv.style.display = "block";
				subflowdiv.style.top = event.clientY + "px";
				subflowdiv.style.left = event.clientX + "px";
				subflowdiv.style.position="absolute"; //必须指定这个属性，否则div层无法跟着鼠标动    
			}else{
				actdiv.style.display = "block";
				actdiv.style.top = event.clientY + "px";
				actdiv.style.left = event.clientX + "px";
				actdiv.style.position="absolute"; //必须指定这个属性，否则div层无法跟着鼠标动    
			}
		}    
		
		return false;
	};
         
	function infoMsg(message){
		//isc.say(message);
		//layer.msg(message, {icon: 1});
		toastr.options = {
				  "closeButton": true,
				  "progressBar": false
			}
		toastr.info("",message);
	}
	
	function errorMsg(message){
		//isc.say(message);
		//layer.msg(message, {icon: 1});
		toastr.options = {
				  "closeButton": true,
				  "progressBar": false
			}
		toastr.error('',message);
	}
         
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
            
            var containerType = "<%=containerType%>";
            var containerId = "<%=containerId%>";  
            var pdid = "<%=pdid%>";
            var ptid = "<%=ptid%>";  
            var piid = "<%=piid%>";  
            var flowStatus = "";
            var initFlag = "<%=initFlag%>";
            var processType = "<%=processType%>";
            
            var selectedGroupId = -1;
            var selectedFigureId = -1;
            
            var internalChange = false;
            
            function showImport(){
                //infoMsg("ok");
                var r = confirm("Current diagram will be deleted. Are you sure?");
                if(r === true){                    
                    $('#import-dialog').modal(); // jQuery object; this demo
                }                
            }
            
            function initLight(id){
                init(id);
                //fullVersionWarning();
                loadDiagramFromServer();
            }
            
            function downloadProcess(){
                internalChange = true;
            
            	var url="<%=request.getContextPath() %>/flow.dflow";
				var flowInfo=getDiagramInfo();
				var flowInfoStr = JSON.stringify(flowInfo); 
				var param="mode=<%=mode%>&componentType=flow&piid=<%=piid%>&command=saveDiagramInfo&containerType="+containerType+"&containerId="+containerId;
				var data = {};
		        data["flowContent"]=flowInfoStr;
				sendRequest(url,param,data, function(data){
					if("false" != data){
		            	window.location.href = "<%=request.getContextPath() %>/FlowDesignerServlet?command=download";
					}else{
						errorMsg("下载流程失败!");
					}
				  }	
				);
            
            }
            
            function openFile(){
			    var width = screen.availWidth * 0.4;  
		        var height = screen.availHeight * 0.4;  
		        var left = parseInt((screen.availWidth/2) - (width/2));//屏幕居中  
		        var top = parseInt((screen.availHeight/2) - (height/2)); 
	
		        var windowFeatures = "width=" + width + ",height=" + height + ",status,resizable=no,left=" + left + ",top=" + top + "screenX=" + left + ",screenY=" + top;  
				window.open('<%=request.getContextPath() %>/form/admin/process/importFlowXmlFile.jsp','读取本地流程文件',windowFeatures);
            }
            
            /**
             * Shows a warning about feature not present in Light version
             * */
            function fullVersionWarning(){
                infoMsg("Some features like: Save, Load, Print, Share, Export are not present in Light version of Diagramo due to technical reason.\n\
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
			
			function connectByPoints(startActId, endActId, startFigure, endFigure, id, name, points){
					var startPoint = null;
					var endPoint = null;
					var turnpoints = [];
					var length = points.length - 2;

				    for(var i=0 ; i< points.length; ++i){
					    var point = points[i];
					    if(i == 0){
					    	startPoint = new Point(point.x, point.y);
					    }
					    else if(i == (points.length-1) ){
					    	endPoint =  new Point(point.x, point.y);
					    }else{
						    //turnpoints[i-1] = new Point(point.x, point.y);
					    }
					    
					    turnpoints[i] = new Point(point.x, point.y);
					    
					}
				    
					var conId = CONNECTOR_MANAGER.connectorCreate(startPoint, endPoint /*fake cp*/, Connector.TYPE_JAGGED,id, name);
	
				    var fOverId = startFigure.id;
					//get the ConnectionPoint's id if we are over it (and belonging to a figure)
					var fCpOverId = CONNECTOR_MANAGER.connectionPointGetByXY(startPoint.x, startPoint.y, ConnectionPoint.TYPE_FIGURE); //find figure's CP
					 var con = CONNECTOR_MANAGER.connectorGetById(conId);
					 //if(name != null)
					 	//con.updateName(name);
	
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
						//infoMsg('First glue ' + g);
					} else if (fOverId !== -1) { //Are we, at least, over the {Figure}?
						
						/*As we are over a {Figure} but not over a {ConnectionPoint} we will switch
						 * to automatic connection*/
						/*var point = new Point(startPoint.x,startPoint.y);
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
						*/
						CONNECTOR_MANAGER.connectorRemoveById(conId, true);
						return false;
					}else{
						CONNECTOR_MANAGER.connectorRemoveById(conId, true);
						return false;
					}

				    //second
				    connectorPickSecond2(endPoint.x, endPoint.y,conId);
	
					CONNECTOR_MANAGER.connectionPointsResetColor();
	
					con.fromActId = startActId;
					con.toActId = endActId;
	      
					state = STATE_NONE;
					HandleManager.clear();
					
					con.turningPoints = turnpoints;
	
					if(turnpoints != null && turnpoints.length>0)
						con.turningPoints = turnpoints;

					return true;
			}
			
			function connectByActs(startActId, endActId, startFigure, endFigure, id, name, points){
					var startPoint = new Point(startFigure.getX() + startFigure.imageWidth/2, startFigure.getY());
					if(startFigure.name == "SplitAct"){
						if(startFigure.y != endFigure.y)
							startPoint = new Point(startFigure.getX(), startFigure.getY()+startFigure.imageHeight/2);
					}
					
					var endPoint = new Point(endFigure.getX() - endFigure.imageWidth/2, endFigure.getY());
					if(endFigure.name == "JoinAct"){
						if(startFigure.y != endFigure.y)
							endPoint = new Point(endFigure.getX(), endFigure.getY()+endFigure.imageHeight/2);
					}
					var conId = CONNECTOR_MANAGER.connectorCreate(startPoint, endPoint /*fake cp*/, Connector.TYPE_JAGGED,id,name);
	
				    var fOverId = startFigure.id;
					//get the ConnectionPoint's id if we are over it (and belonging to a figure)
					var fCpOverId = CONNECTOR_MANAGER.connectionPointGetByXY(startPoint.x, startPoint.y, ConnectionPoint.TYPE_FIGURE); //find figure's CP
					 var con = CONNECTOR_MANAGER.connectorGetById(conId);
					 //if(name != null)
					 	//con.updateName(name);
	
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
						//infoMsg('First glue ' + g);
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
			}

			function connectTwoActs(startActId, endActId,  id, name, points){
				action('connector-jagged');
				//action('connector-straight');
				var startFigure = STACK.figureGetById(startActId);
				var endFigure = STACK.figureGetById(endActId);
				
				if(points && points.length >= 2){
					var isSnap = connectByPoints(startActId, endActId, startFigure, endFigure, id, name, points);

					if(!isSnap)//can not snap the transition points to the acts, connect the acts directly						
						connectByActs(startActId, endActId, startFigure, endFigure, id, name, points);
				}else{
					connectByActs(startActId, endActId, startFigure, endFigure, id, name, points);
					
				}

			   draw();
			}
			
 function publishDiagramFromServer(){
 		 if("RELEASED" == flowStatus){
			infoMsg("已发布流程不允许再发布!");
		    return;
	    }
 		internalChange = true;
 		
 		showMask();
 		
		var url="<%=request.getContextPath() %>/flow.dflow";
		var flowInfo=getDiagramInfo();
		var flowInfoStr = JSON.stringify(flowInfo); 
//		var param="mode=<%=mode%>&componentType=flow&piid=<%=piid%>&command=publishDiagram&containerType=<%=containerType%>&flowContent="+flowInfoStr;
		var param="mode=<%=mode%>&componentType=flow&piid=<%=piid%>&command=publishDiagram&containerType=<%=containerType%>";
		var data = {};
        data["flowContent"]=flowInfoStr;
		sendRequest(url,param,data, function(data){
            hideMask();
			//var data = eval(data);
            if("validateError" == data){
				infoMsg("流程校验失败,不允许发布,请查看流程校验!");
			}else if("false" == data){
				errorMsg("发布流程失败!");
			}else{
				ptid = data;
				infoMsg("发布流程成功!");
				flowStatus = "RELEASED";
				document.getElementById("statusTxt").innerHTML="已发布";
			}
            
		  }	
		);
	}	
 
 function releaseDiagramFromServer(){
	if("RELEASED" != flowStatus){
			infoMsg("未发布流程不支持取消发布!");
	    return;
    }
	
	internalChange = true;
	
	layer.confirm( "取消已发布流程会自动删除相关流程实例信息，是否继续取消发布？",{  time: 0,yes:function (index) {layer.close(index);exeReleaseProc()},no:function (index){Matrix.hideMask();return false;}});
		
	
}	
 
    function exeReleaseProc(){
    	var url="<%=request.getContextPath() %>/flow.dflow";
    	var flowInfo=getDiagramInfo();
    	var flowInfoStr = JSON.stringify(flowInfo); 
//    	var param="mode=<%=mode%>&componentType=flow&piid=<%=piid%>&command=releaseDiagram&containerType=<%=containerType%>&flowContent="+flowInfoStr;
    	var param="mode=<%=mode%>&componentType=flow&piid=<%=piid%>&ptid=<%=ptid%>&command=releaseDiagram&containerType=<%=containerType%>";
    	var data = {};
        data["flowContent"]=flowInfoStr;
    	sendRequest(url,param,data, function(data){
    		//var data = eval(data);
    		if("false" == data){
    			errorMsg("取消发布流程失败!");
    		}else{
    			ptid = null;
    			infoMsg("取消发布流程成功!");
    			flowStatus = "UNDER_REVISION";
    			document.getElementById("statusTxt").innerHTML="未发布";
    		}
    	  }	
    	);
    }
	
	
	
	 function saveDiagramFromServer(){
	    if("RELEASED" == flowStatus){
			infoMsg("已发布流程不允许再保存!");
		    return;
	    }

	    internalChange = true;
	    
	    showMask();
	 
		var url="<%=request.getContextPath() %>/flow.dflow";
		var flowInfo=getDiagramInfo();
		var flowInfoStr = JSON.stringify(flowInfo); 
		var param="mode=<%=mode%>&componentType=flow&piid=<%=piid%>&command=saveDiagram&containerType="+containerType+"&containerId="+containerId;
		var data = {};
        data["flowContent"]=flowInfoStr;
		sendRequest(url,param,data, function(data){
		    hideMask();
			if("false" != data){
				ptid = data;
				infoMsg("保存流程成功!");
			}else{
				errorMsg("保存流程失败!");
			}
		  }	
		);
	}	
	
			function getDiagramInfo(){
			     var actFigs = STACK.figures;
				 var swimlineFigs = STACK.containers;
				 var connectors = CONNECTOR_MANAGER.connectors;

				 var flowInfo = {};

				 var swimlines = [];
				 for(var i=0 ; i< swimlineFigs.length; ++i){
				    var swimlineFig = swimlineFigs[i];
					var swimline = {};
					swimline.x = swimlineFig.topLeft.x;
					swimline.y = swimlineFig.topLeft.y;
					swimline.width=swimlineFig.bottomRight.x - swimlineFig.topLeft.x;
					swimline.height=swimlineFig.bottomRight.y - swimlineFig.topLeft.y;
					swimline.id = swimlineFig.id;
					swimline.type = swimlineFig.type;
					swimlines[i] = swimline;
				 }

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
	
	function returnProcessList(){
		var url = "<%=request.getContextPath() %>/process/ruleAction_queryRules.action?processId=${param.processId}";
		window.location.href = url;
	}
	
	function setInitFlag(value){
		this.initFlag = value;
	}
	
     function loadDiagramFromServer(){
    	 showMask();
    	 	
		var url="<%=request.getContextPath() %>/flow.dflow";
		
		
		var param="mode=<%=mode%>&componentType=flow&command=loadDiagram&fromDB="+initFlag+"&piid=<%=piid%>&ptid=<%=ptid%>&pdid=<%=pdid%>&containerType="+containerType+"&containerId="+containerId;

		getUrlData(url,param,function(data){
			var data = eval('(' +data+ ')');
			var activities = data.activities;
			var transitions = data.transitions;
			var swimlines = data.swimlines;
            pdid = data.pdid;
            ptid = data.ptid;
			flowStatus = data.status;
			if("RELEASED" == flowStatus){
	    		document.getElementById("statusTxt").innerHTML="已发布";
	    		infoMsg("流程已发布,只能查看,不能修改!");
			}else{
	    		document.getElementById("statusTxt").innerHTML="未发布";
			}
			loadDiagram(activities, transitions,swimlines);
			

			//重新刷新transition文本
			var connectors = CONNECTOR_MANAGER.connectors;
			 for(var i=0 ; i< connectors.length; ++i){
				    var connector = connectors[i];
				    var length = connector.turningPoints.length;
				    if(length >=2){
				    	connector.updateMiddleText();
				    }
			 }	   
			 
            selectedGroupId = -1;
            selectedFigureId = -1;
            
            document.getElementById("container").style.display="block";
            document.getElementById("info").style.display="none";
            
            //初始流程属性
            exeInitProcProperties();
			hideMask();
		  }	
		);
	}
	
	function editProcess(){
	///editor/flow/editFlowProMainPage.jsp?optType=2&processId=
	}
	
	function validateProcess(){
		    var width = screen.availWidth * 0.5;  
	        var height = screen.availHeight * 0.5;  
	        var left = parseInt((screen.availWidth/2) - (width/2));//屏幕居中  
	        var top = parseInt((screen.availHeight/2) - (height/2)); 

	        var windowFeatures = "width=" + width + ",height=" + height + ",status,resizable=no,left=" + left + ",top=" + top + "screenX=" + left + ",screenY=" + top;  
			window.open('<%=request.getContextPath() %>/editor/validationListPage.jsp','流程校验信息',windowFeatures);
	}
	
	function editActivity(operation){
	
	    if(selectedFigureId == null || selectedFigureId == -1 || operation == 'process'){ //编辑流程
		    var width = screen.availWidth * 0.7;  
	        var height = screen.availHeight * 0.7;  
	        var left = parseInt((screen.availWidth/2) - (width/2));//屏幕居中  
	        var top = parseInt((screen.availHeight/2) - (height/2)); 

	        var windowFeatures = "width=" + width + ",height=" + height + ",status,resizable=no,left=" + left + ",top=" + top + "screenX=" + left + ",screenY=" + top;  
	//		window.open('<%=request.getContextPath() %>/editor/flow/editFlowProMainPage.jsp?mode=<%=mode%>&optType=2&processId=<%=pdid%>&containerId=<%=containerId%>&containerType=<%=containerType%>','编辑活动',windowFeatures);
			
			var processPage = layer.open({
				id:"editProcess",
				type : 2,
				
				title : ['编辑流程'],
				closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
				shade: [0.1, '#000'],
				shadeClose: false, //开启遮罩关闭
				area : [ '75%', '90%' ],
				content : '<%=request.getContextPath() %>/editor/flow/editFlowProMainPage.jsp?mode=<%=mode%>&optType=2&processId=<%=pdid%>&containerId=<%=containerId%>&containerType=<%=containerType%>'
			});
	    }else{//编辑活动
		    var width = screen.availWidth * 0.7;  
	        var height = screen.availHeight * 0.7;  
	        var left = parseInt((screen.availWidth/2) - (width/2));//屏幕居中  
	        var top = parseInt((screen.availHeight/2) - (height/2)); 
			var figure = STACK.figureGetById(selectedFigureId);
			
			if("StartAct" == figure.name)
				return;
				
			if(figure != null && figure != -1){
		        var windowFeatures = "width=" + width + ",height=" + height + ",status,resizable=no,left=" + left + ",top=" + top + "screenX=" + left + ",screenY=" + top;
		        
		        var type = figure.name;
				if(type == "StopAct" || type == "ConditionAct" || type == "SplitAct" || type == "JoinAct"){
//					window.open('<%=request.getContextPath() %>/editor/frame/loadLogicActivityTreeNodePage.jsp?mode=<%=mode%>&activityId='+selectedFigureId+"&type="+figure.name+"&processdid=<%=pdid%>&containerId=<%=containerId%>&processType=<%=processType%>&containerType=<%=containerType%>",'编辑活动',windowFeatures);
					var activityPage1 = layer.open({
						id:"activityPage1",
						type : 2,
						
						title : ['编辑活动'],
						closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
						shade: [0.1, '#000'],
						shadeClose: false, //开启遮罩关闭
						area : [ '75%', '90%' ],
						content : '<%=request.getContextPath() %>/editor/frame/loadLogicActivityTreeNodePage.jsp?mode=<%=mode%>&activityId='+selectedFigureId+'&type='+figure.name+'&processdid=<%=pdid%>&containerId=<%=containerId%>&processType=<%=processType%>&containerType=<%=containerType%>',
	cancel: function(index, layero){ 
 		var url = "<%=request.getContextPath()%>/editor/editor_clearSession.action";
		getUrlData(url,"",function(data){});
  		return true; 
	}    
					});
				}else{
					var activityPage2 = layer.open({
						id:"activityPage2",
						type : 2,
						
						title : ['编辑活动'],
						closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
						shade: [0.1, '#000'],
						shadeClose: false, //开启遮罩关闭
						area : [ '75%', '90%' ],
						content : '<%=request.getContextPath() %>/editor/frame/loadBasicActivityTreeNodePage.jsp?mode=<%=mode%>&activityId='+selectedFigureId+'&type='+figure.name+'&processdid=<%=pdid%>&containerId=<%=containerId%>&processType=<%=processType%>&containerType=<%=containerType%>',
						cancel: function(index, layero){ 
						 		var url = "<%=request.getContextPath()%>/editor/editor_clearSession.action";
								getUrlData(url,"",function(data){});
						  		return true; 
							}    					
					
					});
//					window.open('<%=request.getContextPath() %>/editor/frame/loadBasicActivityTreeNodePage.jsp?mode=<%=mode%>&activityId='+selectedFigureId+"&type="+figure.name+"&processdid=<%=pdid%>&containerId=<%=containerId%>&processType=<%=processType%>&containerType=<%=containerType%>",'编辑活动',windowFeatures);
				}
 			}	
				
			document.getElementById('text-editor').focus();
	    }
	
	}
	
	function editSwimline(contId){
		    var width = screen.availWidth * 0.7;  
	        var height = screen.availHeight * 0.7;  
	        var left = parseInt((screen.availWidth/2) - (width/2));//屏幕居中  
	        var top = parseInt((screen.availHeight/2) - (height/2)); 
 				if(contId != null && contId != -1){
 					var contaienr = STACK.containerGetById(contId);
			        var windowFeatures = "width=" + width + ",height=" + height + ",status,resizable=no,left=" + left + ",top=" + top + "screenX=" + left + ",screenY=" + top;  
					//window.open('<%=request.getContextPath() %>//editor/frame/loadSwimLineTreeNodePage.jsp??mode=<%=mode%>&swimlineId='+contId+"&type="+contaienr.type+"&processdid=<%=pdid%>&containerId=<%=containerId%>&containerType=<%=containerType%>",'编辑活动',windowFeatures);
					var swimlinepg = layer.open({
						id:"swimlinepg",
						type : 2,
						
						title : ['编辑泳道'],
						closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
						shade: [0.1, '#000'],
						shadeClose: false, //开启遮罩关闭
						area : [ '75%', '90%' ],
						content : '<%=request.getContextPath() %>//editor/frame/loadSwimLineTreeNodePage.jsp??mode=<%=mode%>&swimlineId='+contId+'&type='+contaienr.type+'&processdid=<%=pdid%>&containerId=<%=containerId%>&containerType=<%=containerType%>'
					});
 				}
	}
	
	function updateActName(actId, newName){
			debugger;
			var figure = STACK.figureGetById(actId);
			figure.updateName(newName);
			draw();
	}
	
	function updateSwimlineName(swimlineId, newName){
			var contaienr = STACK.containerGetById(swimlineId);
			contaienr.updateName(newName);
			draw();
	}
	
	function updateTransitionName(transitionId, newName){
			var con = CONNECTOR_MANAGER.connectorGetById(transitionId);
			con.updateName(newName);
			draw();
	}
	
	function editTransition(cId){
	    if(cId != null || cId != -1){
		    var width = 800;  
	        var height = 600;  
	        var left = parseInt((screen.availWidth/2) - (width/2));//屏幕居中  
	        var top = parseInt((screen.availHeight/2) - (height/2)); 
	        var windowFeatures = "width=" + width + ",height=" + height + ",status,resizable=no,left=" + left + ",top=" + top + "screenX=" + left + ",screenY=" + top;
			//window.open("<%=request.getContextPath() %>/editor/frame/loadActivityLineTreeNodePage.jsp?type=ActivityLine&&processdid=<%=pdid%>&transitionId="+cId+"&containerId=<%=containerId%>&containerType=<%=containerType%>",'编辑活动',windowFeatures);
			
			var transitionpg = layer.open({
						id:"transitionpg",
						type : 2,
						
						title : ['编辑转移'],
						closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
						shade: [0.1, '#000'],
						shadeClose: false, //开启遮罩关闭
						area : [ '70%', '90%' ],
						content : '<%=request.getContextPath() %>/editor/frame/loadActivityLineTreeNodePage.jsp?type=ActivityLine&&processdid=<%=pdid%>&transitionId='+cId+'&containerId=<%=containerId%>&containerType=<%=containerType%>'
					});
	    }
	
	}
	
	function addCusActivity(){
	    if(selectedFigureId == null || selectedFigureId == -1){
	    	infoMsg("请先选中添加发起活动!");
	    	return;
	    }
	
	    var width = 800;  
        var height = 500;  
        var left = parseInt((screen.availWidth/2) - (width/2));//屏幕居中  
        var top = parseInt((screen.availHeight/2) - (height/2)); 
        var windowFeatures = "width=" + width + ",height=" + height + ",status,resizable=no,left=" + left + ",top=" + top + "screenX=" + left + ",screenY=" + top;  
		window.open('<%=request.getContextPath() %>/mobile/usersSelectPage.jsp','选择加签人员',windowFeatures);
	}
		
	function exit(){
		window.close();
		//parent.MOpenDesignWin.hide();
	}

     function deleteActivity(){
	 	if(this.selectedContainerId > 0){
			//var figuresIds = STACK.figureGetIdsByGroupId(this.selectedContainerId);
			var figure = STACK.containerGetById(this.selectedContainerId);
			 var figuresIds = CONTAINER_MANAGER.getAllFigures(this.selectedContainerId);
			var adids = "";			
	        for(var i=0; i<figuresIds.length; i++){
	        	if(i>0)
	        		adids= adids+",";
	        	adids = adids+figuresIds[i];
	        	
	        }
	        	var url="<%=request.getContextPath() %>/flow.dflow";
				var param="mode=<%=mode%>&componentType="+figure.type+"&command=delete&groupId="+selectedContainerId+"&pdid="+pdid+"&containerId=<%=containerId%>&containerType=<%=containerType%>&componentId="+adids;
				getUrlData(url,param,function(data){
						var cmdDelFig = new ContainerDeleteCommand(selectedContainerId);
						cmdDelFig.execute();
				        draw();
						History.addUndo(cmdDelFig);
				
				        for(var i=0; i<figuresIds.length; i++){
			 				var cmdDelFig = new FigureDeleteCommand(figuresIds[i]);
							cmdDelFig.execute();
					        draw();
							History.addUndo(cmdDelFig);
				        }
				        
				}	
				);
     	 }
		
     	 if(this.selectedGroupId > 0){
			var figuresIds = STACK.figureGetIdsByGroupId(this.selectedGroupId);
			var adids = "";			
	        for(var i=0; i<figuresIds.length; i++){
	        	if(i>0)
	        		adids= adids+",";
	        	adids = adids+figuresIds[i];
	        	
	        }

	        	var url="<%=request.getContextPath() %>/flow.dflow";
				var param="mode=<%=mode%>&componentType=VSwimline&command=delete&pdid="+pdid+"&containerId=<%=containerId%>&containerType=<%=containerType%>&componentId="+adids;
				getUrlData(url,param,function(data){
						var cmdDelFig = new GroupDeleteCommand(selectedGroupId);
						cmdDelFig.execute();
				        draw();
						History.addUndo(cmdDelFig);
				
				       /* for(var i=0; i<figuresIds.length; i++){
			 				var cmdDelFig = new GroupDeleteCommand(figuresIds[i]);
							cmdDelFig.execute();
					        draw();
							History.addUndo(cmdDelFig);
				        }*/
				        
				}	
				);
     	 }
				
	     if(this.selectedFigureId > 0){
	     	var selectFigure = STACK.figureGetById(selectedFigureId);
	    
	        var figure = STACK.figureGetById(selectedFigureId);
			var url="<%=request.getContextPath() %>/flow.dflow";
			var param="mode=<%=mode%>&componentType="+figure.name+"&command=delete&pdid="+pdid+"&containerType=<%=containerType%>&componentId="+selectedFigureId;
			getUrlData(url,param,function(data){
	 				var cmdDelFig = new FigureDeleteCommand(selectedFigureId);
					cmdDelFig.execute();
			        draw();
					History.addUndo(cmdDelFig);
			}	
			);
	     }
	     
	     initProperties('',pdid);
		
	}
	
	function saveAsLocalImage () { 
		var myCanvas = document.getElementById("a"); 
		// here is the most important part because if you dont replace you will get a DOM 18 exception. 
		var image = myCanvas.toDataURL("image/png").replace("image/png", "image/octet-stream;Content-Disposition: attachment;filename="+pdid+".png"); 
		//var image = myCanvas.toDataURL("image/png").replace("image/png", "image/octet-stream"); 
		internalChange = true;
		window.location.href=image; // it will save locally
	} 
	
	//当流程设计器中点了活动或泳道但没有移动到流程图中就释放鼠标时删除后台模型已添加的活动
    function clearActivity(type, actId){
	 	if(type == 'HumanTask' || type == 'SubflowAct' || type == 'BlockAct' || type == 'StartAct' || type == 'StopAct' || type == 'ConditionAct' || type == 'SplitAct' || type == 'JoinAct' ){
	        	var url="<%=request.getContextPath() %>/flow.dflow";
				var param="mode=<%=mode%>&componentType="+type+"&command=delete&pdid="+pdid+"&containerId=<%=containerId%>&containerType=<%=containerType%>&componentId="+actId;
				getUrlData(url,param,function(data){
				}	
				);
     	 }
		
	 	else if(type == 'HSwimline' || type == 'VSwimline' ){
	 		var figuresIds = STACK.figureGetIdsByGroupId(actId);
			var adids = "";			
	        for(var i=0; i<figuresIds.length; i++){
	        	if(i>0)
	        		adids= adids+",";
	        	adids = adids+figuresIds[i];
	        	
	        }
	        	var url="<%=request.getContextPath() %>/flow.dflow";
				var param="mode=<%=mode%>&componentType="+type+"&groupId="+actId+"&command=delete&pdid="+pdid+"&containerId=<%=containerId%>&containerType=<%=containerType%>&componentId="+adids;
				getUrlData(url,param,function(data){
				}	
				);
     	 }
				
	     initProperties('',pdid);
		
	}


    function backProcess(){
       internalChange = true;
    	var url="<%=request.getContextPath() %>/flow.dflow";
		var flowInfo=getDiagramInfo();
		var flowInfoStr = JSON.stringify(flowInfo); 
		//var param="mode=<%=mode%>&componentType=flow&piid=<%=piid%>&command=saveDiagramInfo&containerType=<%=containerType%>&containerId=<%=containerId%>&flowContent="+flowInfoStr;
		var param="mode=<%=mode%>&componentType=flow&piid=<%=piid%>&command=saveDiagramInfo&containerType=<%=containerType%>&containerId=<%=containerId%>";

		var data = {};
        data["flowContent"]=flowInfoStr;
		sendRequest(url,param,data, function(data){		
		//getUrlData(url,param,function(data){
			//var data = eval(data);
			if("false" != data){
			    var oldSelectedId = selectedFigureId;
			    selectedGroupId = -1;
            	selectedFigureId = -1;
            	containerId = pdid;
            	containerType = "process"; 
		    	window.location="<%=request.getContextPath() %>/editor/flowdesigner.jsp?mode=<%=mode%>&pdid=<%=pdid%>&ptid=<%=ptid%>&containerType=process&containerId="+pdid;
			}
		  }	
		);
    }
    
    function enterSubProcess(){
        internalChange = true;
    	var url="<%=request.getContextPath() %>/flow.dflow";
		var flowInfo=getDiagramInfo();
		var flowInfoStr = JSON.stringify(flowInfo); 
		//var param="mode=<%=mode%>&componentType=flow&piid=<%=piid%>&command=saveDiagramInfo&containerType=<%=containerType%>&containerId=<%=containerId%>&flowContent="+flowInfoStr;
		var param="mode=<%=mode%>&componentType=flow&piid=<%=piid%>&command=saveDiagramInfo&containerType=<%=containerType%>&containerId=<%=containerId%>";
		
		var data = {};
        data["flowContent"]=flowInfoStr;
		sendRequest(url,param,data, function(data){		
		//getUrlData(url,param,function(data){
			//var data = eval(data);
			if("false" != data){
			    var oldSelectedId = selectedFigureId;
			    selectedGroupId = -1;
            	selectedFigureId = -1;
            	containerId = oldSelectedId;
            	containerType = "subProcess"; 
		    	window.location="<%=request.getContextPath() %>/editor/flowdesigner.jsp?mode=<%=mode%>&pdid=<%=pdid%>&ptid=<%=ptid%>&containerType=subProcess&adid="+oldSelectedId+"&containerId="+oldSelectedId;
			}
		  }	
		);
    
    }
    
    function sendRequest(url,param,data,callback){
        url = url+"?"+param
        showMask();
		$.ajax({
	        type : "POST",
	        url : url,
	        data: data,
	        error : function(){
				hideMask();
				errorMsg("服务器操作异常,请与管理员联系!");
	        },
	
	        success : function(data) {
	        	callback(data);
	        	hideMask();
	        }
	    })
    }
    
	$(document).ready(function () {
		//监听标签页DIV点击切换事件
		$('#activity').click(function(){
			$('.activity-pane').css('display','block'); 
			$('.process-pane').css('display','none'); 
			$("#activity").addClass("select");
			$("#process").removeClass("select");
			if(document.getElementById('table001').style.display == 'none'){
				document.getElementById('emptyMessage').style.display = '';
			}else{
				document.getElementById('emptyMessage').style.display = 'none';
			}
		});
		$('#process').click(function(){
			$('.process-pane').css('display','block'); 
			$('.activity-pane').css('display','none'); 
			$("#process").addClass("select");
			$("#activity").removeClass("select");
		});
		
		laydate.render({
			elem: '#fromDate', 
			format: 'yyyy-MM-dd',
			done: function(value, date, endDate){
				var element = {};
				element.name = 'fromDate';
				element.value = value;
				updateBasicInfoByType(element);
			}
		})
		laydate.render({
			elem: '#toDate', 
			format: 'yyyy-MM-dd',
			done: function(value, date, endDate){
				var element = {};
				element.name = 'toDate';
				element.value = value;
				updateBasicInfoByType(element);
			}
		})
		
	});
    
	function initProcProperties(){
	    setTimeout("exeInitProcProperties();",200);

	}
    
    function exeInitProcProperties(){
    	debugger;
		document.getElementById('emptyMessage').style.display = 'none';
		document.getElementById('table001').style.display = 'none';
		//初始加载流程的基本属性信息
		var url="<%=request.getContextPath() %>/editor/editor_loadBasicInfoByType.action";
		var param="type=&processdid="+pdid+"&containerType="+containerType+"&containerId="+containerId;
		sendRequest(url,param,null, function(data){
			if(data!=null){
				var obj = JSON.parse(data);
				var processCode = obj.processCode;   //编码
				var processName = obj.processName;  //名称
				var processDesc = obj.processDesc;  //描述
				var processPriority = obj.processPriority;  //优选级
				var author = obj.author;  //作者
				var version = obj.version;  //版本
				var fromStr = obj.fromStr;  //开始期限
				var toStr = obj.toStr;  //结束期限
				
				document.getElementById('processCode').value = obj.processCode;
				document.getElementById('processName').value = obj.processName;
				document.getElementById('processDesc').value = obj.processDesc;
				var select = document.getElementById('processPriority');  
			    for (var i = 0; i < select.options.length; i++){  
			        if (select.options[i].value == priority){  
			            select.options[i].selected = true;  //选中
			            break;  
			        }  
			    } 
			    document.getElementById('author').value = author;
			    document.getElementById('version').value = version;
			    document.getElementById('fromDate').value = fromStr;
			    document.getElementById('toDate').value = toStr;
			}
		});
    }
	
	//弹出授权类型窗口
	function openpopupSelectDialogSec(){
		var processType = "<%=processType%>";
		layer.open({
	    	id:'popupSelectDialogSec',
			type : 2,
			
			title : ['请选择授权信息'],
			shade: [0.1, '#000'],
			shadeClose: false, //开启遮罩关闭
			area : [ '30%', '55%' ],
			content : '<%=request.getContextPath()%>/mobile/securityInfoPage.jsp?iframewindowid=popupSelectDialogSec&flag=false&processType='+processType
		});  
	}
	//选择授权类型窗口回调
	function onpopupSelectDialogSecClose(data){
		if(data!=null){
			var authId = data.uuid;
			var groupName = data.groupName;
			document.getElementById('authId').value = authId;
			document.getElementById('authName').value = groupName;
			
			var element = {};
			element.name = 'authName';
			element.value = groupName;
			element.authId = authId;
			updateBasicInfoByType(element); 
		}
	}
	
	
	var pType;   //修改属性类型
	var pId; //修改属性编码
	
	//异步去后台加载基本属性
	function initProperties(type,id){
		pType = type;
	    pId = id;
	    setTimeout("exeInitProperties();",200);

	}	
	
	//异步去后台加载基本属性
	function exeInitProperties(){
		debugger;
	
		var type = pType;
		var id = pId;
	
		if(type != ''){  //点击的活动 连线  泳道
			$('.activity-pane').css('display','block'); 
			document.getElementById('emptyMessage').style.display = 'none';
			document.getElementById('table001').style.display = '';
			$('.process-pane').css('display','none'); 
			$("#activity").addClass("select");
			$("#process").removeClass("select");
			
			var phase = '<%= session.getAttribute("matrix_phaseId")%>';
			
			if(type == 'StartAct' || type == 'StopAct' || type == 'ConditionAct' || type == 'SplitAct' || type == 'JoinAct'){   //逻辑活动
				document.getElementById('name').readOnly = true;  //名称只读
			}else{
				document.getElementById('name').readOnly = false;  
			}
					
			if(type == 'HumanTask' || type == 'Connector'){     //人工活动或编辑连线
				//优先级
				document.getElementById('tr007').style.display = '';
				document.getElementById('tr008').style.display = '';
			}else{
				//优先级
				document.getElementById('tr007').style.display = 'none';
				document.getElementById('tr008').style.display = 'none';
			}
			if(type == 'HumanTask'){   //人工活动
				//授权类型
				document.getElementById('tr009').style.display = '';
				document.getElementById('tr010').style.display = '';
			}else{
				//授权类型
				document.getElementById('tr009').style.display = 'none';
				document.getElementById('tr010').style.display = 'none';
			}
			if(type == 'HumanTask' && phase == '4'){  //人工活动并且是实施阶段 
				//操作权限按钮
				document.getElementById('tr011').style.display = '';
			}else{
				//操作权限按钮
				document.getElementById('tr011').style.display = 'none';
			}
			
			//记录类型和编码
			document.getElementById('type').value = type;
			document.getElementById('id').value = id;
		}else{   //点击的流程
			/*
			$('.process-pane').css('display','block'); 
			$('.activity-pane').css('display','none'); 
			$("#process").addClass("select");
			$("#activity").removeClass("select");
			*/
			document.getElementById('emptyMessage').style.display = '';
			document.getElementById('table001').style.display = 'none';
		}
		
		var param = "&type="+type+"";
		if(type!=''){
			if(type == 'Connector'){   //连线
				param += "&transitionId="+id+"";
			}else if(type == 'Container'){   //泳道
				param += "&swimlineId="+id+"";
			}else{
				param += "&activityId="+id+"";
			}
		}
		param += "&processdid="+pdid+"&containerType="+containerType+"&containerId="+containerId;
		var url="<%=request.getContextPath() %>/editor/editor_loadBasicInfoByType.action";
		sendRequest(url,param,null, function(data){
			if(data!=null){
				var obj = JSON.parse(data);
				if(type != ''){   //非流程
					var code = obj.code;   //编码
					var name = obj.name;  //名称
					var desc = obj.desc;  //描述
					document.getElementById('code').value = code;
					document.getElementById('name').value = name;
					document.getElementById('desc').value = desc;
					if(type == 'HumanTask' || type == 'Connector'){
						var priority = obj.priority;  //优选级
						var select = document.getElementById('priority');  
					    for (var i = 0; i < select.options.length; i++){  
					        if (select.options[i].value == priority){  
					            select.options[i].selected = true;  //选中
					            break;  
					        }  
					    }  
					}
					if(type == 'HumanTask'){   //人工活动并且是实施阶段
						var authId = obj.authId;   //授权类型编码
						var authName = obj.authName;   //授权类型名称
						document.getElementById('authId').value = authId;
						document.getElementById('authName').value = authName;
					}
				}else{   //流程
					var processCode = obj.processCode;   //编码
					var processName = obj.processName;  //名称
					var processDesc = obj.processDesc;  //描述
					var processPriority = obj.processPriority;  //优选级
					var author = obj.author;  //作者
					var version = obj.version;  //版本
					var fromStr = obj.fromStr;  //开始期限
					var toStr = obj.toStr;  //结束期限
					
					document.getElementById('processCode').value = processCode;
					document.getElementById('processName').value = processName;
					document.getElementById('processDesc').value = processDesc;
					var select = document.getElementById('processPriority');  
				    for (var i = 0; i < select.options.length; i++){  
				        if (select.options[i].value == priority){  
				            select.options[i].selected = true;  //选中
				            break;  
				        }  
				    } 
				    document.getElementById('author').value = author;
				    document.getElementById('version').value = version;
				    document.getElementById('fromDate').value = fromStr;
				    document.getElementById('toDate').value = toStr;
				}
				
			}
		});
	}
	
	//控件内容改变时异步去后台保存属性
	function updateBasicInfoByType(element){
		debugger;
		var type;   
		var id;
		//获取当前显示激活的标签页
		var tab = $('div .select-btn.select');
		if(tab.text() == '活动属性'){
			type = document.getElementById('type').value;
			id = document.getElementById('id').value;
		}else if(tab.text() == '流程属性'){
			type = '';
		}

		var elementName = element.name;
		var elementValue = element.value;
		var url="<%=request.getContextPath() %>/editor/editor_updateBasicInfoByType.action";
		var param = "&type="+type+"";
		if(type!=''){
			if(type == 'Connector'){   //连线
				param += "&transitionId="+id+"";
			}else if(type == 'Container'){   //泳道
				param += "&swimlineId="+id+"";
			}else{
				param += "&activityId="+id+"";
			}
		}
		param += "&processdid="+pdid+"&containerType="+containerType+"&containerId="+containerId;
		var data = {};
		data["type"] = type;
        data["elementName"] = elementName;
        data["elementValue"] = elementValue;
        if(elementName == 'authName'){   //授权类型时
        	var authId = element.authId;
        	data["authId"] = authId;
        }
		sendRequest(url,param,data, function(data){
			if(data!=null){
				var obj = JSON.parse(data);
				if(obj.actId && obj.actId!=''){    
					updateActName(obj.actId,obj.newName);  //修改活动名称
				}else if(obj.transitionId && obj.transitionId!=''){   
					updateTransitionName(obj.transitionId,obj.newName);  //修改连线名称
				}else if(obj.swimlineId && obj.swimlineId!=''){    
					updateSwimlineName(obj.swimlineId,obj.newName);  //修改泳道名称
				}
			}
		});
	}
    
	//更多属性按钮点击事件 打开窗口
	function openMoreAttributes(){
		var type;   
		var id;
		//获取当前显示激活的标签页
		var tab = $('div .select-btn.select');
		if(tab.text() == '活动属性'){
			type = document.getElementById('type').value;
			id = document.getElementById('id').value;
		}else if(tab.text() == '流程属性'){
			type = '';
		}
		
		if(type!=''){   //非流程(活动  -连线  -泳道)
			if(type == 'Connector'){  //连线
				editTransition(id);
			}else if(type == 'Container'){ //泳道
				editSwimline(id)
			}else{
				editActivity();
			}
		}else{   //流程
			editActivity('process');
		}
	}
	
	//实施时 人工活动点击操作权限按钮 打开窗口
	function openSecScope(){
		var formId = parent.document.getElementById('formId1').value;   //表单编码
		var activityId = document.getElementById('id').value;
		var activityName = document.getElementById('name').value;
		layer.open({
			id:"secScope",
			type : 2,
			
			title : ['权限范围列表'],
			shade: [0.1, '#000'],
			closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
			shadeClose: false, //开启遮罩关闭
			area : [ '70%', '90%' ],
			content : '<%=request.getContextPath() %>/editor/editor_loadSecScope.action?formId='+formId+'&activityId='+activityId+'&scopeName='+activityName+''
		});
	}
	
	var iframeJs;
	//实施时 流程设计数据权限
	function onoperationSetClose(data){
		iframeJs.onoperationSetClose(data);
	}
	
    //snapToGrid();
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
			 
		//左对齐, 将所有选中活动x 设置为其中最小值		
		function leftAlign(){
			if(this.selectedGroupId == -1)
				return;
				
			var figuresIds = STACK.figureGetIdsByGroupId(this.selectedGroupId);
			var minX = -1;			
	        for(var i=0; i<figuresIds.length; i++){
	            var actFig = STACK.figureGetById(figuresIds[i]);
	            if(minX == -1)
					minX = actFig.getX();
				else{
					if(actFig.getX() < minX)
						minX = actFig.getX();
				}
	        }
				
	        for(var i=0; i<figuresIds.length; i++){
	            var actFig = STACK.figureGetById(figuresIds[i]);
				actFig.changePosition(minX, actFig.getY());
			}	
			draw();
		}	
		
		//右对齐, 将所有选中活动x 设置为其中最大值		
		function rightAlign(){
			if(this.selectedGroupId == -1)
				return;
				
			var figuresIds = STACK.figureGetIdsByGroupId(this.selectedGroupId);

			var maxX = -1;			
			 for(var i=0; i<figuresIds.length; i++){
            	var actFig = STACK.figureGetById(figuresIds[i]);
				if(maxX < 0)
					maxX = actFig.getX()+actFig.imageWidth;
				else{
					if(actFig.x+actFig.width > maxX)
						maxX = actFig.getX()+actFig.imageWidth;
				}
			}
			
			for(var i=0; i<figuresIds.length; i++){
            	var actFig = STACK.figureGetById(figuresIds[i]);
				actFig.changePosition((maxX - actFig.imageWidth), actFig.getY());
				
			}	
			
			draw();
			
		}
		
		//上对齐, 将所有选中活动y 设置为其中最小值		
		function topAlign(){
			if(this.selectedGroupId == -1)
				return;
				
			var figuresIds = STACK.figureGetIdsByGroupId(this.selectedGroupId);

			var minY = -1;			
			 for(var i=0; i<figuresIds.length; i++){
            	  var actFig = STACK.figureGetById(figuresIds[i]);
						if(minY == -1)
							minY = actFig.getY();
						else{
							if(actFig.getY() < minY)
								minY = actFig.getY();
						}
				
			}
			
			for(var i=0; i<figuresIds.length; i++){
            	 var actFig = STACK.figureGetById(figuresIds[i]);
				actFig.changePosition(actFig.getX(),minY);
			}	
			
			draw();
		}
		
		//下对齐, 将所有选中活动y 设置为其中最大值		
		function bottomAlign(){
			if(this.selectedGroupId == -1)
				return;
				
			var figuresIds = STACK.figureGetIdsByGroupId(this.selectedGroupId);

			var minY = -1;			
			 for(var i=0; i<figuresIds.length; i++){
            	  var actFig = STACK.figureGetById(figuresIds[i]);
						if(minY == -1)
							minY = actFig.getY();
						else{
							if(actFig.getY() > minY)
								minY = actFig.getY();
						}
				
			}
			
			for(var i=0; i<figuresIds.length; i++){
            	 var actFig = STACK.figureGetById(figuresIds[i]);
				actFig.changePosition(actFig.getX(),minY);
			}	
			
			draw();
		}
		
		//水平对齐		
		function hCenterAlign(){
			if(this.selectedGroupId == -1)
				return;
				
			var figuresIds = STACK.figureGetIdsByGroupId(this.selectedGroupId);

			var minY = -1;
			var maxY = -1;			
			for(var i=0; i<figuresIds.length; i++){
            	 var actFig = STACK.figureGetById(figuresIds[i]);
					
						if(minY < 0)
							minY = actFig.getY();
						else{
							if(actFig.getY() < minY)
								minY = actFig.getY();
						}	

						if(maxY < 0)
							maxY = actFig.getY()+actFig.imageHeight;
						else{
							if(actFig.getY()+actFig.imageHeight > maxY)
								maxY = actFig.getY()+actFig.imageHeight;
						}
			}
			
			var vCenterY = (maxY - minY)/2 + minY;
			for(var i=0; i<figuresIds.length; i++){
            	var actFig = STACK.figureGetById(figuresIds[i]);
            	var imageHeight = actFig.imageHeight;
            	if(imageHeight == 32){
            		imageHeight = 45;
            	}
				actFig.changePosition(actFig.getX(),(vCenterY - imageHeight/2));
			}	
			
			draw();
		}
		
		//居中对齐		
		function vCenterAlign(){
			if(this.selectedGroupId == -1)
				return;
				
			var figuresIds = STACK.figureGetIdsByGroupId(this.selectedGroupId);


			var minX = -1;
			var maxX = -1;			
			for(var i=0; i<figuresIds.length; i++){
            	    var actFig = STACK.figureGetById(figuresIds[i]);
						if(minX < 0)
							minX = actFig.getX();
						else{
							if(actFig.getX() < minX)
								minX = actFig.getX();
						}	

						if(maxX < 0)
							maxX = actFig.getX()+actFig.imageWidth;
						else{
							if(actFig.getX()+actFig.imageWidth > maxX)
								maxX = actFig.getX()+actFig.imageWidth;
						}
				
			}
			
			var vCenterX = (maxX - minX)/2 + minX;
			for(var i=0; i<figuresIds.length; i++){
            	 var actFig = STACK.figureGetById(figuresIds[i]);
             	var imageWidth = actFig.imageWidth;
            	if(imageWidth == 32){
            		imageWidth = 70;
            	}
            	 actFig.changePosition((vCenterX - imageWidth/2),actFig.getY());

			}	
			
			draw();
			
		}
		
		
		function zoomOut(){
			var canvas = document.getElementById("a"); 
			var ctx = canvas.getContext('2d');
			ctx.clearRect(0,0,3200,1200)
			scale = scale*1.2;
			ctx.scale(1.2,1.2);
			draw();
		}
		
		function zoomIn(){
			var canvas = document.getElementById("a"); 
			var ctx = canvas.getContext('2d');
			ctx.clearRect(0,0,3200,1200)
			scale = scale/1.2;
			ctx.scale(1/1.2,1/1.2);
			draw();
		}
	
	    var scale = parseFloat("1");
		
	    
	  //显示按钮提交遮罩
	    function showMask(){
	    	var docVar;
	    	if(window.top){
	    		docVar = window.top.document;
	    	}
	    	if(!docVar){
	    		docVar = window.document;
	    	}
	    	var maskDiv = docVar.getElementById("matrixMask");
	    	if(!maskDiv){
	    		maskDiv = docVar.createElement("div");
	    		maskDiv.id="matrixMask";
	    		maskDiv.className="matrixMask";
	    		docVar.body.appendChild(maskDiv);
	    		maskDiv.style.display="";
	    	}else{
	    		maskDiv.style.display="";
	    	}

	    	var curDoc = document.getElementById("matrixMask");
	    	if(curDoc){
	    		curDoc.style.display="";
	        }

	    }
	    // 隐藏按钮提交遮罩
	    function hideMask(){
	    	var docVar;
	    	if(window.top){
	    		docVar = window.top.document;
	    	}
	    	if(!docVar){
	    		docVar = window.document;
	    	}
	    	var maskDiv = docVar.getElementById("matrixMask");
	    	if(maskDiv){
	    		maskDiv.style.display = "none";
	    	}

	    	var curDoc = document.getElementById("matrixMask");
	    	if(curDoc){
	    		curDoc.style.display="none";
	        }
	    }
	    
	    //屏蔽键盘上下左右移动滚动条事件
	    document.onkeydown=function(e){
	    	var e = e || window.event;
	    	if(e.keyCode == '37' || e.keyCode == '38' || e.keyCode == '39' || e.keyCode == '40'){
		    	if(e.preventDefault){
		    		e.preventDefault();
		    	}else{
			    	e.returnValue = false;
		    	}
	    	}
	    }
	    
	    
		</script>
        <!--[if IE]>
        <script src="./assets/javascript/excanvas.js"></script>
        <![endif]-->
       
    </head>
    <body onload="initLight('');" id="body" style="overflow:hidden;">
<div id='matrixMask' name='matrixMask' class='matrixMask' style='width:100%;height:100%;display:none;'> </div>
        

        <div id="actions" style="background-color:#F6F6F6;height: 35px;padding-top: 10px;">
                        
           <a href="javascript:openFile();" title="读取文件"><img src="assets/images/btn_open.png" border="0" alt="读取文件"/></a>

            <img class="separator" src="assets/images/toolbar_separator.gif" border="0" width="1" height="16"/>
           
           <a href="javascript:downloadProcess();" title="保存文件"><img src="assets/images/save.png" border="0" alt="保存文件"/></a>

            <img class="separator" src="assets/images/toolbar_separator.gif" border="0" width="1" height="16"/>
           
            <a href="javascript:saveAsLocalImage();"  title="保存为图片"><img src="assets/images/saveimage.png" border="0"/></a>

            <img class="separator" src="assets/images/toolbar_separator.gif" border="0" width="1" height="16"/>

            <a href="javascript:deleteActivity();" title="删除当前活动"><img src="assets/images/delete.png" border="0"/></a>
            
            <img class="separator" src="assets/images/toolbar_separator.gif" border="0" width="1" height="16"/>
            
<% 
    if(com.matrix.form.api.MFormContext.getPhaseId()==3){
    	

%>            
            <a href="javascript:editActivity();" title="编辑流程属性"><img src="assets/images/edit.png" border="0" alt="Organiaaaa"/></a>
            
            <img class="separator" src="assets/images/toolbar_separator.gif" border="0" width="1" height="16"/>

            <a href="javascript:validateProcess();" title="校验流程"><img src="assets/images/validate.png" border="0" alt="校验流程"/></a>

            <img class="separator" src="assets/images/toolbar_separator.gif" border="0" width="1" height="16"/>

<% 
    };

%>            
            <a href="javascript:saveDiagramFromServer();" title="保存流程"><img src="assets/images/publish.png" border="0" alt="保存"/></a>
            
            <img class="separator" src="assets/images/toolbar_separator.gif" border="0" width="1" height="16"/>
            
            <a href="javascript:publishDiagramFromServer();" title="发布流程"><img src="assets/images/upload.png" border="0" alt="发布流程"/></a>
            
            <img class="separator" src="assets/images/toolbar_separator.gif" border="0" width="1" height="16"/>
            
<%
//如果当前为产品模式，不能取消发布
int runModeType = MFSystemProperties.getInstance().getRunModeType().getValue();
if(runModeType == 1)
{
%>			 		
            <a href="javascript:releaseDiagramFromServer();" title="取消发布流程"><img src="assets/images/return.png" border="0" alt="取消发布流程"/></a>
            
            <img class="separator" src="assets/images/toolbar_separator.gif" border="0" width="1" height="16"/>            
                        
<%
}
%>            
            <a href="javascript:zoomOut();" title="放大"><img src="assets/images/btn_zoomin.png" border="0" alt="放大"/></a>

            <img class="separator" src="assets/images/toolbar_separator.gif" border="0" width="1" height="16"/>            
                        
            <a href="javascript:zoomIn();" title="缩小"><img src="assets/images/btn_zoomout.png" border="0" alt="缩小"/></a>

            <img class="separator" src="assets/images/toolbar_separator.gif" border="0" width="1" height="16"/>            
                        
            <a href="javascript:leftAlign();" title="左边对齐"><img src="assets/images/left_align.png" border="0" alt="左边对齐"/></a>

            <img class="separator" src="assets/images/toolbar_separator.gif" border="0" width="1" height="16"/>            
                        
            <a href="javascript:rightAlign();" title="右边对齐"><img src="assets/images/right_align.png" border="0" alt="右边对齐"/></a>

            <img class="separator" src="assets/images/toolbar_separator.gif" border="0" width="1" height="16"/>            
                        
            <a href="javascript:topAlign();" title="顶部对齐"><img src="assets/images/top_align.png" border="0" alt="顶部对齐"/></a>

            <img class="separator" src="assets/images/toolbar_separator.gif" border="0" width="1" height="16"/>            
                        
            <a href="javascript:bottomAlign();" title="底部对齐"><img src="assets/images/bottom_align.png" border="0" alt="底部对齐"/></a>

            <img class="separator" src="assets/images/toolbar_separator.gif" border="0" width="1" height="16"/>            
                        
            <a href="javascript:vCenterAlign();" title="垂直居中"><img src="assets/images/vertical_center.png" border="0" alt="垂直居中"/></a>

            <img class="separator" src="assets/images/toolbar_separator.gif" border="0" width="1" height="16"/>            
                        
            <a href="javascript:hCenterAlign();" title="水平居中"><img src="assets/images/horizontal_center.png" border="0" alt="水平居中"/></a>

        <!--    <img class="separator" src="assets/images/toolbar_separator.gif" border="0" width="1" height="16"/>            
                        
            <a href="javascript:exit();" title="退出"><img src="assets/images/exit.png" border="0" alt="退出"/></a>  -->
            
           <div style="float:right;padding-right: 10px;"> <lable>当前状态:</lable><lable id="statusTxt"></lable> </div>
            
		
        </div>
        
        
        <div id="editor" style="width: 100%; height:calc( 100% - 35px); padding-left: 10px;padding-top: 10px;padding-right: 10px;background-color: rgb(236, 234, 234);" >
           <div style="width:16%;float:left;height:100%;;padding-bottom:30px;">
            <div style="width:100%;height: 100%;">
            <div style="width:100%;height:100%;overflow:hidden;">
           <div  class="class1"  onClick="use('class1content')">

<input type="button" class="button2" value="活动连线" style="height:36px;width:100%;"  onClick="use('class1content')"></input>
<span style="width: 80%; height:300px;text-align:center;position:relative;margin: 0px auto;" id="class1content">
<div class="bujian" style="width:100%;height:78px;margin-top:3px;;margin-bottom:3px;" onclick="javascript:addItem('Transition')">
<img src="lib/sets/flow/connection.png" style="height:22px;width:22px;margin-top:2px;margin-top:2px;"></img>
<p >活动连线</p>
</div>
</span>
</div>
<div class="class1"  onClick="use('class2content')">

<input type="button" class="button2" value="基本活动" style="height:36px;width:100%;"  onClick="use('class2content')"></input>
<span style="width: 80%;height:calc(100% - 144px); text-align:center;display:block;position:relative;margin: 0px auto;" id="class2content">
<div class="bujian" style="width:100%;height:78px;margin-top:6px;" onclick="javascript:addItem('HumanTask')">
<img src="lib/sets/flow/m_humanTask_L.png" style="height:36px;width:60px;margin-top:4px;"></img>
<p >人工活动</p>
</div>

<%
//if(!"custom".equals(mode)){ 
//业务定制阶段
if(curPhase!=4&&!"custom".equals(flowLoadType)){ 
%>
<div class="bujian" style="width:100%;height:78px;" onclick="javascript:addItem('AutomaticAct')">
<img src="lib/sets/flow/m_automatic_L.png" style="height:36px;width:60px;margin-top:4px;"></img>
<p>自动活动</p>
</div>
<%} 
%>
<div class="bujian" style="width:100%;height:78px;" onclick="javascript:addItem('BlockAct')">
<img src="lib/sets/flow/m_block_L.png" style="height:36px;width:60px;margin-top:4px;"></img>
<p  style="display:block;">内部子流程</p>
</div>
<%
//if(!"custom".equals(mode)){ 
//业务定制阶段
if(curPhase!=4&&!"custom".equals(flowLoadType)){ 
%>
<div class="bujian" style="width:100%;height:78px;margin-bottom:6px;" onclick="javascript:addItem('SubflowAct')">
<img src="lib/sets/flow/m_subflow_L.png" style="height:36px;width:60px;margin-top:4px;"></img>
<p style="display:block;">外部子流程</p>
</div>
<%} %>

</span>

</div>
<div class="class1" >
<input type="button" class="button2" value="逻辑活动" style="height:36px;width:100%;"  onClick="use('class3content')"></input>
<span style="width: 80%; height:calc(100% - 144px);text-align:center;position:relative;margin: 0px auto;" id="class3content">
<div class="bujian" style="width:100%;height:72px;margin-top:6px;" onclick="javascript:addItem('StartAct')">
<img src="lib/sets/flow/m_start_L.png" style="height:32px;width:32px;margin-top:4px;"></img>
<p >开始活动</p>
</div>
<div class="bujian" style="width:100%;height:72px;" onclick="javascript:addItem('StopAct')">
<img src="lib/sets/flow/m_stop_L.png" style="height:32px;width:32px;margin-top:4px;"></img>
<p>完成活动</p>
</div>
<div class="bujian" style="width:100%;height:72px;" onclick="javascript:addItem('ConditionAct')">
<img src="lib/sets/flow/m_condition_L.png" style="height:32px;width:32px;margin-top:4px;"></img>
<p>条件活动</p>
</div>
<div class="bujian" style="width:100%;height:72px;" onclick="javascript:addItem('SplitAct')">
<img src="lib/sets/flow/split.png" style="height:32px;width:32px;margin-top:4px;"></img>
<p>并发活动</p>
</div>
<div class="bujian" style="width:100%;height:72px;margin-bottom:6px;" onclick="javascript:addItem('JoinAct')">
<img src="lib/sets/flow/join.png" style="height:32px;width:32px;margin-top:4px;"></img>
<p>合并活动</p>
</div>
</span>

</div>
<div class="class1" >

<input type="button" class="button2" value="流程泳道" style="height:36px;width:100%;"  onClick="use('class4content')"></input>
<span style="width: 80%; height:calc(100% - 144px);text-align:center;position:relative;margin: 0px auto;" id="class4content">
<div class="bujian" style="width:100%;height:73px;margin-top:6px;" onclick="javascript:addItem('HSwimline')">
<img src="lib/sets/flow/vlineS.png" style="height:32px;width:32px;margin-top:4px;"></img>
<p >水平泳道</p>
</div>
<div class="bujian" style="width:100%;height:73px;margin-bottom:6px;" onclick="javascript:addItem('VSwimline')">
<img src="lib/sets/flow/hlineS.png" style="height:32px;width:32px;margin-top:4px;"></img>
<p>垂直泳道</p>
</div>
</span>
</div>
</div>  
</div>  
           
           </div> 
            
            <!--THE canvas-->
                <!--THE canvas-->
                <div  id="container" style=" overflow:hidden;width:66%;height:calc( 100% - 10px);margine:0px;float:left;display:none;" onselectstart="return false">
	                <div style=" height: calc(100% - 20px); padding-left: 10px;background-color: #ececec;">
		                <div style="width:100%;height:100%;overflow:auto;">
		                    <canvas id="a" style="background-color: rgb(236, 234, 234);cursor: default;">
		                        Your browser does not support HTML5. Please upgrade your browser to any modern version.
		                    </canvas>
		                    <div id="text-editor"></div>
		                    <div id="text-editor-tools"></div>
		                </div> 
	                </div>
                </div>

                <div id="properties" style=" float:right;overflow:hidden;width:calc( 18% - 10px);height:calc( 100% - 30px);margine:0px;background-color: white;" onselectstart="return false">              
	                 <%@ include file="/editor/properties.jsp"%>	               
                </div>
            
                <div  id="info" style=" width:82%;height:100%;margine:0px;float:left;">
                	<br>
                	<div style="width:100%;height:100%;line-height:300px;text-align:center;overflow:hidden;background:#fff;   ">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;正在加载,请稍候...</div>
                </div> 
        </div>
        
        <br/>
<script>

WebContextPath = "<%=request.getContextPath()%>";

function addItem(type){
		if(type == "Transition"){
			action('connector-jagged');
			initProperties('',pdid);
			return;
		}
	
		var url="<%=request.getContextPath() %>/flow.dflow";
		var param="mode=<%=mode%>&componentType="+type+"&command=create&pdid=<%=pdid%>&containerId=<%=containerId%>&containerType=<%=containerType%>";
		getUrlData(url,param,function(data){
		    if( "false"!=data && "disable"!=data ){
		        var adid = data;
				//var type = data.editorType;
				var createFunction = "figure_"+type;
				var imgName;
				if(type == "HumanTask"){
					imgName = "m_humanTask_L.png";
				}else if(type == "AutomaticAct"){
					imgName = "m_automatic_L.png";
				}else if(type == "SubflowAct"){
					imgName = "m_subflow_L.png";
				}else if(type == "BlockAct"){
					imgName = "m_block_L.png";
				}else if(type == "StartAct"){
					imgName = "m_start_L.png";
				}else if(type == "StopAct"){
					imgName = "m_stop_L.png";
				}else if(type == "ConditionAct"){
					imgName = "m_condition_L.png";
				}else if(type == "SplitAct"){
					imgName = "split.png";
				}else if(type == "JoinAct"){
					imgName = "join.png";
				}else if(type == "HSwimline"){
					imgName = "vlineL.png";
				}else if(type == "VSwimline"){
					imgName = "hlineL.png";
				}
				
				newFigureId = data;
				var imgUrl = "<%=request.getContextPath() %>/editor/lib/sets/flow/"+imgName;
				createFigure(window[createFunction] ,imgUrl, type);
				
				if(type == "HSwimline" || type == "VSwimline"){
					initProperties('',pdid);
				}else{
					initProperties(type,newFigureId);
				}
		     }else if("disable"==data ){
	                 infoMsg("已经有另一种泳道,不允许同一个流程有不同的泳道！");
	         }else{
	                 errorMsg("添加失败,请检查服务器！");
	         }

				if(document.getElementById("inSubflow")){
					document.getElementById("inSubflow").style.display="";
				}
				if(document.getElementById("outSubflow")){
					document.getElementById("outSubflow").style.display="";
				}
				if(document.getElementById("edit1")){
					document.getElementById("edit1").style.display="";
				}
				if(document.getElementById("edit2")){
					document.getElementById("edit2").style.display="";
				}
				if(document.getElementById("edit3")){
					document.getElementById("edit3").style.display="";
				}
				if(document.getElementById("delete1")){
					document.getElementById("delete1").style.display="";
				}
				if(document.getElementById("delete2")){
					document.getElementById("delete2").style.display="";
				}
				
			}	
		);

}
</script>   

<script>
	//设置流转线名称,main.js中鼠标移动时调用
	function setTransitionName(content){
	}
	//显示流转线名称
	function displayTransitionName(){
	}
	
	

</script>


		 <div id="actdiv" class="operationDiv" style="display:none;width:150px;"> 
              <div class="operation_list">
                <a style="height:26px;" href="javascript:editActivity();"><img src="lib/sets/basic/edit.png" width="16" height="16"/><span id="edit1" style="margin-left:15px;">编辑</span></a>
                <a style="height:26px;" href="javascript:deleteActivity();"><img src="lib/sets/basic/delete.png" width="16" height="16"/><span id="delete1"  style="margin-left:15px;">删除</span></a>
              </div>
         </div>       
		 <div id="subflowdiv" class="operationDiv" style="display:none;width:150px;"> 
              <div class="operation_list">
                <a style="height:26px;"  href="javascript:editActivity();"><img src="lib/sets/basic/edit.png" width="16" height="16"/><span id="edit2"  style="margin-left:15px;">编辑</span></a>
                <a style="height:26px;"  href="javascript:deleteActivity();"><img src="lib/sets/basic/delete.png" width="16" height="16"/><span  id="delete2" style="margin-left:15px;">删除</span></a>
                <a style="height:26px;border-bottom:1px solid #ECEEEB;"  href="javascript:enterSubProcess();"><img src="lib/sets/basic/enter.png" width="16" height="16"/><span  id="inSubflow" style="margin-left:15px;">进入子流程</span></a>
              </div>
         </div>       
		 <div id="flowdiv" class="operationDiv" style="display:none;width:150px;"> 
              <div class="operation_list">
                <a style="height:26px;"  href="javascript:editActivity();"><img src="lib/sets/basic/edit.png" width="16" height="16"/><span id="edit3"  style="margin-left:15px;">编辑</span></a>
                <%if(!"process".equals(containerType)){ %>
	                <a style="height:26px;border-bottom:1px solid #ECEEEB;"  href="javascript:backProcess();"><img src="lib/sets/basic/return.png" width="16" height="16"/><span  id="outSubflow" style="margin-left:15px;">返回上级流程</span></a>
                <%} %>
              </div>
         </div>       

    </body>
</html>
