<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.matrix.form.admin.catalog.model.CatalogInfo"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>

<!DOCTYPE HTML><html><head><meta charset='utf-8'/>
<%@ include file="/form/html5/admin/html5Head.jsp"%>
<script type="text/javascript">

	//编码验证
	function midValidate(){
		var mid = $('#Mid').val();
		if( mid == null || mid == '' ){
			$('#midfont').html("请输入编码");
			flag = true;
		}else{
			var pattern = /^[a-zA-Z][a-zA-Z0-9_]*$/;
			if(!mid.match(pattern)){
				$('#midfont').html("以英文字母开头，只能使用数字，字母或下划线！");
				flag = true;
			}
			var url = "<%=path%>/html5Catalog_designerEntityValidate.action";
			var data = {};
			data.mid = mid;
			Matrix.sendRequest(url,data,function(data){
				if(data.data=="error"){
					$('#midfont').html("编码重复！");
				}else if(data.data=="success"){
					
				}
			});
		}
	}
	
	//名称验证
	function nameValidate(){
		var name = $('#Name').val();
		if( name == null || name == '' ){
			$('#namefont').html("请输入名称");
		}
		if( $('#TableName').val() == null || $('#TableName').val() == '' ){
			$('#tableNamefont').html("请输入表名");
		}else{
			$('#tableNamefont').html("");
		}
		var parentId = $('#parentId').val();
		var step = "designer";
		var url = "<%=path%>/html5Catalog_nameValidate.action";
		var data = {};
		data.name = name;
		data.parentId = parentId;
		data.step = step;
		Matrix.sendRequest(url,data,function(data){
			if(data.data=="error"){
				$('#namefont').html("名称重复！");
			}else if(data.data=="success"){
				
			}
		});
	}

</script>
<style>

</style>
</head>
<body>

<div class="container" style="width:100%;height:100%;overflow:auto;position:relative;margin:0 auto;zoom:1;padding:10px 10px;" id="context"><form id="form0" name="form0" eventProxy="Mform0" method="post" action="<%=request.getContextPath() %>/html5Catalog_addComponentH5.action" style="margin:0px;position:relative;overflow:auto;width:100%;height:100%;" enctype="application/x-www-form-urlencoded">
<table id="table001" class="tableLayout" style="width:100%;"><tr id="tr001"><td id="td001" class="tdLayout" style="width:40%;text-align:center;vertical-align:middle;background-color:rgb(248, 248, 248)"><label id="label001" name="label001" id="label001" class="control-label ">
编码：</label></td>
<td id="td002" class="tdLayout" style="width:60%;"><div id="input001_div" class="input-group default-width col-md-12 " style="display: inline-table; vertical-align: middle; width:80%; "> <input id="Mid" name="mid" type="text" class="form-control "  required style=" width:100%;height:100%;padding-left: 5px;" autocomplete="off" value=${catalogNode.mid } > </div>
<font id="midfont" color="red" >${requestScope.idEchoMessage }</font>
</td>
</tr>
<tr id="tr002"><td id="td003" class="tdLayout" style="width:40%;text-align:center;vertical-align:middle;background-color:rgb(248, 248, 248)"><label id="label002" name="label002" id="label002" class="control-label ">
名称：</label></td>
<td id="td004" class="tdLayout" style="width:60%;"><div id="input002_div" class="input-group default-width col-md-12 " style="display: inline-table; vertical-align: middle; width:80%; "> <input id="Name" name="name"  required  type="text" class="form-control " style=" width:100%;height:100%;padding-left: 5px;" autocomplete="off" value=${catalogNode.name } > </div>
<font id="namefont" color="red" >${requestScope.nameEchoMessage }</font>
</td>
</tr>
<tr id="tr003"><td id="td005" class="tdLayout" style="width:40%;text-align:center;vertical-align:middle;background-color:rgb(248, 248, 248)"><label id="label003" name="label003" id="label003" class="control-label ">
启用状态：</label></td>
<td id="td006" class="tdLayout" style="width:60%;"><div id="comboBox001_div" class="input-group col-md-12 " style="width:80%; "> <select class="form-control js-states" id="State" name="state" tabindex="-1" style=" width:100%;height:100%;" >
<option value="1"
<%
	Integer state = (Integer)request.getAttribute("state");
	if(state == 1){
 %>
 selected="selected" 
<%} %>
>启用</option><option value="2" 
<% if(state == 2){ %>
 selected="selected" 
<%} %>
>未启用</option></select></div> 
</td>
</tr>
<tr id="tr004"><td id="td007" class="tdLayout" style="width:40%;text-align:center;vertical-align:middle;background-color:rgb(248, 248, 248)"><label id="label004" name="label004" id="label004" class="control-label ">
表名：</label></td>
<td id="td008" class="tdLayout" style="width:60%;"><div id="input003_div" class="input-group default-width col-md-12 " style="display: inline-table; vertical-align: middle; width:80%; "> <input id="TableName" name="tableName" type="text" class="form-control " style=" width:100%;height:100%;padding-left: 5px;" autocomplete="off" value=${tableName } > </div>
<font id="tableNamefont" color="red" ></font>
</td>
</tr>
<tr id="tr005"><td id="td009" class="tdLayout" style="width:40%;text-align:center;vertical-align:middle;background-color:rgb(248, 248, 248)"><label id="label005" name="label005" id="label005" class="control-label ">
主键生成策略：</label></td>
<td id="td010" class="tdLayout" style="width:60%;"><div id="comboBox002_div" class="input-group col-md-12 " style="width:80%; "> <select class="form-control js-states" id="KeyStrategy" name="keyStrategy" tabindex="-1" style=" width:100%;height:100%;" onchange="sequenceFun(this.options[this.options.selectedIndex].value);">
<script type="text/javascript">
function sequenceFun(a){
	//var sel = document.getElementById("KeyStrategy");
	//var val = sel.options[sel.selectIndex].value;
	if(a=="sequence"){
		document.getElementById("tr100").style.display = "table-row";
	}else{
		document.getElementById("tr100").style.display = "none";
	}
}
</script>
<option value="assigned" 
<%
	String keyStrategy = (String)request.getAttribute("keyStrategy");
	if("assigned".equals(keyStrategy)){
 %>
 selected="selected" 
<%} %>
>assigned</option>
<option value="uuid.hex"
<% if("uuid.hex".equals(keyStrategy)){ %>
 selected="selected" 
<%} %>
>uuid.hex</option>
<option value="increment" 
<% if("increment".equals(keyStrategy)){ %>
 selected="selected" 
<%} %>
>increment</option>
<option value="sequence" 
<% if("sequence".equals(keyStrategy)){ %>
 selected="selected" 
<%} %>
>sequence</option>
</select></div> 
</td>
</tr>
<tr id="tr100" style="display:none;"><td id="td100" class="tdLayout" style="width:40%;text-align:center;vertical-align:middle;background-color:rgb(248, 248, 248)"><label id="label006" name="label006" id="label006" class="control-label ">
序列名:</label><a></a>
<td id="td101" class="tdLayout" style="width:60%;"><div id="input101_div" class="input-group default-width col-md-12 " style="display: inline-table; vertical-align: middle; width:80%; "> <input id="sequenceName" name="sequenceName" type="text" class="form-control " style=" width:100%;height:100%;padding-left: 5px;" autocomplete="off" value=${sequenceName } > </div>
<font id="sequenceNamefont" color="red" ></font>
</td>
</tr>
<tr id="tr006"><td id="td011" class="tdLayout" style="width:40%;text-align:center;vertical-align:middle;background-color:rgb(248, 248, 248)"><label id="label006" name="label006" id="label006" class="control-label ">
缓存类型：</label></td>
<td id="td012" class="tdLayout" style="width:60%;"><div id="comboBox003_div" class="input-group col-md-12 " style="width:80%; "> <select class="form-control js-states" id="CacheType" name="cacheType" tabindex="-1" style=" width:100%;height:100%;"  >
<option value="none" 
<%
	String cacheType = (String)request.getAttribute("cacheType");
	if("none".equals(cacheType)){
 %>
  selected="selected" 
<%} %>
>无</option>
<option value="read-only"
<% if("read-only".equals(cacheType)){ %>
 selected="selected" 
<%} %>
>只读型</option>
<option value="read-write" 
<% if("read-write".equals(cacheType)){ %>
 selected="selected" 
<%} %>
>读写型</option>
<option value="nonstrict-read-only" 
<% if("nonstrict-read-only".equals(cacheType)){ %>
 selected="selected" 
<%} %>
>非严格读写型</option>
</select></div> 
</td>
</tr>
<tr id="tr007"><td id="td013" class="tdLayout" style="width:40%;text-align:center;vertical-align:middle;background-color:rgb(248, 248, 248)"><label id="label007" name="label007" id="label007" class="control-label ">
数据源名称：</label></td>
<td id="td014" class="tdLayout" style="width:60%;"><div id="comboBox004_div" class="input-group col-md-12 " style="width:80%; "> <select class="form-control js-states" id="DsName" name="dsName" tabindex="-1" style=" width:100%;height:100%;" >
<option value="">默认</option>

<%
List dsNames = (List)request.getAttribute("dsNames");
String dsName2 = (String)request.getAttribute("dsName");
    for(Iterator iter = dsNames.iterator(); iter.hasNext(); ){
    	String dsName = (String)iter.next();
%>

<option value="<%=dsName%>" 

<%
if("workflowDS".equals(dsName2)){
%>

selected="selected" 

<%} %>
><%=dsName%></option>

<%   
    }

%>

</select></div> 
</td>
</tr>
<tr id="tr008"><td id="td015" class="tdLayout" style="width:40%;text-align:center;vertical-align:middle;background-color:rgb(248, 248, 248)"><label id="label008" name="label008" id="label008" class="control-label ">
描述：</label></td>
<td id="td016" class="tdLayout" style="width:60%;"><div id="inputTextArea001_div" class="col-md-12 input-group " style="width:100%; "> <textarea id="Desc" name="desc" " class="form-control " style=" width:100%;height:100%;" >${catalogNode.desc } </textarea></div></td>
</tr>
<tr id="tr009"><td id="td017" class="cmdLayout" colspan="2" rowspan="1" >
<button type="button"  id="button001" class="x-btn ok-btn " >确定</button>
<button type="button"  id="button002" class="x-btn cancel-btn " >取消</button>
	<input id="tenantId" type="hidden" name="tenantId" value=${catalogNode.tenantId } />
    <input id="phase" type="hidden" name="phase" value=${catalogNode.phase } />
	<input id="type" type="hidden" name="type" value=${catalogNode.type } />
	<input id="parentId" type="hidden" name="parentId" value=${catalogNode.parentUuid } />
	<input id="parentNodeId" type="hidden" name="parentNodeId" value="${param.parentNodeId}" />
	<input id="comType" type="hidden" name="comType" value=${catalogNode.comType } />
	<input id="isPublic" type="hidden" name="isPublic" value=${catalogNode.isPublic } >	
</tr>
</table>
<script type="text/javascript">
	$('#button001').click(function(){
		var mid = $('#Mid').val();
		if( mid == null || mid == '' ){
			$('#midfont').html("请输入编码");
			return false;
		}else{
			var pattern = /^[a-zA-Z][a-zA-Z0-9_]*$/;
			if(!mid.match(pattern)){
				$('#midfont').html("以英文字母开头，只能使用数字，字母或下划线！");
				return false;
			}
			var url = "<%=path%>/html5Catalog_designerEntityValidate.action";
			var data = {};
			data.mid = mid;
			Matrix.sendRequest(url,data,function(data){
				if(data.data=="error"){
					$('#midfont').html("编码重复！");
					return false;
				}else if(data.data=="success"){
					var name = $('#Name').val();
					if( name == null || name == '' ){
						$('#namefont').html("请输入名称");
						return false;
					}
					if( $('#TableName').val() == null || $('#TableName').val() == '' ){
						$('#tableNamefont').html("请输入表名");
						return false;
					}else{
						$('#tableNamefont').html("");
					}
					var parentId = $('#parentId').val();
					var step = "designer";
					var url = "<%=path%>/html5Catalog_nameValidate.action";
					var data = {};
					data.name = name;
					data.parentId = parentId;
					data.step = step;
					Matrix.sendRequest(url,data,function(data){
						if(data.data=="error"){
							$('#namefont').html("名称重复！");
							return false;
						}else if(data.data=="success"){
							if( $('#KeyStrategy').val() == "sequence"){
								if( $('#sequenceName').val() == null || $('#sequenceName').val() == '') {
									$('#sequenceNamefont').html('请输入序列名');
								}else{
									$('#sequenceNamefont').html("");
								}
							}
							$('#form0').submit();
						}
					});
				}
			});
			}
	});
		
		$('#button002').click(function(){
			var index = parent.layer.getFrameIndex(window.name);
			parent.layer.close(index);
		});
</script>
</form></div></body>
</html>
