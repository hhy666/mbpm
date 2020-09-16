<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page  import="sun.misc.BASE64Decoder" %>
<%@ page import="java.io.UnsupportedEncodingException" %>  
<html><head id="linkList">
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!--签章控件需要在IE9模式下才能显示  -->
        <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE9">
        <title>print</title>
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
                    border:0px;
                    margin:0px;
                }
                #iSignatureHtmlDiv{
                	display: none;
                }
            }
            
        </style>
                <script>
var contentType = "20";      
var viewState = "1"; 
window.onload = function(){
 
}   
function thisclose(){
 window.close();
}
function printIt(n){
  var _WebBrowser = document.getElementById('WebBrowser');
  if(n==1){
    var frame = window.frames[0];
  frame.focus();
  frame.print();
  }else{
    try {
      _WebBrowser.ExecWB(n,1);
    }catch(e){}
  }
}
var _currentZoom = 0;
function doChangeSize(changeType){
  var content = document.getElementById("context") ;
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
      document.getElementById('content').style.MozTransform='scale('+(1+_currentZoom)+')';
    }
    clearnText() ;
  }
}
function clearnText(){
    var print8 = document.getElementById("print8") ;
    var context = document.getElementById("context") ;
    if(print8 &&  context){
      var size = 1+_currentZoom;
      print8.value = parseInt(size * 100);
    }
   
}


function initBodyHeight(iframename) {
 var selfHeight = document.body.scrollHeight-73;
 var selfWidth = document.body.clientWidth-20;
    var p_demo = window.top.document.getElementById(iframename);
    p_demo.height=selfHeight;
    p_demo.width=selfWidth;
     if (!window.ActiveXObject || "ActiveXObject" in window) {
    	document.getElementById("print2").style.display="none";
   	    document.getElementById("print3").style.display="none";
  }
  var url=window.opener.document.getElementById('url').value;
 	document.getElementById("time").src=url;
}

</script>

     
    </head>
    <body onload="initBodyHeight('time');" class="body">
    <%  byte[] b = null;  
        String result = null;  
       String s=request.getParameter("fdid");
            BASE64Decoder decoder = new BASE64Decoder();  
            try {  
            if(s!=null&&s.length()>0){
                b = decoder.decodeBuffer(s);  
                result = new String(b, "utf-8");  
                }
            } catch (Exception e) {  
                e.printStackTrace();  
            }  
          
    %>
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
       <div class="content"  id="context" style="zoom:1;">
       <iframe id='time' name="time" frameborder="0"  src="" style="width:100%">
       
       </iframe>
        </div>
        <OBJECT id=WebBrowser classid=CLSID:8856F961-340A-11D0-A96B-00C04FD705A2 style="width:0px;height:0px;margin:0px;padding:0px"></OBJECT>   


</body></html>