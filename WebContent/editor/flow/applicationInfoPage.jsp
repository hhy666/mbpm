<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
	<meta charset="UTF-8">
	<title>交互式组件信息</title>
	<%@ include file="/form/html5/admin/html5Head.jsp"%>
	<script>
		window.onload = function(){
			var entityId = document.getElementById('entityId').value;
			if(entityId == "jhszj"){
				debugger;
		    	document.getElementById('tr003').style.display = "none";
		    	var type = '${application.applicationType}';
				if(type=='FORM'){     //表单
					document.getElementById('tr003').style.display = "none";
					document.getElementById('tr013').style.display = "";
				}else{   //链接
					document.getElementById('tr013').style.display = "none";
					document.getElementById('tr003').style.display = "";
				}
			}else{
				document.getElementById('tr013').style.display = "none";
				document.getElementById('tr002').style.display = "none";
			}
			setTimeout('setFocus()',500);
		}
		//下拉框改变事件
		function changeJS(){
			var com = Matrix.getMatrixComponentById("comboBox001");
			var comValue = Matrix.getFormItemValue('comboBox001');
			if(comValue==8){  //表单
				document.getElementById('tr003').style.display = "none";
				document.getElementById('tr013').style.display = "";
			}if(comValue==4){  //链接
				document.getElementById('tr013').style.display = "none";
				document.getElementById('tr003').style.display = "";
		    }
		}	
		//页面失焦事件
		window.onblur = function(){
			var synJson = Matrix.formToObject('form0'); 
			var type = Matrix.getFormItemValue('comboBox001');
			if(synJson!=null){
				var url = "<%=request.getContextPath()%>"+"/editor/process_saveApplication.action?type="+type;
				Matrix.sendRequest(url,synJson,function(){
					return true;
				});
			}	
		}
		
		//弹出选择表单窗口
		function openpopupSelectDialog1(){
			parent.parent.parent.openSelectFormTree(this);   //editFlowProMainPage.jsp弹出
		}
       
         //设置焦点
         function setFocus(){
          	var input001 = document.getElementsByName('input001')[0];
            input001.focus();
         }
 </script>
</head>
<body>
  <div style="width: 100%; height: 100%; overflow: auto; position: relative;">
	<form id="form0" name="form0" eventProxy="Mform0" method="post" style="margin: 0px; position: relative; overflow: auto; width: 100%; height: 100%;"
		enctype="application/x-www-form-urlencoded">
		<input type="hidden" name="index" id="index" value="${param.index }"/>
		<input type="hidden" name="appdid" id="appdid" value="${param.appdid}" />
		<input type="hidden" name="location" id="location"  value='${application.location}' />
		<input type="hidden" id="entityId" name="entityId" value="${param.entityId}" />
		<table id="table001" class="tableLayout" style="width: 100%;">
			<tr id="tr001">
				<td id="td001" class="tdLabelCls" style="width: 25%;text-align:right;">
					<label id="label001" name="label001" id="label001">
						名&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;称：
					</label>
				</td>
				<td id="td002" class="tdValueCls" style="width: 75%;">
					<div id="input001_div" style="vertical-align: middle;">
						<input id="input001" name="input001" type="text" value="${application.name}" onkeyup="changeContent();" class="form-control" style="height:100%;width:100%;"/>
					</div>
					<script>
					function changeContent(){
					     var name = Matrix.getFormItemValue('input001');//名称
					     var index = Matrix.getFormItemValue('index');
						 parent.parent.updateName(name,index);
					}
					</script>
				</td>
			</tr>
			<tr id="tr002">
				<td id="td003" class="tdLabelCls" style="width: 25%;text-align:right;">
					<label id="label002" name="label002" id="label002">
						类&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;型：
					</label>
				</td>
				<td id="td004" class="tdValueCls" style="width: 75%;">
					<div id="comboBox001_div" style="vertical-align: middle;">
						<select id="comboBox001" name="comboBox001" value="${application.applicationType=='FORM'?8:4}" onchange="changeJS();" class="form-control" style="height:100%;width:100%;">
	                       <option value="8" ${application.applicationType == 'FORM' ? "selected" : ""}>表单</option>
	                       <option value="4" ${application.applicationType != 'FORM' ? "selected" : ""}>链接</option>
	                    </select>
					</div>				
				</td>
			</tr>
			<tr id="tr013">
				<td id="td015" class="tdLabelCls" style="width: 25%;text-align:right;">
					<label id="label013" name="label013" id="label013">
						业务组件：
					</label>
				</td>
				<td id="td016" class="tdValueCls" style="width: 75%;">
					<div id="popupSelectDialog1_div" class="input-group">
						 <input id="input012" name="input012" type="text" value="${application.formName}" class="form-control" style="height:100%;width:100%;" readonly="readonly"/>
	            		 <span class="input-group-addon addon-udSelect udSelect" onclick="openpopupSelectDialog1();"><i class="fa fa-search"></i></span>
					</div>		
				</td>
			</tr>
			<tr id="tr003">
				<td id="td005" class="tdLabelCls" style="width: 25%;text-align:right;">
					<label id="label003" name="label003" id="label003">
						业务组件：
					</label>
				</td>
				<td id="td006" class="tdValueCls" style="width: 75%;">
					<div id="input002_div" style="vertical-align: middle;">
						 <input type="text" id="input002" name="input002" value="${application.location}"  class="form-control">
					</div>					
				</td>
			</tr>
			<tr id="tr004">
				<td id="td007" class="tdLabelCls" rowspan="1" style="width: 25%;text-align:right;">
					<label id="label004" name="label004" id="label004">
						描&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;述：
					</label>
				</td>
				<td id="td008" class="tdValueCls" rowspan="1" style="width: 25%;">
					<div id="inputTextArea001_div">
						<textarea class="form-control" rows="3" id="inputTextArea001" name="inputTextArea001" style="resize: none;">${application.description}</textarea>
					</div>
				</td>
			</tr>
		</table>
	</form>
 </div>
 </body>
</html>
