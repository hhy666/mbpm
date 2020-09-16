<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">

<link href='<%=request.getContextPath() %>/resource/html5/css/font-awesome.min.css' rel="stylesheet"></link>
<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/jquery.min.js'></SCRIPT>
<title>Insert title here</title>
<style type="text/css">
	*{
		margin: 0px;
		padding: 0px;
	}
	a{
		text-decoration: none;
		color: black;
	}
	
	.headUser{
		position:absolute;
		padding: 3.3% 89.1% 3.3% 5.8%;
	}
	.headTitle{
		font-family: PingFangSC-Medium;
		font-size: 17px;
		color: #FFFFFF;
		letter-spacing: 0.55px;
		padding-bottom: 3.3%;	
		padding-top: 3.3%;
		text-align: center;
	}
	.homeHeadTop{
		position:relative;
		height:9.8%;
		background: #438BDD;
		width: 100%;
	}
	.homeHeadAd{
		height:26.5%;
		width:100%;
		position:relative;
	}
	.homeHeadAdIn{
		position: absolute;
		top:0;
		left:0;
		width:100%;
	}
	.homeBackGround{
		height:63.7%;
		width:100%;
		background: #F3F5F7;
	}
	.homeCenter{
		position: absolute;
		background: #FFFFFF;
		box-shadow: 0 7px 9px 0 rgba(0,0,0,0.17);
		border-radius: 8px;
		margin-top: 39.1%;
    	margin-left: 5.3%;
   	    margin-right: 5.1%;
		width:89.6%;
		height:65.5%;
	}
	.homeBlock{
	/* 	display:inline-block; */
		text-align: center;
		margin-top: 30px;
	}
	.fontDiv{
		font-family: PingFangSC-Regular;
		font-size: 14px;
		color: #000000;
		letter-spacing: 0.45px;
	}
	.homeBlockBox{
		display:inline-block;
		width:30%;
	}
	.gap{
		display:inline-block;
		width:5%;
	}
	.homeBolckHr{
		width:120px;
		border: 1px solid #D8D8D8;
	}
	#backIcon{
		 position: fixed;
		 top: 0;
		 left: 0px;
		 z-index: 999999;
		 margin: 6px 25px 6px 0px;
		 width: 70px;
		 padding: 0;
		 height: 34px;
		 padding-left: 15px;   
	}
	#logoff{
		 position:absolute;
		 right:20px;
		 color: #ffff;
    }
</style>
<script type="text/javascript">
var loadflag = true;
	$(function(){
		getMyTaskNum();   //待办任务个数
		getunReadedMessageNum();   //未读消息个数
		$('#logoff').css('top',$('.headTitle').css('padding-top'));
		setInterval(function(){getMyTaskNum()},10000);
		$('#logoff').click(function(){
			top.location="<%=request.getContextPath()%>/logon/logon_logoff.action";
		});
	});
	//计算协同待办任务个数
	function getMyTaskNum(){
		if(loadflag){
			var url = "<%=request.getContextPath()%>/mobile/task_countReadyTask.action?type=common";
			$.ajax({
				'url':url,
				'success':function(response){
					var result = JSON.parse(response);
					if( result!=null && (result.toDoTaskCount) && result.toDoTaskCount!=0){
						//$('.warnCircle').remove('');
						var num = result.toDoTaskCount;
						if(num>99){
							num='99+';
						}
						$('#warnSpan').append("<i class='fa fa-circle fa-stack-2x' style='color: red;'></i><i class='fa fa-stack-1x fa-inverse'>"+num+"</i>");
					}else{	
						//$('.warnCircle').remove('');
					}
				}
			})
		}
	}
	
	//计算未读消息个数
	function getunReadedMessageNum(){
		if(loadflag){
			var url = "<%=request.getContextPath()%>/mobile/message_getUnReadedCount.action?";
			$.ajax({
				'url':url,
				'success':function(response){
					var result = JSON.parse(response);
					if( result!=null && (result.unReadedCount) && result.unReadedCount!=0){
						//$('.warnCircle').remove('');
						var num = result.unReadedCount;
						if(num>99){
							num='99+';
						}
						$('#unReadedSpan').append("<i class='fa fa-circle fa-stack-2x' style='color: red;'></i><i class='fa fa-stack-1x fa-inverse'>"+num+"</i>");
					}else{	
						//$('.warnCircle').remove('');
					}
				}
			})
		}
	}
	
</script>
</head>

<body>

<div>
<div class='homeHeadTop'>
	<div class='headTitle'>移动办公平台</div>
	<div id="logoff">注销</div>
	<%-- <div class='headUser'>
		<img alt="" src="<%=request.getContextPath() %>/resource/mobile/userPage.png">
	</div> --%>
</div>
<div class='homeHeadAd' >
	<div class='homeHeadAdIn'>
	<img style='width:100%;' alt="" src="<%=request.getContextPath() %>/resource/mobile/adPage.png" style='width:40px;height:40px;'>
	</div>
</div>
<div class='homeBackGround'>
	<div class="homeCenter">
		<div class="gap"></div>
		<div class='homeBlockBox'>
			<div class='homeBlock'>
				<a id="signin" href="<%=request.getContextPath() %>/mobile/apply_query.action">
				<img alt="" src="<%=request.getContextPath() %>/resource/mobile/menu_1.png" style='width:40px;height:40px;'>
				</a>
				<div class='fontDiv'><a href="<%=request.getContextPath() %>/mobile/apply_query.action">新建事项</a></div>
				
			</div>
			<div class='homeBlock'>
				<a id="archive" href="archive-list.jsp?type=catalog&parentId=root">
				<img alt="" src="<%=request.getContextPath() %>/resource/mobile/menu_4.png" style='width:40px;height:40px;'>
				</a>
				<div class='fontDiv'><a href="archive-list.jsp?type=catalog&parentId=root">文档中心</a></div>
				
			</div>
			<div class='homeBlock'>
				<a id="survery" href="survery-inlet.jsp?type=surverylist">
				<img alt="" src="<%=request.getContextPath() %>/resource/mobile/menu_7.png" style='width:40px;height:40px;'>
				</a>
				<div class='fontDiv'><a href="survery-inlet.jsp?type=surverylist">调查</a></div>
				
			</div>	
			<div class='homeBlock'>
				<a id="maintain" href="<%=request.getContextPath() %>/mobile/utilization_loadDataUtilization.action">
				<img alt="" src="<%=request.getContextPath() %>/resource/mobile/menu_10.png" style='width:40px;height:40px;'>
				</a>
				<div class='fontDiv'><a href="<%=request.getContextPath() %>/mobile/utilization_loadDataUtilization.action">数据维护</a></div>
			</div>
		</div>
		<div class='homeBlockBox'>
			<div class='homeBlock'>
				<span id='warnSpan' class="fa-stack fa-1x" style='position:absolute; right:35%;' onclick="javascript:window.location.href='flow-list.jsp?type=readyTask'">
				</span>
				<a id="flow" href="flow-list.jsp?type=readyTask">
				<img alt="" src="<%=request.getContextPath() %>/resource/mobile/menu_2.png" style='width:40px;height:40px;'>
				</a>
				<div class='fontDiv'><a href="flow-list.jsp?type=readyTask">任务中心</a></div>	
			</div>
			<div class='homeBlock'>
				<a id="news" href="news-inlet.jsp?type=newslist">
				<img alt="" src="<%=request.getContextPath() %>/resource/mobile/Bitmap6.png" style='width:40px;height:40px;'>
				</a>
				<div class='fontDiv'><a href="news-inlet.jsp?type=newslist">新闻</a></div>
			</div>
			<div class='homeBlock'>
				<a id="discuss" href="discuss-inlet.jsp?type=discusslist">
				<img alt="" src="<%=request.getContextPath() %>/resource/mobile/menu_8.png" style='width:40px;height:40px;'>
				</a>
				<div class='fontDiv'><a href="discuss-inlet.jsp?type=discusslist">讨论</a></div>	
			</div>
			<div class='homeBlock'>
				<a id="query" href="<%=request.getContextPath() %>/mobile/query_loadDataQuery.action">
				<img alt="" src="<%=request.getContextPath() %>/resource/mobile/menu_11.png" style='width:40px;height:40px;'>
				</a>
				<div class='fontDiv'><a href="<%=request.getContextPath() %>/mobile/query_loadDataQuery.action">数据查询</a></div>			
			</div>
		</div>
		<div class='homeBlockBox'>
			<div class='homeBlock'>
				<a id="apply" href="app-list.jsp?type=createdApp&parentId=flowRoot">
				<img alt="" src="<%=request.getContextPath() %>/resource/mobile/flow.png" style='width:40px;height:40px;'>
				</a>
				<div class='fontDiv'><a href="app-list.jsp?type=createdApp&parentId=flowRoot">已发事项</a></div>	
			</div>
			<div class='homeBlock'>
				<a id="notice" href="notice-inlet.jsp?type=noticelist">
				<img alt="" src="<%=request.getContextPath() %>/resource/mobile/menu_6.png" style='width:40px;height:40px;'>
				</a>
				<div class='fontDiv'><a href="notice-inlet.jsp?type=noticelist">公告</a></div>
			</div>
			<div class='homeBlock'>
				<span id='unReadedSpan' class="fa-stack fa-1x" style='position:absolute; right:15px;' onclick="javascript:window.location.href='message-list.jsp?type=unReaded'">
				</span>
				<a id="messages" href="message-list.jsp?type=unReaded">
				<img alt="" src="<%=request.getContextPath() %>/resource/mobile/menu_9.png" style='width:40px;height:40px;'>
				</a>
				<div class='fontDiv'><a href="message-list.jsp?type=unReaded">消息</a></div>
			</div>
			<!--  
			<div class='homeBlock'>
				<a id="address" href="address-list.jsp?type=address&parentId=">
				<img alt="" src="<%=request.getContextPath() %>/resource/mobile/menu_12.png" style='width:40px;height:40px;'>
				</a>
				<div class='fontDiv'>通讯录</div>
			</div>
			-->
			<div class='homeBlock'>
				<a id="statistic" href="<%=request.getContextPath() %>/mobile/statistic_loadStatistic.action">
				<img alt="" src="<%=request.getContextPath() %>/resource/mobile/menu_13.png" style='width:40px;height:40px;'>
				</a>
				<div class='fontDiv'>统计模型</div>
			</div>
		 </div>
	 </div>
	 <div class="gap"></div>
   </div>
</div>
</body>
</html>