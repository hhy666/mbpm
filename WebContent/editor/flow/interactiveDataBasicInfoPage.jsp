<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>交互数据基本信息</title>
	<%@ include file="/form/html5/admin/html5Head.jsp"%>
	<script>
	function saveInteractiveData(){
	    var flowType = Matrix.getFormItemValue("flowType");
		var outParam = Matrix.getFormItemValue("popupSelectDialog002");
  		var inputParam = Matrix.getFormItemValue("popupSelectDialog001");
	
        var inputParamId = Matrix.getFormItemValue("inputParamId");
		
		
		var outParamId = Matrix.getFormItemValue("outParamId");
	
	    var str = "{'outParamId':'"+outParamId+"',";
	
	 	str +="'outParam':'"+outParam+"','inputParam':'"+inputParam+"','inputParamId':'"+inputParamId+"'}";
		
		var synJson = isc.JSON.decode(str);
		if(flowType==0){
			synJson["activityId"]=Matrix.getFormItemValue("activityId");
			synJson["containerId"]=Matrix.getFormItemValue("containerId");
			var url = "<%=request.getContextPath()%>/editor/editor_saveTypeDeclarations.action";
			Matrix.sendRequest(url,synJson,function(){
				
			});
		}else{
	    	var url = "<%=request.getContextPath()%>/editor/process_saveTypeDeclarations.action";
			Matrix.sendRequest(url,synJson,function(){
				
			});
		}	
	}
	
	function saveInputInteractiveData(){
        var flowType = Matrix.getFormItemValue("flowType");
		var flowType = Matrix.getFormItemValue("flowType");
		var outParam = Matrix.getFormItemValue("popupSelectDialog002");
   		var inputParam = Matrix.getFormItemValue("popupSelectDialog001");
       	var inputParamId = Matrix.getFormItemValue("inputParamId");
		var str = "{'outParamId':'"+outParamId+"',";
		str +="'outParam':'"+outParam+"','inputParam':'"+inputParam+"','inputParamId':'"+inputParamId+"'}";
		var synJson = isc.JSON.decode(str);
	    if(flowType==0){
	    	synJson["activityId"]=Matrix.getFormItemValue("activityId");
	    	synJson["containerId"]=Matrix.getFormItemValue("containerId");
			var url = "<%=request.getContextPath()%>/editor/editor_saveInputTypeDeclarations.action";
			Matrix.sendRequest(url,synJson,function(){
				
			});
			}else{
	    	var url = "<%=request.getContextPath()%>/editor/process_saveInputTypeDeclarations.action";
			Matrix.sendRequest(url,synJson,function(){
				
			});
		}
	}
	
	//输入参数对象弹出选择参数对象窗口
	function openpopupSelectDialog001(){
		parent.parent.openParameterObject1(this);     //编辑流程时editFlowProMainPage.jsp弹出       编辑外部子流程活动时loadBasicActivityTreeNodePage.jsp
	}
	
	//输出参数对象弹出选择参数对象窗口
	function openpopupSelectDialog002(){
		parent.parent.openParameterObject2(this);     //editFlowProMainPage.jsp弹出      编辑外部子流程活动时loadBasicActivityTreeNodePage.jsp
	}
	</script>
</head>
 <body>
	<div style="width: 100%; height: 100%; overflow: auto; position: relative;">
		<form id="form0" name="form0" eventProxy="Mform0" method="post" action="" 
			style="margin: 0px; position: relative; overflow: auto; width: 100%; height: 100%;"
			enctype="application/x-www-form-urlencoded">
			<input type="hidden" name="activityId" id="activityId" value="${param.activityId}" />
			<input type="hidden" name="flowType" id="flowType" value="${param.flowType}" />
			<input type="hidden" name="containerId" id="containerId" value="${param.containerId}"/>
			<input id="inputParamId" type="hidden" name="inputParamId" value="${inContainers.id }"/>
			<input id="outParamId" type="hidden" name="outParamId" value="${outContainers.id}"/>
			
			<table id="table001" class="tableLayout" style="width: 100%;">
				<tr id="tr001">
					<td id="td001" class="tdValueCls" style="width: 30%;">
						<label id="label001" name="label001" id="label001">
							输入参数对象：
						</label>
					</td>
					<td id="td002" class="tdValueCls" style="width: 70%;">
						<div id="popupSelectDialog001_div" class="input-group">
							 <input type="text" id="popupSelectDialog001" name="popupSelectDialog001" value="${inContainers.name}"  class="form-control" readonly="readonly">
		            		 <span class="input-group-addon addon-udSelect udSelect" onclick="openpopupSelectDialog001();"><i class="fa fa-search"></i></span>
						</div>	
					</td>
				</tr>
				<tr id="tr002">
					<td id="td003" class="tdValueCls" style="width: 30%;">
						<label id="label002" name="label002" id="label002">
							输出参数对象：
						</label>
					</td>
					<td id="td004" class="tdValueCls" style="width: 70%;">
						<div id="popupSelectDialog002_div" class="input-group">
							 <input type="text" id="popupSelectDialog002" name="popupSelectDialog002" value="${outContainers.name}"  class="form-control" readonly="readonly">
		            		 <span class="input-group-addon addon-udSelect udSelect" onclick="openpopupSelectDialog002();"><i class="fa fa-search"></i></span>
						</div>	
					</td>
				</tr>
			</table>	
		</form>
	</div>
 </body>
</html>
