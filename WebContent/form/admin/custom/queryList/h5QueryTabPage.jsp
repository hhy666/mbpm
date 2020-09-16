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
<title>添加更新查询查询标签页</title>
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
</style>
<script type="text/javascript">
	//记录iframe中的一级弹出窗口
	var iframeJs;
	//记录授权的组织机构编码
	var authUser = {};
	
	//电脑端弹出输出数据项窗口回调
	function onlayer01Close(selectedItems){
		iframeJs.onlayer01Close(selectedItems);
	}
	
	//移动端弹出输出数据项窗口回调
	function onlayer02Close(selectedItems){
		iframeJs.onlayer02Close(selectedItems);
	}
	
	//排序设置窗口回调
	function onlayer03Close(selectedItems){
		iframeJs.onlayer03Close(selectedItems);
	}
	
	//系统查询条件回调
	function onlayer04Close(data){
		iframeJs.onlayer04Close(data);
	}
	
	//高级查询条件回调
	function onlayer05Close(selectedItems){
		iframeJs.onlayer05Close(selectedItems);
	}
	
	//查询授权窗口回调
	function onlayer06Close(data){
		iframeJs.onlayer06Close(data);
	}
	
	//用户输入条件窗口回调
	function onlayer07Close(selectedItems){
		iframeJs.onlayer07Close(selectedItems);
	}
</script>
</head>
<body>

<div style="width:100%;height:100%;position:relative;margin:0 auto;zoom:1" id="context">
  <form id="form0" name="form0" eventProxy="Mform0" method="post" action="" style="margin:0px;position:relative;width:100%;height:100%;" enctype="application/x-www-form-urlencoded">
	<!-- 操作类型  add添加  update修改 -->
	<input type="hidden" id="oType" name="oType" value="${param.oType }"/>   
	<!-- 表单编码 -->
	<input type="hidden" id="formId" name="formId" value="${param.formId}">
	<!-- 表单变量编码 -->
	<input type="hidden" id="formFlag" name="formFlag" value="${param.formFlag }"/>   
	<!-- 表单模板主键mo_doc_template表  根据此关联外键查询查询设置列表-->
	<input type="hidden" id="catalogId" name=catalogId value="${param.catalogId }"/> 
	 <!-- 查询设置主键 -->
	<input type="hidden" id="uuid" name="uuid" value="${param.uuid }"/>  

	<ul id="TabContainer001" class="nav nav-tabs disable" style="height:32px;display:none;"/>
	    <li><a href="#TabPanel001" data-toggle="tab" id="tabVal">添加查询设置</a></li>
	</ul>
	<div id="content-main" class="tab-content" style="height:100%;width:100%;border-color: #e7eaec;border-image: none;border-style: solid;border-width: 1px;border-top: 0px;">
		<script>
		$(document).ready(function () {
			debugger;
			$('#TabContainer001 a[href="#TabPanel001"]').tab('show');   //启用标签页
			var formFlag = $("#formFlag").val();
			var catalogId = $("#catalogId").val();
			var oType = $("#oType").val();
			var formId = $("#formId").val();
			var uuid = $("#uuid").val();
			
			if(oType == 'add'){   //添加
				$("#tabVal").text("添加查询设置");
				document.getElementById('J_iframe').src = "<%=request.getContextPath()%>/form/admin/custom/queryList/h5QuerySet.jsp?formFlag="+formFlag+"&catalogId="+catalogId+"&oType=add&formId="+formId+"&uuid="+uuid;
			}else if(oType == 'update'){   //修改
				$("#tabVal").text("更新查询设置");
				document.getElementById('J_iframe').src = "<%=request.getContextPath()%>/query/query_getQueryById.action?formFlag="+formFlag+"&catalogId="+catalogId+"&oType=update&formId="+formId+"&uuid="+uuid;
			}	
		})
		</script>
		<div class="tab-pane fade in active" id="TabPanel001" style='height:100%;padding: 0px 0px 0px 0px;'>
			<iframe class="J_iframe" id="J_iframe" src="" style='height:100%;width:100%;border-width: 0px;'></iframe>
		</div>
	</div>
  </form>
</div>
</body>
</html>
