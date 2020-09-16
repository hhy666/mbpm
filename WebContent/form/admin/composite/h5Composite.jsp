<%@page pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:include page="/form/html5/admin/html5Head.jsp"/>
<link rel='stylesheet' href='<%=path%>/resource/html5/css/font-awesome.min.css'/>
<title>Insert title here</title>

<script type="text/javascript">

	window.onload = function(){
		debugger;
		Matrix.showMask2();
		var index = layer.load(0, {shade: false}); //0代表加载的风格，支持0-2
		var templateType = $('#templateType').val();
		if(templateType!=null&&templateType=='3'){
			$('#flowDesigner').css('display','none');
		}
		var templateId = document.getElementById('templateId').value;
		//加载基本信息内容
		$("#content").attr("src","<%=path%>/templateAction_getInfo.action?mBizId="+templateId);
		
	}
	
	//标签页点击事件
	function aClick(win,title){
		debugger;
		//$('#loading').css('display','');
		Matrix.showMask2();
		var index = layer.load(0, {shade: false}); //0代表加载的风格，支持0-2
		//每次点击清除其他标签选中的class
		$('.itme-head').removeClass('select');
		//给当前选中加class
		$(win).addClass('select');
		
		//清楚其他标签下划线 给选中增加
		$('.bottom-line').css('display','none');
		win.parentNode.parentNode.children[1].style.display = "";
		
		var formId = document.getElementById('nodeId').value;
		var formUuid = document.getElementById('formUuid').value;
		var templateId = document.getElementById('templateId').value;
		var templateClass = document.getElementById('templateType').value;
		var isHaveMobile = "";
		var mobileform = document.getElementById('mobileform').value;
		if(mobileform!=2){
			isHaveMobile = "false";
		}else{
			isHaveMobile = "true";
		}
		//设置各个标签的跳转
		$("#head").css('display','');
		$("#main").css('width','85%');
		$("#main").css('height','calc(95% - 80px)%');
		$("#main").css('margin-top','10px');
		$("#content").css('border','1px solid rgb(231, 234, 236)');
		
		if(title=='基本信息'){
			//$("#content").attr("src","<%=path%>/CompositeModel.rform?mBizId="+templateId+"&mHtml5Flag=true");
			$('#head').css('display','none');
			$('#main').css('display','none');
			$("#content").css('display','none');
			$("#main").css('width','50%');
			$("#main").css('height','100%');
			$("#main").css('box-shadow','');
			$("#content").css('border','0px');
			$("#content").attr("src","<%=path%>/templateAction_getInfo.action?mBizId="+templateId);
		}else if(title=='表单设计'){
			$("#head").css('display','none');
			$('#main').css('height','0px');
			$("#main").css('width','100%');
			$("#main").css('margin-top','0px');
			$("#content").attr("src","<%=path%>/templateAction_toFormDesigner.action?formId="+formId+"&isHaveMobile="+isHaveMobile+"&nodeUuid="+formUuid+"&type=1&processType="+(templateClass=="3"?"":templateClass));
		}else if(title=='表单权限'){
			$("#head").css('display','none');
			$("#main").css('width','100%');
			$("#main").css('height','calc(100% - 50px)');
			$("#main").css('margin-top','0px');
			$("#content").attr("src","<%=path%>/security/formSecurity_loadSecurityIndex.action?catalogId="+formUuid);
		}else if(title=='流程设计'){
			$("#head").css('display','none');
			$('#main').css('display','none');
			$("#content").css('display','none');
			$("#main").css('width','100%');
			$("#main").css('height','calc(100% - 50px)');
			$("#main").css('margin-top','0px');
			$("#content").attr("src",'<%=path%>/form/admin/composite/flowDesigner.jsp?mHtml5Flag=true&formId1='+formId+'&flowId1=&parentId1='+templateId+'&formUuid='+formUuid+'&flowOrDoc=${param.flowOrDoc}&type=${param.type}&tempCls=${param.tempCls }&startType=0&id=${param.mid }&docType=${param.docType}&processType='+('${param.tempCls}'=='3'?'':'${param.tempCls}'));
		}else if(title=='数据管理'){
			$("#head").css('display','none');
			$("#main").css('width','100%');
			$("#main").css('height','calc(100% - 50px)');
			$("#main").css('margin-top','0px');
			$("#content").attr("src",'<%=path%>/form/admin/custom/utilization/h5UtilizationList.jsp?catalogId='+templateId+'&formId='+formId);
		}else if(title=='数据查询'){
			$("#head").css('display','none');
			$("#main").css('width','100%');
			$("#main").css('height','calc(100% - 50px)');
			$("#main").css('margin-top','0px');
			$("#content").attr("src",'<%=path%>/form/admin/custom/queryList/h5QueryList.jsp?catalogId='+templateId+'&formId='+formId);
		}else if(title=='统计分析'){
			$("#head").css('display','none');
			$("#main").css('width','100%');
			$("#main").css('height','calc(100% - 50px)');
			$("#main").css('margin-top','0px');
			$("#content").attr("src",'<%=path%>/statistic/statisticAction_statisticMain.action?templateId='+templateId+'&formId='+formId);
		}

	}
	
	//返回上级界面
	function backList(){
		var templateType = $("#templateType").val();
		var paretnNodeId = $("#paretnNodeId").val();
		var childWin = top.childWindow;
		childWin.document.getElementById('templateType').value = templateType;
		childWin.document.getElementById('nodeId').value = paretnNodeId;
		childWin.refreshData();
		Matrix.closeWindow();
		<%-- window.location.href = "<%=path%>/form/html5/admin/logon/matrix/h5FormList.jsp?templateType="+templateType+"&nodeId="+paretnNodeId; --%>
	}
	</script>
</head>
<body style="background: rgba(245,245,247,.9)">
	<!-- 是否有移动表单 用于切换移动表单-->
	<input type="hidden" id="mobileform" name="mobileform">
	<!-- 父模板ID 只用于返回上级菜单-->
	<input type="hidden" id="paretnNodeId" name="paretnNodeId" value="${nodeId}">
	<input type="hidden" id="templateType" name="templateType" value="${templateType}">
	
	<!-- 当前模板ID -->
	<input type="hidden" id="templateId" name="templateId" value="${mBizId}">
	
	<!-- 树节点 表单编码 由子页面h5CompositeModel.jsp赋值 -->
	<input type="hidden" id="nodeId" name="nodeId">
	
	<!-- 表单ID 由子页面h5CompositeModel.jsp赋值 -->
	<input type="hidden" id="formUuid" name="formUuid">
	
	<div id="matrixMask" name="matrixMask" class="matrixMask" style="width: 100%; height: 100%; position: absolute;top: 1;left: 1;z-index: 9999999999999;display: none;"> </div>
	<div class="synergTitle">
		<%-- <img onclick="backList();" id="back" src="<%=path %>/image/back.jpg" style="width:20px;height:20px;position: absolute;left: 10px;top: 12px"/> --%>
		<i onclick="backList();" class="fa fa-angle-left" style="color: #fff;top: 10px;left:15px;font-size: 30px;position: absolute;cursor: pointer;"></i>
		<div style="top: 15px;left:50px;position: absolute;color:white;font-size:15px">${name}</div>
		<div style="display: inline-table;width: 80px;position: relative;text-align: center;">
			<div style="height: 48px;width:110px">
				<a class="itme-head select" href="javascript:void(0);" onclick="aClick(this,'基本信息')">基本信息</a>
			</div>
			<div class="bottom-line" style="width: 100%;background: white;height: 2px;"></div>
		</div>
		<div style="display: inline-table;width: 80px;position: relative;text-align: center;">
			<div style="height: 48px;width:110px">
				<a class="itme-head" href="javascript:void(0);" onclick="aClick(this,'表单设计')">表单设计</a>
			</div>
			<div class="bottom-line" style="width: 100%;background: white;height: 2px;display:none;"></div>
		</div>
		<div style="display: none;width: 80px;position: relative;text-align: center;">
			<div style="height: 48px;width:110px">
				<a class="itme-head" href="javascript:void(0);" onclick="aClick(this,'表单权限')">表单权限</a>
			</div>
			<div class="bottom-line" style="width: 100%;background: white;height: 2px;display:none;"></div>
		</div>
		<div id="flowDesigner" style="display: inline-table;width: 80px;position: relative;text-align: center;">
			<div style="height: 48px;width:110px">
				<a class="itme-head" href="javascript:void(0);" onclick="aClick(this,'流程设计')">流程设计</a>
			</div>
			<div class="bottom-line" style="width: 100%;background: white;height: 2px;display:none;"></div>
		</div>
		<div style="display: inline-table;width: 80px;position: relative;text-align: center;">
			<div style="height: 48px;width:110px">
				<%-- <img class="imgButton" src="<%=path %>/image/test1.jpg" style="margin-bottom:2px;height: 15px;width: 15px;" /> --%>
				<a class="itme-head" href="javascript:void(0);" onclick="aClick(this,'数据管理')">数据管理</a>
			</div>
			<div class="bottom-line" style="width: 100%;background: white;height: 2px;display:none;"></div>
		</div>
		<div style="display: inline-table;width: 80px;position: relative;text-align: center;">
			<div style="height: 48px;width:110px">
				<a class="itme-head"  href="javascript:void(0);" onclick="aClick(this,'数据查询')">数据查询</a>
			</div>
			<div class="bottom-line" style="width: 100%;background: white;height: 2px;display:none;"></div>
		</div>
		<div style="display: inline-table;width: 80px;position: relative;text-align: center;">
			<div style="height: 48px;width:110px">
				<a class="itme-head" href="javascript:void(0);" onclick="aClick(this,'统计分析')">统计分析</a>
			</div>
			<div class="bottom-line" style="width: 100%;background: white;height: 2px;display:none;"></div>
		</div>
	</div>
	<!--  
	<div id="loading" style="width:100%;height:100%">
		<img style="position: absolute;margin: auto;top: 0px;bottom: 0px;left: 0px;right: 0px;" src="<%=path %>/image/ajax-loader.gif">
	</div>
	-->
	<div id="head" style="display:none;margin:auto;margin-top:10px;width:85%;height: 50px;padding-top:10px;border:1px solid rgb(231, 234, 236);background:white;box-shadow:0 2px 4px 0 rgba(0,0,0,.08)">
		<div id="form_div" style="top:0px;bottom:0px;right: 10px;padding-top: 15px;margin:auto;position: absolute;">
		</div>
	</div>
	<div id="main" style="margin:auto;margin-top:10px;width:50%;height: 100%;background:white;";>
		<iframe id="content" style="width:100%;height:100%;" frameborder="0" src="" >
		</iframe>
	</div>
</body>
</html>