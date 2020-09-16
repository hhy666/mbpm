<%@page  import="java.util.*" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="this is my page">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <link href="<%=path %>/resource/html5/css/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet"></link>
    <script src="<%=path %>/resource/html5/js/jquery.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/html5/js/jquery.min.js"></script>
	<script SRC="<%=path %>/resource/html5/css/bootstrap/dist/js/bootstrap.min.js"></script>
    <jsp:include page="/foundation/common/taglib.jsp" />
	<jsp:include page="/foundation/common/resource.jsp" />
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resource/css/formulaset.css"/>
	<script type="text/javascript">
		window.onload = function(){
			document.getElementById("formulaStr").value="${msgContent}";
		}
		function changeClass(element){
			var lis = document.getElementsByTagName("li");
			var i = 0;
			for(;i < lis.length; i++){
				lis[i].className = "";
			}
			var li = element.parentNode;
			li.className="current";
			
			var selects = document.getElementsByTagName("select");
			var j = 0;
			for(;j < selects.length; j++){
				selects[j].style.display = 'none';
			}
			if(li.id == 'field_li'){
				document.getElementById('fieldSelect').style.display='';
			}
			if(li.id == 'org_li'){
				document.getElementById('orgSelect').style.display='';
			}
			if(li.id == 'date_li'){
				document.getElementById('dateSelect').style.display='';
			}
			if(li.id == 'system_li'){
				document.getElementById('systemSelect').style.display='';
			}
		}
		function dblClickField(selection){
			
			var value ;
			if(selection.type == 'select-multiple'){
				var index =  selection.selectedIndex;
				value = selection.options[index].text;
				value = "{" + value + "}";
			}else if(selection.type == 'select-one'){
				var index =  selection.selectedIndex;
				value = selection.options[index].text;
				value = "[" + value + "]";
			}else{
				value = " " + selection.value + " ";

			}
		  	var obj = document.getElementById("formulaStr");
		  	if(document.selection){
		  		var sel = document.selection.createRange(); 
		  		sel.text = value; 
		  	}else if(typeof obj.selectionStart === 'number' && typeof obj.selectionEnd === 'number'){
		  		var startPos = obj.selectionStart, 
					endPos = obj.selectionEnd, 
					cursorPos = startPos, 
					tmpStr = obj.value; 
		  		obj.value = tmpStr.substring(0, startPos) + value + tmpStr.substring(endPos, tmpStr.length); 
		  		cursorPos += value.length; 
		  		obj.selectionStart = obj.selectionEnd = cursorPos; 
		  	}else{
		  		obj.value += value; 
		  	}
		  	obj.focus();
		  }
		  
		  function clearTextArae(){
		  	var obj = document.getElementById("formulaStr");
		  	obj.value = "";
		  }
		  
		  function closeWindow(){
		  	Matrix.closeWindow();
		  }
		  
		  
		  function evalValue(){
		  	var msgContent = document.getElementById('formulaStr').value;
		  	var url = "<%=request.getContextPath()%>/trigger/conditionTrans_textToValue.action";
			var param = "{'msgContent':'"+msgContent+"'}";
			var synJson = isc.JSON.decode(param);
			Matrix.sendRequest(url,synJson,function(data){
				var result = data.data;
				Matrix.closeWindow(result);
			});
		  }
	</script>
  </head>
  
  <body>
  	<input id="type" name="type" type="hidden"/> <!-- 区分是取年 还是取日 还是取月 -->
  	<input id="including" name="including" type="hidden"/> <!-- 区分是包含还是不包含 -->
    <div style="width: 100%; height: 90%;margin-top:8px;" class="font_size12" align="center">
			<div id="modelSet" style="height: 100%;">
				<div id="model1" style="display: ''">
					<form id="formulaForm">
						<div style="width: 95%; height: 90px;">
						   <textarea id="formulaStr" name="formulaStr"
								class="form-control" style="height:100px;resize:none;"></textarea>
						</div>
						<div style="width: 95%; height: 30px; margin-top: 20px;">
							<div style="float: left; margin-left: 5px;height:35px;">
								双击选中数据域到公式框
							</div>
							<div style="float: right;">
								<a id="btnreset" class="common_button common_button_gray"
									href="javascript:void(0);" onclick="clearTextArae()">重置</a>
								<a id="helpbutton" class="common_button common_button_gray"
									href="javascript:void(0);" onclick="">帮助</a>
							</div>
						</div>

						<div style="width:100%;height:calc(100% - 130px);margin-top: 5px;">
							<div style="width: 100%;float: left;"
							   id="dataDiv">
								<div id="tabs" style="width: 99%; ">
									<div id="tabs_head" class="common_tabs clearfix"
										style="width: 99%;">
										<ul class="left" style="float:left">
											<li id="field_li" class="current">
												<a class="last_tab" onclick="changeClass(this)"
													href="javascript:void(0)"> <span title="表单数据域">
														表单数据域 </span> </a>
											</li>
											<li id="org_li" class="">
												<a class="last_tab" onclick="changeClass(this)"
													href="javascript:void(0)"> <span title="组织机构变量">
														组织机构变量</span> </a>
											</li>
											<li id="date_li" class="">
												<a class="last_tab" onclick="changeClass(this)"
													href="javascript:void(0)"> <span title="日期变量">
														日期变量 </span> </a>
											</li>
										</ul>
									</div>
									<div id="tabs_body" class="common_tabs_body"
										style="width: 99%;">
										<div id="field_div" class="show" style="height:95%;">
										<%
										List list = (List)request.getAttribute("entVal");
										int count = list.size();
										 %>
											<select id="fieldSelect" class="w100b"
												ondblclick="dblClickField(this)" style="height:80%;display:'';"
												name="fieldSelect" multiple="multiple" size="<%=count%>">
												<c:forEach var="text" items="${entVal}">
													<option value="${text }">${text }</option>
												</c:forEach>
											</select>
											
											<select id="orgSelect" class="w100b" ondblclick="dblClickField(this)" size="15" name="orgSelect" style="display:none;">
												<c:forEach var="orgVar" items="${orgVars}">
													<option value="${orgVar}">${orgVar}</option>
												</c:forEach>
											</select>
										
											<select id="dateSelect" class="w100b" ondblclick="dblClickField(this)" size="15" name="dateSelect" style="display:none;">											
												<c:forEach var="dateVar" items="${dateVars}">
													<option value="${dateVar}">${dateVar}</option>
												</c:forEach>																	
											</select>	
										</div>
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
		<div id="footer" align="center" style="margin-left:0px;">
			<table style="width:100%;height:100%">
			   <tr style="text-align:center;">
			  	 <td>
			  		<button class="x-btn ok-btn " type="button" name="submit2" id="butt1" onClick="evalValue();">确认</button>
			    	<button class="x-btn cancel-btn " type="button" name="butt1" id="butt2" onClick="closeWindow();">取消</button>
				 </td>
			   </tr>
			</table>
		</div>
  </body>
</html>
