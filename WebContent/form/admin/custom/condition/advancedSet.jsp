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
	<title>计算公式高级设置页面</title>
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
			height: calc(100% - 94px);
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
						layer.confirm("切换会使计算式丢失,是否继续？", {
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
			newTd2.innerHTML = "<td><label>如果&nbsp;&nbsp;</label></td>";	
			newTd2.vAlign = "top";
			newTd2.align = "right";
			newTd2.style = "width: 60px;"
			var newTd3 = newTr.insertCell();
			newTd3.innerHTML = "<td><textarea id=\"ifFormField\" name=\"ifFormField\" class=\"form-control\" style=\"height: 120px;\" onclick=\"setifCondition(this)\" readonly=\"true\"></textarea></td>";
			newTd3.vAlign = "top";
			newTd3.align = "right";
			var newTd4 = newTr.insertCell();
			newTd4.innerHTML = "<td><label>则为&nbsp;&nbsp</label></td>";
			newTd4.vAlign = "top";
			newTd4.align = "right";
			newTd4.style = "width: 70px;"
			var newTd5 = newTr.insertCell();
			newTd5.innerHTML = "<td><textarea id=\"resultFormField\" name=\"resultFormField\" class=\"form-control\" style=\"height: 120px;\" onclick=\"setResult(this)\" readonly=\"true\"></textarea></td>";
			newTd5.vAlign = "top";
			newTd5.align = "right";
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
		//如果-弹出条件窗口
		function setifCondition(obj){
		   element = obj;
		   layer.open({
		    	id:'condition',
				type : 2,
				
				title : ['计算条件设置'],
				shadeClose: false, 
				area : [ '100%', '98%' ],
				content : "<%=request.getContextPath()%>/condition/condition_loadConditionSet.action?iframewindowid=condition&formType=mainForm&flag=${param.flag}&entrance=IfFormula&firstCondition="+encodeURI(element.value)
		    });
		}
		
		function onconditionClose(data){
			if(data!=null){
				element.value = data.conditionText;
			}
		}
		
		//则为 否则为-结果条件弹出窗口
		function setResult(obj){
			element = obj;
			 layer.open({
		    	id:'result',
				type : 2,
				
				title : ['计算条件设置'],
				shadeClose: false, 
				area : [ '100%', '98%' ],
				content : "<%=request.getContextPath()%>/condition/condition_loadConditionSet.action?iframewindowid=result&formType=mainForm&isResult=1&flag=${param.flag}&entrance=ResultFormula&firstCondition="+encodeURI(element.value)
			});
		}
		
		function onresultClose(data){
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
				var tr = tb.rows[0];
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
			var str = "{";
			var m = 0;
			var n = 0;
			for(var i=1; i<textAreas.length; i++){
				var content = textAreas[i].value.trim();
				if(content==""){
					Matrix.warn("存在未设置的条件，请设置");
					return;
				}
				if(i == textAreas.length-1){ //最后一个 textArea 为 elseResult
					str += "\"elseResult\":\""+content+"\"}";
				}else{
					if(i%2 == 0){
						str += "\"ifResult_"+n+"\":\""+content+"\"";
						str += ",";
						n++;
					}else{
						str += "\"ifCondition_"+m+"\":\""+content+"\"";
						str += ",";
						m++;
					}
				}
			}
			
			var synJson = {"condition": str};
			var url = "<%=request.getContextPath()%>/trigger/conditionTrans_outToIn2.action"; 
			Matrix.sendRequest(url,synJson,function(data){
	  			if(data.data){
					var result = eval('(' + data.data + ')');	
					
					var suffixId = $("#suffixId").val();
					var index = $("#index").val();
					result.setType = 1;	  //setType 为设置类型，1：高级设置，0：普通设置
					result.suffixId = suffixId;
					result.index = index;
					
					Matrix.closeWindow(result);
				}
	  		});
			document.getElementById("advancedSetStr").value = str;
		}
	</script>
</head>
<body>
	<input id="iframewindowid" name="iframewindowid" type="hidden" value="${param.iframewindowid}"/>  <!-- 弹出窗口编码 -->
	<!-- 高级设置条件编码
	<input name="advancedSetStr" id="advancedSetStr" type="hidden" />
	 -->         
	<input id="suffixId" name="suffixId" type="hidden" value="${param.suffixId}"/>  <!-- 计算普通和高级设置时记录的选中行字段编码 -->
  	<input id="index" name="index" type="hidden" value="${param.index}"/>  <!-- 计算普通和高级设置时记录的table选中行索引 -->
	
	<div id="container">
		<div id="head">
			<input id="nomalSet" name="modelSet" type="radio" value="1" class="box"><label style="vertical-align: -webkit-baseline-middle;margin-right:10px;margin-bottom: 5px;font-weight: 700;">普通设置</label>
			<input id="advancedSet" name="modelSet" type="radio" value="2" class="box" checked="checked"/><label style="vertical-align: -webkit-baseline-middle;margin-bottom: 5px;font-weight: 700;">高级设置</label>
			<textarea id="advancedSetStr" name="advancedSetStr" cols="20" style="display: none;" ></textarea>
		</div>
		<div id="content">
			<div style="width: 100%;">
				<table id="setArea" style="height: 100%;width: 100%;" >
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
							<td valign="top" align="right" style="width: 20px">
								<span id="add" class="ico16 oprate_plus_16 right" onclick="addRow(this);"></span>
								<br>
								<br>
								<span id="del" class="ico16 oprate_reduce_16 right" onclick="delRow(this.parentNode.parentNode);"></span>
							</td>
							<td valign="top" align="right" style="width: 60px">
								<label>如果&nbsp;&nbsp;</label>
							</td>
							<td valign="top" align="right">
								<textarea id="ifFormField" name="ifFormField" class="form-control" style="height: 120px;" onclick="setifCondition(this)" readonly="true"><%=ifCondition %></textarea>
							</td>
							<td valign="top" align="right" style="width: 70px">
								<label>则为&nbsp;&nbsp;</label>
							</td>
							<td valign="top" align="right">
								<textarea id="resultFormField" name="resultFormField" class="form-control" style="height: 120px;" onclick="setResult(this)" readonly="true"><%=ifResult %></textarea>
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
							<td valign="top" align="right" style="width: 60px">
								<label>如果&nbsp;&nbsp;</label>
							</td>
							<td valign="top" align="right">
								<textarea id="ifFormField" name="ifFormField" class="form-control" style="height: 120px;" onclick="setifCondition(this)" readonly="true"></textarea>
							</td>
							<td valign="top" align="right" style="width: 70px">
								<label>则为&nbsp;&nbsp;</label>
							</td>
							<td valign="top" align="right">
								<textarea id="resultFormField" name="resultFormField" class="form-control" style="height: 120px;" onclick="setResult(this)" readonly="true"></textarea>
							</td>
						</tr>
						<%}%>
						<tr id="elseTr">
							<td valign="top" align="right"></td>
							<td valign="top" align="right"></td>
							<td valign="top" align="right"></td>
							<td valign="top" align="right">
								<label>否则为&nbsp;&nbsp;</label>
							</td>
							<td valign="top" align="right">
								<textarea id="resultFormField" name="resultFormField" class="form-control" style="height: 120px;" onclick="setResult(this)" readonly="true"><%=elseResult==null?"": elseResult%></textarea>
							</td>
						</tr>
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
