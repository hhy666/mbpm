<%@page pageEncoding="utf-8"%>
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
    <link href='../../../resource/html5/css/matrix_runtime.css' rel="stylesheet"></link>
 <link rel="stylesheet" type="text/css" href="../../../css/bootstrap.min.css">
      <link rel="stylesheet" type="text/css" href="bootstrap-colorpicker.min.css">
     <script src="../../../resource/html5/js/jquery.min.js"></script>
     <script src="ion.rangeSlider.min.js"></script> 
 <script src="bootstrap-colorpicker.min.js"></script>
   <jsp:include page="../../../foundation/common/taglib.jsp"/>
<jsp:include page="../../../foundation/common/resource.jsp"/>
  </head>
  
  <body onLoad="loadJS();">
  <script>
                 function loadJS(){
                 debugger;
        var oldstyle= parent.Matrix.getFormItemValue('input002');//父窗口样式字符串
 if(typeof(oldstyle)=='undefined')
 oldstyle="";
 var oldstyleArr = [];
 
 if(oldstyle!=""&&oldstyle!=null){
 oldstyleArr=oldstyle.split(";");
 if(oldstyleArr!=null&&oldstyleArr.length>0){
 for(var i=0;i<oldstyleArr.length;i++){
 var oldStylestyle = oldstyleArr[i].split(":");
 var oldStylestyle0 = oldStylestyle[0];
 var oldStylestyle1 = oldStylestyle[1];
 if(oldStylestyle0.trim().startWith("font-color")&&oldStylestyle1!=""){
 $("#label_Color").val(oldStylestyle1);
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
  1</script>
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
  <div class="input-group demo2 colorpicker-element" style="margin-bottom: 6px">
                            <input type="text" id="label_Color" style="width:220px;" value="#000000" class="form-control">
                            <span class="input-group-addon"><i style="background-color: rgb(0, 0, 0);"></i></span>
                          </div>
                           </td>
  </tr>
   <tr>
  
    <td class="form_label">字体</td><td class="form_input">
    <select id="label_Font" class="form-control" style="    border-radius: 0px;width: 340px;"><option>"Times New Roman",Georgia,Serif</option><option>Arial,Verdana,Sans-serif</option></select>
    </td>
    </tr>
    <tr>
  
    <td class="form_label">大小</td><td class="form_input"><select id="label_Font_Size" class="form-control" style="    border-radius: 0px;width: 100px;"><option value="12px">12px</option><option value="14px">14px</option></select>
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
        $('.demo2').colorpicker();
 $("#button002").click(function(){
 debugger;
 var oldstyle= parent.Matrix.getFormItemValue('input002');//父窗口样式字符串
 if(typeof(oldstyle)=='undefined')
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
 if(oldStylestyle0.trim().startWith("font-color")&&oldStylestyle1!=""){
 oldstyle = oldstyle.replace(oldstyleArr[i],"font-color:"+bcolor);
 concolor = true;
 }
 else if(oldStylestyle0.trim().startWith("font-family")&&oldStylestyle1!=""){
 oldstyle = oldstyle.replace(oldstyleArr[i],"font-family:"+options.val());
 confont = true;
 }
 else if(oldStylestyle0.trim().startWith("font-size")&&oldStylestyle1!=""){
 oldstyle = oldstyle.replace(oldstyleArr[i],"font-size:"+options2.val());
 confontsize = true;
 }
 else if(oldStylestyle0.trim().contains("font-weight")&&oldStylestyle1!=""){
 conbold = true;
  oldstyle = oldstyle.replace(oldstyleArr[i],"font-weight:"+val);

}
 }

 }

 }
 if(!concolor)
 oldstyle+="font-color:"+bcolor+";";
 if(!confont)
 oldstyle+="font-family:"+options.val()+";";
 if(!confontsize)
    oldstyle+=" font-size:"+options2.val()+";";
    if(!conbold)
      oldstyle+=" font-weight:"+val+";";     
   
  // alert(style);
   Matrix.closeWindow(oldstyle);
        });

     
      });
    </script>
  </body>
</html>
