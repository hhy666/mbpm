<%@page  import="java.util.*" pageEncoding="UTF-8" %>
<%@page import="com.matrix.form.admin.custom.formula.model.IfModel"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>advencedSet.html</title>

		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="this is my page">
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resource/css/advancedSet.css">
		<jsp:include page="/foundation/common/taglib.jsp" />
		<jsp:include page="/foundation/common/resource.jsp" />
	<script type="text/javascript">
		function addRow(element){  //添加一行
			var tr = element.parentNode.parentNode;
			var index = tr.rowIndex;
			var tb = document.getElementById('setArea');
			var newTr = tb.insertRow(index+1);
			var newTd1 = newTr.insertCell();
			newTd1.innerHTML = "<td class=\" padding_t_5 padding_r_5\" width=\"12%\" valign=\"top\" height=\"100%\" align=\"right\"> <span id=\"add\" class=\"ico16 oprate_plus_16 right\" onclick=\"addRow(this);\"></span><br/><br/><span id=\"del\" class=\"ico16 oprate_reduce_16 right\" onclick=\"delRow(this.parentNode.parentNode);\"></span></td>";
			var newTd2 = newTr.insertCell();
			newTd2.innerHTML = "<td class=\"padding_t_5\" width=\"8%\" valign=\"top\" height=\"100%\" align=\"right\"><span class=\"font_size12 padding_r_5 right\">如果</span></td>";	
			var newTd3 = newTr.insertCell();
			newTd3.innerHTML = "<td class=\"padding_t_5\" width=\"27%\" valign=\"middle\" height=\"100%\" align=\"left\"><textarea id=\"ifFormField\" class=\"input-100\" onclick=\"setifCondition(this)\" rows=\"5\" cols=\"25\" readonly=\"true\" name=\"ifFormField\"></textarea></td>";
			var newTd4 = newTr.insertCell();
			newTd4.innerHTML = "<td class=\"padding_t_5\" width=\"10%\" valign=\"top\" height=\"100%\" align=\"right\"><span class=\"font_size12 padding_r_5 right\"> 则为</span></td>";
			var newTd5 = newTr.insertCell();
			newTd5.innerHTML = "<td class=\" padding_t_5\" width=\"43%\" valign=\"middle\" align=\"left\"><textarea id=\"resultFormField\" class=\"input-100\" onclick=\"setResult(this)\" rows=\"5\" cols=\"25\" readonly=\"true\" name=\"resultFormField\"></textarea></td>";
		}
		function delRow(element){  //删除一行
			var tr = element;
			var index = tr.rowIndex;
			var elseTr = document.getElementById("elseTr");
			var elseIndex = elseTr.rowIndex;
			var tb = document.getElementById('setArea');
			if(elseIndex > 1){
				tb.deleteRow(index);
			}
		}
		var element = {};
		function setifCondition(obj){
			element = obj;
			Mcondition.initSrc = "<%=request.getContextPath()%>/formula/formula_loadConditionSet.action?formType=mainForm&flag=${param.flag}&condition="+encodeURI(element.value);
			Mcondition.Src = "<%=request.getContextPath()%>/formula/formula_loadConditionSet.action?formType=mainForm&flag=${param.flag}&condition="+encodeURI(element.value);
			Matrix.showWindow("condition");
		}
		function onconditionClose(result){
			if(result!=null){
				var data = eval("("+result+")");
				element.value = data.conditionText;
			}
		}
		function setResult(obj){
			element = obj;
			Mresult.initSrc = "<%=request.getContextPath()%>/formula/formula_loadNormalSet.action?formType=mainForm&isResult=1&flag=${param.flag}&content="+encodeURI(element.value);
			Mresult.Src = "<%=request.getContextPath()%>/formula/formula_loadNormalSet.action?formType=mainForm&isResult=1&flag=${param.flag}&content="+encodeURI(element.value);
			Matrix.showWindow("result");
		}
		function onresultClose(data){
			if(data!=null){
				element.value = data.value;
			}
		}
		function reset(){ //重置
			var tb = document.getElementById("setArea");
			var rowNum = tb.rows.length;
			var i = 0;
			while(i<rowNum-2){
				var tr = tb.rows[0];
				delRow(tr);
				i++;
			}
			var textAreas = document.getElementsByTagName("textarea");
			for(var j=0; j<textAreas.length; j++){
				textAreas[j].value = "";
			}
		}
		function changeModel(){ //切换到普通设置模式
			var textAreas = document.getElementsByTagName("textarea");
			var tflag = false;
			var content = "";
			var setType = 0;
			for(var i=0; i<textAreas.length; i++){
				if(textAreas[i].value != ""){
					tflag = true;
					break;
				}
			}
			if(tflag){
				if(confirm("切换会是计算式丢失,是否继续？")){
					window.location.href = "<%=request.getContextPath()%>/formula/formula_loadNormalSet.action?formType=mainForm&flag=${param.flag}&content="+content+"&setType=0&iframewindowid=${param.iframewindowid}";
				}else{
					document.getElementById("advancedSet").checked = true;;
				}
			}else{
				window.location.href = "<%=request.getContextPath()%>/formula/formula_loadNormalSet.action?formType=mainForm&flag=${param.flag}&content="+content+"&setType=0&iframewindowid=${param.iframewindowid}";
			}
		}
		function closeWindow(){  //关闭
			Matrix.closeWindow();
		}
		function evalValue(){ //点击确认
			var textAreas = document.getElementsByTagName("textarea");
			var str = "{";
			var m = 0;
			var n = 0;
			for(var i=0; i<textAreas.length; i++){
				var content = textAreas[i].value;
				if(content!=null){
					content=content.replace(/\'+/g,"\\'");
					content=content.replace(/\"+/g,"\\\"");
				}
				if(content==""){
					alert("存在未设置的条件，请设置");
					return;
				}
				if(i == textAreas.length-1){ //最后一个 textArea 为 elseResult
					str += "\"elseResult\":\""+content+"\"}";
				}else{
					if(i%2 == 0){
						str += "\"ifCondition_"+m+"\":\""+content+"\"";
						str += ",";
						m++;
					}else{
						str += "\"ifResult_"+n+"\":\""+content+"\"";
						str += ",";
						n++;
					}
				}
			}
				var url = "<%=request.getContextPath()%>/trigger/conditionTrans_outToIn2.action";
 		  		var jsonStr = '{"condition":'+str+'}';
 		  		var synJson = eval('(' + jsonStr + ')'); 
 		  		Matrix.sendRequest(url,synJson,function(result){
 		  			if(result != null){
 		  				var data = eval("("+result.data+")");
 		  				data.setType = 1;//setType 为设置类型，1：高级设置，0：普通设置
 		  				Matrix.closeWindow(data);
 		  			}
 		  		});
			document.getElementById("advancedSetStr").value = str;
		}
	</script>
	</head>

	<body>
		<input name="iframewindowid" id="iframewindowid" type="hidden" value="<%=request.getParameter("iframewindowid") %>"/>
		<input name="advancedSetStr" id="advancedSetStr" type="hidden" />
		<div style="width: 625px; height: 90%;overflow-x:hidden;" class="font_size12">
			<div id="modelSet" style="height: 50px; line-height: 50px;">
				<label for="modelSet" style="margin-left: 30px">
					<input type="radio" value="1" id="nomalSet" name="modelSet" onclick="changeModel()"/>
					普通设置
				</label>
				<label for="modelSet" style="margin-left: 30px">
					<input type="radio" value="2" id="advancedSet" name="modelSet"
						checked="checked" />
					高级设置
				</label>
			</div>
			<div style="overflow-x:hidden;overflow-y:auto;">
				<table style="width: 100%;" id="setArea" class="margin_5">
					<tbody>
						<%
							List<IfModel> ifList = (List<IfModel>)request.getAttribute("ifList");
							String elseResult = (String)request.getAttribute("elseResult");
							if(ifList != null && ifList.size()>0){
								for(IfModel ifModel : ifList){
									String ifCondition = ifModel.getIfCondition();
									String ifResult = ifModel.getIfResult();
						 %>
						<tr>
							<td class=" padding_t_5 padding_r_5" width="12%" valign="top"
								height="100%" align="right">
								<span id="add" class="ico16 oprate_plus_16 right"
									onclick="addRow(this);"></span>
								<br />
								<br />
								<span id="del" class="ico16 oprate_reduce_16 right"
									onclick="delRow(this.parentNode.parentNode);"></span>
							</td>
							<td class="padding_t_5" width="8%" valign="top" height="100%"
								align="right">
								<span class="font_size12 padding_r_5">如果</span>
							</td>
							<td class="padding_t_5" width="27%" valign="middle" height="100%"
								align="left">
								<textarea id="ifFormField" class="input-100" value=""
									onclick="setifCondition(this)" rows="5" cols="25" readonly="true"
									name="ifFormField"><%=ifCondition %></textarea>
							</td>
							<td class="padding_t_5" width="10%" valign="top" height="100%"
								align="right">
								<span class="font_size12 padding_r_5"> 则为</span>
							</td>
							<td class=" padding_t_5" width="43%" valign="middle" align="left">
								<textarea id="resultFormField" class="input-100" value=""
									onclick="setResult(this)" rows="5" cols="25" readonly="true"
									name="resultFormField"><%=ifResult %></textarea>
							</td>
						</tr>
						<%}
						}else { %>
						<tr>
							<td class=" padding_t_5 padding_r_5" width="12%" valign="top"
								height="100%" align="right">
								<span id="add" class="ico16 oprate_plus_16 right"
									onclick="addRow(this);"></span>
								<br />
								<br />
								<span id="del" class="ico16 oprate_reduce_16 right"
									onclick="delRow(this.parentNode.parentNode);"></span>
							</td>
							<td class="padding_t_5" width="8%" valign="top" height="100%"
								align="right">
								<span class="font_size12 padding_r_5">如果</span>
							</td>
							<td class="padding_t_5" width="27%" valign="middle" height="100%"
								align="left">
								<textarea id="ifFormField" class="input-100"
									onclick="setifCondition(this)" rows="5" cols="25" readonly="true"
									name="ifFormField"></textarea>
							</td>
							<td class="padding_t_5" width="10%" valign="top" height="100%"
								align="right">
								<span class="font_size12 padding_r_5"> 则为</span>
							</td>
							<td class=" padding_t_5" width="43%" valign="middle" align="left">
								<textarea id="resultFormField" class="input-100"
									onclick="setResult(this)" rows="5" cols="25" readonly="true"
									name="resultFormField"></textarea>
							</td>
						</tr>
						<%}%>
						<tr id="elseTr">
							<td class=" padding_t_5 padding_r_5" width="12%" valign="top"
								height="100%" align="right">
					
							</td>
							<td class="padding_t_5" width="8%" valign="top" height="100%"
								align="right">
								
							</td>
							<td class="padding_t_5" width="27%" valign="middle" height="100%"
								align="left">
								
							</td>
							<td class="padding_t_5" width="10%" valign="top" height="100%"
								align="right">
								<span class="font_size12 padding_r_5">否则为</span>
							</td>
							<td class=" padding_t_5" width="43%" valign="middle" align="left">
								<textarea id="resultFormField" class="input-100" value=""
									onclick="setResult(this)" rows="5" cols="25" readonly="true"
									name="resultFormField"><%=elseResult==null?"": elseResult%></textarea>
							</td>
						</tr>
					</tbody>
				</table>
				<a id="abandon" class="common_button common_button_gray" href="javascript:void(0)" style="margin-left:30px" onclick="reset();">重置</a>
			</div>
		</div>
		<div id="footer" align="center" style="margin-left:0px;">
			<table style="width:100%;height:100%" id="ft">
				<tr>
					<td align="right">
						<input name="submit2" type="submit" id="butt1" onClick="evalValue();"
							value="确认" />&nbsp;
					</td>
					<td align="left">
						&nbsp;<input name="butt1" type="button" id="butt2" onClick="closeWindow();" value="取消" />
					</td>
				</tr>
			</table>
		</div>
	<script>//设置 if 条件
		isc.Window.create( {
			ID : "Mcondition",
			id : "condition",
			name : "condition",
			autoCenter : true,
			position : "absolute",
			height : "100%",
			width : "100%",
			title : "计算条件设置",
			canDragReposition : true,
			showMinimizeButton : false,
			showMaximizeButton : true,
			showCloseButton : true,
			showModalMask : false,
			modalMaskOpacity : 0,
			isModal : true,
			autoDraw : false,
			headerControls : [ "headerIcon", "headerLabel", "minimizeButton",
					"maximizeButton", "closeButton" ],
			showFooter : false
		});
		</script>
		<script>
			Mcondition.hide();
		</script>
		<script>//设置结果
		isc.Window.create( {
			ID : "Mresult",
			id : "result",
			name : "result",
			autoCenter : true,
			position : "absolute",
			height : "100%",
			width : "100%",
			title : "计算条件设置",
			canDragReposition : false,
			showMinimizeButton : false,
			showMaximizeButton : false,
			showCloseButton : true,
			showModalMask : false,
			modalMaskOpacity : 0,
			isModal : true,
			autoDraw : false,
			headerControls : [ "headerIcon", "headerLabel", "minimizeButton",
					"maximizeButton", "closeButton" ],
			showFooter : false
		});
		</script>
		<script>
			Mresult.hide();
		</script>
	</body>
</html>
