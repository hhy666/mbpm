<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<html><head id="linkList">
<link href='<%=request.getContextPath() %>/resource/html5/css/printStyle.css'></link>
<link href='<%=request.getContextPath() %>/resource/css/default.print.css' rel='stylesheet' type="text/css"></link>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
basePath = path+"/";
%>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!--签章控件需要在IE9模式下才能显示
        <!-- <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE9"> -->
        <title>打印</title>
        <script src="<%=path%>/resource/html5/js/jquery.min.js"></script>
        <script src="<%=path%>/resource/html5/js/jquery.jqprint-0.3.js"></script>
       <style>
            .body{
                border-top:10px #ededed solid;
                border-bottom:0px #ededed solid;
                margin:0px;
                background:#fff;
            }
            body, div, dl, dt, dd, pre, code, form, input, button, textarea, p, th, td, ul, li {
    margin: 0;
    padding: 0;
    font-family: "Microsoft YaHei",SimSun,Arial,Helvetica,sans-serif;
}
            .margin_b_5 {
    margin-bottom: 5px;
}
.margin_t_5 {
    margin-top: 5px;
}

.font_size12 {
    font-size: 12px;
}
            .common_button, .form_btn {
    font-size: 12px;
    border: 1px solid #CCC;
    color: #111;
    background: #EAEAEA;
    border-radius: 5px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    max-width: 91px;
    display: inline-block;
    padding: 0 10px;
    line-height: 24px;
    height: 24px;
    vertical-align: middle;
    _vertical-align: baseline;
    display: inline-block;
}
         
            .common_button:HOVER, .form_btn:HOVER {
    font-size: 12px;
    border: 1px solid #CCC;
    color: #111;
    background: #F5F5F5;
    border-radius: 5px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    max-width: 91px;
    display: inline-block;
    padding: 0 10px;
    line-height: 24px;
    height: 24px;
    vertical-align: middle;
    _vertical-align: baseline;
    display: inline-block;
}   
            /***全局样式干扰表单样式，此处需要重新定义这些样式***/
            #context div,#context form,#context input,#context textarea,#context p,#context th,#context td,#context ul,#context li{
				font-family: inherit;
			}
            .header{
                background:#ededed;
            }
            #context{
                background:#ffffff;
                margin:0px auto;
              /*  padding-left:35px;
                padding-right:35px;*/
                word-break: break-all;
            }
            /**input框被替换成了span导致input[type='text']无法适用于原来的input内容，所以添加此样式**/
            span[type="text"]{
				font-size:12px;
				height:auto;
				line-height: 20px;
				white-space: normal;
			}
            @media print{
                #header{
                    display:none;
                }
                .body{
                    border:1px;
                    margin:0px;
                }
                #iSignatureHtmlDiv{
                	display:none;
                }
            }
            
        </style>
                <script>
     
var contentType = "20";      
var viewState = "1";     

function thisclose(){
 window.close();
}
function printIt(n){
   var _WebBrowser = document.getElementById('WebBrowser');
  /* var frame = window.frames[0];
	frame.focus();
	var head_str = "<html><head><title></title></head><body>"; //先生成头部
    var foot_str = "</body></html>"; //生成尾部
	//var a = document.getElementById("context").outerHTML ;
//	var a = document.getElementById('time').contentWindow.document.getElementsByTagName('form')[0].outerHTML;
	//var a = document.getElementById('time').contentWindow.document.getElementsByTagName('form')[0].innerHTML;
	var a = document.getElementById('time').contentWindow.document.getElementById('table001').outerHTML;
	var s = frame.document.body.innerHTML;
//	var asd = "<div style='zoom:"+z+"'>";
	var asd = head_str+a+foot_str;
//	asd += a+"</div>";
	//document.write(a);
	//alert(asd);
	frame.document.body.innerHTML = asd; */
	var z = document.getElementById('time').contentWindow.document.getElementsByTagName('form')[0].style.zoom;
  if(n==1){
	 var pdid = '${param.pdid}';
	 if($("#time").contents().find(".cke_wysiwyg_frame").length > 0){//ckeditor编辑器时候
		 $("#time").contents().find(".cke_wysiwyg_frame").contents().find("body").css("zoom",z);
		$("#time").contents().find(".cke_wysiwyg_frame").contents().find("body").jqprint({ 
	          debug: false,            
	          importCSS: true,         
	          printContainer: true,    
	          operaSupport: false   
	      });
	 }else{//正常
	  $(window.frames["time"].document).find("#form0").css("zoom",z);
	   $(window.frames["time"].document).find("#form0").jqprint({ 
          debug: false,      //如果是true则可以显示iframe查看效果（iframe默认高和宽都很小，可以再源码中调大），默认是false  
          importCSS: true,    //true表示引进原来的页面的css，默认是true。（如果是true，先会找$("link[media=print]")，若没有会去找$("link")中的css文件）       
          printContainer: true,   //表示如果原来选择的对象必须被纳入打印（注意：设置为false可能会打破你的CSS规则）。 
          operaSupport: false    //表示如果插件也必须支持歌opera浏览器，在这种情况下，它提供了建立一个临时的打印选项卡。默认是true    
      });
	 }
//	frame.print();
	/* frame.document.body.innerHTML = s; */
  }else{
    try {
		document.all.time.ExecWB(n,1);
		frame.document.body.innerHTML = s;
    }catch(e){}
  }
}
var _currentZoom = 0;
function doChangeSize(changeType){
  //var content = document.getElementById("context") ;
  var content = document.getElementById('time').contentWindow.document.getElementsByTagName('form')[0];
  //var content = document.getElementById('time').contentWindow.document.getElementById("table001");
  if(content.style.zoom == "" || undefined || null ){
  content.style.zoom = '1';
  }
  if(changeType == "bigger") {
      thisMoreBig(content);
  }else if(changeType == "smaller"){
      thisSmaller(content);
  }else if(changeType == "self"){
      thisToSelf(content); 
  }else if(changeType == "customize"){
      thisCustomize(content) ;
  }
}
function thisMoreBig(content,size){
  if(!size){
    size = 0.05 ;
  }
  zoomIt(content,size);
}
function thisSmaller(content,size){
  if(!size){
    size = -0.05 ;
  }else {
    size = size * -1;
  }
  zoomIt(content,size);
}
function thisToSelf(content){
  zoomIt(content);
}
function thisCustomize(content){
  var print8 = document.getElementById("print8") ;
  
  if(content && print8 && print8.value != "" ){
      if(isNaN(print8.value)){
        alert("common.print.ratio.number.label") ;
         return ;
      }
      _currentZoom = 0;
      zoomIt(content, parseFloat(print8.value / 100) - 1);
  }
}
function zoomIt(content,size) {
  if(content){
    if(!size) {
      size = 0;
      _currentZoom = 0;
    }
    _currentZoom = _currentZoom + size;
    if(content.style.zoom) {
      content.style.zoom = 1 + _currentZoom ;
    }else {
   // document.getElementById('time').contentWindow.document.getElementById("table001").style.MozTransform='scale('+(1+_currentZoom)+')';
    document.getElementById('time').contentWindow.document.getElementsByTagName('form')[0].style.MozTransform='scale('+(1+_currentZoom)+')';
    //  document.getElementById('content').style.MozTransform='scale('+(1+_currentZoom)+')';
    }
    clearnText() ;
  }
}
function clearnText(){
    var print8 = document.getElementById("print8") ;
   //  var context = document.getElementById('time').contentWindow.document.body;
   var context = document.getElementById('time').contentWindow.document.getElementsByTagName('form')[0];
   // var context = document.getElementById("context") ;
    if(print8 &&  context){
      var size = 1+_currentZoom;
      print8.value = parseInt(size * 100);
      var zoom = context.style.zoom;
      
      var width = context.style.width;
      if(width.indexOf("%")>0){
      width = width.replace("%","");
      context.style.width = 100*parseFloat(zoom)+"%";
      }
    }
   
}


function initBodyHeight(iframename) {
 var selfHeight = document.body.scrollHeight-73;
 var selfWidth = document.body.clientWidth-20;
    var p_demo = window.top.document.getElementById(iframename);
   p_demo.height=selfHeight;
    p_demo.width=selfWidth;
   document.getElementById('time').contentWindow.document.getElementsByTagName('form')[0].style.height="";
   document.getElementById('time').contentWindow.document.getElementsByTagName('form')[0].style.width="";
  document.getElementById('time').contentWindow.document.getElementsByTagName('form')[0].align="center";
     if (!window.ActiveXObject || "ActiveXObject" in window) {
    $('#print2').hide();
    $('#print3').hide();
  }
  
  debugger;
  var tables = document.getElementById('time').contentWindow.document.getElementsByClassName('tableLayout');
  for(var i=0;i<tables.length;i++){
	  var tableObj = tables[i];
	  if(tableObj){
		  tableObj.align="center";
		  tableObj.style.width="99%";
	  }
  }
}

window.onerror=function(){return true;} 
</script>

     
    </head>
    <body onload="initBodyHeight('time');" class="body">
        <div id="header" class="header">     
            <table width="100%" cellpadding="0" cellspacing="0">
                <tbody><tr onclick="">
                   <td style="padding-left:10px;">
                        <a id="print1" class="common_button common_button_gray" href="javascript:printIt(1);" target="_self" style="color: rgb(0, 0, 0); text-decoration: none; cursor: default;">打印</a>
                        <a id="print2" class="common_button common_button_gray" href="javascript:printIt(8);" target="_self" style=" color: rgb(0, 0, 0); text-decoration: none; cursor: default;">打印设置</a>
                        <a id="print3" class="common_button common_button_gray" href="javascript:printIt(7);" target="_self" style=" color: rgb(0, 0, 0); text-decoration: none; cursor: default;">打印预览</a>
                        <a id="print4" class="common_button common_button_gray" href="javascript:thisclose();" target="_self" style="color: rgb(0, 0, 0); text-decoration: none; cursor: default;">关闭</a>
                        <div class="margin_t_5 margin_b_5 font_size12" id="_showOrDisableButton">
                        <a id="print5" class="common_button common_button_gray" href="javascript:doChangeSize('bigger');" target="_self" style="color: rgb(0, 0, 0); text-decoration: none; cursor: default;">放大</a>
                        <a id="print6" class="common_button common_button_gray" href="javascript:doChangeSize('smaller');" target="_self" style="color: rgb(0, 0, 0); text-decoration: none; cursor: default;">缩小</a>
                        <a id="print7" class="common_button common_button_gray" href="javascript:doChangeSize('self');" target="_self" style="color: rgb(0, 0, 0); text-decoration: none; cursor: default;">还原</a>
                        <span class="margin_l_5" style="cursor: default;">自定义比例：</span><input type="text" id="print8" style="border:1px #b6b6b6 solid;height:24px;width:30px;" value="100" onblur="doChangeSize('customize')">%
                        </div>
                    </td>
                    <td style="padding-right:10px;">
                       
                    </td>
                </tr>
            </tbody></table>
        </div>  
       <div class="content" style="height:auto; padding:15px 200px 15px 200px;background-color:rgb(202, 203, 202);" id="context2" style="zoom:1;">
     <iframe id='time' style="height:100%; width:100%;"  name="time" frameborder="0" src="<%=basePath%>${param.fdid}?mFlowBizId=${param.mFlowBizId}&matrix_view_flag=true&printCss=${param.printCss }&mode=print&piid=${param.piid}&aiid=${param.aiid}&pdid=${param.pdid}&adid=${param.adid}&matrix_print_flag=true&mHtml5Flag=true">
       </iframe>
        </div>
        <OBJECT id=WebBrowser classid=CLSID:8856F961-340A-11D0-A96B-00C04FD705A2 style="width:0px;height:0px;margin:0px;padding:0px"></OBJECT>   


</body>
</html>