<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="com.matrix.form.admin.custom.validation.model.Validation"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%> 
<%@page import="java.util.List"%>
<%@page import="com.matrix.form.admin.custom.formula.model.IfModel"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>联合校验设置页面</title>
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
			//监听普通设置,切换到普通设置模式
			$("input:radio[name='modelSet']").on('ifChecked', function(event){
				var value = $(this).val();  //1.普通设置。2.高级设置。
				var iframewindowid = $("#iframewindowid").val();
				var suffixId = $("#suffixId").val();
				var index = $("#index").val();
			    if(value == 1){
			    	var textAreas = document.getElementsByTagName("textarea");
					var tflag = false;
					var content = "";
					var setType = 0;
					for(var i=1; i<textAreas.length; i++){
						if(textAreas[i].value != ""){
							tflag = true;
							break;
						}
					}
					if(tflag){
						layer.confirm("切换会使计算式丢失,是否继续？？", {
		 				     btn: ['确定','取消'],  //按钮
		 				     closeBtn:0
		 		         },function(winId){
		 		        	 window.location.href = "<%=request.getContextPath()%>/condition/condition_loadConditionSet.action?iframewindowid="+iframewindowid+"&setType=0&flag=${param.flag}&entrance=GeneralFormula&suffixId="+suffixId+"&index="+index+"";        	
		 		         },function(winId){
		 		        	  $("#nomalSet").iCheck('uncheck');
		 		        	  $("#advancedSet").iCheck('check');      	
		 		         })
					}else{
						window.location.href = "<%=request.getContextPath()%>/condition/condition_loadConditionSet.action?iframewindowid="+iframewindowid+"&setType=0&flag=${param.flag}&entrance=GeneralFormula&suffixId="+suffixId+"&index="+index+"";
					}
			    }	     
			});		
		})
		
		//添加一行
		function addRow(element){  
			var tr = element.parentNode.parentNode;
			var index = tr.rowIndex;
			var tb = document.getElementById('setArea');
			var newTr = tb.insertRow(index+1);
			var newTd1 = newTr.insertCell();
			newTd1.innerHTML = "<td><span id=\"add\" class=\"ico16 oprate_plus_16 right\" onclick=\"addRow(this);\"></span><br><br><span id=\"del\" class=\"ico16 oprate_reduce_16 right\" onclick=\"delRow(this.parentNode.parentNode);\"></span></td>";
			newTd1.vAlign = "top";
			newTd1.align = "right";
			newTd1.style = "width: 20px;"
			var newTd2 = newTr.insertCell();
			newTd2.innerHTML = "<td></td>";	
			newTd2.vAlign = "top";
			newTd2.align = "right";
			newTd2.style = "width: 2px;"
			var newTd3 = newTr.insertCell();
			newTd3.innerHTML = "<td><textarea id=\"adValidation\" name=\"adValidation\" class=\"form-control\" style=\"height: 120px;\" onclick=\"openJointValidation(this)\" readonly=\"true\"></textarea></td>";
			newTd3.vAlign = "top";
			newTd3.align = "right";
			newTd3.style = "width: 60%;";
			var newTd4 = newTr.insertCell();
			newTd4.innerHTML = "<td></td>";
			newTd4.vAlign = "top";
			newTd4.align = "right";
			newTd4.style = "width: 30px;"
			var newTd5 = newTr.insertCell();
			newTd5.innerHTML = "<td><textarea id=\"validAlert\" name=\"validAlert\" class=\"form-control\" style=\"height: 120px;\"></textarea></td>";
			newTd5.vAlign = "top";
			newTd5.align = "right";
		}
		
		//删除一行
		function delRow(element){  
			var tr = element;
			var index = tr.rowIndex;
			var tb = document.getElementById('setArea');	
			if(tb.rows.length > 2){
				tb.deleteRow(index);
			}
		}
		
		var element = {};
		//校验条件-弹出条件窗口
		function openJointValidation(obj){
		   element = obj;
		   var adValidation = element.value;
		   layer.open({
		    	id:'validation',
				type : 2,
				
				title : ['设置条件'],
				shade: [0.1, '#000'],
				shadeClose: false, //开启遮罩关闭
				area : [ '100%', '98%' ],
				content : "<%=request.getContextPath() %>/condition/condition_loadConditionSet.action?iframewindowid=validation&entrance=FormJointValidation&firstCondition="+encodeURI(adValidation)+""
		   });			
		}
		
		function onvalidationClose(data){
			if(data!=null){
				element.value = data.conditionText;
			}
		}
	
		//重置
		function reset(){ 
			var tb = document.getElementById("setArea");
			var rowNum = tb.rows.length;
			var i = 0;
			while(i<rowNum-2){
				var tr = tb.rows[1];
				delRow(tr);
				i++;
			}
			var textAreas = document.getElementsByTagName("textarea");
			for(var j=1; j<textAreas.length; j++){
				textAreas[j].value = "";
			}
		}
		
		//关闭
		function cancel(){
	  	    Matrix.closeWindow();
	  	}
		
		//点击确认
		function evalValue(){ 
			debugger;
			var textAreas = document.getElementsByTagName("textarea");
			
			var flag = false;
			if(textAreas.length == 2){   //只有一行且没有填写时可点击确认
				for(var i=0; i<textAreas.length; i=i+2){
					var adValidation = textAreas[i].value.trim();
					var validAlert = textAreas[i+1].value.trim();
					
					if(adValidation == "" && validAlert==""){
						flag = true;
					}
				}
			}
			var str = '[';
			if(flag){
				str = str + '{';
				str = str + '"adValidation":"",';
			 	str = str + '"validAlert":""';
			 	str = str + '}';
			}else{
				for(var i=0; i<textAreas.length; i=i+2){
					var adValidation = textAreas[i].value.trim();
					if(adValidation == ""){
						Matrix.warn("存在未设置的校验条件，请设置");
						return;
					}
					var validAlert = textAreas[i+1].value.trim();
					if(validAlert==""){
						Matrix.warn("存在未设置的校验失败信息，请设置");
						return;
					}
					
					str = str + '{';
				 	str = str + '"adValidation":"'+adValidation+'",';
				 	str = str + '"validAlert":"'+validAlert+'"';
				 	str = str + '},';
				}
				str = str.substring(0,str.length-1);
			}
			str = str + ']';
			
			var data = {};
			data.validationValue = str;
			Matrix.closeWindow(data);
		}
	</script>
</head>
<body>
	<input id="iframewindowid" name="iframewindowid" type="hidden" value="${param.iframewindowid}"/>  <!-- 弹出窗口编码 -->       
	<div id="container">
		<div id="content">
			<div style="width: 100%;">
				<table id="setArea" style="height: 100%;width: 100%;" >
					<tbody>		
						<tr>
							<td valign="top" align="right" style="width: 20px;height: 20px;padding-top: 0px;"></td>
							<td valign="top" align="right" style="width: 20px;height: 20px;padding-top: 0px;"></td>
							<td valign="top" align="center" style="height: 20px;padding-top: 0px;">
								<label style="color: rgb(22, 105, 171);font-weight: bold;">校验条件</label>
							</td>
							<td valign="top" align="right" style="width: 30px;height: 20px;padding-top: 0px;"></td>
							<td valign="top" align="center" style="height: 20px;padding-top: 0px;">
								<label style="color: rgb(22, 105, 171);font-weight: bold;">校验失败信息</label>					
							</td>
						</tr>	
						<%
							List<Validation> validations = (List<Validation>)request.getAttribute("validations");
							if(validations != null && validations.size() > 0){
								for(Validation validation : validations){
									String adValidation = validation.getAdValidation();  //校验条件
									String validAlert = validation.getValidAlert();   //校验提示信息				
						%>	
						<tr>
							<td valign="top" align="right" style="width: 20px">
								<span id="add" class="ico16 oprate_plus_16 right" onclick="addRow(this);"></span>
								<br>
								<br>
								<span id="del" class="ico16 oprate_reduce_16 right" onclick="delRow(this.parentNode.parentNode);"></span>
							</td>
							<td valign="top" align="right" style="width: 20px">
								
							</td>
							<td valign="top" align="right" style="width: 60%">
								<textarea id="adValidation" name="adValidation" class="form-control" style="height: 120px;" onclick="openJointValidation(this)" readonly="true"><%=adValidation %></textarea>
							</td>
							<td valign="top" align="right" style="width: 30px">
								
							</td>
							<td valign="top" align="right">
								<textarea id="validAlert" name="validAlert" class="form-control" style="height: 120px;"><%=validAlert %></textarea>
							</td>
						</tr>
						<%}
						}else { %>	
						<tr>
							<td valign="top" align="right" style="width: 20px">
								<span id="add" class="ico16 oprate_plus_16 right" onclick="addRow(this);"></span>
								<br>
								<br>
								<span id="del" class="ico16 oprate_reduce_16 right" onclick="delRow(this.parentNode.parentNode);"></span>
							</td>
							<td valign="top" align="right" style="width: 20px">
								
							</td>
							<td valign="top" align="right" style="width: 60%">
								<textarea id="adValidation" name="adValidation" class="form-control" style="height: 120px;" onclick="openJointValidation(this)" readonly="true"></textarea>
							</td>
							<td valign="top" align="right" style="width: 30px">
								
							</td>
							<td valign="top" align="right">
								<textarea id="validAlert" name="validAlert" class="form-control" style="height: 120px;"></textarea>
							</td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>
			</div>
		</div>
		<div class="cmdLayout">
			<div class="x-btn ok-btn" onclick="evalValue();">
				<span>确定</span>
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
