<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://huachuangpower.com/tags-mbpm" prefix="mbpm"%>
<%@ page import="com.matrix.client.*,
    com.matrix.api.*,
    com.matrix.api.identity.*"%>
<%
response.setHeader("Pragma", "No-cache");
response.setDateHeader("Expires", 0);
response.setHeader("Cache-Control", "no-cache");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>查看实例图形</title>
<link href="css/monitor.css" rel="stylesheet" type="text/css">
<link href="css/matrixProcessMonitor.css" rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath()%>/matrix/resource/isomorphic/skins/Enterprise/skin_styles.css" rel="stylesheet" type="text/css" />
<link href='<%=request.getContextPath() %>/resource/html5/css/matrix_runtime.css' rel="stylesheet"></link>
<link href='<%=request.getContextPath() %>/resource/html5/css/bootstrap/dist/css/bootstrap.min.css' rel="stylesheet"></link>
<link href='<%=request.getContextPath() %>/resource/html5/css/skin/mCustom_<%=session.getAttribute("skin") %>.css' rel="stylesheet"></link>
<link href='<%=request.getContextPath() %>/resource/html5/css/font-awesome.min.css' rel="stylesheet"></link>
<script type="text/javascript" src="js/matrixProcessMonitor.js"></script>
<script src='<%=request.getContextPath() %>/resource/html5/js/jquery.min.js'></script>
<style type="text/css">
	body{
	    margin: 0;
	    padding: 0;
	    font-size: 12px;
	}
	div{
		box-sizing: border-box;
		-webkit-user-select: none;
	    -khtml-user-select: none;
	    -moz-user-select: none;
	    -ms-user-select: none;
	    -o-user-select: none;
	    user-select: none;
	}
	.container{
	    height: calc(100% - 54px);
	    width: 100%;
	    margin: auto;
	    //padding:0px 10px;
	    padding:0px;
	    overflow: auto;
	    background: #fff;
	    font-size: 12px;
	}
    .process-pane,.history-pane,.activity-pane{
		height: calc(100% - 80px);
		padding: 5px 5px 0px 5px;
	    overflow: auto;
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
	<!-- 处理监控数据 -->
	<%
		//从Session中取到流程服务对象
	    MFExecutionService service = (MFExecutionService) session.getAttribute(ClientConstants.EXECUTION_SERVICE);

	
		String piid = request.getParameter("piid"); // 流程实例编码
		
		// 流程播放需要参数其他参数
	    String params = "";
		MFUser user = service.getMFUser();
		String userId = user.getUserId();
		String sessionId = service.getSessionId();
	String contextPath = request.getContextPath();
	if(contextPath!=null && contextPath.startsWith("/")){
	    contextPath = contextPath.substring(1);
	}
	    //String serverIp = request.getLocalAddr();
		String url = request.getRequestURL().toString();
		//String serverIp = url.substring(url.indexOf("//")+2,url.indexOf(":",url.indexOf("//"))); 
		String serverIp = request.getServerName();
	    int serverPort = request.getServerPort();
	    params +="serverIp="+serverIp;
	    params +="&contextPath="+contextPath;
	    params +="&sessionId="+sessionId;
	    params +="&userId="+userId;
	    params +="&serverPort="+serverPort;
	    params +="&simulationType=1";
		    
	%>
<script type="text/javascript">
	$(function(){
		//监听标签页DIV点击切换事件
		$('#process').click(function(){
			$('.process-pane').css('display','block'); 
			$('.history-pane').css('display','none'); 
			$('.activity-pane').css('display','none'); 
			$("#process").addClass("select");
			$("#history").removeClass("select");
			$("#activity").removeClass("select");
		});
		$('#history').click(function(){
			$('.history-pane').css('display','block'); 
			$('.process-pane').css('display','none'); 
			$('.activity-pane').css('display','none');
			$("#history").addClass("select");
			$("#process").removeClass("select");
			$("#activity").removeClass("select");
		});
		$('#activity').click(function(){
			$('.activity-pane').css('display','block'); 
			$('.process-pane').css('display','none'); 
			$('.history-pane').css('display','none');
			$("#activity").addClass("select");
			$("#process").removeClass("select");
			$("#history").removeClass("select");
		});
		
	})
	
	// 播放流程实例
	function videoProcess(){
	    var piid = "<%=piid%>";
	    if(piid==null || piid.length==0){
	    	return false;
	    }
	    var params = "<%=params%>";
	    params = params + "&piid="+piid;
		var url = "<%=request.getContextPath()%>/monitor/flex/MatrixDesigner.jsp?"+params;
		var iHeight = 500;
		var iWidth = 700;
		var iTop = (window.screen.availHeight-30-iHeight)/2; //获得窗口的垂直位置;
  		var iLeft = (window.screen.availWidth-10-iWidth)/2;  //获得窗口的水平位置;
  		var property = "toolbar=no, menubar=no, scrollbars=no, resizable=yes,location=no, status=no, width=" + iWidth + ",height=" + iHeight + ",left=" + iLeft + ",top=" + iTop;
		window.open( url, "播放流程实例", property);
	}
	
	function cancel(){
		window.close();
	}
</script>
</head>
<body style="background: rgba(245,245,247,.9);position: absolute;height: 100%;width: 100%;">
	<div style="position: relative;height: 100%;width: 100%;margin: auto;border: 1px solid rgb(231, 234, 236); box-shadow: 0 2px 4px 0 rgba(0,0,0,0.16), 0 2px 8px 0 rgba(0,0,0,0.12);overflow: hidden;">
		<div style="padding-left:20px;width: 100%;height: 40px;line-height:40px;border-bottom: 1px solid #cccccc;background-color: white;">
			<label style="font-weight: bold;font-size: 16px;color: rgb(22, 105, 171);">
				流程监控
			</label>
		</div>
		<div class="container">
		 	<div class="select-menu">
				<div class="select-btn select" id="process">实例图形</div>
				<div class="select-btn" id="history">历史图形</div>
				<div class="select-btn" id="activity">活动记录</div>
			</div>
			<div class="process-pane">
			   <div class="monitor_content">
			  	  <mbpm:monitor id="monitor1" piid="${param.piid}" type="process" executionService='ExecutionService' closeIcon="images/close.gif"/>
			   </div>
			</div>
			<div class="history-pane" style="display: none;">
				<div class="monitor_content">
			  	  <mbpm:monitor id="monitor1" piid="${param.piid}" type="history" executionService='ExecutionService' closeIcon="images/close.gif"/>
			    </div>
			</div>
			<div class="activity-pane" style="display: none;">			
			  	 <mbpm:monitor id="monitor1" piid="${param.piid}" type="activityRecord" executionService='ExecutionService' closeIcon="images/close.gif"/>		  
			</div>
			<div class="cmdLayout" style="text-align: center;">
				<div class="x-btn cancel-btn" onclick="videoProcess();">
					<span>播放</span>
				</div>
				<div class="x-btn cancel-btn" onclick="cancel();">
					<span>关闭</span>
				</div>
			</div>
	    </div>
	</div>
</body>
</html>
