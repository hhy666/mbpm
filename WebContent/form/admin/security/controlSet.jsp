<%@page import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.matrix.form.admin.security.model.FormSecurityOperateSet"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>advencedSet.html</title>

		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="this is my page">
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath() %>/resource/css/advancedSet.css">
		<jsp:include page="/foundation/common/taglib.jsp" />
		<jsp:include page="/foundation/common/resource.jsp" />
		
	</head>

	<body onLoad="loadJS();">

		<input name="iframewindowid" id="iframewindowid" type="hidden"
			value="<%=request.getParameter("iframewindowid") %>" />
		<input name="advancedSetStr" id="advancedSetStr" type="hidden" />
		<div style="width: 600px; height: 500px; overflow-x: hidden;"
			class="font_size12">
			<div id="modelSet" style="height: 50px; line-height: 50px;">
				
			</div>
			<div>
				<table style="width: 100%;" id="setArea" class="margin_5">
					<tbody>
						<%
							List<FormSecurityOperateSet> ifList = (List<FormSecurityOperateSet>)request.getAttribute("ifList");
							String elseResult = (String)request.getAttribute("elseResult");
							if(ifList != null && ifList.size()>0){
								int i=0;
								for(FormSecurityOperateSet fso : ifList){
									String ifCondition=fso.getCondition();
									int genre =fso.getConditionSecurity();
								    boolean isRequired=fso.isRequired();
						 %>
						<tr>
							<td class=" padding_t_5 padding_r_5" width="8%" valign="top"
								height="100%" align="right">
								<span id="add" class="ico16 oprate_plus_16 right"
									onclick=
	addRow(this);;
></span>
								<br />
								<br />
								<span id="del" class="ico16 oprate_reduce_16 right"
									onclick=
	delRow(this.parentNode.parentNode);;
></span>
							</td>
							<td class="padding_t_5" width="6%" valign="top" height="100%"
								align="right">
								<span class="font_size12 padding_r_5">条件</span>
							</td>
							<td class="padding_t_5" width="35%" valign="middle" height="100%"
								align="left">
								<textarea id="ifFormField" class="input-100" value=""
									onclick="setifCondition(this);" rows="5" cols="25"
									readonly="true" name="ifFormField"><%=ifCondition %></textarea>
							</td>
							<td class="padding_t_5" width="8%" valign="top" height="100%"
								align="right">
								<span class="font_size12 padding_r_5"></span>
							</td>
							<td class=" padding_t_5" width="43%" valign="middle" align="left">
								<label>
									<input name="genre_<%=i %>" type="radio" value="0" onclick="to_change2('genre_<%=i %>','isRequired_<%=i %>');" <%=(genre==0?"checked":"")%>/>
									浏览
								</label>
								<label>
									<input name="genre_<%=i %>" type="radio" value="1" onclick="to_change2('genre_<%=i %>','isRequired_<%=i %>');" <%=(genre==1?"checked":"")%>/>
									编辑
								</label>
								<label>
									<input name="genre_<%=i %>" type="radio" value="2" onclick="to_change2('genre_<%=i %>','isRequired_<%=i %>');" <%=(genre==2?"checked":"")%>/>
									隐藏
								</label>
								<label>
								<input type="checkbox" name="isRequired_<%=i %>" id="isRequired_<%=i %>" <%=(isRequired==true?"checked":"")%>/> 
								必填
								</label>
							</td>
						</tr>
						<%
							i++;
						}
						}else { %>
						<tr>
							<td class=" padding_t_5 padding_r_5" width="8%" valign="top"
								height="100%" align="right">
								<span id="add" class="ico16 oprate_plus_16 right"
									onclick="addRow(this)";></span>
								<br />
								<br />
								<span id="del" class="ico16 oprate_reduce_16 right"
									onclick="delRow(this.parentNode.parentNode);"></span>
							</td>
							<td class="padding_t_5" width="6%" valign="top" height="100%"
								align="right">
								<span class="font_size12 padding_r_5">条件</span>
							</td>
							<td class="padding_t_5" width="35%" valign="middle" height="100%"
								align="left">
								<textarea id="ifFormField" class="input-100"
									onclick="setifCondition(this);" rows="5" cols="25"
									readonly="true" name="ifFormField"></textarea>
							</td>
							<td class="padding_t_5" width="8%" valign="top" height="100%"
								align="right">
								<span class="font_size12 padding_r_5"> </span>
							</td>
							<td class=" padding_t_5" width="43%" valign="middle" align="left">
								<label>
									<input name="genre_0" type="radio" value="0" checked="checked"	onclick="to_change(this);"/>
									浏览
								</label>
								<label>
									<input name="genre_0" type="radio" value="1" onclick="to_change(this);"/>
									编辑
								</label>
								<label>
									<input name="genre_0" type="radio" value="2" onclick="to_change(this);"/>
									隐藏
								</label>
								<label>
								<input type="checkbox" name="isRequired_0" id="isRequired_0"> 
								必填
								</label>
							</td>
						</tr>
						<%}%>
						<tr id="elseTr">

						</tr>
					</tbody>
				</table>
				<a id="abandon" class="common_button common_button_gray"
					href="javascript:void(0)" style="margin-left: 30px"
					onclick=
	reset();;
>重置</a>
			</div>
		</div>
		<div id="footer" align="center" style="margin-left: 0px;">
			<table style="width: 100%; height: 100%" id="ft">
				<tr>
					<td align="right">
						<input name="submit2" type="submit" id="butt1"
							onClick=
	evalValue();;
value="确认" />
						&nbsp;
					</td>
					<td align="left">
						&nbsp;
						<input name="butt1" type="button" id="butt2"
							onClick=
	closeWindow();;
value="取消" />
					</td>
				</tr>
			</table>
		</div>
		<script>
	//设置 if 条件
	isc.Window.create( {
		ID : "Mcondition",
		id : "condition",
		name : "condition",
		autoCenter : true,
		position : "absolute",
		height : "90%",
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
	Mcondition.hide();
</script>
		<script>
	//设置结果
	isc.Window.create( {
		ID : "Mresult",
		id : "result",
		name : "result",
		autoCenter : true,
		position : "absolute",
		height : "90%",
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
<script type="text/javascript">
function loadJS(){
var radios=document.getElementsByTagName("input");
for(var i=0;i<radios.length;i++){
var radioElement = radios[i];
        var type =radioElement.type;
        if("radio"==type){


var radioId = radioElement.name;
var xiahua = radioId.substring(6,radioId.length);
var isRequiredId = "isRequired_"+xiahua;
	if(radioElement.checked==true){
		if(radioElement.value=='0'||radioElement.value=='2'){//浏览
			//必填不可编辑
			var checkbox = document.getElementById(isRequiredId);
			checkbox.disabled = true;
			checkbox.checked = false;
				}else if(radioElement.value=='1'){//编辑
				//必填可以编辑
				var checkbox = document.getElementById(isRequiredId);
			checkbox.disabled = false;
				}
			}
			}
			
}
}
function to_change2(genreId,isRequiredId){
		var obj  = document.getElementsByName(genreId);
		for(var i=0;i<obj.length;i++){
			if(obj[i].checked==true){
				if(obj[i].value=='0'||obj[i].value=='2'){//浏览
			//必填不可编辑
			var checkbox = document.getElementById(isRequiredId);
			checkbox.disabled = true;
			checkbox.checked = false;
				}else if(obj[i].value=='1'){//编辑
				//必填可以编辑
				var checkbox = document.getElementById(isRequiredId);
			checkbox.disabled = false;
				}
			}
		}
	}
function to_change(data){
		var obj  = document.getElementsByName(data.name);
		var sign=data.name.split("_");
		for(var i=0;i<obj.length;i++){
			if(obj[i].checked==true){
				if(obj[i].value=='0'||obj[i].value=='2'){//浏览
			//必填不可编辑
			var checkbox = document.getElementById('isRequired_'+sign[1]);
			checkbox.disabled = true;
			checkbox.checked = false;
				}else if(obj[i].value=='1'){//编辑
				//必填可以编辑
				var checkbox = document.getElementById('isRequired_'+sign[1]);
			checkbox.disabled = false;
				}
			}
		}
	}
		 var i=<%=request.getAttribute("num")%>;
		function addRow(element){  //添加一行
			i++;
			var tr = element.parentNode.parentNode;
			var index = tr.rowIndex;
			var tb = document.getElementById('setArea');
			var newTr = tb.insertRow(index+1);
			var newTd1 = newTr.insertCell();
			newTd1.innerHTML = "<td class=\" padding_t_5 padding_r_5\" width=\"6%\" valign=\"top\" height=\"100%\" align=\"right\"> <span id=\"add\" class=\"ico16 oprate_plus_16 right\" onclick=\"addRow(this);\"></span><br/><br/><span id=\"del\" class=\"ico16 oprate_reduce_16 right\" onclick=\"delRow(this.parentNode.parentNode);\"></span></td>";
			var newTd2 = newTr.insertCell();
			newTd2.innerHTML = "<td class=\"padding_t_5\" width=\"8%\" valign=\"top\" height=\"100%\" align=\"right\"><span class=\"font_size12 padding_r_5 right\">条件</span></td>";	
			var newTd3 = newTr.insertCell();
			newTd3.innerHTML = "<td class=\"padding_t_5\" width=\"35%\" valign=\"middle\" height=\"100%\" align=\"left\"><textarea id=\"ifFormField\" class=\"input-100\" onclick=\"setifCondition(this)\" rows=\"5\" cols=\"25\" readonly=\"true\" name=\"ifFormField\"></textarea></td>";
			var newTd4 = newTr.insertCell();
			newTd4.innerHTML = "<td class=\"padding_t_5\" width=\"8%\" valign=\"top\" height=\"100%\" align=\"right\"><span class=\"font_size12 padding_r_5 right\"></span></td>";
			var newTd5 = newTr.insertCell();
			newTd5.innerHTML = "<td class=\"padding_t_5\" width=\"43%\" valign=\"middle\" align=\"left\"><label><input name=\"genre_"+i+"\" type=\"radio\" value=\"0\" checked onclick=\"to_change(this);\"/>浏览</label><label><input name=\"genre_"+i+"\" type=\"radio\" value=\"1\" onclick=\"to_change(this);\"/>编辑</label><label><input name=\"genre_"+i+"\" type=\"radio\" value=\"2\" onclick=\"to_change(this);\"/>隐藏</label><label><input type=\"checkbox\" name=\"isRequired_"+i+"\" id=\"isRequired_"+i+"\" disabled>必填</label></td>";
			
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
			Mcondition.initSrc = "<%=request.getContextPath()%>/security/formSecurity_loadConditionSet.action?formUuid=<%=request.getParameter("formUuid")%>&condition="+encodeURI(element.value);
			Mcondition.Src = "<%=request.getContextPath()%>/security/formSecurity_loadConditionSet.action?formUuid=<%=request.getParameter("formUuid")%>&condition="+encodeURI(element.value);
			Matrix.showWindow("condition");
		}
		function onconditionClose(result){
			if(result!=null){
				var data = eval("("+result+")");
				element.value = data.conditionText;
			}else if(typeof(result)=='undefined'){
				
			}else{
				element.value =null;
			}
		}
		function setResult(obj){
			element = obj;
			Mresult.initSrc = "<%=request.getContextPath()%>/formula/formula_loadNormalSet.action?formType=mainForm&isResult=1&flag=${param.flag}&content="+element.value;
			Mresult.Src = "<%=request.getContextPath()%>/formula/formula_loadNormalSet.action?formType=mainForm&isResult=1&flag=${param.flag}&content="+element.value;
			Matrix.showWindow("result");
		}
		function onresultClose(data){
			if(data!=null){
				element.value = data.value;
			}else{
				element.value =null;
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
			var inputs = document.getElementsByTagName("input");
			for(var i=0;i<inputs.length;i++){
				 var obj = inputs[i];
  				if(obj.type=='checkbox'){
     				obj.checked = false;
 				 }
 				 if(obj.type=='radio'){
     				if(obj.value=='0')
     				 obj.checked=true;
 				 }
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
			var checkboxs=[];
			var radios=[];
			var inputs = document.getElementsByTagName("input");
			for(var i=0;i<inputs.length;i++){
				 var obj = inputs[i];
  				if(obj.type=='checkbox'){
     				checkboxs.push(obj);
 				 }
 				 if(obj.type=='radio'){
     				radios.push(obj);
 				 }
			}
			var str = "{";
			for(var i=0; i<textAreas.length; i++){
				var content = textAreas[i].value;
				var genre="";
				//var isRequired=checkboxs[i].value;//按checkbox的顺序号查找
				for (n=i*3; n<i*3+3; n++) {  
       			 if (radios[n].checked) {  
          			 genre=radios[n].value 
       			 }  
    			}  
    			if(1 == textAreas.length&&(content==""||content==null)){
    				Matrix.closeWindow(true);
    				return;
    			}
				if(i == textAreas.length-1){ //最后一个 textArea 
					if(content==""||content==null){
						alert("存在未设置的条件，请设置");
						return;
					}
						str += '"ifCondition_'+i+'":"'+content+'"';
						str += ',';
						str += '"genre_'+i+'":"'+genre+'"';
						str += ',';
					str += '"isRequired_'+i+'":'
					if(checkboxs[i].checked){
					str+=true;
					}else{
					str+=false;
					}
					str+='}';
				}else{
					if(content==""||content==null){
					alert("存在未设置的条件，请设置");
					return;
					}
						str += '"ifCondition_'+i+'":"'+content+'"';
						str += ',';
						str += '"genre_'+i+'":"'+genre+'"';
						str += ',';
						str += '"isRequired_'+i+'":'
				if(checkboxs[i].checked){
					str+=true;
					}else{
					str+=false;
					}
					str+=',';
					}
				
			}
				var url = "<%=request.getContextPath()%>/security/formSecurity_outToIn2.action?formUuid=${param.formUuid}";
 		  		var jsonStr = '{"condition":'+str+'}';
 		  		var synJson = isc.JSON.decode(jsonStr);
	Matrix.sendRequest(url, synJson, function(result) {
			if (result != null) {
				var data = eval("(" + result.data + ")");
				Matrix.closeWindow(data);
			}
		});
		document.getElementById("advancedSetStr").value = str;
	}
</script>
	</body>
</html>
