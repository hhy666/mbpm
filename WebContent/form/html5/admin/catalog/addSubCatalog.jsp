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
<div style="width:100%;height:100%;overflow:auto;position:relative;margin:0 auto;zoom:1;padding:10px 10px;" id="context"><form id="form0" name="form0" eventProxy="Mform0" method="post" action="<%=request.getContextPath() %>/html5Catalog_addSubCatalogH5.action" style="margin:0px;position:relative;overflow:auto;width:100%;height:100%;" enctype="application/x-www-form-urlencoded">
<div type="hidden" id="form0_hidden_text_div" name="form0_hidden_text_div" style="position:absolute;width:0;height:0;z-index:-9999999999;top:0;left:0;display:none;"></div>
<table id="table001" class="tableLayout " style="width:100%;"><tr id="tr001"><td id="td001" class="tdLayout" style="width:40%;text-align:center;vertical-align:middle;background-color:rgb(248, 248, 248)"><label id="label001" name="label001" id="label001" class="control-label ">
编码：</label></td>
<td id="td002" class="tdLayout" style="width:60%;"><div id="input001_div" class="input-group col-md-12 " style="display: inline-table; vertical-align: middle; width:80%; "> <input id="mid" name="mid" type="text" required class="form-control " style=" width:100%;height:100%;padding-left: 5px;" autocomplete="off" value=${catalogNode.mid } > </div>
<font id="midfont" color="red" >${requestScope.idEchoMessage }</font>
</td>
</tr>
<tr id="tr002"><td id="td003" class="tdLayout" style="width:40%;text-align:center;vertical-align:middle;background-color:rgb(248, 248, 248)"><label id="label002" name="label002" id="label002" class="control-label ">
名称：</label></td>
<td id="td004" class="tdLayout" style="width:60%;"><div id="input002_div" class="input-group col-md-12 " style="display: inline-table; vertical-align: middle; width:80%; "> <input id="name" name="name" type="text" class="form-control " style=" width:100%;height:100%;padding-left: 5px;" autocomplete="off" value=${catalogNode.name } >
 </div>
 <font id="namefont" color="red" >${requestScope.nameEchoMessage }</font>
 </td>
</tr>
<tr id="tr003"><td id="td005" class="tdLayout" style="width:40%;text-align:center;vertical-align:middle;background-color:rgb(248, 248, 248)"><label id="label003" name="label003" id="label003" class="control-label ">
备注：</label></td>
<td id="td006" class="tdLayout" style="width:60%;"><div id="inputTextArea001_div" class="col-md-12 input-group " style="width:100%; "> <textarea id="desc" name="desc" " class="form-control " style=" width:100%;height:100%;" >${catalogNode.desc }</textarea></div></td>
</tr>
<tr id="tr004" ><td id="td007" class="cmdLayout" colspan="2" rowspan="1" >
	<button type="button"  id="button001" class="x-btn ok-btn " >确定</button>
	<button type="button"  id="button002" class="x-btn cancel-btn " >取消</button>
	
	<input id="tenantId" type="hidden" name="tenantId" value=${catalogNode.tenantId } />
    <input id="phase" type="hidden" name="phase" value="3" />
	<input id="type" type="hidden" name="type" value="1"/>
	<input id="parentUuid" type="hidden" name="parentUuid" value=${catalogNode.parentUuid } />	
	<input id="parentId" type="hidden" name="parentId" value=${catalogNode.parentUuid } />
	<input id="parentNodeId" type="hidden" name="parentNodeId" value=${catalogNode.parentUuid } />
	<input id="nodeUrl" type="hidden" name="nodeUrl" value=${nodeUrl } >
	
	<script>
		$('#button001').click(function(){
			var flag = false;
			if( $('#mid').val() == null || $('#mid').val() == '' ){
				$('#midfont').html("请输入编码");
				flag = true;
			}else{
				var pattern = /^[a-z][0-9a-zA-Z_]+$/;
				if($('#mid').val().match(pattern)){
					$('#midfont').html("");
				}else{
					$('#midfont').html("请以小写字母开头，只能使用数字，字母或下划线！");
					flag = true;
				}
			}
			if( $('#name').val() == null || $('#name').val() == '' ){
				$('#namefont').html("请输入名称");
				flag = true;
			}else{
				$('#namefont').html("");
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
	</script></td>
</tr>

</table>

</form></div></body>
</html>
