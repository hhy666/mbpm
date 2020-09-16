<%@page pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML>
<html>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<head>
    <title>tdstyle.html</title>
	
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="this is my page">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
   
   	<link href='<%=request.getContextPath() %>/resource/html5/css/matrix_runtime.css' rel="stylesheet"></link>
	<link href='<%=request.getContextPath() %>/resource/html5/css/square/blue.css' rel="stylesheet"></link>
    <link rel="stylesheet" type="text/css" href="../../../../../resource/html5/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="../bootstrap-colorpicker.min.css">
    <script src="../../../../../resource/html5/js/jquery.min.js"></script>
	<script src='<%=request.getContextPath() %>/resource/html5/js/icheck.min.js'></script>
	<script src='<%=request.getContextPath() %>/resource/html5/js/autosize.min.js'></script>
	<script src='<%=request.getContextPath() %>/resource/html5/js/matrix_runtime.js'></script>

    <script src="../ion.rangeSlider.min.js"></script> 
 	<script src="../bootstrap-colorpicker.min.js"></script>
 
 
  <script src="../../../../../resource/html5/js/bootstrap.min.js"></script>
  <jsp:include page="../../../../../foundation/common/taglib.jsp"/>
  <jsp:include page="../../../../../foundation/common/resource.jsp"/>
  <link href='<%=request.getContextPath() %>/resource/html5/css/skin/mCustom_<%=session.getAttribute("skin") %>.css' rel="stylesheet"></link>
  </head>
  
  <body onLoad = "loadJS();" >
  <style>
  td{
  	font-size:14px;
  }
 .addon-udSelect {
    background-color: rgb(255, 255, 255);
    border-top-left-radius: 0;
    border-bottom-left-radius: 0;
    color: #bbb;
 }
 .udSelect {
    pointer-events: auto;
    cursor: pointer;
 } 
 .form_label{
   text-align: center;
   color: #4A4D4A;
   background-color: rgb(250, 250, 250);

   margin: 0;
   padding: 0;
   height: 41px;
   border: 1px solid rgb(204, 204, 204);
 }
 .form_input{
    height: 28px;
    border: 1px solid rgb(204, 204, 204);
    text-align: left;
  
 }
 .form-control {
    display:inline-block
 }
 .outspan{
	border-style: dotted;border-width: 1px;
 }
 .inspan{
    border: 1px solid #316AC5;
 }
 .outspanuncheck{
	border: 1px solid transparent;
 }
 .inspanuncheck{
	border:1px solid transparent;
  }
</style>
  <script>
 /*  function colorhtml(){
	  var color1 = document.getElementById('label_Color').value;
	  var color2 = $("#label_Color").spectrum("get");
	  alert(color2);
  } */
  
 /*  function spanBlur(){
	 // alert(111);
	  var color = document.getElementById("label_Color").value;
	  document.getElementById("label_Color").style.backgroundColor = color;
  } */
  
  
  function showtdcolor(){
  document.getElementById('tdcolor').style.display="block";

  var background = document.getElementById('label_Color').style.backgroundColor;
  var aOts = $('#tdcolor a');
	  for(var i=0;i<aOts.length;i++){
		  if(aOts[i].style.backgroundColor==background){
		  aOts[i].style.border="1px solid #c31414";
		  break;
		  }
	  }
  }
  function selectcolor(obj){
  var background = document.getElementById(obj).style.background;
  document.getElementById('label_Color').style.backgroundColor = background;
  document.getElementById('label_Color').value = background;
  $("#bgColorSelect").css('backgroundColor',background);
  document.getElementById('tdcolor').style.display="none";

    var aOts = $('#tdcolor a');

	  for(var i=0;i<aOts.length;i++){
		  if(aOts[i].style.border=="1px solid rgb(195, 20, 20)"){
		  aOts[i].style.border="1px solid #E2E4E7";
		  
		  }
	  }
  }
  
  function showtdcolor1(){
	  document.getElementById('tdcolor1').style.display="block";

	  var background = document.getElementById('border_Color').style.backgroundColor;
		  var aOts = $('#tdcolor1 a');
		  for(var i=0;i<aOts.length;i++){
			  if(aOts[i].style.backgroundColor==background){
			  aOts[i].style.border="1px solid #c31414";
			  break;
			  }
		  }
	  }
  function selectcolor1(obj){
	  var background = document.getElementById(obj).style.background;
	  document.getElementById('border_Color').style.backgroundColor = background;
	  document.getElementById('border_Color').value = background;
	  $("#borderColorSelect").css('backgroundColor',background);
	  document.getElementById('tdcolor1').style.display="none";

		  var aOts = $('#tdcolor1 a');
		  for(var i=0;i<aOts.length;i++){
			  if(aOts[i].style.border=="1px solid rgb(195, 20, 20)"){
			  aOts[i].style.border="1px solid #E2E4E7";
			  
			  }
		  }
	  }
  
  function showFontColor(){
	  document.getElementById('fontColor').style.display="block";

	  var background = document.getElementById('font_Color').style.backgroundColor;
  }
  
  function selectcolor3(obj){
	  var background = document.getElementById(obj).style.background;
	  document.getElementById('font_Color').style.backgroundColor = background;
	  document.getElementById('font_Color').value = background;
	  $("#fontColorSelect").css('backgroundColor',background);	  
  }
  
  //初始加载  带入style样式
  function loadJS(){
	  var operation = "${param.operation}";
	  $('#isSetBase').iCheck('check'); //选中基本设置复选框
	  $('#isSetBase').iCheck('disable');  //禁用基本设置复选框
	  if(operation == 'other'){  //非单元格
		  $("#textAlignTr").hide();
		  $("#verticalAlignTr").hide();
		  $("#backgroundColorTr").hide();
		  $("#fontSizeTr").show();
		  $("#fontColorTr").show();				  
		  $("#borderSetTr").hide();
	  }
	  var elements = parent.$("div[eventproxy*='MMatrixPropertyCode']");
	  var iframe = elements[0].firstChild;
   	  var oldstyle= iframe.contentWindow.document.getElementById('style').value;//父窗口样式字符串
   
 if(typeof(oldstyle)=='undefined'||oldstyle==null)
 oldstyle="";
 if(oldstyle!=""&&oldstyle.trim().length>0){
 var oldstyleArr=oldstyle.split(";");
 if(oldstyleArr!=null&&oldstyleArr.length>0){
 for(var i=0;i<oldstyleArr.length;i++){
 var oldStylestyle = oldstyleArr[i].split(":");
 var oldStylestyle0 = oldStylestyle[0];
  var oldStylestyle1 = oldStylestyle[1];
 
 if(oldStylestyle0.trim().startWith("width")&&oldStylestyle1!=""||oldStylestyle0.trim().startWith("height")&&oldStylestyle1!=""||oldStylestyle0.trim().startWith("text-align")&&oldStylestyle1!=""||oldStylestyle0.trim().startWith("vertical-align")&&oldStylestyle1!=""){
	 $('#isSetBase').iCheck('check'); //选中 
  	break;
 }
 }
 }
 if(oldstyle.contains("border") && !oldstyle.contains("border: none")){
   $("#bordertr").show();
   $('#isSetBorder').iCheck('check'); //选中
 }else{
  $("#bordertr").hide(); 
  
 }
 }else{
  $("#bordertr").hide(); 
 }

 var bordercss = "";
 if(oldstyle!=""&&oldstyle!=null){
 
 oldstyleArr=oldstyle.split(";");
 if(oldstyleArr!=null&&oldstyleArr.length>0){
 for(var i=0;i<oldstyleArr.length;i++){
 var oldStylestyle = oldstyleArr[i].split(":");
 var oldStylestyle0 = oldStylestyle[0];
 var oldStylestyle1 = oldStylestyle[1];
 
 if(oldStylestyle0.trim().startWith("width")&&oldStylestyle1!=""){
 if(oldStylestyle1.contains('%')&&oldStylestyle1.length>1){
 Matrix.setFormItemValue('td_Width',oldStylestyle1.substring(0,oldStylestyle1.length-1));
 $("#td_Width_Unit").val("%");
 }
 else if(!oldStylestyle1.contains('%')&&oldStylestyle1.contains('px')&&oldStylestyle1.length>2){
  Matrix.setFormItemValue('td_Width',oldStylestyle1.substring(0,oldStylestyle1.length-2));
   $("#td_Width_Unit").val("px");
  }

 }else  if(oldStylestyle0.trim().startWith("height")&&oldStylestyle1!=""){
 if(oldStylestyle1.contains('%')&&oldStylestyle1.length>1){
 Matrix.setFormItemValue('td_Height',oldStylestyle1.substring(0,oldStylestyle1.length-1));
 $("#td_Height_Unit").val("%");
 }
 else if(!oldStylestyle1.contains('%')&&oldStylestyle1.contains('px')&&oldStylestyle1.length>2){
  Matrix.setFormItemValue('td_Height',oldStylestyle1.substring(0,oldStylestyle1.length-2));
   $("#td_Height_Unit").val("px");
  }

 } 
 else if(oldStylestyle0.trim().startWith("background-color")&&oldStylestyle1!=""){
  document.getElementById('label_Color').value= oldStylestyle1;
  document.getElementById('label_Color').style.backgroundColor = oldStylestyle1;
  $("#bgColorSelect").css('backgroundColor',oldStylestyle1);
 }
 else if(oldStylestyle0.trim().startWith("font-size")&&oldStylestyle1!=""){  //字体大小
  document.getElementById('font_Size').value= oldStylestyle1.substring(0,oldStylestyle1.length-2);
 }
 else if(oldStylestyle0.trim().startWith("color")&&oldStylestyle1!=""){  //字体颜色
  document.getElementById('font_Color').value= oldStylestyle1;
  document.getElementById('font_Color').style.backgroundColor = oldStylestyle1;
  $("#fontColorSelect").css('backgroundColor',oldStylestyle1);
 }
 else if(oldStylestyle0.trim().startWith("text-align")&&oldStylestyle1!=""){
 $("input[name='alignstyle'][value="+oldStylestyle1+"]").attr("checked",true); 

 }
 else if(oldStylestyle0.trim().startWith("vertical-align")&&oldStylestyle1!=""){
  $("input[name='valignstyle'][value="+oldStylestyle1+"]").attr("checked",true); 
 }
 else if(oldStylestyle0.trim().contains("border")&&oldStylestyle1!=""){
	bordercss+= oldstyleArr[i]+";";
	
	var str = oldStylestyle1.replace(/\s/g,"");  //去除空格 
	if(oldStylestyle0.trim() == "border"){        //border: 4px solid rgb(204, 204, 204)
		if(str && str != 'none'){
			//边框颜色
			var borderColor = str.substring(str.indexOf("solid")+5,str.length);
			$("#border_Color").val(borderColor);
			$("#border_Color").css('backgroundColor',borderColor);
			$("#borderColorSelect").css('backgroundColor',borderColor);
			//边框宽度
			var borderSize = str.substring(0,str.indexOf("px")+2);
			$("#border_Width").val(borderSize);
			
			document.getElementById('upImg').src = '<%=path%>/form/admin/designer/style/image/upchecked.png';
		   	document.getElementById('downImg').src = '<%=path%>/form/admin/designer/style/image/downchecked.png';
		   	document.getElementById('leftImg').src = '<%=path%>/form/admin/designer/style/image/leftchecked.png';
		   	document.getElementById('rightImg').src = '<%=path%>/form/admin/designer/style/image/rightchecked.png';
		}
	}else if(oldStylestyle0.trim() == "border-top" || oldStylestyle0.trim() == "border-bottom"           //border-top: 1px solid rgb(255, 0, 0);
			|| oldStylestyle0.trim() == "border-left" || oldStylestyle0.trim() == "border-right"){
		if(str && str != 'none'){
			//边框颜色
			var borderColor = str.substring(str.indexOf("solid")+5,str.length);
			$("#border_Color").val(borderColor);
			$("#border_Color").css('backgroundColor',borderColor);
			$("#borderColorSelect").css('backgroundColor',borderColor);
			//边框宽度
			var borderSize = str.substring(str.indexOf(":")+1,str.indexOf("px")+2);
			$("#border_Width").val(borderSize);
			
			if(oldStylestyle0.trim() == "border-top"){
				document.getElementById('upImg').src = '<%=path%>/form/admin/designer/style/image/upchecked.png';  
			}else if(oldStylestyle0.trim() == "border-bottom"){
				 document.getElementById('downImg').src = '<%=path%>/form/admin/designer/style/image/downchecked.png';
			}else if(oldStylestyle0.trim() == "border-left"){
				document.getElementById('leftImg').src = '<%=path%>/form/admin/designer/style/image/leftchecked.png';
			}else if(oldStylestyle0.trim() == "border-right"){
				 document.getElementById('rightImg').src = '<%=path%>/form/admin/designer/style/image/rightchecked.png';
			}
			
		}
	}else if(oldStylestyle0.trim() == "border-color"){
		//边框颜色
		var borderColor = oldStylestyle1.trim();
		$("#border_Color").val(borderColor);
		$("#border_Color").css('backgroundColor',borderColor);
		$("#borderColorSelect").css('backgroundColor',borderColor);
		
	}else if(oldStylestyle0.trim() == "border-width"){
		//边框宽度
		var borderSize = oldStylestyle1.trim();
		$("#border_Width").val(borderSize);
	}
}
 }

 }
 }
 document.getElementById('tdcontent').style.cssText = bordercss;
  } 
</script>
<div style="width:100%;height:calc(100% - 54px);overflow-y:auto;overflow-x:hidden;">
	<table style="width:100%;">
  		<tbody>
  			<tr>
  				<td colspan="2" style="background: #F8F8F8;height: 35px;border-bottom: 1px solid rgb(204, 204, 204);">
  					<font style="margin-left:10px;font-size:14px;font-weight: bold;">基本设置</font>
					<input type="checkbox" id="isSetBase" name="isSetBase" class="box">
				</td>
  </tr><tr>
  <td class="form_label" style="width:50%">宽度</td><td class="form_input"><input type="number" id="td_Width" class="form-control" style="border-radius: 0px; width: 220px;" name="width">&nbsp;<select id="td_Width_Unit" class="form-control" style="    border-radius: 0px;width: 100px;"><option value="px">像素</option><option value="%">%</option></select></td>
  </tr>

<tr>
  <td class="form_label" style="width:50%">高度</td><td class="form_input"><input type="number" id="td_Height" class="form-control" style="border-radius: 0px; width: 220px;" name="width">&nbsp;<select id="td_Height_Unit" class="form-control" style="    border-radius: 0px;width: 100px;"><option value="px">像素</option><option value="%">%</option></select></td>
  </tr>
  <tr id="textAlignTr">
  <td class="form_label" style="width:50%">水平对齐</td>
  <td class="form_input">
  
  <input type="radio" name="alignstyle" value="left" style="vertical-align: text-bottom;margin-left: 10px;">居左
  <input type="radio" name="alignstyle" value="center" style="vertical-align: text-bottom;margin-left: 5px;" checked="checked">居中
 <input type="radio" name="alignstyle" value="right" style="vertical-align: text-bottom;margin-left: 5px;">居右
  </td>
  
  </tr>

<tr id="verticalAlignTr">
  <td class="form_label" style="width:50%">垂直对齐</td>
  <td class="form_input">
  
  <input type="radio" name="valignstyle" value="top" style="vertical-align: text-bottom;margin-left: 10px;">居顶
  <input type="radio" name="valignstyle" value="middle" style="vertical-align: text-bottom;margin-left: 5px;" checked="checked">居中
 <input type="radio" name="valignstyle" value="bottom" style="vertical-align: text-bottom;margin-left: 5px;">居底 </td>
  
  </tr>
  <tr id="backgroundColorTr">
  <td class="form_label" style="width:50%">背景颜色</td>
<td class="form_input">
 <div class="demo2 colorpicker-element" style="display: -webkit-inline-box;">
 <!--  <div style="border: 1px solid #ACACAC;border-radius: 0px;width: 220px;" class="form-control">
  <span style="   padding:0 0;   display:inline-block; height:20px;border-radius: 0px; width:194px; background-color:rgb(255, 255, 255); " id="tdbackground"></span>
  </div> -->
  <input type="text" id="label_Color" style="border-radius: 0px;width:220px;" value="rgb(255, 255, 255)" class="form-control" readonly="readonly">
  <span class="input-group-addon addon-udSelect udSelect" style="height:33px;"><i id="bgColorSelect" style="background-color: rgb(0, 0, 0);"></i> </span>
   <div class="x-btn cancel-btn" style="height: 34px; line-height: 32px;padding: 0 10px;" onclick="showtdcolor();">
		<span>选择颜色</span>
	</div>
   </div>
    
    <div id="tdcolor" style="display:none;position:relative;/* width:200px; */top:0px;z-index:999999;background:rgb(255, 255, 255);">
  <a id="a1" href="javascript:selectcolor('a1');" style="width: 15px; height: 15px; display: block; border: 1px solid rgb(226, 228, 231); float: left; margin-right: 5px; padding: 1px; background: rgb(255, 255, 255);" onmouseover="this.style.border='1px solid #c31414';this.style.padding='1px 1px'" onmouseout="this.style.border='1px solid #E2E4E7';"> </a>
  &nbsp;
  <a id="a2" href="javascript:selectcolor('a2');" style="width: 15px; height: 15px; display: block; border: 1px solid rgb(226, 228, 231); float: left; margin-right: 5px; padding: 1px; background: rgb(0, 0, 0);" onmouseover="this.style.border='1px solid #c31414';this.style.padding='1px 1px'" onmouseout="this.style.border='1px solid #E2E4E7';"> </a>
  &nbsp;
  <a id="a3" href="javascript:selectcolor('a3');" style="width: 15px; height: 15px; display: block; border: 1px solid rgb(226, 228, 231); float: left; margin-right: 5px; padding: 1px; background: rgb(204, 204, 204);" onmouseover="this.style.border='1px solid #c31414';this.style.padding='1px 1px'" onmouseout="this.style.border='1px solid #E2E4E7';"> </a>
  &nbsp;
   <a id="a4" href="javascript:selectcolor('a4');" style="width: 15px; height: 15px; display: block; border: 1px solid rgb(226, 228, 231); float: left; margin-right: 5px; padding: 1px; background: rgb(68, 84, 106);" onmouseover="this.style.border='1px solid #c31414';this.style.padding='1px 1px'" onmouseout="this.style.border='1px solid #E2E4E7';"> </a>
  &nbsp;
   <a id="a5" href="javascript:selectcolor('a5');" style="width: 15px; height: 15px; display: block; border: 1px solid rgb(226, 228, 231); float: left; margin-right: 5px; padding: 1px; background: rgb(91, 155, 213);" onmouseover="this.style.border='1px solid #c31414';this.style.padding='1px 1px'" onmouseout="this.style.border='1px solid #E2E4E7';"> </a>
  &nbsp;
  <a id="a6" href="javascript:selectcolor('a6');" style="width: 15px; height: 15px; display: block; border: 1px solid rgb(226, 228, 231); float: left; margin-right: 5px; padding: 1px; background: rgb(237, 125, 49);" onmouseover="this.style.border='1px solid #c31414';this.style.padding='1px 1px'" onmouseout="this.style.border='1px solid #E2E4E7';"> </a>
  &nbsp;
   <a id="a7" href="javascript:selectcolor('a7');" style="width: 15px; height: 15px; display: block; border: 1px solid rgb(226, 228, 231); float: left; margin-right: 5px; padding: 1px; background: rgb(165, 165, 165);" onmouseover="this.style.border='1px solid #c31414';this.style.padding='1px 1px'" onmouseout="this.style.border='1px solid #E2E4E7';"> </a>
  &nbsp;
   <a id="a8" href="javascript:selectcolor('a8');" style="width: 15px; height: 15px; display: block; border: 1px solid rgb(226, 228, 231); float: left; margin-right: 5px; padding: 1px; background: rgb(255, 192, 0);" onmouseover="this.style.border='1px solid #c31414';this.style.padding='1px 1px'" onmouseout="this.style.border='1px solid #E2E4E7';"> </a>
  &nbsp;
   <a id="a9" href="javascript:selectcolor('a9');" style="width: 15px; height: 15px; display: block; border: 1px solid rgb(226, 228, 231); float: left; margin-right: 5px; padding: 1px; background: rgb(68, 114, 196);" onmouseover="this.style.border='1px solid #c31414';this.style.padding='1px 1px'" onmouseout="this.style.border='1px solid #E2E4E7';"> </a>
  &nbsp;
   <a id="a10" href="javascript:selectcolor('a10');" style="width: 15px; height: 15px; display: block; border: 1px solid rgb(226, 228, 231); float: left; margin-right: 5px; padding: 1px; background: rgb(112, 173, 71);" onmouseover="this.style.border='1px solid #c31414';this.style.padding='1px 1px'" onmouseout="this.style.border='1px solid #E2E4E7';"> </a>
  &nbsp;
   <a id="a11" href="javascript:selectcolor('a11');" style="width: 15px; height: 15px; display: block; border: 1px solid rgb(226, 228, 231); float: left; margin-right: 5px; padding: 1px; background: rgb(255, 0, 0);" onmouseover="this.style.border='1px solid #c31414';this.style.padding='1px 1px'" onmouseout="this.style.border='1px solid #E2E4E7';"> </a>
  &nbsp;
  <br>
  
  </div>
  </td>
  </tr>
  
  <tr id="fontSizeTr" style="display:none;">
  	<td class="form_label" style="width:50%">字体大小</td>
  	<td class="form_input">
  		<input type="number" id="font_Size" class="form-control" style="border-radius: 0px; width: 220px;" name="fontSize">
  	</td>
  </tr>
  
  <tr id="fontColorTr" style="display:none;">
	  <td class="form_label" style="width:50%">字体颜色</td>
	<td class="form_input">
	 <div class="demo2 colorpicker-element" style="display: -webkit-inline-box;">
	 <!--  <div style="border: 1px solid #ACACAC;border-radius: 0px;width: 220px;" class="form-control">
	  <span style="   padding:0 0;   display:inline-block; height:20px;border-radius: 0px; width:194px; background-color:rgb(255, 255, 255); " id="tdbackground"></span>
	  </div> -->
	  <input type="text" id="font_Color" style="border-radius: 0px;width:220px;" value="" class="form-control" readonly="readonly">
	  <span class="input-group-addon addon-udSelect udSelect" style="height:33px;"><i id="fontColorSelect" style="background-color: rgb(0, 0, 0);"></i> </span>
	   <div class="x-btn cancel-btn" style="height: 34px; line-height: 32px;padding: 0 10px;" onclick="showFontColor();">
			<span>选择颜色</span>
		</div>
	   </div>
	    
	    <div id="fontColor" style="display:none;position:relative;/* width:200px; */top:0px;z-index:999999;background:rgb(255, 255, 255);">
	  <a id="a1" href="javascript:selectcolor3('a1');" style="width: 15px; height: 15px; display: block; border: 1px solid rgb(226, 228, 231); float: left; margin-right: 5px; padding: 1px; background: rgb(255, 255, 255);" onmouseover="this.style.border='1px solid #c31414';this.style.padding='1px 1px'" onmouseout="this.style.border='1px solid #E2E4E7';"> </a>
	  &nbsp;
	  <a id="a2" href="javascript:selectcolor3('a2');" style="width: 15px; height: 15px; display: block; border: 1px solid rgb(226, 228, 231); float: left; margin-right: 5px; padding: 1px; background: rgb(0, 0, 0);" onmouseover="this.style.border='1px solid #c31414';this.style.padding='1px 1px'" onmouseout="this.style.border='1px solid #E2E4E7';"> </a>
	  &nbsp;
	  <a id="a3" href="javascript:selectcolor3('a3');" style="width: 15px; height: 15px; display: block; border: 1px solid rgb(226, 228, 231); float: left; margin-right: 5px; padding: 1px; background: rgb(204, 204, 204);" onmouseover="this.style.border='1px solid #c31414';this.style.padding='1px 1px'" onmouseout="this.style.border='1px solid #E2E4E7';"> </a>
	  &nbsp;
	   <a id="a4" href="javascript:selectcolor3('a4');" style="width: 15px; height: 15px; display: block; border: 1px solid rgb(226, 228, 231); float: left; margin-right: 5px; padding: 1px; background: rgb(68, 84, 106);" onmouseover="this.style.border='1px solid #c31414';this.style.padding='1px 1px'" onmouseout="this.style.border='1px solid #E2E4E7';"> </a>
	  &nbsp;
	   <a id="a5" href="javascript:selectcolor3('a5');" style="width: 15px; height: 15px; display: block; border: 1px solid rgb(226, 228, 231); float: left; margin-right: 5px; padding: 1px; background: rgb(91, 155, 213);" onmouseover="this.style.border='1px solid #c31414';this.style.padding='1px 1px'" onmouseout="this.style.border='1px solid #E2E4E7';"> </a>
	  &nbsp;
	  <a id="a6" href="javascript:selectcolor3('a6');" style="width: 15px; height: 15px; display: block; border: 1px solid rgb(226, 228, 231); float: left; margin-right: 5px; padding: 1px; background: rgb(237, 125, 49);" onmouseover="this.style.border='1px solid #c31414';this.style.padding='1px 1px'" onmouseout="this.style.border='1px solid #E2E4E7';"> </a>
	  &nbsp;
	   <a id="a7" href="javascript:selectcolor3('a7');" style="width: 15px; height: 15px; display: block; border: 1px solid rgb(226, 228, 231); float: left; margin-right: 5px; padding: 1px; background: rgb(165, 165, 165);" onmouseover="this.style.border='1px solid #c31414';this.style.padding='1px 1px'" onmouseout="this.style.border='1px solid #E2E4E7';"> </a>
	  &nbsp;
	   <a id="a8" href="javascript:selectcolor3('a8');" style="width: 15px; height: 15px; display: block; border: 1px solid rgb(226, 228, 231); float: left; margin-right: 5px; padding: 1px; background: rgb(255, 192, 0);" onmouseover="this.style.border='1px solid #c31414';this.style.padding='1px 1px'" onmouseout="this.style.border='1px solid #E2E4E7';"> </a>
	  &nbsp;
	   <a id="a9" href="javascript:selectcolor3('a9');" style="width: 15px; height: 15px; display: block; border: 1px solid rgb(226, 228, 231); float: left; margin-right: 5px; padding: 1px; background: rgb(68, 114, 196);" onmouseover="this.style.border='1px solid #c31414';this.style.padding='1px 1px'" onmouseout="this.style.border='1px solid #E2E4E7';"> </a>
	  &nbsp;
	   <a id="a10" href="javascript:selectcolor3('a10');" style="width: 15px; height: 15px; display: block; border: 1px solid rgb(226, 228, 231); float: left; margin-right: 5px; padding: 1px; background: rgb(112, 173, 71);" onmouseover="this.style.border='1px solid #c31414';this.style.padding='1px 1px'" onmouseout="this.style.border='1px solid #E2E4E7';"> </a>
	  &nbsp;
	   <a id="a11" href="javascript:selectcolor3('a11');" style="width: 15px; height: 15px; display: block; border: 1px solid rgb(226, 228, 231); float: left; margin-right: 5px; padding: 1px; background: rgb(255, 0, 0);" onmouseover="this.style.border='1px solid #c31414';this.style.padding='1px 1px'" onmouseout="this.style.border='1px solid #E2E4E7';"> </a>
	  &nbsp;
	  <br>
	  
	  </div>
	  </td>
  </tr>
  
  
  
<tr id="borderSetTr">
<td colspan="2" style="background: #F8F8F8;height: 35px;border-bottom: 1px solid rgb(204, 204, 204);">
  	<font style="margin-left:10px;font-size:14px;font-weight: bold;">边框设置</font>
  	<input type="checkbox" id="isSetBorder" name="isSetBorder" class="box"></td>
</tr><tr id="bordertr" style="display:none;">

<td class="form_input">
  <div style="height: 100%;padding: 5px;">
<font style="margin-left:5px;font-size:14px;">颜色：</font>
<br>
 <div class="demo3 colorpicker-element" style="display:-webkit-inline-box;">
    <input type="text" id="border_Color" style="border-radius: 0px;width:180px;background-color: rgb(204, 204, 204);" value="rgb(204, 204, 204)" class="form-control" readonly="readonly">
    <span class="input-group-addon addon-udSelect udSelect" style="height:33px;"><i id="borderColorSelect" style="background-color: rgb(204, 204, 204);"></i></span>
    <div class="x-btn cancel-btn" style="height: 34px; line-height: 32px;padding: 0 10px;" onclick="showtdcolor1();">
		<span>选择颜色</span>
	</div>
 </div>

<div id="tdcolor1" style="display:none;position:relative;/* width:200px; */top:0px;z-index:999999;background:rgb(255, 255, 255);">
  <a id="a1" href="javascript:selectcolor1('a1');" style="width: 15px; height: 15px; display: block; border: 1px solid rgb(226, 228, 231); float: left; margin-right: 5px; padding: 1px; background: rgb(255, 255, 255);" onmouseover="this.style.border='1px solid #c31414';this.style.padding='1px 1px'" onmouseout="this.style.border='1px solid #E2E4E7';"> </a>
  &nbsp;
  <a id="a2" href="javascript:selectcolor1('a2');" style="width: 15px; height: 15px; display: block; border: 1px solid rgb(226, 228, 231); float: left; margin-right: 5px; padding: 1px; background: rgb(0, 0, 0);" onmouseover="this.style.border='1px solid #c31414';this.style.padding='1px 1px'" onmouseout="this.style.border='1px solid #E2E4E7';"> </a>
  &nbsp;
  <a id="a3" href="javascript:selectcolor1('a3');" style="width: 15px; height: 15px; display: block; border: 1px solid rgb(226, 228, 231); float: left; margin-right: 5px; padding: 1px; background: rgb(204, 204, 204);" onmouseover="this.style.border='1px solid #c31414';this.style.padding='1px 1px'" onmouseout="this.style.border='1px solid #E2E4E7';"> </a>
  &nbsp;
   <a id="a4" href="javascript:selectcolor1('a4');" style="width: 15px; height: 15px; display: block; border: 1px solid rgb(226, 228, 231); float: left; margin-right: 5px; padding: 1px; background: rgb(68, 84, 106);" onmouseover="this.style.border='1px solid #c31414';this.style.padding='1px 1px'" onmouseout="this.style.border='1px solid #E2E4E7';"> </a>
  &nbsp;
   <a id="a5" href="javascript:selectcolor1('a5');" style="width: 15px; height: 15px; display: block; border: 1px solid rgb(226, 228, 231); float: left; margin-right: 5px; padding: 1px; background: rgb(91, 155, 213);" onmouseover="this.style.border='1px solid #c31414';this.style.padding='1px 1px'" onmouseout="this.style.border='1px solid #E2E4E7';"> </a>
  &nbsp;
  <a id="a6" href="javascript:selectcolor1('a6');" style="width: 15px; height: 15px; display: block; border: 1px solid rgb(226, 228, 231); float: left; margin-right: 5px; padding: 1px; background: rgb(237, 125, 49);" onmouseover="this.style.border='1px solid #c31414';this.style.padding='1px 1px'" onmouseout="this.style.border='1px solid #E2E4E7';"> </a>
  &nbsp;
   <a id="a7" href="javascript:selectcolor1('a7');" style="width: 15px; height: 15px; display: block; border: 1px solid rgb(226, 228, 231); float: left; margin-right: 5px; padding: 1px; background: rgb(165, 165, 165);" onmouseover="this.style.border='1px solid #c31414';this.style.padding='1px 1px'" onmouseout="this.style.border='1px solid #E2E4E7';"> </a>
  &nbsp;
   <a id="a8" href="javascript:selectcolor1('a8');" style="width: 15px; height: 15px; display: block; border: 1px solid rgb(226, 228, 231); float: left; margin-right: 5px; padding: 1px; background: rgb(255, 192, 0);" onmouseover="this.style.border='1px solid #c31414';this.style.padding='1px 1px'" onmouseout="this.style.border='1px solid #E2E4E7';"> </a>
  &nbsp;
   <a id="a9" href="javascript:selectcolor1('a9');" style="width: 15px; height: 15px; display: block; border: 1px solid rgb(226, 228, 231); float: left; margin-right: 5px; padding: 1px; background: rgb(68, 114, 196);" onmouseover="this.style.border='1px solid #c31414';this.style.padding='1px 1px'" onmouseout="this.style.border='1px solid #E2E4E7';"> </a>
  &nbsp;
   <a id="a10" href="javascript:selectcolor1('a10');" style="width: 15px; height: 15px; display: block; border: 1px solid rgb(226, 228, 231); float: left; margin-right: 5px; padding: 1px; background: rgb(112, 173, 71);" onmouseover="this.style.border='1px solid #c31414';this.style.padding='1px 1px'" onmouseout="this.style.border='1px solid #E2E4E7';"> </a>
  &nbsp;
   <a id="a11" href="javascript:selectcolor1('a11');" style="width: 15px; height: 15px; display: block; border: 1px solid rgb(226, 228, 231); float: left; margin-right: 5px; padding: 1px; background: rgb(255, 0, 0);" onmouseover="this.style.border='1px solid #c31414';this.style.padding='1px 1px'" onmouseout="this.style.border='1px solid #E2E4E7';"> </a>
  &nbsp;
  <br>
  
  </div>
  <div style="display: block;padding: 2px;">
  </div>
<font style="margin-left:5px;font-size:14px;">宽度：</font>
<br>
<select id="border_Width" style="width:180px; border-radius: 0px;" class="form-control" onchange="changeWidth();">
<option value="1px">1像素</option><option value="2px">2像素</option>
<option value="3px">3像素</option><option value="4px">4像素</option>
<option value="5px">5像素</option><option value="6px">6像素</option>
<option value="7px">7像素</option><option value="8px">8像素</option>
<option value="9px">9像素</option><option value="10px">10像素</option>
</select>
  </div>
</td>

<td class="form_input">
<div style="height: 100%;padding: 5px;">
<font style="margin-left:5px;font-size:14px;">预览：</font>
<script>
	//全选
    function allSelect(){
       $("#tdcontent").css("border",$("#border_Width option:selected").val() + " solid " + $("#border_Color").val());
       document.getElementById('upImg').src = '<%=path%>/form/admin/designer/style/image/upchecked.png';
   	   document.getElementById('downImg').src = '<%=path%>/form/admin/designer/style/image/downchecked.png';
   	   document.getElementById('leftImg').src = '<%=path%>/form/admin/designer/style/image/leftchecked.png';
   	   document.getElementById('rightImg').src = '<%=path%>/form/admin/designer/style/image/rightchecked.png';
    }
	//全不选
	function allNotSelect(){
	   $("#tdcontent").css("border","none");
	   document.getElementById('upImg').src = '<%=path%>/form/admin/designer/style/image/upuncheck.png';
   	   document.getElementById('downImg').src = '<%=path%>/form/admin/designer/style/image/downuncheck.png';
   	   document.getElementById('leftImg').src = '<%=path%>/form/admin/designer/style/image/leftuncheck.png';
   	   document.getElementById('rightImg').src = '<%=path%>/form/admin/designer/style/image/rightuncheck.png';
	}
	
	//上边框 下边框 左边框 右边框单独设置
	function addborder(obj,type){
		if('up'==type){
			if(obj.src.endsWith('ed.png')){
				obj.src='<%=path%>/form/admin/designer/style/image/upuncheck.png';
				$("#tdcontent").css("border-top","none");
			}else{
			    obj.src='<%=path%>/form/admin/designer/style/image/upchecked.png';
			    $("#tdcontent").css("border-top",$("#border_Width option:selected").val() + " solid " + $("#border_Color").val());
			}
		}else if('down'==type){
			if(obj.src.endsWith('ed.png')){
				obj.src='<%=path%>/form/admin/designer/style/image/downuncheck.png';
				$("#tdcontent").css("border-bottom","none");
			}else{
			 	obj.src='<%=path%>/form/admin/designer/style/image/downchecked.png';
			    $("#tdcontent").css("border-bottom",$("#border_Width option:selected").val() + " solid " + $("#border_Color").val());  
			}
		}else if('left'==type){
			if(obj.src.endsWith('ed.png')){
				obj.src='<%=path%>/form/admin/designer/style/image/leftuncheck.png';
				$("#tdcontent").css("border-left","none");
			}else{
			    obj.src='<%=path%>/form/admin/designer/style/image/leftchecked.png';
			    $("#tdcontent").css("border-left",$("#border_Width option:selected").val() + " solid " + $("#border_Color").val());
			}
		}else if('right'==type){
			if(obj.src.endsWith('ed.png')){
				obj.src='<%=path%>/form/admin/designer/style/image/rightuncheck.png';
				$("#tdcontent").css("border-right","none");
			}else{
			    obj.src='<%=path%>/form/admin/designer/style/image/rightchecked.png';
			    $("#tdcontent").css("border-right",$("#border_Width option:selected").val() + " solid " + $("#border_Color").val());
			}
		}
	}
	
	//边框宽度下拉框改变事件
	function changeWidth(){
		$("#tdcontent").removeAttr("style");
		$("#tdcontent").css("border",$("#border_Width option:selected").val() + " solid " + $("#border_Color").val());
	    document.getElementById('upImg').src = '<%=path%>/form/admin/designer/style/image/upchecked.png';
	   	document.getElementById('downImg').src = '<%=path%>/form/admin/designer/style/image/downchecked.png';
	   	document.getElementById('leftImg').src = '<%=path%>/form/admin/designer/style/image/leftchecked.png';
	   	document.getElementById('rightImg').src = '<%=path%>/form/admin/designer/style/image/rightchecked.png';
	}
</script>
<table>
<tbody>
<tr>
<td></td>
<td style="text-align: center;padding-bottom: 15px;">
<img style="margin-right: 5px;" src="<%=path%>/form/admin/designer/style/image/check.png" onclick="allSelect();" title="全选">
<img src="<%=path%>/form/admin/designer/style/image/uncheck.png" onclick="allNotSelect();" title="全不选"></td>
</tr>
<tr>
<td style="vertical-align: middle;padding-right: 20px;">
<img style="margin-bottom: 5px;" src="<%=path%>/form/admin/designer/style/image/upuncheck.png" onclick="addborder(this,'up');" id="upImg">
<br><img src="<%=path%>/form/admin/designer/style/image/downuncheck.png" onclick="addborder(this,'down');" id="downImg"></td>
<td id="tdcontent"><img src="<%=path%>/form/admin/designer/style/image/tdcontent.png" style="margin-left:2px"></td>
</tr>
<tr>
<td></td>
<td style="text-align: center;padding-top: 15px;">
<img style="margin-right: 5px;" src="<%=path%>/form/admin/designer/style/image/leftuncheck.png" onclick="addborder(this,'left');" id="leftImg">
<img src="<%=path%>/form/admin/designer/style/image/rightuncheck.png" onclick="addborder(this,'right');" id="rightImg"></td>
</tr>
</tbody></table>
</div>
</td>
</tr>
<tr>
<td height="100px"></td></tr>
  </tbody></table>
    
  </div>

  <div class="cmdLayout">
  <button id="button002" class="x-btn ok-btn " type="button">确定</button>
    <button style="margin-left:5px;" id="button001" class="x-btn cancel-btn " type="button">取消</button>
  </div>
 

 
   
                           <script>
      $(document).ready(function() {
    	  
    	 /*  $("label_Color").blur(function(){
    		  var colorbg = document.getElementById("label_Color").value;
    		  document.getElementById("label_Color").style.backgroundColor = colorbg;
    		  alert(colorbg);
    	  }); */
      
       
    	  //获取colorpicker颜色改变事件
        $('.demo2').colorpicker().on('changeColor',function(){
        	 var color = document.getElementById("label_Color").value;
      	  	 document.getElementById("label_Color").style.backgroundColor = color; 
        });
    	  $('.demo3').colorpicker().on('changeColor',function(){
         	 var color = document.getElementById("border_Color").value;
       	  	 document.getElementById("border_Color").style.backgroundColor = color; 
       	  	 
       	 	 $("#tdcontent").removeAttr("style");
	  		 $("#tdcontent").css("border",$("#border_Width option:selected").val() + " solid " + $("#border_Color").val());
	  	     document.getElementById('upImg').src = '<%=path%>/form/admin/designer/style/image/upchecked.png';
	  	   	 document.getElementById('downImg').src = '<%=path%>/form/admin/designer/style/image/downchecked.png';
	  	   	 document.getElementById('leftImg').src = '<%=path%>/form/admin/designer/style/image/leftchecked.png';
	  	   	 document.getElementById('rightImg').src = '<%=path%>/form/admin/designer/style/image/rightchecked.png';
         });

	  $("#button002").click(function(){
		  debugger;
	   var elements = parent.$("div[eventproxy*='MMatrixPropertyCode']");
	   var iframe = elements[0].firstChild;
   	   var oldstyle= iframe.contentWindow.document.getElementById('style').value;//父窗口样式字符串
       if(typeof(oldstyle)=='undefined'||oldstyle==null)
       oldstyle="";
       var oldstyleArr = [];
       var conwidth = false;//是否包含宽度
       var conalign = false; //是否包含水平对齐方式
       var convalign = false;//是否包含垂直对齐方式
       var conborder = false;//是否包含边框样式
       var isSetBase = $("input[id='isSetBase']").is(':checked');//是否设置基本设置
       var isSetBorder = $("input[id='isSetBorder']").is(':checked');//是否设置边框
       var val=$('input:radio[name="alignstyle"]:checked').val();  //水平对齐
       var val2=$('input:radio[name="valignstyle"]:checked').val();//垂直对齐
       var tdWidth=$("#td_Width").val();    //单元格宽度值
       var tdHeight = $("#td_Height").val(); //单元格高度值
       if(tdWidth==""||tdWidth==null)
       tdWidth=0;
       if(tdHeight==""||tdHeight==null)
       tdHeight=0;
       var options2=$("#td_Width_Unit option:selected");  //单元格宽度单位
           var optionsh2=$("#td_Height_Unit option:selected");  //单元格宽度单位
       var tdborder = document.getElementById('tdcontent').style.cssText;
           if(tdborder==""||tdborder==null)
           tdborder="border:none;";
          
        var fontSize = $("#font_Size").val();    //字体大小值
        var fontColor = $("#font_Color").val(); //字体颜色值
           
 if(oldstyle!=""&&oldstyle!=null){
 oldstyleArr=oldstyle.split(";");
 if(oldstyleArr!=null&&oldstyleArr.length>0){
 for(var i=0;i<oldstyleArr.length;i++){
 var oldStylestyle = oldstyleArr[i].split(":");
 var oldStylestyle0 = oldStylestyle[0];
 var oldStylestyle1 = oldStylestyle[1];
 if(oldStylestyle0.trim().startWith("width")&&oldStylestyle1!=""){
// oldstyle = oldstyle.replace(oldstyleArr[i],"width:"+tdWidth+options2.val());
oldstyle = oldstyle.replace(oldstyleArr[i],"");
 conwidth = true;
 }
 else if(oldStylestyle0.trim().startWith("height")&&oldStylestyle1!=""){
// oldstyle = oldstyle.replace(oldstyleArr[i],"width:"+tdWidth+options2.val());
oldstyle = oldstyle.replace(oldstyleArr[i],"");

 }
 else if(oldStylestyle0.trim().startWith("font-size")&&oldStylestyle1!=""){
	// oldstyle = oldstyle.replace(oldstyleArr[i],"width:"+tdWidth+options2.val());
    oldstyle = oldstyle.replace(oldstyleArr[i],"");

 }
 else if(oldStylestyle0.trim().startWith("color")&&oldStylestyle1!=""){
    // oldstyle = oldstyle.replace(oldstyleArr[i],"width:"+tdWidth+options2.val());
    oldstyle = oldstyle.replace(oldstyleArr[i],"");

 }
 else if(oldStylestyle0.trim().startWith("text-align")&&oldStylestyle1!=""){
 //oldstyle = oldstyle.replace(oldstyleArr[i],"text-align:"+val);
 oldstyle = oldstyle.replace(oldstyleArr[i],"");
 conalign = true;
 } else if(oldStylestyle0.trim().startWith("background-color")&&oldStylestyle1!=""){
 //oldstyle = oldstyle.replace(oldstyleArr[i],"text-align:"+val);
 oldstyle = oldstyle.replace(oldstyleArr[i],"");

 }
 else if(oldStylestyle0.trim().startWith("vertical-align")&&oldStylestyle1!=""){
 //oldstyle = oldstyle.replace(oldstyleArr[i],"vertical-align:"+val2);
 oldstyle = oldstyle.replace(oldstyleArr[i],"");
 convalign = true;
 }
 else if(oldStylestyle0.contains("border")&&oldStylestyle1!=""){
 conborder = true;
 oldstyle = oldstyle.replace(oldstyleArr[i],"");

}
 }

 }

 }
if(oldstyle!=""&&oldstyle.trim().length>0&&!oldstyle.trim().endWith(";")){
oldstyle+=";";
}
  if(isSetBorder)
oldstyle+=tdborder+";";
  if(isSetBase){
if(tdWidth!=0)
oldstyle+="width:"+tdWidth+options2.val()+";";
if(tdHeight!=0)
oldstyle+="height:"+tdHeight+optionsh2.val()+";";
if(fontSize!=""&&fontSize.trim().length>0)
oldstyle+="font-size:"+fontSize+"px;";
if(fontColor!=""&&fontColor.trim().length>0)
oldstyle+="color:"+fontColor+";";
	
var operation = "${param.operation}";
if(operation != 'other'){  //单元格
	oldstyle+="text-align:"+val+";";
	oldstyle+="vertical-align:"+val2+";";
	var background = document.getElementById('label_Color').style.backgroundColor;
	if(background!=null && background!=''){
		oldstyle+="background-color:"+background+";";
	}else{
		oldstyle+="background-color:rgb(255, 255, 255);"
	}
}
}

var h = [];
if(oldstyle.trim().length>0){
var m = oldstyle.split(";");
if(m!=null&&m.length>0){
for(var i=0;i<m.length;i++){
var n = m[i];
if(n.trim().length>0){
h.push(n);
}
}
}
}
var b="";
if(h!=null&&h.length>0){
b = h.join(";");
}
       if(b.trim().length>0&&b.endWith(";"))
   b = b.substring(0,b.length-1);   //截取最后一个分号
          //  var style = "text-align:"+val+";"+"vertical-align:"+val2+";"+"width:"+tdWidth+options2.val()+";"+tdborder+";";
            var data = {};
            data["style"]=b;
            Matrix.closeWindow(data);
        });
	  $("#button001").click(function(){
	   Matrix.closeWindow();
	  });
		$("input:checkbox[name='isSetBorder']").on('ifChecked', function(event){		
			 $("#bordertr").show();
		});
		$("input:checkbox[name='isSetBorder']").on('ifUnchecked', function(event){
			 $("#bordertr").hide(); 
		});
	
      });
    </script>
  </body>
</html>
