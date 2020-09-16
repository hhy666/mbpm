<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.matrix.form.admin.catalog.model.CatalogInfo"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>

<!DOCTYPE HTML><html><head><meta charset='utf-8'/>
<%@ include file="/form/html5/admin/html5Head.jsp"%>
<style>

</style>
<script type="text/javascript">


	function selectState(){
		var selected = $('#ComType').val();
		if(selected ==  1){
			$('#tr004').show();
			$('#tr005').show();
		}
		if(selected == 2){
			$('#tr004').hide();
			$('#tr005').show();
		}
		if(selected == 3){
			$('#tr004').hide();
			$('#tr005').hide();
		}
	}
</script>
</head>
<body onload="selectState();">

<div style="width:100%;height:100%;overflow:auto;position:relative;margin:0 auto;zoom:1;padding:10px 10px;" id="context"><form id="form0" name="form0" eventProxy="Mform0" method="post" action="<%=request.getContextPath() %>/html5Catalog_addComponentH5.action" style="margin:0px;position:relative;overflow:auto;width:100%;height:100%;" enctype="application/x-www-form-urlencoded">
<input type="hidden" name="form0" value="form0" />
<input type="hidden" id="matrix_form_tid" name="matrix_form_tid" value="f1f72590-7f16-48a5-9a95-a509e3d4d173" />
<div type="hidden" id="form0_hidden_text_div" name="form0_hidden_text_div" style="position:absolute;width:0;height:0;z-index:-9999999999;top:0;left:0;display:none;"></div>
<table id="table001" class="tableLayout" style="width:100%;"><tr id="tr001"><td id="td001" class="tdLayout" style="width:35%;text-align:center;vertical-align:middle;background-color:rgb(248, 248, 248)"><label id="label001" name="label001" id="label001" class="control-label ">
编码：</label></td>
<td id="td002" class="tdLayout" style="width:50%;"><div id="input001_div" class="input-group default-widthcol-md-12 " style="display: inline-table; vertical-align: middle; width:65%; "> <input id="Mid" name="mid" type="text" class="form-control "  required style=" width:100%;height:100%;padding-left: 5px;" autocomplete="off" value=${catalogNode.mid } > </div>
<font id="midfont" color="red" >${idEchoMessage }</font>
</td>
</tr>
<tr id="tr002"><td id="td003" class="tdLayout" style="width:35%;text-align:center;vertical-align:middle;background-color:rgb(248, 248, 248)"><label id="label002" name="label002" id="label002" class="control-label ">
名称：</label></td>
<td id="td004" class="tdLayout" style="width:0%;"><div id="input002_div" class="input-group default-widthcol-md-12 "  required style="display: inline-table; vertical-align: middle; width:65%; "> <input id="Name" name="name" type="text" class="form-control " style=" width:100%;height:100%;padding-left: 5px;" autocomplete="off" value=${catalogNode.name } > </div>
<font id="namefont" color="red" >${nameEchoMessage }</font>
</td>
</tr>
<tr id="tr003"><td id="td005" class="tdLayout" style="width:35%;text-align:center;vertical-align:middle;background-color:rgb(248, 248, 248)"><label id="label003" name="label003" id="label003" class="control-label ">
类型：</label></td>
<td id="td006" class="tdLayout" style="width:-50%;"><div id="comboBox001_div" class="input-group col-md-12 " style="width:65%; "> <select class="form-control js-states" id="ComType" name="comType" tabindex="-1" style=" width:100%;height:100%;" >
<option value="1"
<%
	CatalogInfo catalog = (CatalogInfo)request.getAttribute("catalogNode");
	String comtype = catalog.getComType();
	if("1".equals(comtype)){
 %>
selected="selected" 
<%} %>
>Spring服务</option>
<option value="2" selected="selected" 
<% if("2".equals(comtype)){ %>
selected="selected" 
<%} %>
>Java服务</option>
<option value="3"
<% if("3".equals(comtype)){ %>
selected="selected" 
<%} %>
>脚本逻辑</option>
</select></div> 
</td>
</tr>
<tr id="tr004"><td id="td007" class="tdLayout" style="width:35%;text-align:center;vertical-align:middle;background-color:rgb(248, 248, 248)"><label id="label004" name="label004" id="label004" class="control-label ">
服务标识：</label></td>
<td id="td008" class="tdLayout" style="width:-100%;"><div id="input003_div" class="input-group default-widthcol-md-12 " style="display: inline-table; vertical-align: middle; width:65%; "> <input id="ServiceName" name="serviceName" type="text" class="form-control " style=" width:100%;height:100%;padding-left: 5px;" autocomplete="off" value=${serviceName } > </div>
<font id="serviceNamefont" color="red" >${serviceNameEchoMsg }</font>
</td>
</tr>
<tr id="tr005"><td id="td009" class="tdLayout" style="width:35%;text-align:center;vertical-align:middle;background-color:rgb(248, 248, 248)"><label id="label005" name="label005" id="label005" class="control-label ">
实现类：</label></td>
<td id="td010" class="tdLayout" style="width:-150%;"><div id="input004_div" class="input-group default-widthcol-md-12 " style="display: inline-table; vertical-align: middle; width:65%; "> <input id="ServiceLocation" name="serviceLocation" type="text" class="form-control " style=" width:100%;height:100%;padding-left: 5px;" autocomplete="off" value=${serviceLocation } > </div>
</td>
</tr>
<tr id="tr006"><td id="td011" class="tdLayout" style="width:35%;text-align:center;vertical-align:middle;background-color:rgb(248, 248, 248)"><label id="label006" name="label006" id="label006" class="control-label ">
描述：</label></td>
<td id="td012" class="tdLayout" style="width:65%;text-align:center;vertical-align:middle;background-color:rgb(255, 255, 255)"><div id="inputTextArea001_div" class="col-md-12 input-group " style="width:100%; "> <textarea id="Desc" name="desc" " class="form-control " style=" width:100%;height:100%;" >${catalogNode.desc }</textarea></div></td>
</tr>
<tr id="tr007"><td id="td013" class="cmdLayout" colspan="2" rowspan="1" >
<button type="button"  id="button001" class="x-btn ok-btn " >确定</button>
<button type="button"  id="button002" class="x-btn cancel-btn " >取消</button>
	<input id="tenantId" type="hidden" name="tenantId" value=${catalogNode.tenantId } />
    <input id="phase" type="hidden" name="phase" value=${catalogNode.phase } />
	<input id="parentId" type="hidden" name="parentId" value=${catalogNode.parentUuid } />
	<input id="isPublic" type="hidden" name="isPublic" value="1"/>
	<input id="type" type="hidden" name="type" value="15"/>
	
	<input id="parentNodeId" type="hidden" name="parentNodeId" value=${param.parentNodeId } />
	

	<script>
	$('#button001').click(function(){
			var flag = false;
			if( $('#Mid').val() == null || $('#Mid').val() == '' ){
				$('#midfont').html("请输入编码");
				flag = true;
			}else{
				var pattern = /^[a-zA-Z][a-zA-Z0-9_]*$/;
				if($('#Mid').val().match(pattern)){
					$('#midfont').html("");
				}else{
					$('#midfont').html("以英文字母开头，只能使用数字，字母或下划线！");
					flag = true;
				}
			}
			if( $('#Name').val() == null || $('#Name').val() == '' ){
				$('#namefont').html("请输入名称");
				flag = true;
			}else{
				$('#namefont').html("");
			}
			var endselected = $('#ComType').val();
			if(endselected == 1 &&( $('#ServiceName').val() == null || $('#ServiceName').val() == '' )){
				$('#serviceNamefont').html("请输入服务标识");
				flag = true;
			}else{
				$('#serviceNamefont').html("");
			}
			if(flag){
				return;
			}
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
<script type="text/javascript">
$('#ComType').change(function(){
	selectState();
});
</script>

</html>
