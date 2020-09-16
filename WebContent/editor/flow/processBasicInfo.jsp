<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java" import=" com.matrix.form.admin.entreflow.action.ConvertDisplayStr" %>
<%@ page language="java" import="com.matrix.template.object.process.WorkflowProcess" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>流程基本信息</title>
	<%@ include file="/form/html5/admin/html5Head.jsp"%>
	<style type="">
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
	
		//页面失去焦点时先保存
		window.onblur=function(){
			var id = Matrix.getFormItemValue("input001");
			var name = Matrix.getFormItemValue("input002");
			var priority = Matrix.getFormItemValue("comboBox001");
			var author = Matrix.getFormItemValue("input003");
			var version = Matrix.getFormItemValue("input004");
			var fromDate = Matrix.getFormItemValue("inputDate001");
			var toDate = Matrix.getFormItemValue("inputDate002");
			var desc = Matrix.getFormItemValue("inputTextArea001");
			var insDesc = Matrix.getFormItemValue("inputTextArea002");
			var newData = {};
			newData.id = id;
			newData.name = name;
			newData.priority = priority;
			newData.author = author;
			newData.version = version;
			newData.fromDate = fromDate;
			newData.toDate = toDate;
			newData.desc = desc;
			newData.insDesc = insDesc;
			var url = "<%=request.getContextPath()%>/editor/process_updateCurProcessBasicPageInfo.action";
			Matrix.sendRequest(url,newData,function(){});
		}
		
		//页面初始事件
		window.onload=function(){
			var phase = '<%=com.matrix.form.admin.common.utils.CommonUtil.getCurPhase()%>';
			if(phase=='4'){
				document.getElementById('tr012').style.display="none";
			}
			var fromDate = "${process.processHeader.validFrom}";
			if(fromDate!=null && fromDate!='null' && fromDate.length>0){
				var dateArr = fromDate.split(" ");
				if(dateArr!=null && dateArr.length>0){
					Matrix.setFormItemValue('inputDate001',dateArr[0])
				}
			} 
			var toDate = "${process.processHeader.validTo}";
			if(toDate!=null && toDate!='null' && toDate.length>0){
				var dateArr = toDate.split(" ");
				if(dateArr!=null && dateArr.length>0){
					Matrix.setFormItemValue('inputDate002',dateArr[0])
				}
			} 
			setTimeout('setFocus()',500);
			
			laydate.render({
				elem: '#inputDate001', 
				format: 'yyyy-MM-dd',
			});
			
			laydate.render({
				elem: '#inputDate002', 
				format: 'yyyy-MM-dd',
			});
		}
		
		//实例描述弹出流程变量选择窗口
		function openpopupSelectDialog001(){
			layer.open({
		    	id:'popupSelectDialog001',
				type : 2,
				
				title : ['流程变量选择窗口'],
				shadeClose: false, //开启遮罩关闭
				area : [ '50%', '65%' ],
				content : '<%=request.getContextPath()%>/editor/common/selectFlowVariablePage.jsp?iframewindowid=popupSelectDialog001'
			});  
		}
		
		//实例描述回调
		function onpopupSelectDialog001Close(data){
			if(data!=null){
				var title = data.id;
				if(title!=null && title.length>0){
					var mTitle = "\$\{"+title+"\}";
					Matrix.setFormItemValue('inputTextArea002',mTitle);
				}
			}
			setTimeout('setFocus()',500);
			
		}
		
		function setFocus(){
			var input = document.getElementsByName('input002')[0];
			input.focus();
		}
	</script>
</head>
<body >
<div id="j_id1" jsId="j_id1" style="position: relative; _layout: flowlayout; width: 100%; height: 100%;overflow-x: hidden;overflow-y: auto;">
 <form id="form0" name="form0" eventProxy="Mform0" method="post" action="<%=request.getContextPath()%>/editor/process_getCurProcessVarible.action"
	style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
	<%
	WorkflowProcess process = (WorkflowProcess)request.getAttribute("process");
	%>
	<table id="table001" class="tableLayout" style="width:100%;" >
		<tr id="tr107" name="tr107">
			<td id="td107" name="td107" colspan="4" style="width:100%;"><font id="font2">基本信息</font></td>
		</tr>
		<tr id="tr001">
			<td id="td001" class="tdLabelCls" style="width:25%;">
				<label id="label001" name="label001" id="label001">
					编&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码：
				</label>
			</td>
			<td id="td002" class="tdValueCls" style="width:75%;">
				<div id="input001_div" style="vertical-align: middle;">
					<input id="input001" name="input001" type="text" value="${process.id}" class="form-control" style="height:100%;width:100%;"/>
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
					<input id="input002" name="input002" type="text" value="${process.name}" class="form-control" style="height:100%;width:100%;"/>
				</div>
			</td>
		</tr>
		<tr id="tr003">
			<td id="td005" class="tdLabelCls" style="width:25%;">
				<label id="label003" name="label003" id="label003">
					优&nbsp;&nbsp;先&nbsp;&nbsp;级：
				</label>
			</td>
			<td id="td006" class="tdValueCls" style="width:75%;">
				<div id="comboBox001_div" style="vertical-align: middle;">
					<select id="comboBox001" name="comboBox001" value="${process.processHeader.priority}" class="form-control" style="height:100%;width:100%;">
					   <option value="0" ${process.processHeader.priority == 0 ? "selected" : ""}>普通</option>
                       <option value="1" ${process.processHeader.priority == 1 ? "selected" : ""}>中级</option>
                       <option value="2" ${process.processHeader.priority == 2 ? "selected" : ""}>高级</option>
                       <option value="3" ${process.processHeader.priority == 3 ? "selected" : ""}>特级</option>
                    </select>
				</div>
			</td>
		</tr>
		<tr id="tr004">
			<td id="td007" class="tdLabelCls" style="width:25%;">
				<label id="label004" name="label004" id="label004">
					作&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;者：
				</label>
			</td>
			<td id="td008" class="tdValueCls" style="width:30%;">
				<div id="input003_div" style="vertical-align: middle;">
					<input id="input003" name="input003" type="text" value="${process.redefinableHeader.author}" class="form-control" style="height:100%;width:100%;"/>
				</div>
			</td>
		</tr>
		<tr id="tr013">
			<td id="td109" class="tdLabelCls" style="width:25%;">
				<label id="label012" name="label011">
					版&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;本：
				</label>
			</td>
			<td id="td010" class="tdValueCls" style="width:30%;">
				<div id="input004_div" style="vertical-align: middle;">
					<input id="input004" name="input004" type="text" value="${process.redefinableHeader.version}" class="form-control" style="height:100%;width:100%;"/>
				</div>
			</td>
		</tr>
		<tr id="tr005">
			<td id="td020" class="tdLabelCls" style="width:25%;">
				<label id="label009" name="label009" id="label009">
					有效期限：
				</label>
			</td>
			<td id="td021" class="tdValueCls" style="width:80%;text-align:left;">
				<label id="label100" name="label100" id="label100" style="padding-left:3px;">自</label>
				<div id="inputDate001_div" class="date-default-width col-md-12  input-prepend input-group" style="display: inline-table; vertical-align: middle;height:100%;width:150px;">
					<input id="inputDate001" name="inputDate001" value="" class="form-control layer-date" autocomplete="off" 
					style="width:100%;height:100%;padding-left: 5px;">
					<span class="input-group-addon addon-udSelect udSelect" id="inputDate001_button"><i class="fa fa-calendar"></i>
					</span>
				</div>
				<label id="label102" name="label102" id="label102">至</label>
				<div id="inputDate002_div" class="date-default-width col-md-12  input-prepend input-group" style="display: inline-table; vertical-align: middle;height:100%;width:150px;">
					<input id="inputDate002" name="inputDate002" value="" class="form-control layer-date" autocomplete="off" 
					style="width:100%;height:100%;padding-left: 5px;">
					<span class="input-group-addon addon-udSelect udSelect" id="inputDate002_button"><i class="fa fa-calendar"></i>
					</span>
				</div>
			</td>	
		</tr>
	<tr id="tr010">
		<td id="td015" class="tdLabelCls" style="width: 20%;border-right: 0px;">
			<label id="label015" name="label015" id="label015"> 定义描述：</label>
		</td>
		<td id="td018" class="tdValueCls" style="width:80%; border-left: 0px;">
			<div id="inputTextArea001_div">
				<%
				if(process.getDescription()!=null && process.getDescription().trim().length()>0){
				%>	
				<textarea class="form-control" rows="3" id="inputTextArea001" name="inputTextArea001" style="resize: none;"><%=process.getDescription()%></textarea>
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
		<td id="td019" class="tdLabelCls" style="width: 20%;border-right: 0px;">
			<label id="label016" name="label016" id="label016"> 实例描述：</label>
		</td>
		<td id="td022" class="tdValueCls" style="width: 80%; border-left: 0px;">
			<div id="popupSelectDialog001_div" class="input-group" style="width: 100%;">
	     		<%
				if(process.getRedefinableHeader().getResponsible()!=null && process.getRedefinableHeader().getResponsible().trim().length()>0){
				%>	
				<textarea class="form-control" rows="3" id="inputTextArea002" name="inputTextArea002" style="resize: none;"><%=process.getRedefinableHeader().getResponsible()%></textarea>
				<% 
				}else{
				%>	
				<textarea class="form-control" rows="3" id="inputTextArea002" name="inputTextArea002" style="resize: none;"></textarea>
				<%
				}
				%>
           		<span class="input-group-addon addon-udSelect udSelect" onclick="openpopupSelectDialog001();"><i class="fa fa-search"></i></span>
			</div>	
		</td>
	</tr>
</table>
</form>
</div>
</body>
</html>