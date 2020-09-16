<%@page pageEncoding="utf-8"%>
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
    <link href='../../../resource/html5/css/matrix_runtime.css' rel="stylesheet"></link>
   <link rel="stylesheet" type="text/css" href="../../../css/bootstrap.min.css">
     <link rel="stylesheet" type="text/css" href="bootstrap-colorpicker.min.css">
     <script src="../../../resource/html5/js/jquery.min.js"></script>
     <script src="ion.rangeSlider.min.js"></script> 
 <script src="bootstrap-colorpicker.min.js"></script>
 
 
  <script src="../../../resource/html5/js/bootstrap.min.js"></script>
  <jsp:include page="../../../foundation/common/taglib.jsp"/>
<jsp:include page="../../../foundation/common/resource.jsp"/>

  </head>
  
  <body onLoad = "loadJS();">
  <style>
  td{
  font-size:14px;
  }
  </style>
  <script>
  function loadJS(){
   var oldstyle= parent.Matrix.getFormItemValue('input001');//父窗口样式字符串
 if(typeof(oldstyle)=='undefined')
 oldstyle="";
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
  <table style="width:99%;">
  <td colspan="2" style="/* background: #0478D0; */color: #ffffff;/* height: 36px; */font-weight: bold;border-bottom: 1px solid #cccccc;"><label style="
    background: #0478D0;
    padding: 10px 14px;
    border-bottom: 1px solid transparent;
">单元格基本设置<label></label></label></td>
  <tr>
  <td class="form_label">宽度</td><td class="form_input"><input type=text id="td_Width" class="form-control" style="       border-radius: 0px; width: 220px;    " id="width" name="width"/>&nbsp;<select id="td_Width_Unit" class="form-control" style="    border-radius: 0px;width: 100px;"><option value="px">像素</option><option value="%">%</option></select></td>
  </tr>


  <tr>
  <td class="form_label">水平对齐</td>
  <td class="form_input">
  
  <input type="radio" checked="checked" name="alignstyle" value="left" />居左
  <input type="radio" name="alignstyle" value="center" />居中
 <input type="radio" name="alignstyle" value="right" />居右
  </td>
  
  </tr>

<tr>
  <td class="form_label">垂直对齐</td>
  <td class="form_input">
  
  <input type="radio" checked="checked" name="valignstyle" value="top" />居顶
  <input type="radio" name="valignstyle" value="middle" />居中
 <input type="radio" name="valignstyle" value="bottom" />居底
  </td>
  
  </tr>
<td colspan="2" style="/* background: #0478D0; */color: #ffffff;/* height: 36px; */font-weight: bold;border-bottom: 1px solid #cccccc;"><label style="
    background: #0478D0;
    padding: 10px 14px;
    border-bottom: 1px solid transparent;
">单元格边框设置<label></label></label></td>
<tr>

<td class="form_input">
  <div style="
    float: left;padding-top:6px;
">
线型：
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
颜色：
<br>
 <div class="input-group demo2 colorpicker-element" style="margin-bottom: 6px">
                            <input type="text" id="border_Color" style="width:220px;" value="#000000" class="form-control">
                            <span class="input-group-addon"><i style="background-color: rgb(0, 0, 0);"></i></span>
                          </div>
                         
宽度：<br>
<select id="border_Width" style="width:100px; border-radius: 0px;" class="form-control"><option value="1px">1像素</option><option value="2px">2像素</option></select>
  </div>
  <!--  
  <div style="
    float: right;
"><hr width="1" color="#828790" style="height:230px;margin-top:5px;margin-bottom:5px">
</div>
-->
</td>

<td  class="form_input">
预览
<table>
<script>
function addborder(obj,type){
if('up'==type){
if(obj.src.endsWith('ed.png')){
obj.src='image/upuncheck.png';
document.getElementById('tdcontent').style.borderTop='none';
}else{
obj.src='image/upchecked.png';
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
obj.src='image/downuncheck.png';
document.getElementById('tdcontent').style.borderBottom='none';
}else{
obj.src='image/downchecked.png';
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
obj.src='image/leftuncheck.png';
document.getElementById('tdcontent').style.borderLeft='none';
}else{
obj.src='image/leftchecked.png';
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
obj.src='image/rightuncheck.png';
document.getElementById('tdcontent').style.borderRight='none';
}else{
obj.src='image/rightchecked.png';
//document.getElementById('tdcontent').style.borderRightStyle='solid';
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
<tr>
<td style="vertical-align: middle;padding-right: 20px;">
<image style="margin-bottom: 5px;" src="image/upuncheck.png" onclick="addborder(this,'up');"></image>
<br/><image src="image/downuncheck.png" onclick="addborder(this,'down');"></image></td>
<td id="tdcontent"><image src="image/tdcontent.png" style="margin-left:2px"></td>
</tr>
<tr>
<td></td>
<td style="text-align: center;padding-top: 15px;">
<image style="margin-right: 5px;" src="image/leftuncheck.png" onclick="addborder(this,'left');"></image>
<image src="image/rightuncheck.png" onclick="addborder(this,'right');"></image></td>
</tr>
</table>
</td>
</tr>
<tr>
<td class="cmdLayout">
  <button id="button002" class="x-btn ok-btn " type="button">确定</button>
    <button style="margin-left:5px;" id="button001" class="x-btn cancel-btn " type="button">取消</button>
</td>


</tr>
  </table>
  <!-- 
  <div>
  <span style="width: 15px;height: 15px;background: rgb(255,255,255);display: block;border: 1px solid rgb(226,228,231);float: left;margin-right:5px"> </span>
  &nbsp;
  <span style="width: 15px;height: 15px;background: rgb(0,0,0);display: block;border: 1px solid rgb(226,228,231);float: left;margin-right:5px"> </span>
  &nbsp;
  <span style="width: 15px;height: 15px;background: rgb(231,230,230);display: block;border: 1px solid rgb(226,228,231);float: left;margin-right:5px"> </span>
  &nbsp;
   <span style="width: 15px;height: 15px;background: rgb(68,84,106);display: block;border: 1px solid rgb(226,228,231);float: left;margin-right:5px"> </span>
  &nbsp;
   <span style="width: 15px;height: 15px;background: rgb(91,155,213);display: block;border: 1px solid rgb(226,228,231);float: left;margin-right:5px"> </span>
  &nbsp;
  <span style="width: 15px;height: 15px;background: rgb(237,125,49);display: block;border: 1px solid rgb(226,228,231);float: left;margin-right:5px"> </span>
  &nbsp;
  </div>
   -->
   
                           <script>
      $(document).ready(function() {
      
       
        $('.demo2').colorpicker();
	  $("#button002").click(function(){
 var oldstyle= parent.Matrix.getFormItemValue('input001');//父窗口样式字符串
 if(typeof(oldstyle)=='undefined')
 oldstyle="";
 var oldstyleArr = [];
 var conwidth = false;//是否包含宽度
 var conalign = false; //是否包含水平对齐方式
 var convalign = false;//是否包含垂直对齐方式
 var conborder = false;//是否包含边框样式
 var val=$('input:radio[name="alignstyle"]:checked').val();
    // alert(val);
      var val2=$('input:radio[name="valignstyle"]:checked').val();
   //  alert(val2);
       var tdWidth=$("#td_Width").val();
       if(tdWidth==""||tdWidth==null)
       tdWidth=0;
    //    alert(tdWidth);
          var options2=$("#td_Width_Unit option:selected");  //

          //  alert(options2.val());
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
 oldstyle = oldstyle.replace(oldstyleArr[i],"width:"+tdWidth+options2.val());
 conwidth = true;
 }
 else if(oldStylestyle0.trim().startWith("text-align")&&oldStylestyle1!=""){
 oldstyle = oldstyle.replace(oldstyleArr[i],"text-align:"+val);
 conalign = true;
 }
 else if(oldStylestyle0.trim().startWith("vertical-align")&&oldStylestyle1!=""){
 oldstyle = oldstyle.replace(oldstyleArr[i],"vertical-align:"+val2);
 convalign = true;
 }
 else if(oldStylestyle0.contains("border")&&oldStylestyle1!=""){
 conborder = true;
 oldstyle = oldstyle.replace(oldstyleArr[i],"");

}
 }

 }

 }
  if(conborder)
oldstyle+=tdborder+";";
if(!conborder&& tdborder!="border:none;")
oldstyle+=tdborder;
if(!conwidth&&tdWidth!=0)
oldstyle+="width:"+tdWidth+options2.val()+";";
if(!conalign)
oldstyle+="text-align:"+val+";";
if(!convalign)
oldstyle+="vertical-align:"+val2+";";
    
          //  var style = "text-align:"+val+";"+"vertical-align:"+val2+";"+"width:"+tdWidth+options2.val()+";"+tdborder+";";
            Matrix.closeWindow(oldstyle);
        });
	  $("#button001").click(function(){
	   Matrix.closeWindow();
	  });
      });
    </script>
    <input type="hidden" value="span001" id="clickspan" name="clickspan"/>
  </body>
</html>
