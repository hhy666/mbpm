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

<div style="width:100%;height:100%;overflow:auto;position:relative;margin:0 auto;zoom:1;padding:10px 10px;" id="context"><form id="form0" name="form0" eventProxy="Mform0" method="post" action="<%=request.getContextPath() %>/refactor/html5RefactorAction_reNameComponentId.action" style="margin:0px;position:relative;overflow:auto;width:100%;height:100%;" enctype="application/x-www-form-urlencoded">
<table id="table001" class="tableLayout" style="width:100%;"><tr id="tr001"><td id="td001" class="tdLayout" style="width:40%;text-align:center;vertical-align:middle;background-color:rgb(248, 248, 248)"><label id="label001" name="label001" id="label001" class="control-label ">
原编码：</label></td>
<td id="td002" class="tdLayout" style="width:60%;"><div id="input001_div" class="input-group default-width col-md-12 " style="display: inline-table; vertical-align: middle; width:80%; "> <input id="Name" name="name" type="text" class="form-control " style=" width:100%;height:100%;padding-left: 5px;" autocomplete="off" readonly="readonly" value=${catalogNode.mid } > </div></td>
</tr>
<tr id="tr002"><td id="td003" class="tdLayout" style="width:40%;text-align:center;vertical-align:middle;background-color:rgb(248, 248, 248)"><label id="label002" name="label002" id="label002" class="control-label ">
新编码：</label></td>
<td id="td004" class="tdLayout" style="width:60%;"><div id="input002_div" class="input-group default-width col-md-12 " style="display: inline-table; vertical-align: middle; width:80%; "> <input id="NewCompId" name="newCompId" type="text" class="form-control " style=" width:100%;height:100%;padding-left: 5px;" autocomplete="off" value=${newCompId } > </div>
<font id="namefont" color="red" >${idEchoMessage } </font>
</td>
</tr>
<tr id="tr003"><td id="td005" class="cmdLayout" colspan="2" rowspan="1" >
<button type="button"  id="button001" class="x-btn ok-btn "  >确定</button>
<button type="button"  id="button002" class="x-btn cancel-btn " >取消</button>
	<input id="cType" type="hidden" name="cType" value=${catalogNode.type } />
	<input id="srcEntityPath" type="hidden" name="srcEntityPath" value=${catalogNode.subItems } />
	<input id="srcCompId" type="hidden" name="srcCompId" value=${catalogNode.mid } />
	<input id="uuid" type="hidden" name="uuid" value=${catalogNode.uuid } />
	<input id="iframewindowid" type="hidden" name="iframewindowid" value="RenameIdDialog"/>
	<script>
		$('#button001').click(function(){
			var flag = false;
			if( $('#NewCompId').val() == null || $('#NewCompId').val() == '' ){
				$('#namefont').html("请输入名称");
				flag = true;
			}else{
				$('#namefont').html("");
			}
			if(flag){
				return;
			}
			$('#form0').submit();
		})
		
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

