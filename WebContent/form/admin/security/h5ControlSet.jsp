<%@page import="com.matrix.form.admin.security.model.FormSecurityOperateSet"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%> 
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>数据权限设置高级条件页面</title>
	<%@ include file="/form/html5/admin/html5Head.jsp"%>
	<style type="text/css">
		body{
	    	margin: 0;
		    padding: 0;
		    color: #333;
		    font-family: "Helvetica Neue", "PingFang SC", "Hiragino Sans GB", "Microsoft YaHei", 微软雅黑, Arial, sans-serif;
		    font-size: 12px;
		}
		div{
			box-sizing: border-box;
			-webkit-user-select: none;
		    -khtml-user-select: none;
		    -moz-user-select: none;
		    -ms-user-select: none;
		    -o-user-select: none;
		    user-select: none;
		}
		td{
			height: 140px;
			padding-top: 10px;
		}
		textarea{
			resize: none;
		}
		#container{
		    position: absolute;
		    height: 100%;
		    width: 100%;
		    padding: 10px 10px 0px 10px;
		}
		#head{
			height: 30px;
		}
		#content{
			position: absolute;
			height: calc(100% - 64px);
			width: calc(100% - 20px);
			border: 1px solid #cccccc;
			border-bottom: 0px;
			padding: 10px 10px 0px 10px;
			overflow: auto
		}
		.ico16 {
			background: rgba(0, 0, 0, 0) url("<%=path %>/resource/images/icon16.png") no-repeat scroll 0 0;
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
	</style>
	<script type="text/javascript">
	$(function(){
		var radios=document.getElementsByTagName("input");
		for(var i=0;i<radios.length;i++){
			var radioElement = radios[i];
			var type =radioElement.type;
			if("radio"==type){
				var radioId = radioElement.name;
				var xiahua = radioId.substring(6,radioId.length);
				var isRequiredId = "isRequired_"+xiahua;
				if(radioElement.checked==true){
					if(radioElement.value=='0'||radioElement.value=='2'){//浏览  隐藏
						//必填不可编辑
						var checkbox = document.getElementById(isRequiredId);
						$(checkbox).iCheck('disable');
						$(checkbox).iCheck('uncheck');
					}else if(radioElement.value=='1'){//编辑
						//必填可以编辑
						var checkbox = document.getElementById(isRequiredId);
						$(checkbox).iCheck('enable');
					}
				}
			}	
		}
		changeStatus();
	})
	
	function changeStatus(){
		//监听单选按钮组选中事件
		$("input:radio[name^='genre_']").on('ifChecked', function(event){
			debugger;
			var value = $(this).val();
			var radioId = $(this)[0].name;
			var xiahua = radioId.substring(6,radioId.length);
			var isRequiredId = "isRequired_"+xiahua;
			var checkbox = document.getElementById(isRequiredId);
			if(value=='0' || value=='2'){
				$(checkbox).iCheck('disable');
				$(checkbox).iCheck('uncheck');
			}else if(value=='1'){
				$(checkbox).iCheck('enable');
			}
		});
	}
	
	
	var i=<%=request.getAttribute("num")%>;
	//添加一行
	function addRow(element){  
		i++;
		var tr = element.parentNode.parentNode;
		var index = tr.rowIndex;
		var tb = document.getElementById('setArea');
		var newTr = tb.insertRow(index+1);
		var newTd1 = newTr.insertCell();
		newTd1.innerHTML = "<td><span id=\"add\" class=\"ico16 oprate_plus_16 right\" onclick=\"addRow(this);\"></span><br/><br/><span id=\"del\" class=\"ico16 oprate_reduce_16 right\" onclick=\"delRow(this.parentNode.parentNode);\"></span></td>";
		newTd1.vAlign = "top";
		newTd1.align = "right";
		newTd1.style = "width: 20px;"
		var newTd2 = newTr.insertCell();
		newTd2.innerHTML = "<td><span class=\"font_size12 padding_r_5 right\">条件&nbsp;&nbsp;</span></td>";	
		newTd2.vAlign = "top";
		newTd2.align = "right";
		newTd2.style = "width: 60px;"
		var newTd3 = newTr.insertCell();
		newTd3.innerHTML = "<td><textarea id=\"ifFormField\" name=\"ifFormField\" class=\"form-control\" style=\"height: 120px;\" onclick=\"setifCondition(this)\" readonly=\"true\"></textarea></td>";
		newTd3.vAlign = "top";
		newTd3.align = "right";
		var newTd4 = newTr.insertCell();
		newTd4.innerHTML = "<td>"+
		"<div><input name=\"genre_"+i+"\" type=\"radio\" value=\"0\" class=\"box\" checked><label style=\"vertical-align: -webkit-baseline-middle;margin-right:10px;margin-bottom: 5px;\">浏览</label></div>"+
		"<div><input name=\"genre_"+i+"\" type=\"radio\" value=\"1\" class=\"box\"><label style=\"vertical-align: -webkit-baseline-middle;margin-right:10px;margin-bottom: 5px;\">编辑</label></div>"+
		"<div><input name=\"genre_"+i+"\" type=\"radio\" value=\"2\" class=\"box\"><label style=\"vertical-align: -webkit-baseline-middle;margin-right:10px;margin-bottom: 5px;\">隐藏</label></div>"+
		"<div><input name=\"isRequired_"+i+"\" id=\"isRequired_"+i+"\" type=\"checkbox\" class=\"box\"><label style=\"vertical-align: -webkit-baseline-middle;margin-right:10px;margin-bottom: 5px;\" disabled>必填</label></div>"+
		"</td>";
		newTd4.vAlign = "top";
		newTd4.align = "left";
		newTd4.style = "padding-left: 10px;"
		
		$("#isRequired_"+i).iCheck('disable');
		$('.box').iCheck({ 
		  labelHover : false, 
		  cursor : true, 
		  checkboxClass : 'icheckbox_square-blue', 
		  radioClass : 'iradio_square-blue', 
		  increaseArea : '20%' 
		});
		
		changeStatus();
	}
	
	//删除一行
	function delRow(element){  
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
	//弹出条件设置窗口
	function setifCondition(obj){
		element = obj;
		layer.open({
	    	id:'condition',
			type : 2,
			
			title : ['设置条件'],
			shadeClose: false, //开启遮罩关闭
			area : [ '90%', '95%' ],
			content : "<%=request.getContextPath() %>/condition/condition_loadConditionSet.action?iframewindowid=condition&entrance=OperationSet&firstCondition="+encodeURI(element.value)+""
		});			
	}
	
	//弹出条件设置窗口回调
	function onconditionClose(data){
		if(data!=null){
			element.value = data.conditionText;
		}
	}
	
	//确认
	function evalValue(){
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
       			if(radios[n].checked){  
          			genre=radios[n].value 
       			}  
   			}  
   			if(1 == textAreas.length&&(content==""||content==null)){
   				Matrix.closeWindow(true);
   				return;
   			}
			if(i == textAreas.length-1){ //最后一个 textArea 
				if(content==""||content==null){
					Matrix.warn("存在未设置的条件，请设置");
					return;
				}
				str += "\"ifCondition_"+i+"\":\""+content+"\"";
				str += ",";
				str += "\"genre_"+i+"\":\""+genre+"\"";
				str += ",";
				str += "\"isRequired_"+i+"\":"
				if(checkboxs[i].checked){
					str+=true;
				}else{
					str+=false;
				}
				str+="\}";
			}else{
				if(content==""||content==null){
					Matrix.warn("存在未设置的条件，请设置");
					return;
				}
				str += "\"ifCondition_"+i+"\":\""+content+"\"";
				str += ",";
				str += "\"genre_"+i+"\":\""+genre+"\"";
				str += ",";
				str += "\"isRequired_"+i+"\":"
				if(checkboxs[i].checked){
					str+=true;
				}else{
					str+=false;
				}
				str+=",";
			}
		}
		var url = "<%=request.getContextPath()%>/trigger/conditionTrans_outToIn2.action"; 
	  	var synJson = {"condition": str};
		Matrix.sendRequest(url, synJson, function(data) {
			if(data.data){
				var result = eval('(' + data.data + ')');	
				Matrix.closeWindow(result);
			}
	    });
	    document.getElementById("advancedSetStr").value = str;
	}
	
	//取消
	function cancel(){  
		Matrix.closeWindow();
	}
		
	//重置
	function reset(){ 
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
</script>
</head>
<body>
	<input name="iframewindowid" id="iframewindowid" type="hidden" value="<%=request.getParameter("iframewindowid") %>" />    <!-- 弹出窗口编码 -->
	<input name="advancedSetStr" id="advancedSetStr" type="hidden" />
	
  	<div id="container">
  		<div id="content">
			<div style="width: 100%;">
				<table id="setArea" style="height: 100%;width: 100%;" >
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
							<td valign="top" align="right" style="width: 20px">
								<span id="add" class="ico16 oprate_plus_16 right" onclick="addRow(this);"></span>
								<br>
								<br>
								<span id="del" class="ico16 oprate_reduce_16 right" onclick="delRow(this.parentNode.parentNode);"></span>
							</td>
							<td valign="top" align="right" style="width: 60px">
								<label>条件&nbsp;&nbsp;</label>
							</td>
							<td valign="top" align="right">	
								<textarea id="ifFormField" name="ifFormField" class="form-control" style="height: 120px;" onclick="setifCondition(this)" readonly="true"><%=ifCondition %></textarea>
							</td>
							<td valign="top" align="left" style="padding-left: 10px;">
								<div>
									<input name="genre_<%=i %>" type="radio" value="0" class="box" <%=(genre==0?"checked":"")%>><label style="vertical-align: -webkit-baseline-middle;margin-right:10px;margin-bottom: 5px;">浏览</label>
								</div>
								<div>
									<input name="genre_<%=i %>" type="radio" value="1" class="box" <%=(genre==1?"checked":"")%>/><label style="vertical-align: -webkit-baseline-middle;margin-bottom: 5px;">编辑</label>
								</div>
								<div>
									<input name="genre_<%=i %>" type="radio" value="2" class="box" <%=(genre==2?"checked":"")%>><label style="vertical-align: -webkit-baseline-middle;margin-right:10px;margin-bottom: 5px;">隐藏</label>
								</div>
								<div>
									<input name="isRequired_0" id="isRequired_0" type="checkbox" class="box" <%=(isRequired==true?"checked":"")%>><label style="vertical-align: -webkit-baseline-middle;margin-right:10px;margin-bottom: 5px;">必填</label>
								</div>
							</td>					
						</tr>
						<%
							i++;
						}
						}else{ %>
						<tr>
							<td valign="top" align="right" style="width: 20px">
								<span id="add" class="ico16 oprate_plus_16 right" onclick="addRow(this);"></span>
								<br>
								<br>
								<span id="del" class="ico16 oprate_reduce_16 right" onclick="delRow(this.parentNode.parentNode);"></span>
							</td>
							<td valign="top" align="right" style="width: 60px">
								<label>条件&nbsp;&nbsp;</label>
							</td>
							<td valign="top" align="right">
								<textarea id="ifFormField" name="ifFormField" class="form-control" style="height: 120px;" onclick="setifCondition(this)" readonly="true"></textarea>
							</td>
							<td valign="top" align="left" style="padding-left: 10px;">
								<div>
									<input name="genre_0" type="radio" value="0" class="box" checked="checked"><label style="vertical-align: -webkit-baseline-middle;margin-right:10px;margin-bottom: 5px;">浏览</label>
								</div>
								<div>
									<input name="genre_0" type="radio" value="1" class="box"/><label style="vertical-align: -webkit-baseline-middle;margin-bottom: 5px;">编辑</label>
								</div>
								<div>
									<input name="genre_0" type="radio" value="2" class="box"><label style="vertical-align: -webkit-baseline-middle;margin-right:10px;margin-bottom: 5px;">隐藏</label>
								</div>
								<div>
									<input name="isRequired_0" id="isRequired_0" type="checkbox" class="box"><label style="vertical-align: -webkit-baseline-middle;margin-right:10px;margin-bottom: 5px;">必填</label>
								</div>
							</td>
						</tr>
						<%}%>
						<tr id="elseTr">

						</tr>
					</tbody>
				</table>
			</div>
		</div>
  		<div class="cmdLayout">
			<div class="x-btn ok-btn" onclick="evalValue();">
				<span>确认</span>
			</div>
			<div class="x-btn ok-btn" onclick="reset();">
				<span>重置</span>
			</div>
			<div class="x-btn cancel-btn" onclick="cancel();">
				<span>取消</span>
			</div>
		</div>
  	</div>
  </body>
</html>
