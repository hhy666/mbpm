<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
	<meta charset="UTF-8">
	<title>辅助事件详细信息页面</title>
	<%@ include file="/form/html5/admin/html5Head.jsp"%>
	<script type="text/javascript">
		window.onblur=function(){
			saveData();
		}
		
		window.onfocus=function(){
			Matrix.setFormItemValue('editFlag','edit');
		}
		
		//保存
		function saveData(){
			var editFlag = Matrix.getFormItemValue('editFlag');
			if(editFlag==null || editFlag!='edit'){
				return;
			}else{
				var entityId = Matrix.getFormItemValue("entityId");
				var component = Matrix.getFormItemValue('popupSelectDialog001');//组件名称
				var authId = Matrix.getFormItemValue('authId');//组件编码
				var name = Matrix.getFormItemValue('input002');//名称
				var condition = Matrix.getFormItemValue('popupSelectDialog2').replaceAll("\"","----#&#----");//条件
				var activityId = Matrix.getFormItemValue('activityId');
				var containerId = Matrix.getFormItemValue('containerId');
				
				var txType = Matrix.getFormItemValue("comboBox001");//事务类型
			
				var json = "{'componentId':'"+authId+"','component':'"+component+"','name':'"+name+"','condition':\""+condition+"\",'containerId':'"+containerId+"','txType':'"+txType+"','entityId':'"+entityId+"','activityId':'"+activityId+"'}";
				var synJson = isc.JSON.decode(json);
				//保存辅助事件的属性
				var url = "<%=request.getContextPath()%>/editor/editor_saveAssistEventDetailProperty.action";
				Matrix.sendRequest(url,synJson,function(){
					return true;
				});
			}
		}
			
		//弹出集成组件选择窗口
		function openpopupSelectDialog1(){
			Matrix.setFormItemValue('editFlag','');
			parent.parent.parent.openNoComponent(this);   //loadBasicActivityTreeNodePage.jsp弹出
		}
		
		//弹出条件编辑窗口
		function openpopupSelectDialog2(){
			var conditionValue = Matrix.getFormItemValue('popupSelectDialog2');
			if(conditionValue==null ||conditionValue=='undefined' ||conditionValue=='null'){
				conditionValue = "";
			}
			Matrix.setFormItemValue('editFlag','');
			parent.parent.parent.openCondiation(conditionValue,this);   //loadBasicActivityTreeNodePage.jsp弹出
		}
	</script>
</head>
<body>

<div id="j_id1" jsId="j_id1" style="position: relative; _layout: flowlayout; width: 100%; height: 100%">
 <form id="form0" name="form0" eventProxy="Mform0" method="post" action="<%=request.getContextPath()%>/editor/editor_.action"
	style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
	<input name="authId" id="authId" type="hidden" value="${assistEvent.actionId}"/>
	<input name="data" id="data" type="hidden" />
	<input name="flag" id="flag" type="hidden" />
	<input name="editFlag" id="editFlag" type="hidden" />
	<input type="hidden" name="index" id="index" value="${param.index }"/>
	<input name="entityId" id="entityId" type="hidden" value="${param.entityId }"/>
	<input name="activityId" id="activityId" type="hidden" value="${param.activityId}"/>
	<input name="type" id="type" type="hidden" value="${param.type}"/>
	<input name="processdid" id="processdid" type="hidden" value="${param.processdid}"/>
	<input name="containerType" id="containerType" type="hidden" value="${param.containerType}"/>
	<input name="containerId" id="containerId" type="hidden" value="${param.containerId }"/>
	<input name="express" id="express" type="hidden" value="${assistEvent.preCondition.value }"/>
	
	<table id="table001" class="tableLayout" style="width:100%;" >
		<tr id="tr004">
			<td id="td007" class="tdLabelCls" style="width:20%;text-align:right;">
				<label id="label004" name="label004" id="label004">
					组件：
				</label>
			</td>
			<td id="td008" class="tdValueCls" style="width:80%;">
				<div id="popupSelectDialog1_div" class="input-group">
					 <input type="text" id="popupSelectDialog1" name="popupSelectDialog1" value="${componentName}"  class="form-control" readonly="readonly">
            		 <span class="input-group-addon addon-udSelect udSelect" onclick="openpopupSelectDialog1();"><i class="fa fa-search"></i></span>
				</div>
			</td>
		</tr>
		<tr id="tr002">
			<td id="td003" class="tdLabelCls" style="width:20%;text-align:right;">
				<label id="label002" name="label002" id="label002">
					名称：
				</label>
			</td>
			<td id="td004" class="tdValueCls" style="width:80%;">
				<div id="input002_div" style="vertical-align: middle;">
					<input id="input002" name="input002" type="text" value="${assistEvent.name}" class="form-control" style="width:100%;" onkeyup="changeContent();"/>
				</div>
			</td>
		</tr>
		<script>
		    //改变辅助事件名称文本框内容事件
			function changeContent(){
				var name = Matrix.getFormItemValue('input002');//名称
				var index = Matrix.getFormItemValue('index');
				parent.parent.updateName(name,index);
			}
		</script>
		<tr id="tr005">
			<td id="td009" class="tdLabelCls" style="width:20%;text-align:right;">
				<label id="label005" name="label005" id="label005">
					条件：
				</label>
			</td>
			<td id="td010" class="tdValueCls" style="width:80%;">
				<div id="popupSelectDialog2_div" class="input-group">
					<input type="text" id="popupSelectDialog2" name="popupSelectDialog2" value="${condition}"  class="form-control" readonly="readonly">
					<span class="input-group-addon addon-udSelect udSelect" onclick="openpopupSelectDialog2();"><i class="fa fa-search"></i></span>
				</div>
			</td>
		</tr>
		<tr id="tr003">
				<td id="td005" class="tdLabelCls" style="width:20%;text-align:right;">
					<label id="label003" name="label003" id="label003">
						事务类型：
					</label>
				</td>
				
				<td id="td006" class="tdValueCls" style="width:80%;">
					<div id="comboBox001_div">
						<select id="comboBox001" name="comboBox001" value="${assistEvent.transactionType}" class="form-control" style="width:100%;">
						   <option value="2" ${assistEvent.transactionType != "Emben" ?  "selected" : ""}>不支持事务</option>
	                       <option value="1" ${assistEvent.transactionType == "Emben" ?  "selected" : ""}>嵌入上级事务中</option>
	                    </select>
				    </div>
				</td>
			</tr>	
	</table>
 </form>
</div>
</body>
</html>