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
    <title>labelstyle.html</title>
	
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
   <jsp:include page="../../../../foundation/common/taglib.jsp"/>
<jsp:include page="../../../../foundation/common/resource.jsp"/>
  </head>
  
  <body onLoad="loadJS();" style="    overflow: auto;">
  <script>
                 function loadJS(){
                 debugger;
        var oldstyle= parent.Matrix.getFormItemValue('style');//父窗口样式字符串
 if(typeof(oldstyle)=='undefined')
 oldstyle="";
  if(oldstyle==null)
  oldstyle="";
 var oldstyleArr = [];
 
 if(oldstyle!=""&&oldstyle!=null){
 oldstyleArr=oldstyle.split(";");
 if(oldstyleArr!=null&&oldstyleArr.length>0){
 for(var i=0;i<oldstyleArr.length;i++){
 var oldStylestyle = oldstyleArr[i].split(":");
 var oldStylestyle0 = oldStylestyle[0];
 var oldStylestyle1 = oldStylestyle[1];
 if(oldStylestyle0.trim().startWith("color")&&oldStylestyle1!=""){
  $("#label_Color").val(oldStylestyle1);
  $("#colorselect")[0].style.backgroundColor=oldStylestyle1;
 }
 else if(oldStylestyle0.trim().startWith("font-family")&&oldStylestyle1!=""){
 $("#label_Font").val(oldStylestyle1);
 }
 else if(oldStylestyle0.trim().startWith("font-size")&&oldStylestyle1!=""){
 $("#label_Font_Size option[value="+oldStylestyle1+"]").attr("selected", true);
 
 }
 else if(oldStylestyle0.contains("font-weight")&&oldStylestyle1!=""){
   $("input[name='isBold'][value="+oldStylestyle1+"]").attr("checked",true); 

}
 }

 }

 }
       }  
                 function showtdcolor(){
                	  document.getElementById('tdcolor').style.display="block";
                	  var background = document.getElementById('tdbackground').style.backgroundColor;
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
  </script>
    <table style="width:100%;">
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
.input-group-addon {
    padding: 8px 12px;
        display: inline;
    }
</style>
 <tr>
    <td class="form_label">颜色</td>
  <td class="form_input">
  <div class="input-group demo2 colorpicker-element" style="margin-bottom: 6px; display: -webkit-inline-box;">
                            <input type="text" id="label_Color" style="width:220px;" value="#000000" class="form-control">
                            <span class="input-group-addon"><i id="colorselect" style="background-color: rgb(0, 0, 0);"></i></span>&nbsp;&nbsp;
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
   <tr>
  
    <td class="form_label">字体</td><td class="form_input">
    <select id="label_Font" class="form-control" style="    border-radius: 0px;width: 340px;">
   <option>默认</option>
    <option>宋体</option>
     <option>仿宋</option>
      <option>楷体</option>
      <option>华文行楷</option>
       <option>微软雅黑</option>
    <option>Times New Roman,Georgia,Serif</option>
    <option>Arial,Verdana,Sans-serif</option>
   
   
    </select>
    </td>
    </tr>
    <tr>
  
    <td class="form_label">大小</td><td class="form_input"><select id="label_Font_Size" class="form-control" style="    border-radius: 0px;width: 100px;">
    <option value="default">默认</option>
    <option value="medium">常规</option>
    <option value="large">大</option>
    <option value="x-large">加大</option>
    <option value="xx-large">超大</option>
    <option value="small">小</option>
    <option value="x-small">加小</option>
    <option value="xx-small">超小</option>
  <%
  
  for(int i=5;i<51;i++){
   %>
    <option value="<%=i %>px"><%=i %>px</option>
   <%
   }
   
    %>
   
    </select>
    </td>
    </tr>
    <tr>
  <td class="form_label">是否加粗</td>
  <td class="form_input">
  
  <input type="radio" name="isBold" value="bold" />是&nbsp;&nbsp;
  <input type="radio" name="isBold" checked="checked" value="normal" />否
 
  </td>
   </tr>
 <tr>
<td class="cmdLayout">
  <button id="button002" class="x-btn ok-btn " type="button">确定</button>
    <button style="margin-left:5px;" id="button001" class="x-btn cancel-btn " type="button">取消</button>
</td>


</tr>
 
    </table>
                <script>
      
      $(document).ready(function() {
 $("#button001").click(function(){
 Matrix.closeWindow();
 });
 $('.demo2').colorpicker().on('changeColor',function(ev){
	 var color = document.getElementById("label_Color").value;
	  document.getElementById("label_Color").style.backgroundColor = color; 
});
 $("#button002").click(function(){
 debugger;
 var oldstyle= parent.Matrix.getFormItemValue('style');//父窗口样式字符串
 if(typeof(oldstyle)=='undefined')
 oldstyle="";
 if(oldstyle==null)
  oldstyle="";
 var oldstyleArr = [];
 var concolor = false;//是否包含颜色
 var confont = false; //是否包含字体
 var confontsize = false;//是否包含字体大小
 var conbold = false;//是否包含加粗
 var bcolor=$("#label_Color").val();
        //alert(bcolor);
           var options=$("#label_Font option:selected");  

            //alert(options.val());   
  
          var options2=$("#label_Font_Size option:selected");  

       //     alert(options2.val());
             var val=$('input:radio[name="isBold"]:checked').val();
  
 if(oldstyle!=""&&oldstyle!=null){
 oldstyleArr=oldstyle.split(";");
 if(oldstyleArr!=null&&oldstyleArr.length>0){
 for(var i=0;i<oldstyleArr.length;i++){
 var oldStylestyle = oldstyleArr[i].split(":");
 var oldStylestyle0 = oldStylestyle[0];
 var oldStylestyle1 = oldStylestyle[1];
 if(oldStylestyle0.trim().startWith("color")&&oldStylestyle1!=""){
 oldstyle = oldstyle.replace(oldstyleArr[i],"color:"+bcolor);
 concolor = true;
 }
 else if(oldStylestyle0.trim().startWith("font-family")&&oldStylestyle1!=""){
 if(options.val()!="默认")
 oldstyle = oldstyle.replace(oldstyleArr[i],"font-family:"+options.val());
 else
 oldstyle = oldstyle.replace(oldstyleArr[i],"");
 confont = true;
 }
 else if(oldStylestyle0.trim().startWith("font-size")&&oldStylestyle1!=""){
 if(options2.val()!="default")
 oldstyle = oldstyle.replace(oldstyleArr[i],"font-size:"+options2.val());
 else
 oldstyle = oldstyle.replace(oldstyleArr[i],"");
 confontsize = true;
 }
 else if(oldStylestyle0.trim().contains("font-weight")&&oldStylestyle1!=""){
 conbold = true;
  oldstyle = oldstyle.replace(oldstyleArr[i],"font-weight:"+val);

}
 }

 }

 }
 if(oldstyle!=""&&oldstyle.trim().length>0&&!oldstyle.trim().endWith(";")){
oldstyle+=";";
}
 if(!concolor)
 oldstyle+="color:"+bcolor+";";
 if(!confont&&options.val()!='默认')
 oldstyle+="font-family:"+options.val()+";";
 if(!confontsize&&options2.val()!='default')
    oldstyle+=" font-size:"+options2.val()+";";
    if(!conbold)
      oldstyle+=" font-weight:"+val+";";     
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

     
      });
    </script>
  </body>
</html>
