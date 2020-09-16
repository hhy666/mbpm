<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html>
<html>
<title>编辑流程属性主页面</title>
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
	
	//流程变量列表弹出添加流程变量窗口
	function openAddFlowVarible(iframe){
		iframeJs = iframe;
		layer.open({
			id:'layer01',
			type : 2,
			
			title : ['添加流程变量'],
			shadeClose: false, //开启遮罩关闭
			area : [ '35%', '45%' ],
			content : '<%=request.getContextPath()%>/editor/process_editFlowVariable.action?processVarId=&iframewindowid=layer01'	
		});  	
	}
	
	//添加流程变量窗口回调
	function onlayer01Close(data){
		if(data!=null&&data.data=='refresh'){
			iframeJs.Matrix.refreshDataGridData('DataGrid001');
		}
	}
	
	//流程变量列表弹出编辑流程变量窗口
	function openEditFlowVarible(iframe,processVarId,index){
		iframeJs = iframe;
		layer.open({
			id:'layer02',
			type : 2,
			
			title : ['编辑流程变量'],
			shadeClose: false, //开启遮罩关闭
			area : [ '35%', '45%' ],
			content : '<%=request.getContextPath()%>/editor/process_editFlowVariable.action?processVarId='+processVarId+'&index='+index+'&iframewindowid=layer02'	
		});  	
	}
	
	//编辑流程变量窗口回调
	function onlayer02Close(data){
		if(data!=null&&data.data=='refresh'){
			iframeJs.Matrix.refreshDataGridData('DataGrid001');
		}
	}
	
	//执行人员弹出选择人员窗口
	function selectUser(iframe){
		iframeJs = iframe;
		layer.open({
	    	id:'layer03',
			type : 2,
			
			title : ['选择人员'],
			shadeClose: false, //开启遮罩关闭
			area : [ '40%', '75%' ],
			content : '<%=request.getContextPath()%>/office/html5/select/SingleSelectPerson.jsp?iframewindowid=layer03'
		});
	}
	
	//选择人员窗口回调
	function onlayer03Close(data){
		iframeJs.Matrix.setFormItemValue('editFlag','');
		if(data!=null){
			iframeJs.Matrix.setFormItemValue("selectedUserId",data.ids);
			iframeJs.Matrix.setFormItemValue('popupSelectDialog004',data.names);
		}
		iframeJs.saveExecutor();
	}
	
	//源自变量人员设计开发弹出选择流程变量窗口
	function openVariables1(iframe){
		iframeJs = iframe;
		layer.open({
	    	id:'layer05',
			type : 2,
			
			title : ['流程变量选择窗口'],
			shadeClose: false, //开启遮罩关闭
			area : [ '40%', '65%' ],
			content : '<%=request.getContextPath()%>/editor/common/selectFlowVariablePage.jsp?iframewindowid=layer05'
		});
	}
	
	//源自变量人员选择流程变量窗口回调
	function onlayer05Close(data){
		iframeJs.Matrix.setFormItemValue('editFlag','');
		if(data!=null){
			iframeJs.Matrix.setFormItemValue("formVarUserId",data.id);	
			iframeJs.Matrix.setFormItemValue('popupSelectDialog003',data.id);
		}
		iframeJs.saveExecutor();
	}
	
	//执行人员弹出角色选择树
	function openRoleTree(iframe){
		iframeJs = iframe;
		layer.open({
		    id:'layer06',
			type : 2,
			
			title : ['选择角色'],
			shadeClose: false, //开启遮罩关闭
			area : [ '35%', '65%' ],
			content : "<%=request.getContextPath()%>/office/html5/select/SingleSelectRole.jsp?iframewindowid=layer06"
		});		
	}
	
	//角色选择树回调
	function onlayer06Close(data){
		iframeJs.Matrix.setFormItemValue('editFlag','');
		if(data!=null){
			iframeJs.Matrix.setFormItemValue('roleId',data.ids);
			iframeJs.Matrix.setFormItemValue('popupSelectDialog005',data.names);
		}
		iframeJs.saveExecutor();
	}	
	
	//源自变量的角色设计开发弹出选择流程变量窗口
	function openVariables2(iframe){
		iframeJs = iframe;
		layer.open({
	    	id:'layer07',
			type : 2,
			
			title : ['流程变量选择窗口'],
			shadeClose: false, //开启遮罩关闭
			area : [ '40%', '65%' ],
			content : '<%=request.getContextPath()%>/editor/common/selectFlowVariablePage.jsp?iframewindowid=layer07'
		});
	}
	
	//弹出窗口选择回调
	function onlayer07Close(data){
		iframeJs.Matrix.setFormItemValue('editFlag','');
		if(data!=null){
			iframeJs.Matrix.setFormItemValue('roleId',data.id);
			iframeJs.Matrix.setFormItemValue('popupSelectDialog006',data.name);
		}
		iframeJs.saveExecutor();
	}
	
	//执行人员弹出选择部门窗口
	function selectDept(iframe){
		iframeJs = iframe;
		layer.open({
	    	id:'layer08',
			type : 2,
			
			title : ['选择部门'],
			shadeClose: false, //开启遮罩关闭
			area : [ '40%', '75%' ],
			content : '<%=request.getContextPath()%>/office/html5/select/SingleSelectDep.jsp?iframewindowid=layer08'
		});
	}
	
	//选择部门窗口回调
	function onlayer08Close(data){
		iframeJs.Matrix.setFormItemValue('editFlag','');
		if(data!=null){
			iframeJs.Matrix.setFormItemValue('depId',data.ids);
			iframeJs.Matrix.setFormItemValue('popupSelectDialog007',data.names);
		}
		iframeJs.saveExecutor();
	}
	
	//源自变量的部门设计开发弹出选择流程变量窗口
	function openVariables3(iframe){
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
	
	//弹出窗口选择回调
	function onlayer09Close(data){
		iframeJs.Matrix.setFormItemValue('editFlag','');
		if(data!=null){
			iframeJs.Matrix.setFormItemValue("depId",data.id);
			iframeJs.Matrix.setFormItemValue('popupSelectDialog008',data.name);
		}
		iframeJs.saveExecutor();
	}
	
	
	//交互数据基本信息输入参数对象弹出选择参数对象窗口
	function openParameterObject1(iframe){
		iframeJs = iframe;
		layer.open({
	    	id:'layer10',
			type : 2,
			
			title : ['选择参数对象'],
			shadeClose: false, //开启遮罩关闭
			area : [ '40%', '65%' ],
			content : '<%=request.getContextPath()%>/editor/common/selectDeclaration.jsp?iframewindowid=layer10'
		});
	}
	
	//弹出窗口选择回调
	function onlayer10Close(data){
		if(data!=null){
			iframeJs.Matrix.setFormItemValue("popupSelectDialog001",data.name);
			iframeJs.Matrix.setFormItemValue("inputParamId",data.id);
		}
		iframeJs.saveInputInteractiveData();
		//初始化iframe
		iframeJs.parent.document.getElementById('tab_iframe2').src  = '<%=request.getContextPath()%>/editor/flow/inputParamListPage.jsp?flowType=1';
	}
	
	//交互数据基本信息输出参数对象弹出选择参数对象窗口
	function openParameterObject2(iframe){
		iframeJs = iframe;
		layer.open({
	    	id:'layer11',
			type : 2,
			
			title : ['选择参数对象'],
			shadeClose: false, //开启遮罩关闭
			area : [ '40%', '65%' ],
			content : '<%=request.getContextPath()%>/editor/common/selectDeclaration.jsp?iframewindowid=layer11'
		});
	}
	
	//弹出窗口选择回调
	function onlayer11Close(data){
		if(data!=null){
			iframeJs.Matrix.setFormItemValue("popupSelectDialog002",data.name);
			iframeJs.Matrix.setFormItemValue("outParamId",data.id);
		}
		iframeJs.saveInteractiveData();
		//初始化iframe
		iframeJs.parent.document.getElementById('tab_iframe3').src  = '<%=request.getContextPath()%>/editor/flow/outputParamListPage.jsp?flowType=1';
	}
	
	//编辑参数映射窗口
	function openParameterMapping(iframe,params){
		iframeJs = iframe;
		layer.open({
	    	id:'layer12',
			type : 2,
			
			title : ['编辑参数映射'],
			shadeClose: false, //开启遮罩关闭
			area : [ '35%', '40%' ],
			content : '<%=request.getContextPath()%>/editor/flow/editParamMapPage.jsp?iframewindowid=layer12'+params
		});
	}
	
	//编辑参数映射窗口回调
	function onlayer12Close(data){
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
	    	id:'layer13',
			type : 2,
			
			title : ['选择流程变量'],
			shadeClose: false, //开启遮罩关闭
			area : [ '40%', '65%' ],
			content : '<%=request.getContextPath()%>/editor/common/selectFlowVariablePage.jsp?iframewindowid=layer13'
		});
	}
	
	//弹出窗口选择回调
	function onlayer13Close(data){
		if(data!=null){
			iframeJs2.Matrix.setFormItemValue('input002',data.id);
			iframeJs2.Matrix.setFormItemValue('newValue',data.uuid);
		}
	}
	
	//辅助事件详细信息页面选择组件弹出非交互式组件窗口
	function openNoComponent(iframe){
		iframeJs = iframe;
		layer.open({
	    	id:'layer14',
			type : 2,
			
			title : ['集成组件选择窗口'],
			shadeClose: false, //开启遮罩关闭
			area : [ '40%', '65%' ],
			content : '<%=request.getContextPath()%>/editor/common/selectnoComponentPage.jsp?iframewindowid=layer14'
		});
	}
	
	//非交互式组件窗口回调
	function onlayer14Close(data){
		iframeJs.Matrix.setFormItemValue('editFlag','edit');
		if(data!=null){
			var authId = data.id;
			var groupName = data.name;
			iframeJs.Matrix.setFormItemValue('authId',authId);
			iframeJs.Matrix.setFormItemValue('popupSelectDialog1',groupName);
		}
		iframeJs.window.focus();
	}
	
	//辅助事件详细信息页面弹出条件编辑窗口
	function openCondiation(conditionValue,iframe){
		iframeJs = iframe;
		Matrix.setFormItemValue('conditionValue',conditionValue);
		layer.open({
			id:'layer15',
			type : 2,
			
			title : ['条件编辑窗口'],
			shadeClose: false, //开启遮罩关闭
			area : [ '50%', '75%' ],
			content : '<%=request.getContextPath()%>/editor/common/conditionEditPage.jsp?iframewindowid=layer15'	
		});  	
	}
	
	//条件编辑窗口回调
	function onlayer15Close(data){
		iframeJs.Matrix.setFormItemValue('editFlag','edit');
		if(data!=null){
			iframeJs.Matrix.setFormItemValue('popupSelectDialog2',data.expressName);
			iframeJs.Matrix.setFormItemValue('express',data.express);
			Matrix.setFormItemValue("conditionValue","");
		}
		iframeJs.window.focus();
	}
	
	//辅助事件详细信息页面 用户自定义时   时间标签页  弹出流程变量选择窗口
	function openVariables4(iframe){
		iframeJs = iframe;
		layer.open({
	    	id:'layer16',
			type : 2,
			
			title : ['流程变量选择窗口'],
			shadeClose: false, //开启遮罩关闭
			area : [ '40%', '65%' ],
			content : '<%=request.getContextPath()%>/editor/common/selectFlowVariablePage.jsp?iframewindowid=layer16'
		});
	}
	
	//流程变量选择窗口回调
	function onlayer16Close(data){
		iframeJs.Matrix.setFormItemValue('editFlag','edit');
		if(data!=null){
			iframeJs.Matrix.setFormItemValue("popupSelectDialog302",data.id);
		}
		iframeJs.window.focus();
	}
	
	//辅助事件详细信息页面 用户自定义时   时间标签页  弹出流程变量选择窗口
	function openVariables5(iframe){
		iframeJs = iframe;
		layer.open({
	    	id:'layer17',
			type : 2,
			
			title : ['流程变量选择窗口'],
			shadeClose: false, //开启遮罩关闭
			area : [ '40%', '65%' ],
			content : '<%=request.getContextPath()%>/editor/common/selectFlowVariablePage.jsp?iframewindowid=layer17'
		});
	}
	
	//流程变量选择窗口回调
	function onlayer17Close(data){
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
	    	id:'layer18',
			type : 2,
			
			title : ['业务日历选择窗口'],
			shadeClose: false, //开启遮罩关闭
			area : [ '40%', '65%' ],
			content : '<%=request.getContextPath()%>/mobile/calendarSelectPage.jsp?iframewindowid=layer18'
		});
	}
	
	//业务日历窗口回调
	function onlayer18Close(data){
		iframeJs.Matrix.setFormItemValue('editFlag','edit');
		if(data!=null){
			iframeJs.Matrix.setFormItemValue("popupSelectDialog301",data.calendarId);
		}
		iframeJs.window.focus();
	}
	

	//流程提醒属性页面弹出选择活动执行人窗口
	function openChooseActivities(iframe){
		iframeJs = iframe;
		layer.open({
	    	id:'layer19',
			type : 2,
			
			title : ['选择活动窗口'],
			shadeClose: false, //开启遮罩关闭
			area : [ '40%', '65%' ],
			content : '<%=request.getContextPath()%>/editor/common/selectActivityNode.jsp?iframewindowid=layer19'
		});
	}
	
	//选择活动执行人窗口回调
	function onlayer19Close(data){
		iframeJs.Matrix.setFormItemValue('editFlag','edit');
		if(data!=null){
			var name = data.name;
			var id = data.id;
			iframeJs.Matrix.setFormItemValue('selectedUserId',id);
			iframeJs.Matrix.setFormItemValue('popupSelectDialog2',name+"("+id+")");
		}
		iframeJs.window.focus();
	}
	
	
	//流程提醒属性页面弹出条件编辑窗口
	function openConditionEdit(iframe){
		iframeJs = iframe;
		layer.open({
	    	id:'layer20',
			type : 2,
			
			title : ['条件编辑窗口'],
			shadeClose: false, //开启遮罩关闭
			area : [ '50%', '65%' ],
			content : '<%=request.getContextPath()%>/editor/common/conditionEditPage.jsp?iframewindowid=layer20'
		});
	}
	
	//条件编辑窗口回调
	function onlayer20Close(data){
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
	function openVariables6(iframe){
		iframeJs = iframe;
		layer.open({
	    	id:'layer21',
			type : 2,
			
			title : ['流程变量选择窗口'],
			shadeClose: false, //开启遮罩关闭
			area : [ '40%', '65%' ],
			content : '<%=request.getContextPath()%>/editor/common/selectFlowVariablePage.jsp?iframewindowid=layer21'
		});
	}
	
	//选择流程变量窗口回调
	function onlayer21Close(data){
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
	
	//选择流程变量窗口回调
	function onlayer22Close(data){
		var oldContent = iframeJs.Matrix.getFormItemValue("inputTextArea002");
		iframeJs.Matrix.setFormItemValue('editFlag','edit');
		if(data!=null){
			var id = data.id;
			iframeJs.Matrix.setFormItemValue('inputTextArea002',oldContent+"\${"+id+"}");
		}
		iframeJs.window.focus();
	}
	
	//编辑扩展属性窗口
	function openEditExpandInsProperty(iframe,propertyName,expandProperty,propertyType,propertyValue){
		iframeJs = iframe;
		layer.open({
	    	id:'layer23',
			type : 2,
			
			title : ['编辑扩展属性'],
			shadeClose: false, //开启遮罩关闭
			area : [ '35%', '40%' ],
			content : '<%=request.getContextPath()%>/editor/common/editExpandPropertyPage.jsp?propertyName='+propertyName+'&expandProperty='+expandProperty+'&propertyType='+propertyType+'&propertyValue='+propertyValue+'&iframewindowid=layer23'
		});
	}
	
	//编辑扩展属性窗口回调
	function onlayer23Close(data){
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
	    	id:'layer24',
			type : 2,
			
			title : ['选择流程变量'],
			shadeClose: false, //开启遮罩关闭
			area : [ '40%', '65%' ],
			content : '<%=request.getContextPath()%>/editor/common/selectFlowVariablePage.jsp?iframewindowid=layer24'
		});
	}
	
	//弹出窗口选择回调
	function onlayer24Close(data){
		if(data!=null){
			iframeJs2.Matrix.setFormItemValue('input002',data.id);
		}
	}
	
	//交互式组件弹出选择表单窗口
	function openSelectFormTree(iframe){
		iframeJs = iframe;
		layer.open({
	    	id:'layer25',
			type : 2,
			
			title : ['选择表单'],
			shadeClose: false, //开启遮罩关闭
			area : [ '35%', '65%' ],
			content : '<%=request.getContextPath()%>/editor/common/selectFormTree.jsp?iframewindowid=layer25'
		});
	}
	
	//弹出窗口选择回调
	function onlayer25Close(data){
		if(data!=null){
            var id = data.id;
            var name = data.name;
            iframeJs.Matrix.setFormItemValue('location',id);
            iframeJs.Matrix.setFormItemValue('input012',name);
         }
		 iframeJs.setTimeout('setFocus()',500);
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
	<input type="hidden" id="processdid" name="processdid" value="${param.processdid }"/>
	<input name="conditionValue" id="conditionValue" type="hidden" />
	<div id="form0_hidden_text_div" name="form0_hidden_text_div" style="position:absolute;width:0;height:0;z-index:-9999999999;top:0;left:0;display:none;"></div>
	<input type="hidden" name="javax.matrix.faces.ViewState" id="javax.matrix.faces.ViewState" value="" />
	<table id="table101" name="table101" style="width:100%;height:100%;">
		<tr id="j_id2" jsId="j_id2">
			<td id="j_id3" jsId="j_id3"  height="50px"
				 style="height: 50px;width:100%;background-image:url(<%=request.getContextPath()%>/matrix/resource/images/probanner.jpg);background-size:100% 100%">
				<br>
				&nbsp;&nbsp;&nbsp;编辑流程属性，完成后点击保存或保存并关闭按钮.
			</td>
		</tr>
		<tr id="tr101" name="tr101">
			<td id="td101" name="td101" style="width:100%;height:100%;">
				<table id="table102" name="table102" style="width:100%;height:100%;">
					<tr>
					    <!-- 属性结构树 -->
						<td id="td103" name="td103">
							<div class="main" style="width:100%;height:100%;">
	    						<iframe id="main_iframe" src="propertyConstructionTree.jsp?processId=${param.processId }&processdid=${param.processId }" style="width:100%;height:100%;" frameborder="0"></iframe>
	    					</div>
						</td>
						<!-- 属性详细信息 -->
						<td id="td104" name="td104">									
							<div class="main" style="width:100%;height:100%;">
								<iframe id="main_iframe1" src="<%=request.getContextPath()%>/editor/process_getCurProcessBasicPageInfo.action?processdid=${param.processId}" style="width:100%;height:100%;overflow:auto;" frameborder="0"></iframe>
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
						var url = "<%=request.getContextPath()%>/editor/process_saveProcessProperty.action";
						Matrix.sendRequest(url,null,function(data){
							Matrix.hideMask2();
							if(data!=null && data.data!=''){
								var json = isc.JSON.decode(data.data);
								if(json.result){
									Matrix.say("保存成功！");
								}
							}
						});
					});	
					//保存并关闭
					$('#button002').click(function() {
						Matrix.showMask2();
						var url = "<%=request.getContextPath()%>/editor/process_updateProcessProperty.action";
						Matrix.sendRequest(url,null,function(data){
							if(data!=null && data.data!=''){
								Matrix.hideMask2();
								var json = isc.JSON.decode(data.data);
								if(json.result){
								    var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
									parent.layer.close(index);
								}
							}
						});
					});	
					//关闭
					$('#button003').click(function() {
						Matrix.showMask2();
						var url = "<%=request.getContextPath()%>/editor/process_clearSession.action";
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