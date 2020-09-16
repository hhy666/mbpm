<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>选择皮肤页面</title>
<%@ include file="/form/html5/admin/html5Head.jsp"%>
<style type="text/css">
	body, ul{
	    margin: 0;
	    padding: 0;
	    font-size: 14px;
	}
	div, ul{
		box-sizing: border-box;
	}
	.container{
		position: absolute;
		height: 100%;
		width: 100%;		
		background: rgba(245,245,247,.9)
	}
	.wea-theme-layout{
		height: 100%;
		width: 60%;
    	margin: auto;
	}
	.wea-theme-layout .icon-coms-plate {
   	 	font-size: 14px;
	}
	.wea-theme-layout .wea-theme-layout-body {
	    height: 380px;
	    padding: 118px 38px;
	}
	
	.wea-theme-layout .wea-theme-layout-item {
	    position: relative;
	    display: inline-block;
	    margin: 0 31px;
	}
	
	.wea-theme-layout .wea-theme-layout-img {
	    border: 2px solid #d7d8d9;
	    cursor: pointer;
	}
	
	.wea-theme-layout .wea-theme-layout-img img {
	    width: 200px;
	    height: 130px;
	}
	
	.wea-theme-layout .wea-theme-layout-name {
	    width: 200px;
	    height: 55px;
	    line-height: 55px;
	    color: #333;
	    font-size: 14px;
	    text-align: center;
	    overflow: hidden;
	    -o-text-overflow: ellipsis;
	    text-overflow: ellipsis;
	    white-space: nowrap;
	    cursor: pointer;
	}
	
	.wea-theme-layout .wea-theme-layout-selected .wea-theme-layout-icon {
	    position: absolute;
	    top: 105px;
	    right: 8px;
	}
	
	
	.mytick:before,
	.mytick:after {
	    content: '';
	    pointer-events: none;
	    position: absolute;
	    color: #fff;
	    border: 1px solid #fff;
	    background-color: #fff;
	}
	
	.mytick:before {
	    width: 4.5px;
	    height: 0px;
	    left: 20%;
	    top: 50%;
	    transform: skew(0deg, 50deg);
	}
	
	.mytick:after {
	    width: 9px;
	    height: 0px;
	    left: 40%;
	    top: 40%;
	    transform: skew(0deg, -50deg);
	}
</style>
<script type="text/javascript">
	$(function(){
		$.ajax({ 
			 url: '<%=request.getContextPath()%>/sysinfo/sysinfo_loadSkinInfo.action',
	         type: "post", 
	         dataType: "json", 
	         success: function(data){ 
	        	var skin = data.skin; 
	        	$('#'+skin).parent().addClass('wea-theme-layout-selected');
	        	$('#'+skin).append('<span class="wea-theme-layout-icon mytick"></span>');
           } 
       });
		
		$(".wea-theme-layout-img").click(function(){
			$('.wea-theme-layout-selected').removeClass('wea-theme-layout-selected');
			$(this).parent().addClass('wea-theme-layout-selected');
			
			$('.wea-theme-layout-icon').remove();
			$(this).append('<span class="wea-theme-layout-icon mytick"></span>');
			
			Matrix.showMask2();
			var skin = $(this).attr('id');
			$.ajax({ 
				 url: '<%=request.getContextPath()%>/sysinfo/sysinfo_saveSkinInfo.action?skin='+skin,
		         type: "post", 
		         dataType: "json", 
		         success: function(data){ 
		        	var saveMessgae = data.saveMessgae; 
			        if(saveMessgae == 'success'){  //保存成功
			        	top.changeView('changeSkin');
			        	Matrix.warn('更换皮肤成功');
			        }else{
			        	Matrix.warn('更换皮肤失败');
			        }
	            } 
	        });
		});
	})
</script>
</head>
<body>
	<div id="matrixMask" name="matrixMask" class="matrixMask" style="width: 100%; height: 100%; position: absolute;top: 1;left: 1;z-index: 9999999999999;display: none;"></div>
	<div class="container">
		<div style="height: 100px;width: 60%;margin: auto;line-height: 100px;">			
			<span style="font-size: 18px">皮肤管理</span>
		</div>
		<div class="wea-theme-layout">
			<div class="wea-theme-layout-item" title="默认皮肤">
				<div class="wea-theme-layout-img" id="primary">
					<img src="<%=path %>/resource/html5/css/skin/primary_skin.png" alt="">
				</div>
				<div class="wea-theme-layout-name">默认皮肤</div>
			</div>
			<div class="wea-theme-layout-item" title="蓝色皮肤">
				<div class="wea-theme-layout-img" id="blue">
					<img src="<%=path %>/resource/html5/css/skin/blue_skin.png" alt="">
				</div>
				<div class="wea-theme-layout-name">蓝色皮肤</div>
			</div>
			<div class="wea-theme-layout-item " title="黑色皮肤">
				<div class="wea-theme-layout-img" id="black">
					<img src="<%=path %>/resource/html5/css/skin/black_skin.png" alt="">
				</div>
				<div class="wea-theme-layout-name">黑色皮肤</div>
			</div>
			<div class="wea-theme-layout-item" title="红色皮肤">
				<div class="wea-theme-layout-img" id="red">
					<img src="<%=path %>/resource/html5/css/skin/red_skin.png" alt="">
				</div>
				<div class="wea-theme-layout-name">红色皮肤</div>
			</div>
			<div class="wea-theme-layout-item" title="绿色皮肤">
				<div class="wea-theme-layout-img" id="green">
					<img src="<%=path %>/resource/html5/css/skin/green_skin.png" alt="">
				</div>
				<div class="wea-theme-layout-name">绿色皮肤</div>
			</div>
			<div class="wea-theme-layout-item" title="橙色皮肤">
				<div class="wea-theme-layout-img" id="orange">
					<img src="<%=path %>/resource/html5/css/skin/orange_skin.png" alt="">
				</div>
				<div class="wea-theme-layout-name">橙色皮肤</div>
			</div>
			<div class="wea-theme-layout-item" title="紫色皮肤">
				<div class="wea-theme-layout-img" id="purple">
					<img src="<%=path %>/resource/html5/css/skin/purple_skin.png" alt="">
				</div>
				<div class="wea-theme-layout-name">紫色皮肤</div>
			</div>
			<div class="wea-theme-layout-item" title="青色皮肤">
				<div class="wea-theme-layout-img" id="cyangreen">
					<img src="<%=path %>/resource/html5/css/skin/cyangreen_skin.png" alt="">
				</div>
				<div class="wea-theme-layout-name">青色皮肤</div>
			</div>
			<div class="wea-theme-layout-item" title="黄色皮肤">
				<div class="wea-theme-layout-img" id="yellow">
					<img src="<%=path %>/resource/html5/css/skin/yellow_skin.png" alt="">
				</div>
				<div class="wea-theme-layout-name">黄色皮肤</div>
			</div>
		</div>
	</div>
</body>
</html>