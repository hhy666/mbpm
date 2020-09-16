<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ page language="java" import="com.matrix.template.object.activity.Activity" %>
<%@ page language="java" import=" com.matrix.form.admin.entreflow.action.ConvertDisplayStr" %>
<%@ page language="java" import="com.matrix.client.ClientConstants" %>
<%@ page language="java" import="com.matrix.api.identity.MFUser" %>
<%@ page language="java" import="com.matrix.api.MFExecutionService" %>
<!DOCTYPE html>
<html>
<head>
		<meta charset="UTF-8">
		<title>基本信息页面</title>
		<%@ include file="/form/html5/admin/html5Head.jsp"%>
		<style type="text/css">
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
		</style>
		<script type="text/javascript">
			window.onload=function(){
				var phase = '<%= session.getAttribute("phase")%>';
				Matrix.setFormItemValue('phase',phase);
				setTimeout('setFocus()',500);
	
				//定制版  需要修改基本信息
				var custom = Matrix.getFormItemValue('custom');
				if(custom!=null && custom=='custom'){
					document.getElementById('tr005').style.display='none';
					document.getElementById('tr006').style.display='none';
					document.getElementById('tr007').style.display='none';
					document.getElementById('tr012').style.display='none';   //隐藏掉实例描述
					//document.getElementById('tr013').style.display='none';
					//document.getElementById('').style.display='none';
					//document.getElementById('').style.display='none';
					//document.getElementById('').style.display='none';
					
				}
				//-----------------------------------------------------
				var type = Matrix.getFormItemValue("type");
				if(type!=null && type.length>0){
					if(type=='HumanTask'){//人工活动
						//选择子流程
						document.getElementById("tr104").style.display='none';
						document.getElementById("td207").style.display='none';
						document.getElementById("td208").style.display='none';
						document.getElementById("tr012").style.display='none';
						if(phase=='4'){//业务定制阶段
							//集成组件
							document.getElementById("tr005").style.display='';
							document.getElementById("td009").style.display='';
							document.getElementById("td010").style.display='';
							document.getElementById('label005').innerHTML="定制表单：";
							
							var formId = Matrix.getFormItemValue("integrateId");
							//业务定制下，默认的表单，不显示
							if(formId!=null && formId == "42329256179"){
								Matrix.setFormItemValue("popupSelectDialog2","");
							}
							var formName = Matrix.getFormItemValue("popupSelectDialog2");
							//协作组件 tr td
							document.getElementById("tr006").style.display='none';
							document.getElementById("td011").style.display='none';
							document.getElementById("td012").style.display='none';
							//浏览组件 tr td
							document.getElementById("tr007").style.display='none';
							document.getElementById("td013").style.display='none';
							document.getElementById("td014").style.display='none';
							
						}else{
							document.getElementById('label005').innerHTML="集成组件：";
							document.getElementById('tr012').style.display=''; //实例描述
						}
						//document.getElementById("td209").style.display='none';
					}else if(type=='AutomaticAct'){//自动活动
						//优先级
						document.getElementById("tr003").style.display='none';
						document.getElementById("td005").style.display='none';
						document.getElementById("td006").style.display='none';
						//授权信息 tr td
						document.getElementById("tr004").style.display='none';
						document.getElementById("td007").style.display='none';
						document.getElementById("td008").style.display='none';
						//协作组件 tr td
						document.getElementById("tr006").style.display='none';
						document.getElementById("td011").style.display='none';
						document.getElementById("td012").style.display='none';
						//浏览组件 tr td
						document.getElementById("tr007").style.display='none';
						document.getElementById("td013").style.display='none';
						document.getElementById("td014").style.display='none';
						
						//选择子流程
						document.getElementById("tr104").style.display='none';
						document.getElementById("td207").style.display='none';
						document.getElementById("td208").style.display='none';
						//document.getElementById("td209").style.display='none';
					}else if(type=='BlockAct'){//内部子流程
						//优先级
						document.getElementById("tr003").style.display='none';
						document.getElementById("td005").style.display='none';
						document.getElementById("td006").style.display='none';
						//授权信息 tr td
						document.getElementById("tr004").style.display='none';
						document.getElementById("td007").style.display='none';
						document.getElementById("td008").style.display='none';
						//集成组件
						document.getElementById("tr005").style.display='none';
						document.getElementById("td009").style.display='none';
						document.getElementById("td010").style.display='none';
						//协作组件 tr td
						document.getElementById("tr006").style.display='none';
						document.getElementById("td011").style.display='none';
						document.getElementById("td012").style.display='none';
						//浏览组件 tr td
						document.getElementById("tr007").style.display='none';
						document.getElementById("td013").style.display='none';
						document.getElementById("td014").style.display='none';
						//实例描述 
						document.getElementById("tr012").style.display='none';
						document.getElementById("td019").style.display='none';
						//document.getElementById("td020").style.display='none';
						//document.getElementById("tr013").style.display='none';
						//document.getElementById("td021").style.display='none';
						document.getElementById("td022").style.display='none';
						//选择子流程
						document.getElementById("tr104").style.display='none';
						document.getElementById("td207").style.display='none';
						document.getElementById("td208").style.display='none';
						//document.getElementById("td209").style.display='none';
					}else if(type=='SubflowAct'){   //外部子流程
						//优先级
						document.getElementById("tr003").style.display='none';
						document.getElementById("td005").style.display='none';
						document.getElementById("td006").style.display='none';
						//授权信息 tr td
						document.getElementById("tr004").style.display='none';
						document.getElementById("td007").style.display='none';
						document.getElementById("td008").style.display='none';
						//集成组件
						document.getElementById("tr005").style.display='none';
						document.getElementById("td009").style.display='none';
						document.getElementById("td010").style.display='none';
						//协作组件 tr td
						document.getElementById("tr006").style.display='none';
						document.getElementById("td011").style.display='none';
						document.getElementById("td012").style.display='none';
						//浏览组件 tr td
						document.getElementById("tr007").style.display='none';
						document.getElementById("td013").style.display='none';
						document.getElementById("td014").style.display='none';
					}
				}
				
				setTimeout('setFocus()',500);
				//-----------------------------------------------------
			}
			
			//失焦保存事件
			window.onblur = function(){
				if(!Mform0.validate()){
					Matrix.hideMask();
					return false;
				}
				var editFlag = Matrix.getFormItemValue('editFlag');
				var data = Matrix.formToObject('form0');
				if(data!=null && editFlag!='edit'){
					var actId = Matrix.getFormItemValue('input001');
					var name = Matrix.getFormItemValue('input002');
//					parent.window.parent.updateActName(actId,name);

					var url = "<%=request.getContextPath()%>/editor/editor_updateBasicInfo.action";
					Matrix.sendRequest(url,data,function(){
						//修改活动名
					});
				}	
			 }
			
			function setFocus(){
				var input = document.getElementsByName('input002')[0];
				//alert(input);
				input.focus();
			}
			
			//弹出集成组件窗口
			function openpopupSelectDialog2(){
				var phase = Matrix.getFormItemValue("phase");//当前阶段
				Matrix.setFormItemValue('editFlag','edit');
				var type = Matrix.getFormItemValue('type');
				if(type=="HumanTask" && phase=='4'){   //人工活动
					//业务定制阶段的人工活动 
					///加载协同定制的表单目录
					var contentUrl;
					//弹出绑定表单选择页面
					if(document.getElementById('processType').value=='1'){
						contentUrl = "<%=request.getContextPath()%>/editor/common/selectCustomFormTree.jsp?iframewindowid=popupSelectDialog2&processType=1";
					}else{
						contentUrl = "<%=request.getContextPath()%>/editor/common/selectCustomFormTree.jsp?iframewindowid=popupSelectDialog2&processType=2";
					}
					layer.open({
				    	id:'popupSelectDialog2',
						type : 2,
						
						title : ['选择表单'],
						shadeClose: false, //开启遮罩关闭
						area : [ '50%', '65%' ],
						content : contentUrl
					});  
				}else{
					var contentUrl;
					if(type=='AutomaticAct'){    //自动活动
						//非交互式组件
						contentUrl = "<%=request.getContextPath()%>/editor/common/selectnoComponentPage.jsp?iframewindowid=popupSelectDialog2";   
					}else{
						//交互式组件
						contentUrl = "<%=request.getContextPath()%>/editor/common/selectComponentPage.jsp?iframewindowid=popupSelectDialog2";   
					}
					layer.open({
				    	id:'popupSelectDialog2',
						type : 2,
						
						title : ['选择集成组件'],
						shadeClose: false, //开启遮罩关闭
						area : [ '50%', '65%' ],
						content : contentUrl
					});  
				}
			}
			
			//集成组件窗口回调
			function onpopupSelectDialog2Close(data){
				
				Matrix.setFormItemValue('editFlag','');
				if(data){
					var id = data.id;
					Matrix.setFormItemValue('integrateId',id);
					var name = data.name;
					Matrix.setFormItemValue('popupSelectDialog2',name);
				}
				setTimeout('setFocus()',500);
			}
			
			//弹出协作组件窗口
			function openpopupSelectDialog1(){
				layer.open({
			    	id:'popupSelectDialog1',
					type : 2,
					
					title : ['选择集成组件'],
					shadeClose: false, //开启遮罩关闭
					area : [ '50%', '65%' ],
					content : '<%=request.getContextPath()%>/editor/common/selectComponentPage.jsp?iframewindowid=popupSelectDialog1'
				});  
			}
			
			//协作组件窗口回调
			function onpopupSelectDialog1Close(data){
				Matrix.setFormItemValue('editFlag','');
				if(data){
					var id = data.id;
					Matrix.setFormItemValue('coorId',id);
					var name = data.name;
					Matrix.setFormItemValue('popupSelectDialog1',name);
				}
				setTimeout('setFocus()',500);
			}
			
			//弹出浏览组件窗口
			function openpopupSelectDialog3(){
				layer.open({
			    	id:'popupSelectDialog3',
					type : 2,
					
					title : ['选择集成组件'],
					shadeClose: false, //开启遮罩关闭
					area : [ '50%', '65%' ],
					content : '<%=request.getContextPath()%>/editor/common/selectComponentPage.jsp?iframewindowid=popupSelectDialog3'
				});  
			}
			
			//浏览组件窗口回调
			function onpopupSelectDialog3Close(data){
				Matrix.setFormItemValue('editFlag','');
				if(data){
					var id = data.id;
					Matrix.setFormItemValue('readId',id);
					var name = data.name;
					Matrix.setFormItemValue('popupSelectDialog3',name);
				}
				setTimeout('setFocus()',500);
			}
			
			
			//弹出流程变量选择窗口
			function openpopupSelectDialog4(){
				layer.open({
			    	id:'popupSelectDialog4',
					type : 2,
					
					title : ['流程变量选择窗口'],
					shadeClose: false, //开启遮罩关闭
					area : [ '50%', '65%' ],
					content : '<%=request.getContextPath()%>/editor/common/selectFlowVariablePage.jsp?iframewindowid=popupSelectDialog4'
				});  
			}
			
			//实例描述流程变量选择窗口回调
			function onpopupSelectDialog4Close(data){
				Matrix.setFormItemValue('editFlag','');
				var oldValue = Matrix.getFormItemValue('inputTextArea002');
				if(data!=null){
					if(data.id!=null && data.id.length>0){
						var value = "\${";
						value+=data.id;
						value+="}";
						Matrix.setFormItemValue("inputTextArea002",oldValue+value);
					}
				}
				setTimeout('setFocus()',500);
			}
			
			//弹出授权信息窗口
			function openpopupSelectDialogSec(){
				var processType = Matrix.getFormItemValue('processType');
				layer.open({
			    	id:'popupSelectDialogSec',
					type : 2,
					
					title : ['请选择授权信息'],
					shadeClose: false, //开启遮罩关闭
					area : [ '50%', '65%' ],
					content : '<%=request.getContextPath()%>/mobile/securityInfoPage.jsp?iframewindowid=popupSelectDialogSec&processType='+processType
				});  
			}
			
			//选择授权信息窗口回调
			function onpopupSelectDialogSecClose(data){
				Matrix.setFormItemValue('editFlag','');
				if(data!=null){
					var authId = data.uuid;
					var groupName = data.groupName;
					Matrix.setFormItemValue('authId',authId);
					Matrix.setFormItemValue('popupSelectDialogSec',groupName);
				}
				setTimeout('setFocus()',500);
			}
			
			//弹出关联子流程窗口
			function openpopupSelectDialogSub(){
				layer.open({
			    	id:'popupSelectDialogSub',
					type : 2,
					
					title : ['选择流程'],
					shadeClose: false, //开启遮罩关闭
					area : [ '50%', '65%' ],
					content : '<%=request.getContextPath()%>/editor/common/selectProcessTree.jsp?iframewindowid=popupSelectDialogSub'
				});  
			}
			
			//关联子流程窗口回调
			function onpopupSelectDialogSubClose(data) {
				if (data!=null){
					Matrix.setFormItemValue('popupSelectDialogSub',data.name);
					Matrix.setFormItemValue('pdid',data.pdid);
				}
				setTimeout('setFocus()',500);
			}
		</script>
</head>
<body>

<div id="j_id1" jsId="j_id1" style="position: relative; _layout: flowlayout; width: 100%; height: 100%;overflow-x: hidden;overflow-y: auto;">
  <form id="form0" name="form0" eventProxy="Mform0" method="post" action="<%=request.getContextPath()%>/editor/editor_getCurActivityEditProperty.action" style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="form0" id="form0" value="form0"/>
	<input name="version" id="version" type="hidden"/>
	<input name="processType" id="processType" type="hidden" value="${param.processType}"/>
	<input name="authId" id="authId" type="hidden" value="${activity.authItemId}"/>
	<input name="custom" id="custom" type="hidden" value="${param.custom}"/>
	<input name="data" id="data" type="hidden" />
	<input name="editFlag" id="editFlag" type="hidden" />
	<input name="flag" id="flag" type="hidden" />
	<input name="activityId" id="activityId" type="hidden" value="${param.activityId}"/>
	<input name="type" id="type" type="hidden" value="${param.type}"/>
	<input name="processdid" id="processdid" type="hidden" value="${param.processdid}"/>
	<input name="containerType" id="containerType" type="hidden" value="${param.containerType}"/>
	<input name="containerId" id="containerId" type="hidden" value="${param.containerId }"/>
	<input name="integrateId" id="integrateId" type="hidden" value="${activity.implementation.DID }"/>
	<input name="coorId" id="coorId" type="hidden" value="${activity.assistAppDID }"/>
	<input name="readId" id="readId" type="hidden" value="${activity.viewAppDID }"/>
	<input type="hidden" id="phase" name="phase"/>
	<!-- 是否修改	0 未修改；1 已修改-->
	<input type="hidden" name="isEdit" id="isEdit" value="0"/>
	<!-- 记录关联子流程的编码 -->
	<input name="pdid" id="pdid" type="hidden" value="${pdid }"/>
	<input name="iframewindowid" id="iframewindowid" type="hidden" value="Dialog001"/>
	<%
		Activity activity = (Activity)request.getAttribute("activity");
	%>
	<table id="table001" class="tableLayout" style="width:100%;" >
		<tr id="tr107" name="tr107">
			<td id="td107" name="td107" colspan="2" style="width:100%;"><font id="font2">基本信息</font></td>
		</tr>
		<tr id="tr001">
			<td id="td001" class="tdLabelCls" style="width:25%;">
				<label id="label001" name="label001" id="label001">
					编&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码：
				</label>
			</td>
			<td id="td002" class="tdValueCls" style="width:75%;">
				<div id="input001_div" style="vertical-align: middle;">
					<input id="input001" name="input001" type="text" value="${activity.id}" class="form-control" style="height:100%;width:100%;" readonly="readonly"/>
				</div>
			</td>
		</tr>
		<tr id="tr002">
			<td id="td003" class="tdLabelCls" style="width:25%;">
				<label id="label002" name="label002" id="label002">
					名&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;称：
				</label>
			</td>
			<td id="td004" class="tdValueCls" style="width:75%;">
				<div id="input002_div" style="vertical-align: middle;">
					<input id="input002" name="input002" type="text" value="${activity.name}" class="form-control" style="height:100%;width:100%;"/>
				</div>
			</td>
		</tr>
		
		<tr id="tr003">
			<td id="td005" class="tdLabelCls" style="width:25%">
				<label id="label003" name="label003" id="label003">
					优&nbsp;&nbsp;先&nbsp;&nbsp;级：
				</label>
			</td>
			<td id="td006" class="tdValueCls" style="width:75%;">
				<div id="comboBox001_div" style="vertical-align: middle;">
					<select id="comboBox001" name="comboBox001" value="${activity.priority}" class="form-control" style="height:100%;width:100%;">
                       <option value="0" ${activity.priority == 0 ? "selected" : ""}>普通</option>
                       <option value="1" ${activity.priority == 1 ? "selected" : ""}>中级</option>
                       <option value="2" ${activity.priority == 2 ? "selected" : ""}>高级</option>
                       <option value="3" ${activity.priority == 3 ? "selected" : ""}>特级</option>
                    </select>
				</div>
			</td>
		</tr>
		<tr id="tr104">
			<td id="td207" class="tdLabelCls" colspan="1" style="width:20%;">
				<label id="label004" name="label004" id="label004">
					关联子流程：
				</label>
			</td>
			<td id="td208" class="tdValueCls" colspan="1" style="width:50%;border-right:0px;">
				<div id="popupSelectDialogSub_div" class="input-group">
					 <input type="text" id="popupSelectDialogSub" name="popupSelectDialogSub" value="${processName}"  class="form-control">
            		 <span class="input-group-addon addon-udSelect udSelect" onclick="openpopupSelectDialogSub();"><i class="fa fa-search"></i></span>
				</div>			
			</td>
		</tr>
		
		<tr id="tr004">
			<td id="td007" class="tdLabelCls" style="width:25%;">
				<label id="label004" name="label004" id="label004">
					授权类型：
				</label>
			</td>
			<td id="td008" class="tdValueCls" style="width:75%;">
				<div id="popupSelectDialogSec_div" class="input-group">
					 <input type="text" id="popupSelectDialogSec" name="popupSelectDialogSec" value="${activity.authItemName}"  class="form-control">
            		 <span class="input-group-addon addon-udSelect udSelect" onclick="openpopupSelectDialogSec();"><i class="fa fa-search"></i></span>
				</div>
			</td>
		</tr>
		
		<tr id="tr005">
			<td id="td009" class="tdLabelCls" style="width:25%;">
				<label id="label005" name="label005" id="label005">
					集成组件：
				</label>
			</td>
			<td id="td010" class="tdValueCls" style="width:75%;">
				<div id="popupSelectDialog2_div" class="input-group">
					 <input type="text" id="popupSelectDialog2" name="popupSelectDialog2" value="${componentName}"  class="form-control" readonly="readonly">
            		 <span class="input-group-addon addon-udSelect udSelect" onclick="openpopupSelectDialog2();"><i class="fa fa-search"></i></span>
				</div>
			</td>
		</tr>
		
		<tr id="tr006">
			<td id="td011" class="tdLabelCls" style="width:25%;">
				<label id="label006" name="label006" id="label006">
					协作组件：
				</label>
			</td>
			<td id="td012" class="tdValueCls" style="width:75%;">
				<div id="popupSelectDialog1_div" class="input-group">
					 <input type="text" id="popupSelectDialog1" name="popupSelectDialog1" value="${assistAppName}"  class="form-control" readonly="readonly">
            		 <span class="input-group-addon addon-udSelect udSelect" onclick="openpopupSelectDialog1();"><i class="fa fa-search"></i></span>
				</div>
			</td>
		</tr>
		
		<tr id="tr007">
			<td id="td013" class="tdLabelCls" style="width:25%;">
				 <label id="label007" name="label007" id="label007">
				               浏览组件：
				 </label>
			</td>
			<td id="td014" class="tdValueCls" style="width:75%;">
				<div id="popupSelectDialog3_div" class="input-group">
					 <input type="text" id="popupSelectDialog3" name="popupSelectDialog3" value="${viewAppName}"  class="form-control" readonly="readonly">
            		 <span class="input-group-addon addon-udSelect udSelect" onclick="openpopupSelectDialog3();"><i class="fa fa-search"></i></span>
				</div>
			</td>
		</tr>
		
		<tr id="tr010">
			<td id="td015" class="tdLabelCls" style="width: 25%;">
				 <label id="label015" name="label015" id="label015"> 定义描述：</label>
			</td>
					
			<td id="td018" class="tdValueCls" style="width: 75%;">
				<div id="inputTextArea001_div">
					<%
					if(activity.getDescription()!=null && activity.getDescription().trim().length()>0){
					%>	
					<textarea class="form-control" rows="3" id="inputTextArea001" name="inputTextArea001" style="resize: none;"><%=activity.getDescription()%></textarea>
					<% 
					}else{
					%>	
					<textarea class="form-control" rows="3" id="inputTextArea001" name="inputTextArea001" style="resize: none;"></textarea>
					<%
					}
					%>
				</div>
		     </td>
		</tr>		
	    <tr id="tr012">
			<td id="td019" class="tdLabelCls" style="width: 25%;border-right: 0px;">
			     <label id="label016" name="label016" id="label016"> 实例描述：</label>
			</td>		
		     <td id="td022" class="tdValueCls" style="width: 75%">
		     	<div id="popupSelectDialog4_div" class="input-group">
		     		<%
					if(activity.getDescXpression()!=null && activity.getDescXpression().trim().length()>0){
					%>	
					<textarea class="form-control" rows="3" id="inputTextArea002" name="inputTextArea002" style="resize: none;"><%=activity.getDescXpression()%></textarea>
					<% 
					}else{
					%>	
					<textarea class="form-control" rows="3" id="inputTextArea002" name="inputTextArea002" style="resize: none;"></textarea>
					<%
					}
					%>
            		<span class="input-group-addon addon-udSelect udSelect" onclick="openpopupSelectDialog4();"><i class="fa fa-search"></i></span>
				</div>
			</td>
		</tr>	
	</table>
 </form>
</div>
</body>
</html>