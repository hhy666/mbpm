<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>

<!DOCTYPE HTML>
	<html>
		<head>
			<meta charset='utf-8'/>
			<%@ include file="/form/html5/admin/html5Head.jsp"%>
		</head>
<body>
<div style="width:100%;height:100%;overflow:auto;position:relative;margin:0 auto;zoom:1;padding:10px 10px;" id="context"><form id="form0" name="form0" eventProxy="Mform0" method="post" action="<%=request.getContextPath() %>/query/code_h5AddCode.action" style="margin:0px;position:relative;overflow:auto;width:100%;height:100%;" enctype="application/x-www-form-urlencoded">
<div type="hidden" id="form0_hidden_text_div" name="form0_hidden_text_div" style="position:absolute;width:0;height:0;z-index:-9999999999;top:0;left:0;display:none;"></div>
<table id="table001" class="tableLayout " style="width:100%;">
<tr id="tr002"><td id="td003" class="tdLayout" style="width:40%;text-align:center;vertical-align:middle;background-color:rgb(248, 248, 248)"><label id="label002" name="label002" id="label002" class="control-label ">
名称：</label></td>
<td id="td004" class="tdLayout" style="width:60%;"><div id="input002_div" class="input-group col-md-12 " style="display: inline-table; vertical-align: middle; width:80%; "> <input id="name" name="name" type="text" class="form-control " style=" width:100%;height:100%;padding-left: 5px;" autocomplete="off" value=${catalogNode.name } >
 </div>
 <font id="namefont" color="red" >${idEchoMessage }</font>
 </td>
</tr>
<tr id="tr003"><td id="td005" class="tdLayout" style="width:40%;text-align:center;vertical-align:middle;background-color:rgb(248, 248, 248)"><label id="label003" name="label003" id="label003" class="control-label ">
备注：</label></td>
<td id="td006" class="tdLayout" style="width:60%;"><div id="inputTextArea001_div" class="col-md-12 input-group " style="width:100%; "> <textarea id="desc" name="desc" " class="form-control " style=" width:100%;height:100%;" >${catalogNode.desc }</textarea></div></td>
</tr>
<tr id="tr004" ><td id="td007" class="cmdLayout" colspan="2" rowspan="1" >
	<button type="button"  id="button001" class="x-btn ok-btn " >确定</button>
	<button type="button"  id="button002" class="x-btn cancel-btn " >取消</button>
	
	<input id="tenantId" type="hidden" name="tenantId"  />
	<input id="type" type="hidden" name="type" value="${codeNode.type }"/>
	<input id="parentUUID" type="hidden" name="parentUUID" value=${codeNode.parentId } />	
	<input id="parentNodeId" type="hidden" name="parentNodeId" value=${codeNode.parentId } />
	<input id="oType" type="hidden" name="oType" value="${param.oType }">	
	<input id="id" type="hidden" name="id">
	<input id="order" type="hidden" name="order" value="0">
	
	<input id="formId" type="hidden" name="formId" value="${param.formId }">
	<input id="formValue" type="hidden" name="formValue" value="${param.formValue }">
	
	<script>
		$('#button001').click(function(){
			var flag = false;
			if( $('#name').val() == null || $('#name').val() == '' ){//判断名称是否为空
				$('#namefont').html("请输入名称");
				flag = true;
			}else{
				$('#namefont').html("");
			}
			if(flag){
				return;
			}
			$("#id").val($('#name').val());
			$('#form0').submit();
		});
		
		$('#button002').click(function(){
			var index = parent.layer.getFrameIndex(window.name);
			parent.layer.close(index);
		});
	</script></td>
</tr>

</table>

</form></div></body>
</html>
