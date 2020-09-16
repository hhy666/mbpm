<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<%@page import="com.matrix.form.admin.custom.trigger.model.DataMapping"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<jsp:include page="/form/admin/common/taglib.jsp" />
		<jsp:include page="/form/admin/common/resource.jsp" />
		<style type="text/css">
.bottom {
	position: fixed;
	left: 0;
	bottom: 0;
	width: 100%;
	height: 35px;
}

.ico16 {
	background: rgba(0, 0, 0, 0) url("../resource/images/icon16.png") no-repeat scroll 0
		0;
	cursor: pointer;
	display: inline-block;
	height: 16px;
	line-height: 16px;
	vertical-align: middle;
	width: 16px;
}

.oprate_reduce_16 {
	background-position: -192px -16px;
}

.oprate_plus_16 {
	background-position: -176px -16px;
}
.select{
    display: block;
    height: 34px;
    padding: 6px 12px;
    font-size: 14px;
    line-height: 1.42857143;
    color: #555;
    background-color: #fff;
    background-image: none;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
    transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
    font-size: smaller;
}
.inputText{
	display: block;
    height: 34px;
    font-size: 14px;
    line-height: 1.42857;
    color: rgb(85, 85, 85);
    background-color: rgb(255, 255, 255);
    background-image: none;
    box-shadow: rgba(0, 0, 0, 0.075) 0px 1px 1px inset;
    padding: 6px 12px;
    border-width: 1px;
    border-style: solid;
    border-color: rgb(204, 204, 204);
    border-image: initial;
    border-radius: 4px;
    transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
    font-size: smaller;
}
tr{
	height:30px;
}
</style>
<script type="text/javascript">
var map = {'1':'文本框','2':'日期框','3':'时间框',
					  			'4':'数字框','5':'下拉框','22':'多选下拉框','6':'单选按钮','7':'复选按钮','8':'单选按钮组','9':'复选按钮组','10':'文本域','30':'大文本域',
					  			'11':'列表框','12':'单文件上传','28':'多文件上传','14':'富文本框',
					  			'20':'隐藏域','21':'弹出选择','23':'单选用户','24':'多选用户','25':'单选部门','26':'多选部门',
					  			'29':'流程意见'
					  			};
	function addRow(element){  //新加一行
		var tr = element.parentNode.parentNode; //获取当前行对象
		var index = tr.rowIndex;
		var tb = document.getElementById('tb');
		var newTr = tb.insertRow(index+1); //在下方插入新的一行
		var divisionTr = document.getElementById("division");//获取分界线所在行
		var lineIndex = divisionTr.rowIndex;//获取分界线的行号
		var newTd1 = newTr.insertCell();
			newTd1.innerHTML = "<td width=\"10%\"></td>";
		var newTd2 = newTr.insertCell();
		var select1 = document.getElementsByTagName("select")[0];
		var select2 = document.getElementsByTagName("select")[1];
		var flag; 
		if(index < lineIndex-1){ //若当前行在分界线上面，则在上面部分添加行，否则在下面部分添加行
			flag = "=";
		}else{
			flag = "-->";
		}
		var str = "<td width=\"35%\"><select style=\"width:90%;\" class=\"select\">";
		for(var i=0;i<select1.length;i++){
			str += "<option value=\"";
			str += select1[i].value;
			str += "\">"
			str += select1[i].text;
			str += "</option>";
		}
		str += "</select>";
		str += "</td>";
		newTd2.innerHTML = str;
		
		var newTd3 = newTr.insertCell();
			newTd3.innerHTML = "<td width=\"10%\">"+ flag +"</td>";
		
		var newTd4 = newTr.insertCell();
		str = "<td width=\"35%\"><select style=\"width:90%;\" class=\"select\">";
		for(var i=0;i<select2.length;i++){
			str += "<option value=\"";
			str += select2[i].value;
			str += "\">"
			str += select2[i].text;
			str += "</option>";
		}
		str += "</select>";
		str += "</td>";
		newTd4.innerHTML = str;
		
		var newTd5 = newTr.insertCell();
			newTd5.innerHTML = "<td width=\"10%\"><span class=\"ico16 oprate_plus_16 right\" onclick=\"addRow(this)\"></span>&nbsp;<span id=\"del\" class=\"ico16 oprate_reduce_16 right\" onclick=\"delRow(this);\"></span></td>";
	}
	function delRow(element){  //删除一行
			var tr = element.parentNode.parentNode;
			var index = tr.rowIndex;
			var tb = document.getElementById('tb');
			var divisionTr = document.getElementById("division");//获取分界线所在行
			var lineIndex = divisionTr.rowIndex;//获取分界线的行号
			if(index < lineIndex){
				if(lineIndex != 4){
					tb.deleteRow(index);
					return;				
				}
			}
			if(index > lineIndex){
				if(tb.rows.length-lineIndex > 3){
					tb.deleteRow(index);
					return;
				}
			}
		}
	function submitByButton(){ //点击确认
			var selects = document.getElementsByTagName("select");
			var divisionTr = document.getElementById("division");//获取分界线所在行
			var lineIndex = divisionTr.rowIndex;//获取分界线的行号
			var fromTypeJsonStr = "${fromTypeJsonStr}"; //获取原表单select的value对应类型组成的JSON串
		
			var synJson = isc.JSON.decode(fromTypeJsonStr);
			var toTypeJsonStr = "${toTypeJsonStr}";//获取目标表单select的value对应类型组成的JSON串
			var fromTypeJsonObj = eval("("+fromTypeJsonStr+")");
			var toTypeJsonObj = eval("("+toTypeJsonStr+")");
			var str;
			if(lineIndex != 1){  //不等于1说明操作类型为修改
				var m = 0;
				var n = 0;
				var fromType;
				var toType;
				var fromPro;
				var toPro;
				str = "[{'condition':{";
				var conditionRows = lineIndex-3; // 获得条件行数
				for(var i=0;i<conditionRows*2;i++){
					var index = selects[i].selectedIndex;
					var value = selects[i].options[index].value;
					var text = selects[i].options[index].text;
					if(i%2 == 0){
						str = str+ "'fromCondition_"+m+"':'";
						str += value;
						str += "',";
						m++;
						fromPro = text;
						fromType = fromTypeJsonObj[value];
					}else{
						str = str + "'toCondition_"+n+"':'";
						str += value;
						str += "',";
						n++;
						toPro = text;
						toType = toTypeJsonObj[value];
					}
					if(m == n){
						if(fromType == null && toType != null){
							alert("存在未选择的选项，请选择要匹配的选项！");
							return;
						}
						if(toType == null && fromType != null){
							alert("存在未选择的选项，请选择要匹配的选项！");
							return;
						}
						if(fromType == null && toType != null){
							alert("存在未选择的选项，请选择要匹配的选项！");
							return;
						}
						if(fromType != toType){
							alert("原表单的"+fromPro+"的类型为:"+map[fromType]+",目标表单的"+toPro+"的类型为:"+map[toType]+".类型不匹配");
							return;
						}
					}
				}
				str = str.substring(0,str.length-1);
				str += "}},{'copyData':{";
				m = 0;
				n = 0;
				var copyDataRows = selects.length/2-conditionRows;//获取复制数据的行数
				for(var i=0;i<copyDataRows*2;i++){
					var j = i + conditionRows*2;
					var index = selects[j].selectedIndex;
					var value = selects[j].options[index].value;
					var text = selects[j].options[index].text;
					if(i%2==0){
						str = str+"'fromData_"+m+"':'";
						str += value;
						str += "',";
						m++;
						fromPro = text;
						fromType = fromTypeJsonObj[value];
					}else{
						str = str+"'toData_"+n+"':'";
						str += value;
						str += "',";
						n++;
						toPro = text;
						toType = toTypeJsonObj[value];
					}
					if(m == n){
						if(fromType == null && toType == null && copyDataRows == 1){
							alert("必须要有主表字段拷贝到主表字段!");
							return;
						}
						if(fromType == null && toType != null){
							alert("存在未选择的选项，请选择要匹配的选项！");
							return;
						}
						if(toType == null && fromType != null){
							alert("存在未选择的选项，请选择要匹配的选项！");
							return;
						}
						if(fromType != toType){
							alert("原表单的"+fromPro+"的类型为:"+map[fromType]+",目标表单的"+toPro+"的类型为:"+map[toType]+".类型不匹配");
							return;
						}
					}
				}
				str = str.substring(0,str.length-1);
				str += "}}]";
			}else{
				var m = 0;
				var n = 0;
				var fromType;
				var toType;
				var fromTypeJsonStr = "${fromTypeJsonStr}"; //获取原表单select的value对应类型组成的JSON串
				var toTypeJsonStr = "${toTypeJsonStr}";//获取目标表单select的value对应类型组成的JSON串
				var fromTypeJsonObj = eval("("+fromTypeJsonStr+")");
				var toTypeJsonObj = eval("("+toTypeJsonStr+")");
				var fromPro;
				var toPro;
				str = "[{'copyData':{";
				for(var i=0;i<selects.length;i++){
					var index = selects[i].selectedIndex;
					var value = selects[i].options[index].value;
					var text = selects[i].options[index].text;
					if(i%2==0){
						str = str+"'fromData_"+m+"':'";
						str += value;
						str += "',";
						m++;
						fromPro = text;
						fromType = fromTypeJsonObj[value];
					}else{
						str = str+"'toData_"+n+"':'";
						str += value;
						str += "',";
						n++;
						toPro = text;
						toType = toTypeJsonObj[value];
					}
					if(m == n){
						if(fromType == null && toType == null && selects.length/2 == 1){
							alert("必须要有主表字段拷贝到主表字段!");
							return;
						}
						if(fromType == null && toType != null){
							alert("存在未选择的选项，请选择要匹配的选项！");
							return;
						}
						if(toType == null && fromType != null){
							alert("存在未选择的选项，请选择要匹配的选项！");
							return;
						}
						if(fromType != toType){
							alert("原表单的"+fromPro+"的类型为:"+map[fromType]+",目标表单的"+toPro+"的类型为:"+map[toType]+".类型不匹配");
							return;
						}
					}
				}
				str = str.substring(0,str.length-1);
				str += "}}]";
			}
			/*
			if(parent.document.getElementsByTagName("iframe")[1].contentWindow.document.getElementsByTagName("iframe")[0].contentWindow.Matrix){
				var iframe = parent.document.getElementsByTagName("iframe")[1].contentWindow.document.getElementsByTagName("iframe")[0].contentWindow;
			}else{
				var iframe = parent.document.getElementsByTagName("iframe")[2].contentWindow.document.getElementsByTagName("iframe")[0].contentWindow;
			}
			*/
			if(str != null && str != ''){
				parent.iframeJs.iframe.Matrix.setFormItemValue('dataCopyStr',str);
			}
			Matrix.closeWindow();
	}
</script>
	</head>
	<body>
	<jsp:include page="/form/admin/common/loading.jsp"/>
	<div id="j_id1" jsId="j_id1"
	style="position: relative; _layout: flowlayout; width: 100%; height: 100%; overflow: auto">
<script> 
var MForm0=isc.MatrixForm.create({
			ID:"MForm0",
			name:"MForm0",
			position:"absolute",
			action:"",
			fields:[{name:'Form0_hidden_text',width:0,height:0,displayId:'Form0_hidden_text_div'}]
		});</script>
	
		<%
  	List<DataMapping> conditionCopyList = (List<DataMapping>) request.getAttribute("conditionCopyList");
  	List<DataMapping> copyList = (List<DataMapping>) request.getAttribute("copyList");
  	List<String> fromEntVal = (List<String>) request.getAttribute("fromEntVal");
  	List<String> fromColVal = (List<String>) request.getAttribute("fromColVal");
  	List<String> toEntVal = (List<String>) request.getAttribute("toEntVal");
  	List<String> toColVal = (List<String>) request.getAttribute("toColVal");
  	String operateType = request.getParameter("operateType");
  	String index = request.getParameter("index");  //所修改数据的index
  	String optString = request.getParameter("optString");// 判断是添加(0)还是修改(1)
  %>
		<form id="Form0" action="">
			<input name="iframewindowid" id="iframewindowid" type="hidden" value="<%=request.getParameter("iframewindowid") %>" />
			<div id="main" style="height:92%;overflow:auto;">
				<table class="" id="tb"
					style="width: 100%; overflow: auto;">
					<tbody>
						<tr>
							<td width="10%"></td>
							<td width="35%">
								<span style="margin-left:40px;">原表单</span>
							</td>
							<td width="10%"></td>
							<td width="35%">
								<span style="margin-left:35px;">目标表单</span>
							</td>
							<td width="10%"></td>
						</tr>
						<%if(!"add".equals(operateType)){%>
						<tr>
							<td colspan="5">
								条件：
							</td>
						</tr>

						<%
    			  if(conditionCopyList != null && conditionCopyList.size()>0){
    			  int i = 0;
    			  boolean flag = true;
    			  for(DataMapping dataMapping : conditionCopyList){
    			%>
						<tr>
							<td width="10%"></td>
							<td width="35%">
								<select id="fromCondition_<%=i%>" name="fromCondition_<%=i%>" style="width:90%;" class="select">
									<option value = "empty_emp">
										---------请选择---------
									</option>
									<%for(int j=0; j<fromEntVal.size();j++) {%>
									<option value="<%=fromColVal.get(j)%>"><%=fromEntVal.get(j)%></option>
									<%} %>
								</select>
								<script type="text/javascript">
									var select = document.getElementById("fromCondition_<%=i%>");
									var options = select.options;
									var fromId = "<%=dataMapping.getFromId()%>";
									for(var i = 0;i<options.length;i++){
										if(options[i].value == fromId){
											options[i].selected = true;
											break;
										}
									}
								</script>
							</td>
							<td width="10%">
								==
							</td>
							<td width="35%">
								<select id="toCondition_<%=i%>" name="toCondition_<%=i%>" style="width:90%;" class="select">
									<option value = "empty_emp">
										---------请选择---------
									</option>
									<%for(int j=0; j<toEntVal.size();j++) {%>
									<option value="<%=toColVal.get(j)%>"><%=toEntVal.get(j)%></option>
									<%} %>
								</select>
								<script type="text/javascript">
									var select = document.getElementById("toCondition_<%=i%>");
									var options = select.options;
									var toId = "<%=dataMapping.getToId()%>";
									for(var i = 0;i<options.length;i++){
										if(options[i].value == toId){
											options[i].selected = true;
											break;
										}
									}
								</script>
							</td>
							<td width="10%">
								<span id="add" class="ico16 oprate_plus_16 right"
									onclick="addRow(this);"></span>
								<span id="del" class="ico16 oprate_reduce_16 right"
									onclick="delRow(this);"></span>
							</td>
						</tr>
						<% i++;}%>
						<tr>
							<td colspan="5">
								<hr/>
							</td>
						</tr>
  						<%}else{%>
						<tr>
							<td width="10%"></td>
							<td width="35%">
								<select id="fromCondition_0" name="fromCondition_0" style="width:90%;" class="select">
									<option value = "empty_emp">
										---------请选择---------
									</option>
									<%for(int j=0; j<fromEntVal.size();j++) {%>
									<option value="<%=fromColVal.get(j)%>"><%=fromEntVal.get(j)%></option>
									<%} %>
								</select>
							</td>
							<td width="10%">
								=
							</td>
							<td width="35%">
								<select id="toCondition_0" name="toCondition_0" style="width:90%;" class="select">
									<option value = "empty_emp">
										---------请选择---------
									</option>
									<%for(int j=0; j<toEntVal.size();j++) {%>
									<option value="<%=toColVal.get(j)%>"><%=toEntVal.get(j)%></option>
									<%} %>
								</select>
							</td>
							<td width="10%">
								<span id="add" class="ico16 oprate_plus_16 right"
									onclick="addRow(this);"></span>
								<span id="del" class="ico16 oprate_reduce_16 right"
									onclick="delRow(this);"></span>
							</td>
						</tr>
						<tr>
							<td colspan="5">
								<hr/>
							</td>
						</tr>
						<%} }%>
	<!--********************** 数据复制部分 ************************ -->
						<tr id="division">
							<td colspan="5">
								复制数据：
							</td>
						</tr>
						<% if(copyList != null && copyList.size() > 0){
    					for(int k = 0;k<copyList.size();k++){
    						DataMapping dataMapping = copyList.get(k);
    					%>
    					<tr>
							<td width="10%"></td>
							<td width="35%">
								<select id="fromData_<%=k%>" name="fromData_<%=k%>" style="width:90%;" class="select">
									<option value = "empty_emp">
										---------请选择---------
									</option>
									<%for(int j=0; j<fromEntVal.size();j++) {%>
									<option value="<%=fromColVal.get(j)%>"><%=fromEntVal.get(j)%></option>
									<%} %>
								</select>
								<script type="text/javascript">
									var select = document.getElementById("fromData_<%=k%>");
									var options = select.options;
									var fromId = "<%=dataMapping.getFromId()%>";
									for(var i = 0;i<options.length;i++){
										if(options[i].value == fromId){
											options[i].selected = true;
											break;
										}
									}
								</script>
							</td>
							<td width="10%">
								-->
							</td>
							<td width="35%">
								<select id="toData_<%=k%>" name="toData_<%=k%>" style="width:90%;" class="select">
									<option value = "empty_emp">
										---------请选择---------
									</option>
									<%for(int j=0; j<toEntVal.size();j++) {%>
									<option value="<%=toColVal.get(j)%>"><%=toEntVal.get(j)%></option>
									<%} %>
								</select>
								<script type="text/javascript">
									var select = document.getElementById("toData_<%=k%>");
									var options = select.options;
									var toId = "<%=dataMapping.getToId()%>";
									for(var i = 0;i<options.length;i++){
										if(options[i].value == toId){
											options[i].selected = true;
											break;
										}
									}
								</script>
							</td>
							<td width="10%">
								<span id="add" class="ico16 oprate_plus_16 right"
									onclick="addRow(this);"></span>
								<span id="del" class="ico16 oprate_reduce_16 right"
									onclick="delRow(this);"></span>
							</td>
						</tr>
    				<%}
    			}else{%>
						<tr>
							<td width="10%"></td>
							<td width="35%">
								<select id="fromData_0" name="fromData_0" style="width:90%;" class="select">
									<option value = "empty_emp">
										---------请选择---------
									</option>
									<%for(int j=0; j<fromEntVal.size();j++) {%>
									<option value="<%=fromColVal.get(j)%>"><%=fromEntVal.get(j)%></option>
									<%} %>
								</select>
							</td>
							<td width="10%">
								<--
							</td>
							<td width="35%">
								<select id="toData_0" name="toData_0" style="width:90%;" class="select">
									<option value = "empty_emp">
										---------请选择---------
									</option>
									<%for(int j=0; j<toEntVal.size();j++) {%>
									<option value="<%=toColVal.get(j)%>"><%=toEntVal.get(j)%></option>
									<%} %>
								</select>
							</td>
							<td width="10%">
								<span id="add" class="ico16 oprate_plus_16 right"
									onclick="addRow(this);"></span>
								<span id="del" class="ico16 oprate_reduce_16 right"
									onclick="delRow(this);"></span>
							</td>
						</tr>
						<%} %>
					</tbody>
				</table>
			</div>
			<div class="bottom" align="center">
					<div id="dataFormSubmitButton_div"
						class="matrixInline matrixInlineIE"
						style="position: relative;; width: 100px;; height: 22px;">
						<script>
	isc.Button.create( {
		ID : "MdataFormSubmitButton",
		name : "dataFormSubmitButton",
		title : "确认",
		displayId : "dataFormSubmitButton_div",
		position : "absolute",
		top : 0,
		left : 0,
		width : "100%",
		height : "100%",
		icon : Matrix.getActionIcon("save"),
		showDisabledIcon : false,
		showDownIcon : false,
		showRollOverIcon : false
	});
	MdataFormSubmitButton.click = function() {
		Matrix.showMask();
		submitByButton();
		Matrix.hideMask();
	};
</script>
					</div>
					<div id="dataFormCancelButton_div"
						class="matrixInline matrixInlineIE"
						style="position: relative;; width: 100px;; height: 22px;">
						<script>
	isc.Button.create( {
		ID : "MdataFormCancelButton",
		name : "dataFormCancelButton",
		title : "关闭",
		displayId : "dataFormCancelButton_div",
		position : "absolute",
		top : 0,
		left : 0,
		width : "100%",
		height : "100%",
		icon : Matrix.getActionIcon("exit"),
		showDisabledIcon : false,
		showDownIcon : false,
		showRollOverIcon : false
	});
	MdataFormCancelButton.click = function() {
		Matrix.showMask();
		Matrix.closeWindow();
		Matrix.hideMask();
	};
</script>
					</div>
				</div>
		</form>
		<script>MForm0.initComplete=true;MForm0.redraw();isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);</script></div>
	</body>
	
</html>
