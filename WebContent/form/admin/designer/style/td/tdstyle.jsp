<%@page pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML><html>

<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<head>
    <title>tdstyle.html</title>
	
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="this is my page">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    
    <!--<link rel="stylesheet" type="text/css" href="./styles.css">-->
   <link rel="stylesheet" type="text/css" href="../../../../../resource/html5/css/bootstrap.min.css">
     <link rel="stylesheet" type="text/css" href="../bootstrap-colorpicker.min.css">
     <script src="../../../../../resource/html5/js/jquery.min.js"></script>
     <script src="../ion.rangeSlider.min.js"></script> 
 <script src="../bootstrap-colorpicker.min.js"></script>
 
 
  <script src="../../../../../resource/html5/js/bootstrap.min.js"></script>
  <jsp:include page="../../../../../foundation/common/taglib.jsp"/>
<jsp:include page="../../../../../foundation/common/resource.jsp"/>

  </head>
  
  <body onLoad = "loadJS();" >
  <style>
  td{
  font-size:14px;
  }
  .input-group-addon {
    padding: 8px 12px;
        display: inline;
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
	  document.getElementById('tdcolor1').style.display="none";

		  var aOts = $('#tdcolor1 a');
		  for(var i=0;i<aOts.length;i++){
			  if(aOts[i].style.border=="1px solid rgb(195, 20, 20)"){
			  aOts[i].style.border="1px solid #E2E4E7";
			  
			  }
		  }
	  }
  
  function loadJS(){
  
   var oldstyle= parent.Matrix.getFormItemValue('style');//父窗口样式字符串
   
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
  $("input[id='isSetBase']").attr("checked",'true');//全选  
  break;
 }
 }
 }
 if(oldstyle.contains("border")){
  $("#bordertr").show();
    $("input[id='isSetBorder']").attr("checked",'true');//全选  
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
  document.getElementById('label_Color').style.backgroundColor = oldStylestyle1;
 }
 else if(oldStylestyle0.trim().startWith("text-align")&&oldStylestyle1!=""){
 $("input[name='alignstyle'][value="+oldStylestyle1+"]").attr("checked",true); 

 }
 else if(oldStylestyle0.trim().startWith("vertical-align")&&oldStylestyle1!=""){
  $("input[name='valignstyle'][value="+oldStylestyle1+"]").attr("checked",true); 
 }
 else if(oldStylestyle0.trim().contains("border")&&oldStylestyle1!=""){

bordercss+= oldstyleArr[i]+";";

}
 }

 }
 }
 document.getElementById('tdcontent').style.cssText = bordercss;
  }
$(function () {
$('.span1').click(function () {

var oldid = document.getElementById('clickspan').value;
if(oldid==$(this)[0].id){
}
else{
$("#"+oldid).removeClass('outspan');
$("#"+oldid).children().removeClass('inspan');
$("#"+oldid).addClass('outspanuncheck');
$("#"+oldid).children().addClass('inspanuncheck');
$(this).removeClass('outspanuncheck');
$(this).children().removeClass('inspanuncheck');
$(this).addClass('outspan');
$(this).children().addClass('inspan');
document.getElementById('clickspan').value=$(this)[0].id;
}
});

}); 
</script>
  <div style="width:99%;height:90%;overflow:auto;">
<table style="width:99%;">
  <tbody><tr><td colspan="2" style="/* background: #0478D0; */color: #ffffff;/* height: 36px; */font-weight: bold;border-bottom: 1px solid #cccccc;"><label style="
    /* background: #0478D0;
    padding: 10px 14px;
    border-bottom: 1px solid transparent;
     */
     padding: 10px 14px;
    color: #4A4D4A;
    background-color: rgb(250, 250, 250);
    font-weight: bold;
    font-size:14px;
">单元格基本设置</label>
<input type="checkbox" id="isSetBase" name="isSetBase">
</td>
  </tr><tr>
  <td class="form_label" style="width:40%">宽度</td><td class="form_input"><input type="text" id="td_Width" class="form-control" style="       border-radius: 0px; width: 220px;    " name="width">&nbsp;<select id="td_Width_Unit" class="form-control" style="    border-radius: 0px;width: 100px;"><option value="px">像素</option><option value="%">%</option></select></td>
  </tr>

<tr>
  <td class="form_label" style="width:40%">高度</td><td class="form_input"><input type="text" id="td_Height" class="form-control" style="       border-radius: 0px; width: 220px;    " name="width">&nbsp;<select id="td_Height_Unit" class="form-control" style="    border-radius: 0px;width: 100px;"><option value="px">像素</option><option value="%">%</option></select></td>
  </tr>
  <tr>
  <td class="form_label" style="width:40%">水平对齐</td>
  <td class="form_input">
  
  <input type="radio" checked="checked" name="alignstyle" value="left">居左
  <input type="radio" name="alignstyle" value="center">居中
 <input type="radio" name="alignstyle" value="right">居右
  </td>
  
  </tr>

<tr>
  <td class="form_label" style="width:40%">垂直对齐</td>
  <td class="form_input">
  
  <input type="radio" checked="checked" name="valignstyle" value="top">居顶
  <input type="radio" name="valignstyle" value="middle">居中
 <input type="radio" name="valignstyle" value="bottom">居底
  </td>
  
  </tr>
  <tr>
  <td class="form_label" style="width:40%">背景颜色</td>
<td class="form_input">
 <div class="input-group demo2 colorpicker-element" style="margin-bottom: 6px ; display: -webkit-inline-box;">
 <!--  <div style="border: 1px solid #ACACAC;border-radius: 0px;width: 220px;" class="form-control">
  <span style="   padding:0 0;   display:inline-block; height:20px;border-radius: 0px; width:194px; background-color:#ffffff; " id="tdbackground"></span>
  </div> -->
  <input type="text" id="label_Color" style="width:220px;" value="#000000" class="form-control" >
  <span class="input-group-addon" ><i id="colorselect" style="background-color: rgb(0, 0, 0);"></i> </span>
       </div>
    <input type="button" value="选择颜色" onclick="showtdcolor();">
    <div id="tdcolor" style="display:none;position:relative;/* width:200px; */top:0px;z-index:999999;background:#ffffff;">
  <a id="a1" href="javascript:selectcolor('a1');" style="width: 15px; height: 15px; display: block; border: 1px solid rgb(226, 228, 231); float: left; margin-right: 5px; padding: 1px; background: rgb(255, 255, 255);" onmouseover="this.style.border='1px solid #c31414';this.style.padding='1px 1px'" onmouseout="this.style.border='1px solid #E2E4E7';"> </a>
  &nbsp;
  <a id="a2" href="javascript:selectcolor('a2');" style="width: 15px; height: 15px; display: block; border: 1px solid rgb(226, 228, 231); float: left; margin-right: 5px; padding: 1px; background: rgb(0, 0, 0);" onmouseover="this.style.border='1px solid #c31414';this.style.padding='1px 1px'" onmouseout="this.style.border='1px solid #E2E4E7';"> </a>
  &nbsp;
  <a id="a3" href="javascript:selectcolor('a3');" style="width: 15px; height: 15px; display: block; border: 1px solid rgb(226, 228, 231); float: left; margin-right: 5px; padding: 1px; background: rgb(231, 230, 230);" onmouseover="this.style.border='1px solid #c31414';this.style.padding='1px 1px'" onmouseout="this.style.border='1px solid #E2E4E7';"> </a>
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
<tr><td colspan="2" style="/* background: #0478D0; */color: #ffffff;/* height: 36px; */font-weight: bold;border-bottom: 1px solid #cccccc;"><label style="
     padding: 10px 14px;
    color: #4A4D4A;
    background-color: rgb(250, 250, 250);
    font-weight: bold;
    font-size:14px;
">单元格边框设置</label><input type="checkbox" id="isSetBorder" name="isSetBorder"></td>
</tr><tr id="bordertr">

<td class="form_input">
  <div style="
    float: left;padding-top:6px;
">
线型:
<br>
<style>
.form_label{
    text-align: center;
    color: #4A4D4A;
    background-color: rgb(250, 250, 250);
    padding: 3px 3px 3px 3px;
    margin: 0;
    padding: 0;
    height: 41px;
    border: 1px solid #cccccc;
  /*  font-family: "Microsoft YaHei";
    font-size: 12px;*/
}
.form_input{
    height: 28px;
    border: 1px solid #cccccc;
    text-align: left;
    padding: 3px 3px 3px 3px;
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
.input-group-addon {
    padding: 8px 12px;
        display: inline;
    }
</style>
<div style="overflow-y: scroll;margin-bottom: 6px;height: auto;width: 260px;border: 1px solid #828790;">
<span id="span001" class="span1 outspan" style="display:block;margin: 2px 2px 0px 2px;">
<span class="span2 inspan" style="padding: 0 7px;display: block;">
<hr style="border: 1px solid;margin-top: 10px;margin-bottom: 10px;">
</span>
</span>
<span id="span002" class="span1 outspanuncheck" style="display:block;margin: 0px 2px 0px 2px;">
<span class="span2 inspanuncheck" style="padding: 0 7px;display:block;">
<hr style="border:1px dotted;margin-top: 10px;margin-bottom: 10px;">
</span>
</span>
<span id="span003" class="span1 outspanuncheck" style="display:block;    margin:0px 2px 2px 2px;">
<span class="span2 inspanuncheck" style="padding: 0 7px;display:block;">
<hr style="border:1px dashed;margin-top: 10px;margin-bottom: 10px;">
</span>
</span>

</div>
颜色:<br>
 <div class="input-group demo3 colorpicker-element" style="margin-bottom: 6px;display:inline-table;">
                            <input type="text" id="border_Color" style="width:180px;" value="#000000" class="form-control">
                            <span class="input-group-addon"><i style="background-color: rgb(0, 0, 0);"></i></span>
                            
                          </div>
                          <div style="display:inline">
                          	<input type="button" value="选择颜色" onclick="showtdcolor1();">
                          </div>

<div id="tdcolor1" style="display:none;position:relative;/* width:200px; */top:0px;z-index:999999;background:#ffffff;">
  <a id="a1" href="javascript:selectcolor1('a1');" style="width: 15px; height: 15px; display: block; border: 1px solid rgb(226, 228, 231); float: left; margin-right: 5px; padding: 1px; background: rgb(255, 255, 255);" onmouseover="this.style.border='1px solid #c31414';this.style.padding='1px 1px'" onmouseout="this.style.border='1px solid #E2E4E7';"> </a>
  &nbsp;
  <a id="a2" href="javascript:selectcolor1('a2');" style="width: 15px; height: 15px; display: block; border: 1px solid rgb(226, 228, 231); float: left; margin-right: 5px; padding: 1px; background: rgb(0, 0, 0);" onmouseover="this.style.border='1px solid #c31414';this.style.padding='1px 1px'" onmouseout="this.style.border='1px solid #E2E4E7';"> </a>
  &nbsp;
  <a id="a3" href="javascript:selectcolor1('a3');" style="width: 15px; height: 15px; display: block; border: 1px solid rgb(226, 228, 231); float: left; margin-right: 5px; padding: 1px; background: rgb(231, 230, 230);" onmouseover="this.style.border='1px solid #c31414';this.style.padding='1px 1px'" onmouseout="this.style.border='1px solid #E2E4E7';"> </a>
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
宽度：<br>
<select id="border_Width" style="width:100px; border-radius: 0px;" class="form-control">
<option value="1px">1像素</option><option value="2px">2像素</option>
<option value="3px">3像素</option><option value="4px">4像素</option>
<option value="5px">5像素</option><option value="6px">6像素</option>
<option value="7px">7像素</option><option value="8px">8像素</option>
<option value="9px">9像素</option><option value="10px">10像素</option>
</select>
  </div>
  <!--  
  <div style="
    float: right;
"><hr width="1" color="#828790" style="height:230px;margin-top:5px;margin-bottom:5px">
</div>
-->
</td>

<td class="form_input">
预览<table>
<script>
//全选
   function allSelect(){
      var options=$("#border_Width option:selected");  //

      document.getElementById('tdcontent').style.borderWidth=options.val();
            var bcolor=$("#border_Color").val();
        document.getElementById('tdcontent').style.borderColor=bcolor;
             var clickspan=$("#clickspan").val();
             var style = "solid";
    if(clickspan=='span002')
     style = "dotted";
     else if(clickspan=='span003')
      style = "dashed";
      document.getElementById('tdcontent').style.borderStyle=style;
    }
	//全不选
	function allNotSelect(){
	   document.getElementById('tdcontent').style.border='none';
	}
	//上边框下边框 左边框 右边框 type 事件
	function addborder(obj,type){
	if('up'==type){
		if(obj.src.endsWith('ed.png')){
			obj.src='<%=path%>/form/admin/designer/style/image/upuncheck.png';
			document.getElementById('tdcontent').style.borderTop='none';
		}else{
		  obj.src='<%=path%>/form/admin/designer/style/image/upchecked.png';
		//document.getElementById('tdcontent').style.borderTopStyle='solid';
		  var options=$("#border_Width option:selected");  //
		
		   document.getElementById('tdcontent').style.borderTopWidth=options.val();
		            var bcolor=$("#border_Color").val();
		        document.getElementById('tdcontent').style.borderTopColor=bcolor;
		             var clickspan=$("#clickspan").val();
		             var style = "solid";
		    if(clickspan=='span002')
		     style = "dotted";
		     else if(clickspan=='span003')
		      style = "dashed";
		      document.getElementById('tdcontent').style.borderTopStyle=style;
		}
	}else if('down'==type){
		if(obj.src.endsWith('ed.png')){
			obj.src='<%=path%>/form/admin/designer/style/image/downuncheck.png';
			document.getElementById('tdcontent').style.borderBottom='none';
		}else{
		  obj.src='<%=path%>/form/admin/designer/style/image/downchecked.png';
		//document.getElementById('tdcontent').style.borderBottomStyle='solid';
		  var options=$("#border_Width option:selected");  //
		
		   document.getElementById('tdcontent').style.borderBottomWidth=options.val();
		            var bcolor=$("#border_Color").val();
		        document.getElementById('tdcontent').style.borderBottomColor=bcolor;
		             var clickspan=$("#clickspan").val();
		             var style = "solid";
		    if(clickspan=='span002')
		     style = "dotted";
		     else if(clickspan=='span003')
		      style = "dashed";
		      document.getElementById('tdcontent').style.borderBottomStyle=style;
		}
	}
	else if('left'==type){
		if(obj.src.endsWith('ed.png')){
			obj.src='<%=path%>/form/admin/designer/style/image/leftuncheck.png';
			document.getElementById('tdcontent').style.borderLeft='none';
		}else{
		  obj.src='<%=path%>/form/admin/designer/style/image/leftchecked.png';
		//document.getElementById('tdcontent').style.borderLeftStyle='solid';
		  var options=$("#border_Width option:selected");  //
		
		   document.getElementById('tdcontent').style.borderLeftWidth=options.val();
		            var bcolor=$("#border_Color").val();
		        document.getElementById('tdcontent').style.borderLeftColor=bcolor;
		             var clickspan=$("#clickspan").val();
		             var style = "solid";
		    if(clickspan=='span002')
		     style = "dotted";
		     else if(clickspan=='span003')
		      style = "dashed";
		      document.getElementById('tdcontent').style.borderLeftStyle=style;
		}
	}
	else if('right'==type){
		if(obj.src.endsWith('ed.png')){
			obj.src='<%=path%>/form/admin/designer/style/image/rightuncheck.png';
			document.getElementById('tdcontent').style.borderRight='none';
		}else{
		  obj.src='<%=path%>/form/admin/designer/style/image/rightchecked.png';
		  var options=$("#border_Width option:selected");  //
		
		   document.getElementById('tdcontent').style.borderRightWidth=options.val();
		            var bcolor=$("#border_Color").val();
		        document.getElementById('tdcontent').style.borderRightColor=bcolor;
		             var clickspan=$("#clickspan").val();
		             var style = "solid";
		    if(clickspan=='span002')
		     style = "dotted";
		     else if(clickspan=='span003')
		      style = "dashed";
		      document.getElementById('tdcontent').style.borderRightStyle=style;
		}
	}
	
	}
</script>
<tbody>
<tr>
<td></td>
<td style="text-align: center;padding-top: 15px;">
<img style="margin-right: 5px;" src="<%=path%>/form/admin/designer/style/image/check.png" onclick="allSelect();" title="全选">
<img src="<%=path%>/form/admin/designer/style/image/uncheck.png" onclick="allNotSelect();" title="全不选"></td>
</tr>
<tr>
<td style="vertical-align: middle;padding-right: 20px;">
<img style="margin-bottom: 5px;" src="<%=path%>/form/admin/designer/style/image/upuncheck.png" onclick="addborder(this,'up');">
<br><img src="<%=path%>/form/admin/designer/style/image/downuncheck.png" onclick="addborder(this,'down');"></td>
<td id="tdcontent"><img src="<%=path%>/form/admin/designer/style/image/tdcontent.png" style="margin-left:2px"></td>
</tr>
<tr>
<td></td>
<td style="text-align: center;padding-top: 15px;">
<img style="margin-right: 5px;" src="<%=path%>/form/admin/designer/style/image/leftuncheck.png" onclick="addborder(this,'left');">
<img src="<%=path%>/form/admin/designer/style/image/rightuncheck.png" onclick="addborder(this,'right');"></td>
</tr>
</tbody></table>
</td>
</tr>
<tr>
<td height="100px"></td></tr>
  </tbody></table>
    
  </div>

  <div style="vertical-align:middle; background-color:rgb(250, 250, 250); border-top: 1px solid #e5e5e5;color:#fff;width:100%;position: fixed;bottom: 0px;height:10%;/*padding: 14px 15px 15px; margin-bottom: 0; */text-align: center;">
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
         });

	  $("#button002").click(function(){
		  debugger;
	   var oldstyle= parent.Matrix.getFormItemValue('style');//父窗口样式字符串
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
//if(!conalign)
oldstyle+="text-align:"+val+";";
//if(!convalign)
oldstyle+="vertical-align:"+val2+";";
 var background = document.getElementById('label_Color').style.backgroundColor;
 oldstyle+="background-color:"+background+";";
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
	  $("input[type='checkbox']").change(function(){
	  	  var borderset = $("input[id='isSetBorder']").is(':checked');
	  if(borderset){
	  $("#bordertr").show();
	  }else{
	   $("#bordertr").hide(); 
	  }
	  });
	  
	
      });
    </script>
    <input type="hidden" value="span001" id="clickspan" name="clickspan"/>
  </body>
</html>
