<!DOCTYPE HTML >
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>

    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=MQ4IRGnocyMzNr4rcB0uwKCG"></script>
    <title>welcome</title>
		<script src="../resource/mobile/mui.min.js"></script>
		<script src="../resource/mobile/app.js"></script>
				<script src="../resource/mobile/common.js"></script>
		
		<script src="../resource/mobile/matrix_mobile.js"></script>
		
		<link rel="stylesheet" href="../resource/mobile/public.css">
		<link rel="stylesheet" href="../resource/mobile/mui.min.css">
		<link rel="stylesheet" href="../resource/mobile/matrix-base.css" />
		
		
	</head>

	<body>

 	<body class="mui-fullscreen" >
 
    <div class="mui-off-canvas-wrap mui-draggable " id="offCanvasWrapper">
        <!-- 侧滑菜单导航容器 -->
        <%@ include file="/mobile/menu-list.jsp"%>
        
		<div class="mui-inner-wrap">
		<div class="mui-content">
		 <header class="mui-bar mui-bar-nav">
                <a class="mui-icon mui-action-back mui-icon-back mui-pull-left"></a>
                <a id="offCanvasShow" href="#offCanvasSide" class="mui-icon mui-action-menu mui-icon-bars mui-pull-right"></a>
                <h1 class="mui-title">考勤打卡</h1>
                
           
            </header>
			<div id="datalist" class="mui-content mui-scroll-wrapper" style="top: 0px;overflow:hidden;width:100%;height:100%;background-color:#FFFFFF;" onchange="">
	
	
			<div id="loadingInfo" style="text-align:center;top:0px;"></div>
			
				 <div style="width:100%;height:100%;border:1px solid gray;margin:30px auto" id="container"></div>  
			</div>

		</div>
		</div>
			
</div>			
		
			<footer class="mui-bar .mui-bar-footer" style="bottom:0px;text-align:center;">
		<button id="btn01" onclick="" class="mui-btn mui-btn-positive mui-pull-center">签到</button>
		<button id="btn02" class="mui-btn mui-btn-positive mui-pull-center">签退</button>
            </footer>
		
<script type="text/javascript">
    		
    	var initFlag = false;	
	    var lng;
	    var lat;
 
    		
    	document.getElementById('btn01').addEventListener('tap',function(){
    	   if(!initFlag){
    	       alert("尚未读到当前位置,请稍候再试");
    	   }
    		//lnt  lat
    		var url="<%=request.getContextPath() %>/attendance/attendance_attendance.action";
			var param="type=1&lng="+lng+"&lat="+lat;
			getUrlData(url,param,function(data){
				alert("签到成功");
		  	}	
			);
		});

    	document.getElementById('btn02').addEventListener('tap',function(){
    	   if(!initFlag){
    	       alert("尚未读到当前位置,请稍候再试");
    	   }
    		//lnt lat
    		//lnt  lat
    		var url="<%=request.getContextPath() %>/attendance/attendance_attendance.action";
			var param="type=2&lng="+lng+"&lat="+lat;
			getUrlData(url,param,function(data){
				alert("签退成功");
		  	}	
			);
		});
    window.onload = function() {
        if(navigator.geolocation) {
        //http://www.cnblogs.com/0201zcr/p/4675028.jsp 申请ak的方法
            	// 百度地图API功能, 手机从url访问定位是准确的,如果刷新当前页面值是有问题的
            	
				var map = new BMap.Map("container");
				//var point = new BMap.Point(116.331398,39.897445);
				//运行一次打卡,将数据库中的lng,lat的值改到这里来
				var point = new BMap.Point(116.3097209,39.91952);
				map.centerAndZoom(point,16);

				var geolocation = new BMap.Geolocation();
				geolocation.getCurrentPosition(function(r){
					if(this.getStatus() == BMAP_STATUS_SUCCESS){
						var mk = new BMap.Marker(r.point);
						map.addOverlay(mk);
						map.panTo(r.point);
						
						//showMap();
						lng = r.point.lng;
						lat = r.point.lat;
						initFlag = true;	
						
						//map.addOverlay(mk);  
                        //map.panTo(r.point); 
						//alert(lng);
						//alert(lat);
						//alert('您的位置：'+r.point.lng+','+r.point.lat);
					}
					else {
						//alert('failed'+this.getStatus());
					}        
				},{enableHighAccuracy: true})
        }
    };
    

		
		function getUrlData(url,param,callback){
			var xmlHttp;
			if(window.ActiveXObject){
				xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}else if(window.XMLHttpRequest){
				xmlHttp = new XMLHttpRequest();
			}
			xmlHttp.open("POST",url+"?"+param,true);
			xmlHttp.setRequestHeader("Content-","application/x-www-form-urlencoded;charset=UTF-8");
			try{
				xmlHttp.send(param);
				xmlHttp.onreadystatechange = function(){
					if(xmlHttp.readyState == 4){
						if(xmlHttp.status == 200){
							var data = xmlHttp.responseText;
							callback(data);
						}else{
							alert("服务器操作异常,请与管理员联系!");
						}
					}
				}	
			}catch(e){
				alert(e);
			}
	   }
</script>	
	</body>

</html>