<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.matrix.form.admin.catalog.model.CatalogInfo"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>

<!DOCTYPE HTML><html><head><meta charset='utf-8'/>
<%@ include file="/form/html5/admin/html5Head.jsp"%>
<script type="text/javascript">
	$(function(){
		var trheight = $('#tr002').height();
		$('#tr001').height(trheight);
	});
	
	function submitEnd(){
		Matrix.closeWindow();
	}
</script>
</head>
<body>

<div style="width:100%;height:100%;overflow:auto;position:relative;margin:0 auto;zoom:1;padding:10px 10px;" id="context"><form id="form0" name="form0" eventProxy="Mform0" method="post" style="margin:0px;position:relative;overflow:auto;width:100%;height:100%;" enctype="application/x-www-form-urlencoded" onsubmit="" >
<table id="table001" class="tableLayout" style="width:100%;"><tr id="tr001" height="20%">
<td id="td001" class="tdLayout" colspan="2" rowspan="1" style="border: none;width:100%;background-color:rgb(255, 255, 255)">
<font id="midfont" color="red" >请选择模块导出模式</font>
</td>
</tr>
<tr id="tr002"><td id="td003" class="tdLayout" style="width:40%;text-align:center;vertical-align:middle;background-color:rgb(248, 248, 248)"><label id="label001" name="label001" id="label001" class="control-label ">
导出模式：</label></td>
<td id="td004" class="tdLayout" style="width:60%;"><div id="comboBox001_div" class="input-group col-md-12 " style=" width:80%; "> 
<select class="form-control js-states" id="ExportType" name="exportType" tabindex="-1" style=" width:100%;height:100%;">
<option value="new">最新版本</option>
<option value="all">所有版本</option>
</select></div> 
</td>
</tr>
<tr id="tr003"><td id="td005" class="cmdLayout" colspan="2" rowspan="1" >
<button type="button"  id="button001" class="x-btn ok-btn " >确定</button>
<button type="button"  id="button002" class="x-btn cancel-btn " >关闭</button>
<% 
	String uuid = request.getParameter("uuid");
	String flag = request.getParameter("flag");
	String type = request.getParameter("type");
 %>

<input type="hidden" id="uuid" name="uuid" value="<%=uuid %>"/>
<input type="hidden" id="flag" name="flag" value="<%=flag %>"/>
<input type="hidden" id="uuids" name="uuids" value=""/>

<script type="text/javascript">
	$('#button001').click(function(data){
		var ctype = '<%=type %>';
		var url ;
		if(ctype == '1'){
			url = "<%=request.getContextPath() %>/Html5OperatorContentsHelper";
		}
		if(ctype == '2'){
			url = "<%=request.getContextPath() %>/Html5OperatorModuleHelper";
		}
		
		var mode = '<%=request.getParameter("mode") %>';
		if(mode == 'list'){
			url = url + "?mode=list";
			$('#uuids').val(parent.uuids);
		}
		$('#form0').attr("action", url);
		$('#form0').submit();
	});
	
	$('#button002').click(function(){
		var index = parent.layer.getFrameIndex(window.name);
		parent.layer.close(index);
	});
	
</script>

</td>
</tr>
</table>

</form></div></body>
</html>