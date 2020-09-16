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
<title>添加更新数据带入标签页</title>
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
	//选择关联表单窗口回调   给formId赋值  给目标表单加option
	function onassociatedClose(data){
		iframeJs.onassociatedClose(data);
	}
</script>
</head>
<body>

<div style="width:100%;height:100%;position:relative;margin:0 auto;zoom:1" id="context">
  <form id="form0" name="form0" eventProxy="Mform0" method="post" action="" style="margin:0px;position:relative;width:100%;height:100%;" enctype="application/x-www-form-urlencoded">
	<input type="hidden" id="oType" name="oType" value="${param.oType }"/>   <!-- 操作类型  add添加  update修改 -->
	<input type="hidden" id="uuid" name="uuid" value="${param.uuid }"/>

	<ul id="TabContainer001" class="nav nav-tabs disable" style="height:32px;"/>
	    <li><a href="#TabPanel001" data-toggle="tab" id="tabVal">添加数据带入</a></li>
	</ul>
	<div id="content-main" class="tab-content" style="height:calc(100% - 32px);width:100%;border-color: #e7eaec;border-image: none;border-style: solid;border-width: 1px;border-top: 0px;">
		<script>
		$(document).ready(function () {
			debugger;
			$('#TabContainer001 a[href="#TabPanel001"]').tab('show');   //启用标签页
			var oType = $("#oType").val();
			var uuid = $("#uuid").val();
			if(oType == 'add'){   //添加
				$("#tabVal").text("添加数据带入");
				document.getElementById('J_iframe').src = "<%=request.getContextPath()%>/mapping/dataMapping_loadH5CopySet.action?oType="+oType+"";
			}else if(oType == 'update'){   //修改
				$("#tabVal").text("更新数据带入");
				document.getElementById('J_iframe').src = "<%=request.getContextPath()%>/mapping/dataMapping_getH5ListById.action?oType="+oType+"&uuid="+uuid;
			}	
		})
		</script>
		<div class="tab-pane fade in active" id="TabPanel001" style='height:100%;padding: 3px 0px 0px 0px;'>
			<iframe class="J_iframe" id="J_iframe" src="" style='height:100%;width:100%;border-width: 0px;'></iframe>
		</div>
	</div>
  </form>
</div>
</body>
</html>
