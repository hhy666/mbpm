<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html>
<html>
<title>编辑活动属性</title>
<meta charset="UTF-8">
<head>
<%@ include file="/form/html5/admin/html5Head.jsp"%>

<style type="text/css">
	#td103{
		width:25%;
		height:100%;
		border:1px #dedede solid;
	}
	#td104{
		width:75%;
		height:100%;
		border:1px #dedede solid;
	}
	#td105{/** 属性结构标题td*/
		width:100%;
		height:30px;
		background:#F8F8F8;
	}
	#td106{/** 属性结构内容td*/
		width:100%;
		height:94%;
		border:1px #dedede solid;
	}
	#font1{
		font-size:14px;
		margin-left:10px;
		font-weight:bold;
	}
	#font2{
		font-size:14px;
		margin-left:10px;
		font-weight:bold;
	}
	#td107{
		width:100%;
		height:30px;
		background:#F8F8F8;
	}
	#td108{
		width:100%;
		height:94%;
		border:1px #dedede solid;
	}
</style>
<script>
	var data = {};
	var iframeJs;     //调用一级弹出窗口的window对象
	var iframeJs2;     //调用二级弹出窗口的window对象
	
	window.onbeforeunload = function(){
	 	var url = "<%=request.getContextPath()%>/editor/editor_clearSession.action";
	 	Matrix.sendRequest(url,null,function(){});
	}
	 
	//辅助事件详细信息页面弹出条件编辑窗口
	function openCondiation(conditionValue,iframe){
		iframeJs = iframe;
		Matrix.setFormItemValue('conditionValue',conditionValue);
		layer.open({
			id:'layer01',
			type : 2,
			
			title : ['条件编辑窗口'],
			shadeClose: false, //开启遮罩关闭
			area : [ '55%', '75%' ],
			content : '<%=request.getContextPath()%>/editor/common/conditionEditPage.jsp?iframewindowid=layer01'	
		});  	
	}
	
	//条件编辑窗口回调
	function onlayer01Close(data){
		iframeJs.Matrix.setFormItemValue('editFlag','edit');
		if(data!=null){
			iframeJs.Matrix.setFormItemValue('popupSelectDialog2',data.expressName);
			iframeJs.Matrix.setFormItemValue('express',data.express);
			Matrix.setFormItemValue("conditionValue","");
		}
		iframeJs.window.focus();
	}
	
	//辅助事件详细信息页面选择组件弹出非交互式组件窗口
	function openNoComponent(iframe){
		iframeJs = iframe;
		layer.open({
	    	id:'layer02',
			type : 2,
			
			title : ['集成组件选择窗口'],
			shadeClose: false, //开启遮罩关闭
			area : [ '40%', '65%' ],
			content : '<%=request.getContextPath()%>/editor/common/selectnoComponentPage.jsp?iframewindowid=layer02'
		});
	}
	
	//非交互式组件窗口回调
	function onlayer02Close(data){
		iframeJs.Matrix.setFormItemValue('editFlag','edit');
		if(data!=null){
			var authId = data.id;
			var groupName = data.name;
			iframeJs.Matrix.setFormItemValue('authId',authId);
			iframeJs.Matrix.setFormItemValue('popupSelectDialog1',groupName);
		}
		iframeJs.window.focus();
	}
	
	
	//辅助事件详细信息页面 用户自定义时   时间标签页  弹出流程变量选择窗口
	function openVariables1(iframe){
		iframeJs = iframe;
		layer.open({
	    	id:'layer03',
			type : 2,
			
			title : ['流程变量选择窗口'],
			shadeClose: false, //开启遮罩关闭
			area : [ '40%', '65%' ],
			content : '<%=request.getContextPath()%>/editor/common/selectFlowVariablePage.jsp?iframewindowid=layer03'
		});
	}
	
	//流程变量选择窗口回调
	function onlayer03Close(data){
		iframeJs.Matrix.setFormItemValue('editFlag','edit');
		if(data!=null){
			iframeJs.Matrix.setFormItemValue("popupSelectDialog302",data.id);
		}
		iframeJs.window.focus();
	}
	

	//辅助事件详细信息页面 用户自定义时   时间标签页  弹出流程变量选择窗口
	function openVariables2(iframe){
		iframeJs = iframe;
		layer.open({
	    	id:'layer04',
			type : 2,
			
			title : ['流程变量选择窗口'],
			shadeClose: false, //开启遮罩关闭
			area : [ '40%', '65%' ],
			content : '<%=request.getContextPath()%>/editor/common/selectFlowVariablePage.jsp?iframewindowid=layer04'
		});
	}
	
	//流程变量选择窗口回调
	function onlayer04Close(data){
		iframeJs.Matrix.setFormItemValue('editFlag','edit');
		if(data!=null){
			iframeJs.Matrix.setFormItemValue("popupSelectDialog303",data.id);
		}
		iframeJs.window.focus();
	}
	
	//辅助事件详细信息页面 用户自定义时   时间标签页  弹出业务日历窗口
	function openCalendar(iframe){
		iframeJs = iframe;
		layer.open({
	    	id:'layer05',
			type : 2,
			
			title : ['业务日历选择窗口'],
			shadeClose: false, //开启遮罩关闭
			area : [ '40%', '65%' ],
			content : '<%=request.getContextPath()%>/mobile/calendarSelectPage.jsp?iframewindowid=layer05'
		});
	}
	
	//业务日历窗口回调
	function onlayer05Close(data){
		iframeJs.Matrix.setFormItemValue('editFlag','edit');
		if(data!=null){
			iframeJs.Matrix.setFormItemValue("popupSelectDialog301",data.calendarId);
		}
		iframeJs.window.focus();
	}
	
	//任务提醒属性页面弹出选择活动执行人窗口
	function openChooseActivities(iframe){
		iframeJs = iframe;
		layer.open({
	    	id:'layer06',
			type : 2,
			
			title : ['选择活动窗口'],
			shadeClose: false, //开启遮罩关闭
			area : [ '40%', '65%' ],
			content : '<%=request.getContextPath()%>/editor/common/selectActivityNode.jsp?iframewindowid=layer06'
		});
	}
	
	//选择活动执行人窗口回调
	function onlayer06Close(data){
		iframeJs.Matrix.setFormItemValue('editFlag','edit');
		if(data!=null){
			var name = data.name;
			var id = data.id;
			iframeJs.Matrix.setFormItemValue('selectedUserId',id);
			iframeJs.Matrix.setFormItemValue('popupSelectDialog2',name+"("+id+")");
		}
		iframeJs.window.focus();
	}
	
	
	//设计开发任务提醒属性页面弹出条件编辑窗口
	function openConditionEditByDesigner(iframe){
		iframeJs = iframe;
		layer.open({
	    	id:'layer07',
			type : 2,
			
			title : ['条件编辑窗口'],
			shadeClose: false, //开启遮罩关闭
			area : [ '55%', '75%' ],
			content : '<%=request.getContextPath()%>/editor/common/conditionEditPage.jsp?iframewindowid=layer07'
		});
	}
	
	//设计开发条件编辑窗口回调
	function onlayer07Close(data){
		iframeJs.Matrix.setFormItemValue('editFlag','edit');
		if(data!=null){
			var expressName = data.expressName;
			iframeJs.Matrix.setFormItemValue('popupSelectDialog001',expressName);
			var express = data.express;
			iframeJs.Matrix.setFormItemValue('express',express);
			Matrix.setFormItemValue('conditionValue',"");
		}
		iframeJs.window.focus();
	}
	
	//任务提醒属性页面标题弹出选择流程变量窗口
	function openVariables3(iframe){
		iframeJs = iframe;
		layer.open({
	    	id:'layer08',
			type : 2,
			
			title : ['流程变量选择窗口'],
			shadeClose: false, //开启遮罩关闭
			area : [ '40%', '65%' ],
			content : '<%=request.getContextPath()%>/editor/common/selectFlowVariablePage.jsp?iframewindowid=layer08'
		});
	}
	
	//选择流程变量窗口回调
	function onlayer08Close(data){
		debugger;
		iframeJs.Matrix.setFormItemValue('editFlag','edit');
		if(data!=null){
			var name = data.name;
			var id = data.id
			var title = iframeJs.Matrix.getFormItemValue("popupSelectDialog1");
			if(title!=null && title!='' && title!='null' && title!='undefined' && title.indexOf("\${")>0){
				var rep = title.substr(title.indexOf("\${"),title.indexOf("\}")+1);
				title = title.replace(rep,"\${"+id+"}");
			}else{
				title = title+"\${"+id+"}";
			}
			iframeJs.Matrix.setFormItemValue('popupSelectDialog1',title);
		}
		iframeJs.window.focus();
	}
		
	//任务提醒属性页面内容弹出选择流程变量窗口
	function openVariables4(iframe){
		iframeJs = iframe;
		layer.open({
	    	id:'layer09',
			type : 2,
			
			title : ['流程变量选择窗口'],
			shadeClose: false, //开启遮罩关闭
			area : [ '40%', '65%' ],
			content : '<%=request.getContextPath()%>/editor/common/selectFlowVariablePage.jsp?iframewindowid=layer09'
		});
	}
	
	//选择流程变量窗口回调
	function onlayer09Close(data){
		var oldContent = iframeJs.Matrix.getFormItemValue("inputTextArea002");
		iframeJs.Matrix.setFormItemValue('editFlag','edit');
		if(data!=null){
			var id = data.id;
			iframeJs.Matrix.setFormItemValue('inputTextArea002',oldContent+"\${"+id+"}");
		}
		iframeJs.window.focus();
	}
	
	//任务分派终止条件弹出条件编辑窗口
	function openEndCondition(iframe){
		iframeJs = iframe;
		layer.open({
	    	id:'layer10',
			type : 2,
			
			title : ['条件编辑窗口'],
			shadeClose: false, //开启遮罩关闭
			area : [ '55%', '75%' ],
			content : '<%=request.getContextPath()%>/editor/common/conditionEditPage.jsp?iframewindowid=layer10'
		});
	}
	
	//选择条件编辑窗口回调
	function onlayer10Close(data){
		if(data!=null){
			var value = data.express;
			iframeJs.Matrix.setFormItemValue('editFlag','');
			iframeJs.Matrix.setFormItemValue('input0',value);
		}
		iframeJs.setTimeout('setFocus()',500);
	}
	
	//设计开发任务分派弹出条件编辑窗口
	function openConditionByDesigner(iframe){
		iframeJs = iframe;
		layer.open({
	    	id:'layer11',
			type : 2,
			
			title : ['条件编辑窗口'],
			shadeClose: false, //开启遮罩关闭
			area : [ '55%', '65%' ],
			content : '<%=request.getContextPath()%>/editor/common/conditionEditPage.jsp?iframewindowid=layer11'
		});
	}
	
	//设计开发任务分派弹出条件选择回调
	function onlayer11Close(data){
		iframeJs.Matrix.setFormItemValue('editFlag','');
		if(data!=null){
			iframeJs.Matrix.setFormItemValue('popupSelectDialog001',data.expressName);
			iframeJs.parent.parent.Matrix.setFormItemValue('conditionValue',"");
		}
		iframeJs.saveExecutor();
	}
	
	//执行人员弹出选定活动执行人员窗口
	function openExecutor(iframe){
		iframeJs = iframe;
		layer.open({
	    	id:'layer12',
			type : 2,
			
			title : ['选择活动窗口'],
			shadeClose: false, //开启遮罩关闭
			area : [ '40%', '65%' ],
			content : '<%=request.getContextPath()%>/editor/common/selectActivityNode.jsp?iframewindowid=layer12'
		});
	}
	
	//选定活动执行人员窗口回调
	function onlayer12Close(data){
		iframeJs.Matrix.setFormItemValue('editFlag','');
		if(data!=null){
			iframeJs.Matrix.setFormItemValue("actExecutorId",data.id);
			iframeJs.Matrix.setFormItemValue('popupSelectDialog002',data.name);
		}
		iframeJs.saveExecutor();
	}
	
	//执行人员弹出选择人员窗口
	function selectUser(iframe){
		iframeJs = iframe;
		layer.open({
	    	id:'layer13',
			type : 2,
			
			title : ['选择人员'],
			shadeClose: false, //开启遮罩关闭
			area : [ '40%', '75%' ],
			content : '<%=request.getContextPath()%>/office/html5/select/SingleSelectPerson.jsp?iframewindowid=layer13'
		});
	}
	
	//选择人员窗口回调
	function onlayer13Close(data){
		iframeJs.Matrix.setFormItemValue('editFlag','');
		if(data!=null){
			iframeJs.Matrix.setFormItemValue("selectedUserId",data.ids);
			iframeJs.Matrix.setFormItemValue('popupSelectDialog004',data.names);
		}
		iframeJs.saveExecutor();
	}
	
	//源自变量人员设计开发弹出选择流程变量窗口
	function openVariables5(iframe){
		iframeJs = iframe;
		layer.open({
	    	id:'layer14',
			type : 2,
			
			title : ['流程变量选择窗口'],
			shadeClose: false, //开启遮罩关闭
			area : [ '40%', '65%' ],
			content : '<%=request.getContextPath()%>/editor/common/selectFlowVariablePage.jsp?iframewindowid=layer14'
		});
	}
	
	//设计开发弹出选择流程变量窗口回调
	function onlayer14Close(data){
		iframeJs.Matrix.setFormItemValue('editFlag','');
		if(data!=null){
			if(data.id.indexOf('.')!=-1){
				iframeJs.Matrix.setFormItemValue('formVarUserId',"{"+data.id+"}");
			}else{
				iframeJs.Matrix.setFormItemValue('formVarUserId',data.id);
			}
			iframeJs.Matrix.setFormItemValue('popupSelectDialog003',data.name);
		}
		iframeJs.saveExecutor();
	}
	
	//源自变量人员实施弹出人员窗口
	function openUserLayer(iframe){
		iframeJs = iframe;
		layer.open({
		    id:'layer15',
			type : 2,
			
			title : ['表单作用域选择窗口'],
			shadeClose: false, //开启遮罩关闭
			area : [ '45%', '75%' ],
			content : "<%=request.getContextPath()%>/office/html5/select/SelectFormVariable.jsp?iframewindowid=layer15&flag=user"
		});		
	}
	
	//人员实施弹出人员窗口回调
	function onlayer15Close(data){
		iframeJs.Matrix.setFormItemValue('editFlag','');
		if(data!=null){
			if(data.opid.indexOf('.')!=-1){
				iframeJs.Matrix.setFormItemValue('formVarUserId',"{"+data.opid+"}");
			}else{
				iframeJs.Matrix.setFormItemValue('formVarUserId',data.opid);
			}
			iframeJs.Matrix.setFormItemValue('popupSelectDialog003',data.formvariable);
		}
		iframeJs.saveExecutor();
	}
	
	//执行人员弹出角色选择树
	function openRoleTree(iframe){
		iframeJs = iframe;
		layer.open({
		    id:'layer16',
			type : 2,
			
			title : ['选择角色'],
			shadeClose: false, //开启遮罩关闭
			area : [ '35%', '65%' ],
			content : "<%=request.getContextPath()%>/office/html5/select/SingleSelectRole.jsp?iframewindowid=layer16"
		});		
	}
	
	//角色选择树回调
	function onlayer16Close(data){
		iframeJs.Matrix.setFormItemValue('editFlag','');
		if(data!=null){
			iframeJs.Matrix.setFormItemValue('roleId',data.ids);
			iframeJs.Matrix.setFormItemValue('popupSelectDialog005',data.names);
		}
		iframeJs.saveExecutor();
	}	
	
	//执行人员弹出角色选择列表
	function openRoleList(iframe){
		iframeJs = iframe;
		layer.open({
		    id:'layer17',
			type : 2,
			
			title : ['角色选择列表'],
			shadeClose: false, //开启遮罩关闭
			area : [ '35%', '65%' ],
			content : "<%=request.getContextPath()%>/editor/common/selectRoleList.jsp?iframewindowid=layer17"
		});		
	}
	
	//角色选择列表回调
	function onlayer17Close(data){
		iframeJs.Matrix.setFormItemValue('editFlag','');
		if(data!=null){
			iframeJs.Matrix.setFormItemValue('roleId',data.id);
			iframeJs.Matrix.setFormItemValue('popupSelectDialog005',data.text);
		}
		iframeJs.saveExecutor();
	}	
	
	//源自变量的角色实施角色窗口
	function openRoleLayer(iframe){
		iframeJs = iframe;
		layer.open({
		    id:'layer18',
			type : 2,
			
			title : ['表单作用域选择窗口'],
			shadeClose: false, //开启遮罩关闭
			area : [ '45%', '75%' ],
			content : "<%=request.getContextPath()%>/office/html5/select/SelectFormVariable.jsp?iframewindowid=layer18&flag=role"
		});		
	}
	
	//弹出窗口选择回调
	function onlayer18Close(data){
		iframeJs.Matrix.setFormItemValue('editFlag','');
		if(data!=null){
			if(data.opid.indexOf('.')!=-1){
				iframeJs.Matrix.setFormItemValue('roleId',"{"+data.opid+"}");
			}else{
				iframeJs.Matrix.setFormItemValue('roleId',data.opid);
			}
			Matrix.setFormItemValue('popupSelectDialog006',data.formvariable);
		}
		iframeJs.saveExecutor();
	}
	
	//源自变量的角色设计开发弹出选择流程变量窗口
	function openVariables6(iframe){
		iframeJs = iframe;
		layer.open({
	    	id:'layer19',
			type : 2,
			
			title : ['流程变量选择窗口'],
			shadeClose: false, //开启遮罩关闭
			area : [ '40%', '65%' ],
			content : '<%=request.getContextPath()%>/editor/common/selectFlowVariablePage.jsp?iframewindowid=layer19'
		});
	}
	
	//弹出窗口选择回调
	function onlayer19Close(data){
		iframeJs.Matrix.setFormItemValue('editFlag','');
		if(data!=null){
			if(data.id.indexOf('.')!=-1){
				iframeJs.Matrix.setFormItemValue('roleId',"{"+data.id+"}");
			}else{
				iframeJs.Matrix.setFormItemValue('roleId',data.id);
			}
			iframeJs.Matrix.setFormItemValue('popupSelectDialog006',data.name);
		}
		iframeJs.saveExecutor();
	}
	
	//执行人员弹出选择部门窗口
	function selectDept(iframe){
		iframeJs = iframe;
		layer.open({
	    	id:'layer20',
			type : 2,
			
			title : ['选择部门'],
			shadeClose: false, //开启遮罩关闭
			area : [ '40%', '75%' ],
			content : '<%=request.getContextPath()%>/office/html5/select/SingleSelectDep.jsp?iframewindowid=layer20'
		});
	}
	
	//选择部门窗口回调
	function onlayer20Close(data){
		iframeJs.Matrix.setFormItemValue('editFlag','');
		if(data!=null){
			iframeJs.Matrix.setFormItemValue('depId',data.ids);
			iframeJs.Matrix.setFormItemValue('popupSelectDialog007',data.names);
		}
		iframeJs.saveExecutor();
	}
	
	//源自变量的部门实施弹出部门窗口
	function openDeptLayer(iframe){
		iframeJs = iframe;
		layer.open({
		    id:'layer21',
			type : 2,
			
			title : ['表单作用域选择窗口'],
			shadeClose: false, //开启遮罩关闭
			area : [ '50%', '85%' ],  
			content : "<%=request.getContextPath()%>/office/html5/select/SelectFormVariable.jsp?iframewindowid=layer21&flag=dept"
		});		
	}
	
	//弹出窗口选择回调
	function onlayer21Close(data){
		iframeJs.Matrix.setFormItemValue('editFlag','');
		if(data!=null){
			if(data.opid.indexOf('.')!=-1){
				iframeJs.Matrix.setFormItemValue('depId',"{"+data.opid+"}");
			}else{
				iframeJs.Matrix.setFormItemValue('depId',data.opid);
			}
			iframeJs.Matrix.setFormItemValue('popupSelectDialog008',data.formvariable);
		}
		iframeJs.saveExecutor();
	}
	
	//源自变量的部门设计开发弹出选择流程变量窗口
	function openVariables7(iframe){
		iframeJs = iframe;
		layer.open({
	    	id:'layer22',
			type : 2,
			
			title : ['流程变量选择窗口'],
			shadeClose: false, //开启遮罩关闭
			area : [ '40%', '65%' ],
			content : '<%=request.getContextPath()%>/editor/common/selectFlowVariablePage.jsp?iframewindowid=layer22'
		});
	}
	
	//弹出窗口选择回调
	function onlayer22Close(data){
		iframeJs.Matrix.setFormItemValue('editFlag','');
		if(data!=null){
			if(data.id.indexOf('.')!=-1){
				iframeJs.Matrix.setFormItemValue('depId',"{"+data.id+"}");
			}else{
				iframeJs.Matrix.setFormItemValue('depId',data.id);
			}
			iframeJs.Matrix.setFormItemValue('popupSelectDialog008',data.name);
		}
		iframeJs.saveExecutor();
	}
	

	//人员辅助类弹出非交互式组件窗口
	function openAssistance(iframe){
		iframeJs = iframe;
		layer.open({
	    	id:'layer23',
			type : 2,
			
			title : ['集成组件选择窗口'],
			shadeClose: false, //开启遮罩关闭
			area : [ '40%', '65%' ],
			content : '<%=request.getContextPath()%>/editor/common/selectnoComponentPage.jsp?iframewindowid=layer23'
		});
	}
	
	//人员辅助类弹出窗口回调
	function onlayer23Close(data){
		iframeJs.Matrix.setFormItemValue('editFlag','');
		if(data!=null){
			iframeJs.Matrix.setFormItemValue('componentId',data.id);
			iframeJs.Matrix.setFormItemValue('popupSelectDialog009',data.name);
		}
		iframeJs.saveExecutor();
	}
	
	//添加多活动实例窗口
	function openMultActivityInstances(iframe,containerId,activityId){
		iframeJs = iframe;
		layer.open({
	    	id:'layer24',
			type : 2,
			
			title : ['添加多活动实例'],
			shadeClose: false, //开启遮罩关闭
			area : [ '55%', '60%' ],
			content : '<%=request.getContextPath()%>/editor/activity/editMultiActInsPage.jsp?containerId='+containerId+'&activityId='+activityId+'&add=add&iframewindowid=layer24'
		});
	}
	
	//添加多活动实例窗口回调
	function onlayer24Close(data){
		if(data!=null){
			var newData = {};
			newData.name = data.variableId;
			newData.seperatFlag = data.token;
			
			var item = iframeJs.Matrix.getGridData('DataGrid001');   //所有数据
			var listSize = item.length;      //长度	
			iframeJs.$('#DataGrid001_table').bootstrapTable('insertRow',{index:listSize,row:newData});   //插入新行
			//设置选中行变色,字体变无色
			var tableId = iframeJs.document.getElementById("DataGrid001_table");
			tableId.rows[listSize+1].classList.add("changeColor");	
			
			iframeJs.saveData();
		}
	}
	
	//多活动实例弹出选择流程变量窗口
	function openVariables8(iframe){
		iframeJs2 = iframe;
		layer.open({
	    	id:'layer25',
			type : 2,
			
			title : ['选择流程变量'],
			shadeClose: false, //开启遮罩关闭
			area : [ '40%', '65%' ],
			content : '<%=request.getContextPath()%>/editor/common/selectFlowVariablePage.jsp?iframewindowid=layer25'
		});
	}
	
	//弹出窗口选择回调
	function onlayer25Close(data){
		if(data!=null){
			iframeJs2.Matrix.setFormItemValue('input002',data.id);
		}
	}
	
	//修改多活动实例窗口
	function openEditInstances(iframe,activityId,index){
		iframeJs = iframe;
		layer.open({
	    	id:'layer26',
			type : 2,
			
			title : ['编辑多活动实例'],
			shadeClose: false, //开启遮罩关闭
			area : [ '55%', '60%' ],
			content : '<%=request.getContextPath()%>/editor/editor_toUpdateMultiActIns.action?activityId='+activityId+'&index='+index+'&add=update&iframewindowid=layer26'
		});
	}
	
	//编辑多活动实例窗口回调
	function onlayer26Close(data){
		debugger;
		if(data!=null){
			var newData = {};
			newData.name = data.variableId;
			newData.seperatFlag = data.token;
			
			var currentIndex = iframeJs.Matrix.getFormItemValue('index');
			iframeJs.$("#DataGrid001_table").bootstrapTable('updateRow',{index:currentIndex,row:newData});
			
			iframeJs.saveData();
		}
	}
	
	//编辑扩展属性窗口
	function openEditExpandInsProperty(iframe,propertyName,expandProperty,propertyType,propertyValue){
		iframeJs = iframe;
		layer.open({
	    	id:'layer27',
			type : 2,
			
			title : ['编辑扩展属性'],
			shadeClose: false, //开启遮罩关闭
			area : [ '55%', '60%' ],
			content : '<%=request.getContextPath()%>/editor/common/editExpandPropertyPage.jsp?propertyName='+propertyName+'&expandProperty='+expandProperty+'&propertyType='+propertyType+'&propertyValue='+propertyValue+'&iframewindowid=layer27'
		});
	}
	
	//编辑扩展属性窗口回调
	function onlayer27Close(data){
		debugger;
		if(data!=null){
			var index = iframeJs.$('#DataGrid001_table').find('tr.changeColor').data('index');//获得选中的行的id
			iframeJs.$("#DataGrid001_table").bootstrapTable('updateRow',{index:index,row:data});
			iframeJs.saveExtendProperties();
		}
	}
	
	//扩展属性弹出选择流程变量窗口
	function openVariables9(iframe){
		iframeJs2 = iframe;
		layer.open({
	    	id:'layer28',
			type : 2,
			
			title : ['选择流程变量'],
			shadeClose: false, //开启遮罩关闭
			area : [ '40%', '65%' ],
			content : '<%=request.getContextPath()%>/editor/common/selectFlowVariablePage.jsp?iframewindowid=layer28'
		});
	}
	
	//弹出窗口选择回调
	function onlayer28Close(data){
		if(data!=null){
			iframeJs2.Matrix.setFormItemValue('input002',data.id);
		}
	}
	
	
	//高级属性开始条件弹出条件编辑窗口
	function openSatrtCondition(iframe){
		iframeJs = iframe;
		layer.open({
	    	id:'layer29',
			type : 2,
			
			title : ['条件编辑窗口'],
			shadeClose: false, //开启遮罩关闭
			area : [ '55%', '75%' ],
			content : '<%=request.getContextPath()%>/editor/common/conditionEditPage.jsp?iframewindowid=layer29'
		});
	}
	
	//选择条件编辑窗口回调
	function onlayer29Close(data){
		if(data!=null){
			var express = data.express;
			iframeJs.Matrix.setFormItemValue("inputTextArea001",data.expressName);
			iframeJs.Matrix.setFormItemValue("startExpress",data.express);
			Matrix.setFormItemValue('conditionValue','');
		}
		iframeJs.setTimeout('setFocus()',300);
	}
	
	//高级属性完成条件弹出条件编辑窗口
	function openFinishCondition(iframe){
		iframeJs = iframe;
		layer.open({
	    	id:'layer30',
			type : 2,
			
			title : ['条件编辑窗口'],
			shadeClose: false, //开启遮罩关闭
			area : [ '55%', '65%' ],
			content : '<%=request.getContextPath()%>/editor/common/conditionEditPage.jsp?iframewindowid=layer30'
		});
	}
	
	//选择条件编辑窗口回调
	function onlayer30Close(data){
		if(data!=null){
			var express = data.express;
			iframeJs.Matrix.setFormItemValue("inputTextArea002",data.expressName);
			iframeJs.Matrix.setFormItemValue("endExpress",data.express);
			Matrix.setFormItemValue('conditionValue','');
		}
		iframeJs.setTimeout('setFocus()',300);
	}
	
	//外部子流程活动交互数据基本信息输入参数对象弹出选择参数对象窗口
	function openParameterObject1(iframe){
		iframeJs = iframe;
		layer.open({
	    	id:'layer31',
			type : 2,
			
			title : ['选择参数对象'],
			shadeClose: false, //开启遮罩关闭
			area : [ '40%', '65%' ],
			content : '<%=request.getContextPath()%>/editor/common/selectDeclaration.jsp?iframewindowid=layer31'
		});
	}
	
	//弹出窗口选择回调
	function onlayer31Close(data){
		if(data!=null){
			iframeJs.Matrix.setFormItemValue("popupSelectDialog001",data.name);
			iframeJs.Matrix.setFormItemValue("inputParamId",data.id);
		}
		iframeJs.saveInputInteractiveData();
		//初始化iframe
		iframeJs.parent.document.getElementById('tab_iframe2').src = '<%=request.getContextPath()%>/editor/flow/inputParamListPage.jsp?activityId='+activityId+'&containerId='+containerId+'&flowType=0';
	}
	
	//外部子流程活动交互数据基本信息输出参数对象弹出选择参数对象窗口
	function openParameterObject2(iframe){
		iframeJs = iframe;
		layer.open({
	    	id:'layer32',
			type : 2,
			
			title : ['选择参数对象'],
			shadeClose: false, //开启遮罩关闭
			area : [ '40%', '65%' ],
			content : '<%=request.getContextPath()%>/editor/common/selectDeclaration.jsp?iframewindowid=layer32'
		});
	}
	
	//弹出窗口选择回调
	function onlayer32Close(data){
		if(data!=null){
			iframeJs.Matrix.setFormItemValue("popupSelectDialog002",data.name);
			iframeJs.Matrix.setFormItemValue("outParamId",data.id);
		}
		iframeJs.saveInteractiveData();
		//初始化iframe
		iframeJs.parent.document.getElementById('tab_iframe3').src = '<%=request.getContextPath()%>/editor/flow/outputParamListPage.jsp?activityId='+activityId+'&containerId='+containerId+'&flowType=0';
	}
	
	//编辑参数映射窗口
	function openParameterMapping(iframe,params){
		iframeJs = iframe;
		layer.open({
	    	id:'layer33',
			type : 2,
			
			title : ['编辑参数映射'],
			shadeClose: false, //开启遮罩关闭
			area : [ '55%', '60%' ],
			content : '<%=request.getContextPath()%>/editor/flow/editParamMapPage.jsp?iframewindowid=layer33'+params
		});
	}
	
	//编辑参数映射窗口回调
	function onlayer33Close(data){
		debugger;
		if(data!=null){
			iframeJs.Matrix.setFormItemValue("ysType",data.ysType);
			iframeJs.Matrix.setFormItemValue("ysValue",data.ysValue);
			iframeJs.Matrix.setFormItemValue("newValue",data.newValue);
			
			var updateRow = {};
			updateRow.type = data.ysType;
			updateRow.structId = data.structId;
			updateRow.typeName = data.typeName;
			updateRow.value = data.ysValue;
			var index = iframeJs.$('#DataGrid001_table').find('tr.changeColor').data('index');//获得选中的行的id
			iframeJs.$("#DataGrid001_table").bootstrapTable('updateRow',{index:index,row:updateRow});
			iframeJs.saveParamMap();
		}
	}
	
	//参数映射弹出选择流程变量窗口
	function openMappingVariables(iframe){
		iframeJs2 = iframe;
		layer.open({
	    	id:'layer34',
			type : 2,
			
			title : ['选择流程变量'],
			shadeClose: false, //开启遮罩关闭
			area : [ '40%', '65%' ],
			content : '<%=request.getContextPath()%>/editor/common/selectFlowVariablePage.jsp?iframewindowid=layer34'
		});
	}
	
	//弹出窗口选择回调
	function onlayer34Close(data){
		if(data!=null){
			iframeJs2.Matrix.setFormItemValue('input002',data.id);
			iframeJs2.Matrix.setFormItemValue('newValue',data.uuid);
		}
	}
	
	//编辑多活动实例  实施阶段弹出源自变量的部门选择窗口
	function openDeptLayer2(iframe){
		iframeJs2 = iframe;
		layer.open({
		    id:'layer35',
			type : 2,
			
			title : ['表单作用域选择窗口'],
			shadeClose: false, //开启遮罩关闭
			area : [ '45%', '70%' ],  
			content : "<%=request.getContextPath()%>/office/html5/select/SelectFormVariable.jsp?iframewindowid=layer35&flag=dept"
		});		
	}
	
	//弹出窗口选择回调
	function onlayer35Close(data){
		if(data!=null){
			if(data.opid.indexOf('.')!=-1){
				iframeJs2 .Matrix.setFormItemValue('input002',"{"+data.opid+"}");
			}else{
				iframeJs2 .Matrix.setFormItemValue('input002',data.opid);
			}
		}
	}
	
	//实施阶段任务分派弹出条件编辑窗口
	function openConditionByAdmin(iframe,conditionValue){
		iframeJs = iframe;
		layer.open({
	    	id:'layer36',
			type : 2,
			
			title : ['条件编辑窗口'],
			shadeClose: false, //开启遮罩关闭
			area : [ '70%', '85%' ],
			content : '<%=request.getContextPath()%>/condition/condition_loadConditionSet.action?iframewindowid=layer36&firstCondition='+encodeURI(conditionValue)+'&entrance=TaskAssign'
		});
	}
	//实施阶段任务分派弹出条件选择回调
	function onlayer36Close(data){
		iframeJs.Matrix.setFormItemValue('editFlag','');
		if(data!=null){
			iframeJs.Matrix.setFormItemValue('popupSelectDialog001',data.conditionText);
			iframeJs.parent.parent.Matrix.setFormItemValue('conditionValue',"");
		}
		iframeJs.saveExecutor();
	}
	
	//实施阶段任务提醒属性页面弹出条件编辑窗口
	function openConditionEditByAdmin(iframe,conditionValue){
		iframeJs = iframe;
		layer.open({
	    	id:'layer37',
			type : 2,
			
			title : ['条件编辑窗口'],
			shadeClose: false, //开启遮罩关闭
			area : [ '70%', '85%' ],
			content : '<%=request.getContextPath()%>/condition/condition_loadConditionSet.action?iframewindowid=layer37&firstCondition='+encodeURI(conditionValue)+'&entrance=TaskRemind'
		});
	}
	
	//实施阶段任务提醒属性页面弹出条件选择回调
	function onlayer37Close(data){
		iframeJs.Matrix.setFormItemValue('editFlag','edit');
		if(data!=null){
			iframeJs.Matrix.setFormItemValue('popupSelectDialog001',data.conditionText);
			iframeJs.Matrix.setFormItemValue('express',data.conditionVal);
			Matrix.setFormItemValue('conditionValue',"");
		}
		iframeJs.window.focus();
	}
</script>
</head>	
<body>
<div style="width: 100%; height: 100%; overflow: auto; position: relative;">
<form id="form0" name="form0" eventProxy="Mform0" method="post" action="" style="margin:0px;position:relative;overflow:auto;width:100%;height:100%;" enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="form0" value="form0" />
	<input type="hidden" id="matrix_form_datagrid_form0" name="matrix_form_datagrid_form0" value="" />
	<!-- 记录当前活动的id -->
	<input type="hidden" id="activityId" name="activityId" value="${param.activityId }"/>
	<input type="hidden" id="optType" name="optType" value="${param.optType }"/>
	<input type="hidden" id="custom" name="custom" value="${param.custom }"/>
	<input type="hidden" id="type" name="type" value="${param.type }"/>
	<input type="hidden" id="processType" name="processType" value="${param.processType }"/>
	<input name="containerId" id="containerId" type="hidden" value="${param.containerId }"/>
	<input name="containerType" id="containerType" type="hidden" value="${param.containerType }"/>
	<input name="conditionValue" id="conditionValue" type="hidden" />
	<div id="form0_hidden_text_div" name="form0_hidden_text_div" style="position:absolute;width:0;height:0;z-index:-9999999999;top:0;left:0;display:none;"></div>
	<input type="hidden" name="javax.matrix.faces.ViewState" id="javax.matrix.faces.ViewState" value="" />
	<table id="table101" name="table101" style="width:100%;height:100%;">
		<tr id="j_id2" jsId="j_id2">
			<td id="j_id3" jsId="j_id3" height="60px" style="height: 50px;width:100%;background-image:url(<%=request.getContextPath()%>/matrix/resource/images/probanner.jpg);background-size:100% 100%">
				<br>
				&nbsp;&nbsp;&nbsp;编辑流程活动节点属性，完成后点击保存或保存并关闭按钮.
			</td>
		</tr>
		<tr id="tr101" name="tr101">
			<td id="td101" name="td101" style="width:100%;height:100%;">
				<table id="table102" name="table102" style="width:100%;height:100%;">
					<tr>
						<!-- 属性结构树 -->
					    <td id="td103" name="td103">				
							<div class="main" style="width:100%;height:100%;">
    							<iframe id="main_iframe" src="basicActivityTree.jsp?type=${param.type }&processdid=${param.processdid }&activityId=${param.activityId }&containerType=${param.containerType }&containerId=${param.containerId }&processType=${param.processType }" style="width:100%;height:100%;" frameborder="0"></iframe>
    						</div>					
						</td>
						<!-- 属性详细信息 -->
						<td id="td104" name="td104">								
							<div class="main" style="width:100%;height:100%;">
								<iframe id="main_iframe1" src="<%=request.getContextPath()%>/editor/editor_autoLoadActBasicInfo.action?type=${param.type }&processdid=${param.processdid }&activityId=${param.activityId }&containerType=${param.containerType }&containerId=${param.containerId }&processType=${param.processType }" style="width:100%;height:100%;" frameborder="0"></iframe>
    						</div>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td style="height:54px;"></td>
		</tr>
		<tr id="tr102" name="tr102">
			<td id="td102" name="td102" class="cmdLayout">
				<input type="button" id="button001" class="x-btn ok-btn" value="保存">
				<input type="button" id="button002" class="x-btn ok-btn" value="保存并关闭">
				<input type="button" id="button003" class="x-btn cancel-btn" value="关闭">
				<script>
					//保存
					$('#button001').click(function() {
						Matrix.showMask2();
						var containerId = Matrix.getFormItemValue('containerId');
						var url = "<%=request.getContextPath()%>/editor/editor_saveActivity.action?containerId="+containerId;
						Matrix.sendRequest(url,null,function(data){
							if(data!=null&& data.data!=""){
								Matrix.hideMask2();
								var json = isc.JSON.decode(data.data);
								if(json.result){
									var actId = Matrix.getFormItemValue("activityId");
									window.parent.updateActName(actId,json.actName);  //修改活动名称
									
									var type = Matrix.getFormItemValue('type');
									window.parent.initProperties(type,actId);   //初始右侧活动属性
									Matrix.say("保存成功！");
								}
							}
						});
						
					});	
					//保存并关闭
					$('#button002').click(function() {
						Matrix.showMask2();
						var containerId = Matrix.getFormItemValue('containerId');
						var url = "<%=request.getContextPath()%>/editor/editor_updateActivityProperty.action?containerId="+containerId;
						Matrix.sendRequest(url,null,function(data){
							if(data!=null&& data.data!=""){
								Matrix.hideMask2();
								var json = isc.JSON.decode(data.data);
								if(json.result){
									var actId = Matrix.getFormItemValue("activityId");
									window.parent.updateActName(actId,json.actName);
									
									var type = Matrix.getFormItemValue('type');
									window.parent.initProperties(type,actId);   //初始右侧活动属性
									
									var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
									parent.layer.close(index);
								}
							}
						
						});
					});	
					//关闭
					$('#button003').click(function() {
						Matrix.showMask2();
						var url = "<%=request.getContextPath()%>/editor/editor_clearSession.action";
						Matrix.sendRequest(url,null,function(){
							Matrix.hideMask2();
							var index = parent.layer.getFrameIndex(window.name);
							parent.layer.close(index);
						});
					   
					});
				</script>
			</td>	
		</tr>
	</table>	
 </form>
</div>											
</body>
</html>