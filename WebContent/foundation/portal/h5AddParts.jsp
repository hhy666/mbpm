<%@page pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML>
<html>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<head>
<jsp:include page="/form/html5/admin/html5Head.jsp"/>
<title>添加部件信息</title>
<script>
	window.onload = function(){
		if('${status}'==0){
			$('#status_0').iCheck('check');
		}else{
			$('#status_1').iCheck('check');
		}
	}
	
	//判断结尾
	function endWith(str, target) {
		var start = str.length-target.length;
		var arr = str.substr(start,target.length);
		if(arr == target){
			return true;
		}
		return false;
	}

	function save(){
		var result = Matrix.validateForm('form0');
		if(result){
			var width = document.getElementById('width').value;
			var height = document.getElementById('height').value;
			//如果宽度为空不进行校验
			if(width!=null&&width.trim()!=''){
				if(this.endWith(width,"px")!=true&&this.endWith(width,"%")!=true){
					Matrix.warn("默认宽度必须以px或者%结尾！")
					return false;
				}else{
					width = width.replace('px','');
					width = width.replace('%','');
					if (parseFloat(width).toString() == "NaN") {
						Matrix.warn('默认宽度必须为数字或百分比!');
						return false;
					}
				}
			}

			//如果高度为空不进行校验
			if(height!=null&&height.trim()!=''){
				if(this.endWith(height,"px")!=true&&this.endWith(height,"%")!=true){
					Matrix.warn("默认高度必须以px或者%结尾！")
					return false;
				}else{
					height = height.replace('px','');
					height = height.replace('%','');
					if (parseFloat(height).toString() == "NaN") {
						Matrix.warn('默认高度必须为数字或百分比!');
						return false;
					}
				}
			}
			var title = document.getElementById('title').value;
			var urlValue = document.getElementById('urlValue').value;
			var vituralbuttonHidden = document.getElementById('matrix_command_id');
			if(vituralbuttonHidden)
				vituralbuttonHidden.parentNode.removeChild(vituralbuttonHidden);
			var currentForm = document.getElementById('form0');
			var buttonHidden = document.createElement('input');
			buttonHidden.type='hidden';
			buttonHidden.name='matrix_command_id';
			buttonHidden.id='matrix_command_id';
			buttonHidden.value='button003';
			currentForm.appendChild(buttonHidden);
			var _mgr=Matrix.convertDataGridDataOfForm('form0');
			if(_mgr!=null&&_mgr==false){
				Matrix.closeWindow();
				return false;
			}
			document.getElementById('form0').action=
			"<%=request.getContextPath()%>/portal/partsAction_saveParts.action";	
			Matrix.send('form0',{'button003':'保存'},function(data){
				var json = isc.JSON.decode(data.data);
				if(json.result==true&&json.flag==true){
					parent.Matrix.refreshDataGridData('DataGrid001');
					parent.Matrix.warn("保存成功！");
					Matrix.closeWindow();
				}
				if(json.result==false&&json.flag==true){
					parent.Matrix.refreshDataGridData('DataGrid001');
					parent.Matrix.warn("修改成功！");
					Matrix.closeWindow();
				}
				if(json.result==true&&json.flag==false){
					parent.Matrix.refreshDataGridData('DataGrid001');
					parent.Matrix.warn("已存在该部件");
				}
			});	
		}else{
			return false;
		}
	}
</script>
</head>
	<body>
		<form id="form0" name="form0" method="post" action="" style="padding:10px;margin: 0px; position: relative; overflow: hidden; width: 100%; height: 100%;" enctype="application/x-www-form-urlencoded"> 
   		<input type='hidden' id='validateType' name='validateType' value='jquery'/>
	   	<input type="hidden" id="matrix_form_tid" name="matrix_form_tid" value="c143cdc1-03ce-4384-bd6b-7e68858dc855" /> 
	   	<input type="hidden" id="matrix_form_datagrid_form0" name="matrix_form_datagrid_form0" value="" />
		<div type="hidden" id="form0_hidden_text_div" name="form0_hidden_text_div" style="position: absolute; width: 0; height: 0; z-index: -9999999999; top: 0; left: 0; display: none;"></div> 
		<input type="hidden" name="javax.matrix.faces.ViewState" id="javax.matrix.faces.ViewState" value="" /> 
		<input type="hidden" name="uuid" id="uuid" value="${param.uuid}" /> 
		<input type="hidden" name="partId" id="partId" value="${param.partId }" /> 
		<input type="hidden" name="portalId" id="portalId" value="${param.portalId }" />
		<table class="maintain_form_content" style="width:100%;height:100%">
			<tr>
				<td class="tdLabelCls" style="width: 30%;">
					<label id="j_id0" name="j_id0">
					 	标题
					</label>
				</td>
				<td class="tdValueCls" style="width: 70%;">
					<div id="title_div" eventProxy="Mform0" class="matrixInline" style="width: 100%">
						<input class="form-control" required type="text" name="title" id="title" style="WIDTH:100%;" value="${title}" >
					</div>
				</td>
			</tr>
			<tr>
				<td class="tdLabelCls" style="width: 30%;">
					<label id="j_id2" name="j_id2">
						链接地址
					</label>
				</td>
				<td class="tdValueCls" style="width: 70%;">
					<div id="urlValue_div" eventProxy="Mform0" class="matrixInline" style="width:100%">
						<input class="form-control" required type="text" name="urlValue" id="urlValue" style="WIDTH:100%;" value="${urlValue}" >
					</div>
				</td>
			</tr>
			<tr>
				<td class="tdLabelCls" style="width: 30%;">
					<label id="j_id3" name="j_id3">
						默认宽度
					</label>
				</td>
				<td class="tdValueCls" style="width: 70%;">
					<div id="width_div" eventProxy="Mform0" class="matrixInline" style="width:100%">
						<input class="form-control" type="text" name="width" id="width" style="WIDTH:100%;" value="${width}">
					</div>
				</td>
			</tr>
			<tr>
				<td class="tdLabelCls" style="width: 30%;">
					<label id="j_id3" name="j_id4">
						默认高度
					</label>
				</td>
				<td class="tdValueCls" style="width: 70%;">
					<div id="height_div" eventProxy="Mform0" class="matrixInline" style="width:100%">
						<input class="form-control" type="text" name="height" id="height" style="WIDTH:100%;" value="${height}">
					</div>
				</td>
			</tr>
			<tr>
				<td class="tdLabelCls" style="width: 30%;">
					<label id="j_id4" name="j_id4">
						默认行数
					</label>
				</td>
				<td class="tdValueCls" style="width: 70%;">
					<div id="rows_div" eventProxy="Mform0" class="matrixInline" style="width:100%">
						<input class="form-control" pattern ="^[1-9][0-9]*$" data-errormessage="步长必须由数字组成" autocomplete="off" type="number" name="rows" id="rows" style="WIDTH:100%;" value="${rows}">
					</div>
				</td>
			</tr>
			<tr>
				<td class="tdLabelCls" style="width: 30%;">
					<label id="j_id5" name="j_id5">
						默认列数
					</label>
				</td>
				<td class="tdValueCls" style="width: 70%;">
					<div id="cols_div" eventProxy="Mform0" class="matrixInline" style="width:100%">
						<input class="form-control" type="number" name="cols" id="cols" style="WIDTH:100%;" value="${cols}">
					</div>
				</td>
			</tr>
			<tr>
				<td class="tdLabelCls" style="width: 30%;">
					<label id="j_id6" name="j_id6">
						更多(url)
					</label>
				</td>
				<td class="tdValueCls" style="width: 70%;">
					<div id="more_div" eventProxy="Mform0" class="matrixInline" style="width:100%">
						<input class="form-control" type="text" name="more" id="more" style="WIDTH:100%;" value="${more}">
					</div>
				</td>
			</tr>
			<tr>
				<td class="tdLabelCls" style="width: 30%;">
					<label id="j_id7" name="j_id7">
						状态
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
			<tr>
				<td class="cmdLayout" colspan="2">
					<div id="button003_div" class="matrixInline" >
						<input type="button" class="x-btn ok-btn " value="保存"  onclick="save()">
					</div>
					<div id="button004_div" class="matrixInline" >
						<input type="button" class="x-btn cancel-btn " value="取消"  onclick="Matrix.closeWindow()">
					</div>
				</td>
			</tr>
		</table>
	</body>
</html>