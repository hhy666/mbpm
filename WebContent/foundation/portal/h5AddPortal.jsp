<%@page pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML>
<html>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<head>
<jsp:include page="/form/html5/admin/html5Head.jsp"/>
<script>
	var titleRecive = '<%=request.getAttribute("title")%>';
	var layRecive = <%=request.getAttribute("layout")%>;
	var staRecive= <%=request.getAttribute("status")%>;
	
	
	function checkLayout(){
		var type = "${type}";
		if(type!=null && type!= 2){
			var depName = document.getElementById('dep').value;
			if(depName!=null && depName.length>0){
				document.getElementById('selectDepTr').style.display = "";
				document.getElementById('dep').disabled = "";
			}else{
	    		document.getElementById('selectDepTr').style.display="none";
	    		document.getElementById('dep').disabled = "disabled";
			}
		}else{
			document.getElementById('selectDepTr').style.display="none";
    		document.getElementById('typeTr').style.display="none";
    		document.getElementById('dep').disabled = "disabled";
		}
		
		//普通用户修改屏蔽门户类型
		var phaseId = $('#phaseId').val();
		if(phaseId==5){
    		document.getElementById('typeTr').style.display="none";
		}
	}
	
	function depLayer(){
		layer.open({
			type:2,
			title:['部门选择'],
			area:['90%','95%'],
			content:"<%=path%>/office/html5/select/SingleSelectDep.jsp?iframewindowid=AddDep"
		});
	}
	
	function onAddDepClose(data){
		if(data!=null){
			document.getElementById('dep').value = data.names;			
    		Matrix.setFormItemValue('depId',data.ids);
		}	
	}
	
	$(document).ready(function(){
		//根据门户部门设置部门显示隐藏
		 $('input[type=radio][name=type]').on('ifChecked', function(event){
			 var isShow = document.getElementById('selectDepTr').style.display;
		    	if(isShow==''){
		    		document.getElementById('selectDepTr').style.display="none";
		    		Matrix.setFormItemValue("type",'1');
		    	}else if(isShow=='none'){
		    		document.getElementById('selectDepTr').style.display="";
		    		Matrix.setFormItemValue("type",'3');
		    	}
		}); 
		 
		 //修改界面layout默认值设置
		 if('${layout}'==1){
			$('#layout_1').iCheck('check');
		 }else if('${layout}'==2){
			$('#layout_2').iCheck('check');
		 }else if('${layout}'==3){
			$('#layout_3').iCheck('check');
		 }
		 
		 //修改界面status默认值设置
		 if('${status}'==0){
			$('#status_0').iCheck('check');
		 }else if('${status}==1'){
			$('#status_1').iCheck('check');
		 }
		 
		 //修改界面type默认值设置
		 if('${type}'==1){
			$('#type_1').iCheck('check');
		 }else if('${type}'==3){
			$('#type_3').iCheck('check');
		 }
	});
	
	function save(){
		if(Matrix.validateForm('form0')){
			var vituralbuttonHidden = document.getElementById('matrix_command_id');
			if(vituralbuttonHidden)
				vituralbuttonHidden.parentNode.removeChild(vituralbuttonHidden);
			var currentForm = document.getElementById('form0');
			var buttonHidden = document.createElement('input');
			buttonHidden.type='hidden';
			buttonHidden.name='matrix_command_id';
			buttonHidden.id='matrix_command_id';
			buttonHidden.value='button001';
			currentForm.appendChild(buttonHidden);
			var _mgr=Matrix.convertDataGridDataOfForm('form0');
			if(_mgr!=null&&_mgr==false){
				Matrix.hideMask();
				return false;
			}
			document.getElementById('form0').action="<%=path%>/portal/portalAction_savePortal.action";
			var data=Matrix.getFormItemValue('uuid');
			var type=Matrix.getFormItemValue('type');
			/* var types = document.getElementsByName('type');
			for(var i=0;i<types.length;i++){
				if(types[i].checked){
					var type = types[i].value;
				}
			} */
			var newData=null;
			var synJson=null;
			if(data!=null){
				newData="{'uuid':'"+data+"','type':'"+type+"'}";
				synJson = isc.JSON.decode(newData);
			}
			var url = "<%=path%>/portal/portalAction_validataPortal.action";
			Matrix.sendRequest(url,synJson,function(data){
				if(data.data=="true"){
					Matrix.send('form0',synJson,function(){
						Matrix.closeWindow();
					});
				}else if(data.data=="false"){
					Matrix.warn('个人门户只允许添加一个！')
					return false;
				}
			});
		}else{
			return false;
		}
}
</script>
</head>
	<body  onload="checkLayout();">
		<div style="width:100%;height:100%;overflow:auto;position:relative;">
	    	<form id="form0" name="form0" method="post" action="<%=request.getContextPath()%>/portal/portalAction_findAllPortal.action" style="margin:0px;position:relative;overflow:hidden;width:100%;height:100%;padding:10px" enctype="application/x-www-form-urlencoded">
 				<input type="hidden" name="form0" value="form0" />
				<input type="hidden" id="phaseId" name="phaseId" value="${param.phaseId }">
				<input type="hidden" id="uuid" name="uuid" value="${param.portalId }">
		        <input type="hidden" id="mode" name="mode" value="debug" />
		        <input type="hidden" id="validateType" name="validateType" value="jquery" />
		        <input type="hidden" id="matrix_form_tid" name="matrix_form_tid" />
		        <input type="hidden" id="matrix_form_datagrid_form0" name="matrix_form_datagrid_form0" value="" />
		        <input name="type" id="type" type="hidden" value="${type}" />
		        <input type="hidden" id="depId" name="depId" value="${depId }" />
		        <div type="hidden" id="form0_hidden_text_div" name="form0_hidden_text_div" style="position:absolute;width:0;height:0;z-index:-9999999999;top:0;left:0;display:none;"></div>
		        <input type="hidden" name="javax.matrix.faces.ViewState" id="javax.matrix.faces.ViewState" value="" />
		        <table class="maintain_form_content" style="width:100%;height: 85%;">
		        	<tr>
		        		<td class="tdLabelCls" style="width: 30%;">
		        			<label id="j_id0" name="j_id0">
								门户标题
							</label>
		        		</td>
		        		<td class="tdValueCls" style="width: 70%;">
		        	
							<div id="title_div" eventProxy="Mform0" class="matrixInline" style="width: 100%">
								<input required class="form-control" type="text" name="title" id="title" style="WIDTH:100%;" value="${title}">
							</div>
						</td>
		        	</tr>
		        	<tr>
		        		<td class="tdLabelCls" style="width: 30%;">
		        			<label id="j_id1" name="j_id1">
								门户列数
							</label>
						</td>		        		
		        		<td class="tdValueCls" style="width: 70%;">
							<table border="0" style="width:100%;height:100%;margin:0px;padding: 0px;" cellspacing="0" cellpadding="0">
								<tr>
									<td style="padding-left: 2px;padding-top: 2px;border-style:none;;width:100px;">
										<div id="layout_1_div" eventProxy="Mform0">
											<input class="box" id="layout_1" type="radio" name="layout" value="1">1列
										</div>
									</td>
									<td style="padding-left: 2px;padding-top: 2px;border-style:none;;width:100px;">
										<div id="layout_2_div" eventProxy="Mform0">
											<input class="box" id="layout_2" type="radio" name="layout" value="2">2列
										</div>
									<td style="padding-left: 2px;padding-top: 2px;border-style:none;;width:100px;display:none;">
										<div id="layout_2_div" eventProxy="Mform0">
											<input class="box" id="layout_3" type="radio" name="layout" value="3">3列
										</div>
									</td>
								</tr>
							</table>
		        		</td>
		        	</tr>
		        	<tr>
		        		<td class="tdLabelCls" style="width: 30%;">
		        			<label id="j_id2" name="j_id2" >
								门户状态
							</label>
						</td>		        
						<td class="tdValueCls" style="width: 70%;">
							<table border="0" style="width:100%;height:100%;margin:0px;padding: 0px;" cellspacing="0" cellpadding="0">
								<tr>
									<td style="padding-left: 2px;padding-top: 2px;border-style:none;;width:100px;">
										<div id="status_0_div" eventProxy="Mform0">
											<input class="box" id="status_0" type="radio" name="status" value="0">启用
										</div>
									</td>
									<td style="padding-left: 2px;padding-top: 2px;border-style:none;;width:100px;">
										<div id="status_1_div" eventProxy="Mform0">
											<input class="box" id="status_1" type="radio" name="status" value="1">禁用
										</div>
									</td>
								</tr>
							</table>
						</td>
		        	</tr>
		        	<tr id="typeTr">
		        		<td class="tdLabelCls" style="width: 30%;">
		        			<label id="j_id3" name="j_id3">
								门户类型
							</label>
						</td>
						<td class="tdValueCls" style="width: 70%;">
							<table border="0" style="width:100%;height:100%;margin:0px;padding: 0px;" cellspacing="0" cellpadding="0">
								<tr>
									<td style="padding-left: 2px;padding-top: 2px;border-style:none;width:100px;">
										<div id="type_0_div" eventProxy="Mform0">
											<input class="box" id="type_1" type="radio" name="type" value="1" checked="checked">公司门户
										</div>
									</td>
									<td style="padding-left: 2px;padding-top: 2px;border-style:none;;width:100px;">
										<div id="type_1_div" eventProxy="Mform0">
											<input class="box" id="type_3" type="radio" name="type" value="3">部门门户
										</div>
									</td>
								</tr>
							</table>
						</td>
		        	</tr>
		        	<tr id="selectDepTr">
						<td class="tdLabelCls" style="width: 30%;">
							<label id="j_id6" name="j_id6">
								选择部门
							</label>
						</td>
						<td class="tdValueCls" style="width: 70%;">
						
							<div class="input-group" style="width:100%;">
								<input class="form-control" readonly="readonly" type="text" name="dep" id="dep" style="WIDTH:100%;" value="${depName}">										
								<span class="input-group-addon addon-udSelect udSelect" onclick="depLayer()"><i class="fa fa-search"></i></span>
							</div>
		        		</td>
	        		</tr>
		        	<tr>
		        		<td class="cmdLayout" colspan="2">
							<div id="button003_div" class="matrixInline">
								<input type="button" class="x-btn ok-btn " value="保存" onclick="save()">
							</div>
							<div id="button004_div" class="matrixInline">
								<input type="button" class="x-btn cancel-btn " value="取消" onclick="Matrix.closeWindow()">
							</div>
						</td>
		        	</tr>
		        </table>
			</form>
		</div>
	</body>
</html>