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
    <title>inputstyle.html</title>
	
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="this is my page">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    
    <!--<link rel="stylesheet" type="text/css" href="./styles.css">-->
    <link href='../../../../resource/html5/css/matrix_runtime.css' rel="stylesheet"></link>
   <link rel="stylesheet" type="text/css" href="../../../../css/bootstrap.min.css">
     <link rel="stylesheet" type="text/css" href="bootstrap-colorpicker.min.css">
     <script src="../../../../resource/html5/js/jquery.min.js"></script>
     <script src="ion.rangeSlider.min.js"></script> 
 <script src="bootstrap-colorpicker.min.js"></script>
 
 
  <script src="../../../../../resource/html5/js/bootstrap.min.js"></script>
  <jsp:include page="../../../../foundation/common/taglib.jsp"/>
<jsp:include page="../../../../foundation/common/resource.jsp"/>

  </head>
  
  <body onLoad = "loadJS();" >
  <style>
  td{
  font-size:14px;
  }
  </style>
  <script>


  function loadJS(){
  
   var oldstyle= parent.Matrix.getFormItemValue('style');//父窗口样式字符串
   
 if(typeof(oldstyle)=='undefined'||oldstyle==null)
 oldstyle="";
 if(oldstyle!=""){
 var oldstyleArr=oldstyle.split(";");
 if(oldstyleArr!=null&&oldstyleArr.length>0){
 for(var i=0;i<oldstyleArr.length;i++){
 var oldStylestyle = oldstyleArr[i].split(":");
 var oldStylestyle0 = oldStylestyle[0];
  var oldStylestyle1 = oldStylestyle[1];
 
 if(oldStylestyle0.trim().startWith("width")&&oldStylestyle1!=""){
 // $("input[id='isSetBase']").attr("checked",'true');//全选  
  break;
 }
 }
 }
 //if(oldstyle.contains("border")){
  //$("#bordertr").show();
   // $("input[id='isSetBorder']").attr("checked",'true');//全选  
 //}else{
  //$("#bordertr").hide(); 
  
 //}
 }
 //else{
  //$("#bordertr").hide(); 
 //}

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
 else if(oldStylestyle0.trim().contains("border")&&oldStylestyle1!=""){

//bordercss+= oldstyleArr[i]+";";

}
 }

 }
 }
 //document.getElementById('tdcontent').style.cssText = bordercss;
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
  <div style="width:99%;height:90%;overflow:auto;">
<table style="width:99%;">
  <tbody>
 
  <tr>
  <td class="form_label" style="width:40%">宽度</td><td class="form_input"><input type="text" id="td_Width" class="form-control" style="       border-radius: 0px; width: 220px;    " name="width">&nbsp;<select id="td_Width_Unit" class="form-control" style="    border-radius: 0px;width: 100px;"><option value="px">像素</option><option value="%">%</option></select></td>
  </tr>
  <!--  
<tr><td colspan="2" style="/* background: #0478D0; */color: #ffffff;/* height: 36px; */font-weight: bold;border-bottom: 1px solid #cccccc;"><label style="
     padding: 10px 14px;
    color: #4A4D4A;
    background-color: rgb(250, 250, 250);
    font-weight: bold;
    font-size:14px;
">输入框边框设置</label><input type="checkbox" id="isSetBorder" name="isSetBorder"></td>
</tr><tr id="bordertr">

<td class="form_input">
  <div style="
    float: left;padding-top:6px;
">
线型：
<br>

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
 
</td>

<td class="form_input">
预览
<table>

<tbody>
<tr>
<td></td>
<td style="text-align: center;padding-top: 15px;">
<img style="margin-right: 5px;" src="<%=path%>/form/admin/designer/style/image/leftuncheck.png" onclick="allSelect();" title="全选">
<img src="<%=path%>/form/admin/designer/style/image/rightuncheck.png" onclick="allNotSelect();" title="全不选"></td>
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
 -->
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
  </tbody></table>
    
  </div>

  <div class="cmdLayout">
  <button id="button002" class="x-btn ok-btn" type="button">确定</button>
   <button style="margin-left:5px;" id="button001" class="x-btn cancel-btn " type="button">取消</button>
  </div>
 

 
   
                           <script>
      $(document).ready(function() {
      
       
        $('.demo2').colorpicker();
	  $("#button002").click(function(){
	   var oldstyle= parent.Matrix.getFormItemValue('style');//父窗口样式字符串
       if(typeof(oldstyle)=='undefined'||oldstyle==null)
       oldstyle="";
       
       var oldstyleArr = [];
       var conwidth = false;//是否包含宽度
   //    var conborder = false;//是否包含边框样式
       var isSetBase = $("input[id='isSetBase']").is(':checked');//是否设置基本设置
    //   var isSetBorder = $("input[id='isSetBorder']").is(':checked');//是否设置边框
       var tdWidth=$("#td_Width").val();    //单元格宽度值
       if(tdWidth==""||tdWidth==null)
       tdWidth=0;
       var options2=$("#td_Width_Unit option:selected");  //单元格宽度单位
 
    //   var tdborder = document.getElementById('tdcontent').style.cssText;
       //    if(tdborder==""||tdborder==null)
       //    tdborder="border:none;";
          
           
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
 else if(oldStylestyle0.contains("border")&&oldStylestyle1!=""){
 //conborder = true;
 //oldstyle = oldstyle.replace(oldstyleArr[i],"");

}
 }

 }

 }
if(oldstyle!=null&&oldstyle!=""&&oldstyle.trim().length>0&&!oldstyle.trim().endWith(";")){
oldstyle+=";";
}
 // if(isSetBorder)
//oldstyle+=tdborder+";";
  //if(isSetBase){
if(tdWidth!=0)
oldstyle+="width:"+tdWidth+options2.val()+";";

//}

var h = [];
if(oldstyle!=null&&oldstyle!=""&&oldstyle.trim().length>0){
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
       if(b!=null&&b!=""&&b.trim().length>0&&b.endWith(";"))
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
