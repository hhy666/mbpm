<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href='<%=path %>/resource/html5/css/bootstrap/dist/css/bootstrap.min.css' rel="stylesheet"></link>
<link href='<%=path %>/resource/css/screen.min.css' rel="stylesheet"></link>
<link href='<%=path %>/resource/html5/css/font-awesome.min.css' rel="stylesheet"></link>
<SCRIPT SRC='<%=path %>/resource/html5/js/jquery.min.js'></SCRIPT>
</head>
<script type="text/javascript">
	$(function(){
		$('main').height(window.innerHeight-75);
//		$('#textDiv').height($('main').height() - $('#btnDiv').height());
        var height = $('main').height();
		$('#textDiv').height(height-42);
	});
</script>
<body >
<section class="content-wrap">
	<div class="container-fluid" >
		<div class="row" >
			<main class=" col-xs-9 main-content" >
				<article class="post"    style="height:100%; overflow: auto; margin-top: 35px ;">
				<div class="widget" >
					<h4 class="title">
						流程
					</h4>
				</div>
					<img id='monitorImg' src="<%=request.getContextPath()%>/processMonitorHelper?matrixMonitorKey=ProcessMonitor&matrixMonitorPdid=${param.pdid }"/>
				</article>
			</main>
			<aside class="col-md-3 sidebar" >
				<div id="textDiv" class="widget" style="margin: 35px auto;" >
					<h4 class="title">
						操作说明
					</h4>
					<div id="contentDiv" class="content community" style="height:60%; overflow: auto;">
					<p style="height:60%; font-size: 12px;">无描述</p>
					</div>
					<br>
				<!-- </div>
				<div id="btnDiv" class="widget" > -->
					<h4 class="title">
						操作
					</h4>
					<div id="btnsDiv" class="content community" style="height:10%;" align="center">
						<button type="button"  id="button001" name="start" class="x-btn ok-btn monitorViewerBtn " style="margin:0 3px;" onclick="btnClick(this);" >发起</button>
					</div>
					
				</div>
			</aside>
		</div>
	</div>
	</section>
</body>
<script>
						var piid ;
						var aiid;
						function btnClick(obj){
							var step = $(obj).attr('name');
							var timestamp = new Date().getTime();
							$.ajax({
								type:"post",
								url:"<%=path %>/MonitorViewerControlServlet",
								data:"step="+step+"&pdid=${param.pdid }&piid="+piid+"&aiid="+aiid,
								dataType:'json',
								success:function(data){
								//	var obj = JSON.parse(data);
									var obj = data;
									piid = obj.piid;
									aiid = obj.aiid;
									var content = obj.content;
									$("#contentDiv > p").text(content);
									var btnNames = obj.btnNameMap;
									$("button").remove(".monitorViewerBtn");
	//								$("#btnsDiv").append("<button type='button' name='back' class='x-btn ok-btn monitorViewerBtn' onclick='btnClick(this);' >上一步</button>");
									$.each(btnNames,function(key,value){
										$("#btnsDiv").append("<button type='button' name='"+key+"' class='x-btn ok-btn monitorViewerBtn' style='margin:0 3px;' onclick='btnClick(this);' >"+value+"</button>");
									});
									var src = "<%=path %>/processMonitorHelper?matrixMonitorKey=ProcessMonitor&matrixMonitorPiid="+piid+"&"+timestamp;
									$('#monitorImg').attr('src',src);
								}
							});
						}
					</script>
</html>