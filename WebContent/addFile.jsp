<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>

<script type="text/javascript">
</script>

<html style="height: 100%">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>上传本地文件</title>
<script type="text/javascript" src="<%=path%>/resource/html5/js/jquery.min.js"></script>
<script type="text/javascript">//Attachment(id, reference, subReference, category, type, filename, mimeType, createDate, size, fileUrl, description){

var EmptyArrayList=new ArrayList();function ArrayList(){this.instance=new Array()}ArrayList.prototype.size=function(){return this.instance.length};ArrayList.prototype.add=function(A){this.instance[this.instance.length]=A};ArrayList.prototype.addSingle=function(A){if(!this.contains(A)){this.instance[this.instance.length]=A}};ArrayList.prototype.addAt=function(A,B){if(A>=this.size()||A<0||this.isEmpty()){this.add(B);return }this.instance.splice(A,0,B)};ArrayList.prototype.addAll=function(A){if(!A||A.length<1){return }this.instance=this.instance.concat(A)};ArrayList.prototype.addList=function(A){if(A&&A instanceof ArrayList&&!A.isEmpty()){this.instance=this.instance.concat(A.instance)}};ArrayList.prototype.get=function(A){if(this.isEmpty()){return null}if(A>this.size()){return null}return this.instance[A]};ArrayList.prototype.getLast=function(){if(this.size()<1){return null}return this.instance[this.size()-1]};ArrayList.prototype.set=function(B,D){if(B>=this.size()){throw"IndexOutOfBoundException : Index "+B+", Size "+this.size()}var A=this.instance[B];this.instance[B]=D;return A};ArrayList.prototype.removeElementAt=function(A){if(A>this.size()||A<0){return }this.instance.splice(A,1)};ArrayList.prototype.remove=function(B){var A=this.indexOf(B);this.removeElementAt(A)};ArrayList.prototype.contains=function(A,B){return this.indexOf(A,B)>-1};ArrayList.prototype.indexOf=function(D,E){for(var A=0;A<this.size();A++){var B=this.instance[A];if(B==D){return A}else{if(E!=null&&B!=null&&D!=null&&B[E]==D[E]){return A}}}return -1};ArrayList.prototype.lastIndexOf=function(D,E){for(var A=this.size()-1;A>=0;A--){var B=this.instance[A];if(B==D){return A}else{if(E!=null&&B!=null&&D!=null&&B[E]==D[E]){return A}}}return -1};ArrayList.prototype.subList=function(B,E){if(B<0){B=0}if(E>this.size()){E=this.size()}var D=this.instance.slice(B,E);var A=new ArrayList();A.addAll(D);return A};ArrayList.prototype.toArray=function(){return this.instance};ArrayList.prototype.isEmpty=function(){return this.size()==0};ArrayList.prototype.clear=function(){this.instance=new Array()};ArrayList.prototype.toString=function(A){A=A||", ";return this.instance.join(A)};
function Properties(A){this.instanceKeys=new ArrayList();this.instance={};if(A){this.instance=A;for(var B in A){this.instanceKeys.add(B)}}}Properties.prototype.size=function(){return this.instanceKeys.size()};Properties.prototype.get=function(B,A){if(B==null){return null}var D=this.instance[B];if(D==null&&A!=null){return A}return D};Properties.prototype.remove=function(A){if(A==null){return null}this.instanceKeys.remove(A);delete this.instance[A]};Properties.prototype.put=function(A,B){if(A==null){return null}if(this.instance[A]==null){this.instanceKeys.add(A)}this.instance[A]=B};Properties.prototype.putRef=function(A,B){if(A==null){return null}this.instanceKeys.add(A);this.instance[A]=B};Properties.prototype.getMultilevel=function(E,B){if(E==null){return null}var D=E.split(".");function A(J,H,G){try{if(J==null||(typeof J!="object")){return null}var K=J.get(H[G]);if(G<H.length-1){K=A(K,H,G+1)}return K}catch(I){}return null}var F=A(this,D,0);return F==null?B:F};Properties.prototype.containsKey=function(A){if(A==null){return false}return this.instance[A]!=null};Properties.prototype.keys=function(){return this.instanceKeys};Properties.prototype.values=function(){var E=new ArrayList();for(var B=0;B<this.instanceKeys.size();B++){var A=this.instanceKeys.get(B);if(A){var D=this.instance[A];E.add(D)}}return E};Properties.prototype.isEmpty=function(){return this.instanceKeys.isEmpty()};Properties.prototype.clear=function(){this.instanceKeys.clear();this.instance={}};
//判断是否安装了精灵
var isA8geniusAdded = false;
var files = new Properties();
var number = 0;
function checks(){
    if(number == 0 || files.isEmpty()){
        //return false;
         alert("选择您要上传的文件(单次上传小于50 MB)");
        return ;
    }
    
    $("#b1").disable();

    show();
    
    for(var i = 1; i <= index; i++){
        var o = document.getElementById("file" + i);
        if(!o){
            continue;
        }

        if(!o.value){
            document.getElementById("fileInputDiv" + i).parentNode.removeChild(document.getElementById("fileInputDiv" + i));
        }
    }
    document.getElementById('form_upload').submit();
    //return true;

}

function checkExtensions(obj){
    var filepath = obj.value;
    if (!filepath) {
        return false;
    }
    
    var extensionstr = document.getElementById("extensions").value;
    if(!extensionstr){
        return true;
    }

    var lastSeparator = filepath.lastIndexOf(".");
    if (lastSeparator == -1) {
        return true;
    }
    else{
        if(extensionstr){
            var extension = filepath.substring(lastSeparator + 1).toLowerCase();
            var extensions = extensionstr.split(",");
            
            for(var i=0; i<extensions.length; i++) {
                if(extensions[i] == extension){
                    return true;
                }
            }
        }
    }
    
    alert("不支持的文件扩展名。支持:");
    
    return false;
}

function show(){
    //document.getElementById("b1").disabled = true;

    document.getElementById("upload1").style.display = "none";
    document.getElementById("uploadprocee").style.display = "";

}






function again(){
    //document.getElementById("b1").disabled = false;
    $("#b1").enable(); 
    document.getElementById("upload1").style.display = "";
    document.getElementById("uploadprocee").style.display = "none";
    if(isA8geniusAdded){
        document.getElementById("selectFile").style.display = "none";     
        document.getElementById("fileProcee").style.display = "";  
    }
    
    number = 0;
    files.clear();
    
    document.getElementById("fileNameDiv").innerHTML = " <li><a>&nbsp;</a></li>";
    document.getElementById("fileInputDiv").innerHTML = "";
    
    addInput(index);
}
var quantity = 9999;
// 参数限制文件数小于5时，安装了精灵也受控，否则不受参数限制
var paramQuantity = 5;
if(isA8geniusAdded){
    quantity = (paramQuantity<5)?paramQuantity:quantity;
}else{
    quantity = paramQuantity;
}
var index = 1;
var geniusNum = 0;

function addNextInput(obj){


    if(!checkExtensions(obj)){
        removeInput(index);
        addInput(index);
        
        return false;
    }

    if( number >= quantity){
        removeInput(index);
        addInput(index);
        
     
        alert('您一次最多选择{0}个文件！');
        return false;
    }

    number++;
    document.getElementById("fileInputDiv" + index).style.display = 'none';
    var s = obj.value.lastIndexOf("\\");
    if(s < 0){
        s = obj.value.lastIndexOf("/");
    }
    var filename = obj.value.substring(s + 1);
    var nameHTML = "";
    //<li><span title="图片上传的附件.jpg">图片上传的附件.jpg</span><em class="ico16 revoked_process_16"></em></li>
    nameHTML += "<li id='fileNameDiv" + index + "' class='margin_r_10'>"
    nameHTML += "<span title='"+filename+"'>"
    nameHTML += filename;
    nameHTML += "</span>"
    nameHTML += "<em  onclick='deleteOne(" + index + ")' class='ico16 affix_del_16' title='刪除'></em>";      
    nameHTML += "</li>";

    document.getElementById("fileNameDiv").innerHTML += nameHTML;
    files.put(index, obj.value);
    index++;
    addInput(index);
    return true;
}

function deleteOne(i){
    var pos = getIndex(i);
    removeInput(i); 
    if(!isA8geniusAdded){
      number-- ;  
    }
    files.remove(i);
    
}

function removeInput(i){

    var errorNode = false;
    var pos = getIndex(i);
    try{
        document.getElementById("fileInputDiv" + i).parentNode.removeChild(document.getElementById("fileInputDiv" + i));
    }
    catch(e){
        errorNode = true;
    }
        
    try{
        document.getElementById("fileNameDiv" + i).parentNode.removeChild(document.getElementById("fileNameDiv" + i));
    }
    catch(e){
       errorNode = true;
    }

    if(isA8geniusAdded&&!errorNode){
        var UFIDA_Upload1 = document.getElementById("UFIDA_Upload1");
        UFIDA_Upload1.DeleteItemFromList(i-1);     
        number--; 
    }
   
}

function addInput(i){
    //var html =  "<div id=\"fileInputDiv" + i + "\" class=\"file_unload clearfix\" style=\"\">" + "</div>";
    var e = document.createElement("div");
    e.setAttribute("id","fileInputDiv" + i);
    e.className = "file_unload clearfix";
    var fileNameIndexFlag = i;
    if(quantity==1)fileNameIndexFlag = 1;
    if(isA8geniusAdded){        
        var inputHTML1 = "";  
        inputHTML1+="<a class=\"common_button common_button_icon file_click\" href=\"###\"><em class=\"ico16 affix_16\"></em>添加";
        inputHTML1+="<INPUT type=\"text\" name=\"file1\" id=\"file1\" onkeydown=\"return false\" onkeypress=\"return false\" style=\"width: 73%\">" + "<INPUT type=\"button\" name=\"button1\" id=\"button1\" onclick=\"OpenBrowser()\" value=\"浏览......\" >";
        inputHTML1+="</a>";
        e.innerHTML=inputHTML1;
    }else{
       
        var inputHTML1 = "";  
        inputHTML1+="<a class=\"common_button common_button_icon file_click\" href=\"###\"><em class=\"ico16 affix_16\"></em>添加";
        inputHTML1+= "<INPUT type=\"file\" name=\"file" + fileNameIndexFlag + "\" id=\"file" + i + "\" onchange=\"addNextInput(this)\" onkeydown=\"return false\" onkeypress=\"return false\" style=\"width: 100%\"/>";
        inputHTML1+="</a>";
        e.innerHTML=inputHTML1;
       }
    document.getElementById("fileInputDiv").appendChild(e);
}


// 根据fileInputDiv的后缀数字获取它在数组中的位置
function getIndex(index)
{
    var name = 'fileNameDiv' + index;
    var container = document.getElementById("fileNameDiv");
    var children = container.getElementsByTagName('div');
    var len = children.length;
    var result = 0;
    for(i = 0;i<len;i++)
    {
        var element = children[i];      
        result ++;
        if(name == element.id ) 
        {
            return result;
        }

    }
    return -1;
}


    

</script>
</head>
<style>
.file_unload {
    position: relative;
    height: 26px;
    overflow: hidden;
}
.clearfix {
    zoom: 1;
    display: block;
    _height: 1px;
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
.common_button_icon em {
    margin-top: -3px;
    margin-right: 5px;
    margin-left: -5px;
    
}

.common_button *, .form_btn * {
    font-size: 12px;
}

.ico16 {
    display: inline-block;
    vertical-align: middle;
    height: 16px;
    width: 16px;
    line-height: 16px;
    background: url(image/icon16.png) no-repeat;
    background-position: 0 0;
    cursor: pointer;
 
}
.affix_16 {
    background-position: -64px 0;
}
.affix_del_16 {
    display: inline-block;
    vertical-align: middle;
    height: 16px;
    width: 16px;
    line-height: 16px;
    background: url(image/control_icon.png) no-repeat;
    background-position: -48px -272px;
    }
    .file_unload .file_click {
    position: absolute;
    left: 0;
    top: 0;
    cursor: pointer;
    overflow: visible;
}
    .file_click input, .file_click:hover input {
    width: 100%;
    height: 26px;
    display: block;
    position: absolute;
    left: 0;
    top: 0;
    z-index: 10;
    filter: alpha(opacity=0);
    moz-opacity: 0;
    opacity: 0;
    cursor: pointer;
}
.border_all {
    border: 1px solid #e3e3e3;
}
.clearfix {
    zoom: 1;
    display: block;
    _height: 1px;
}
.file_select li {
    height: 24px;
    line-height: 24px;
    float: left;
    white-space: nowrap;
}
.margin_r_10 {
    margin-right: 10px;
}
.file_select li span {
    vertical-align: middle;
    margin-right: 5px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    max-width: 90px;
    display: inline-block;
}
a {
    text-decoration: none;
    cursor: pointer;
}
li {
    list-style: none;
}
body, div, dl, dt, dd, pre, code, form, input, button, textarea, p, th, td, ul, li {
    margin: 0;
    padding: 0;
    font-family: "Microsoft YaHei",SimSun,Arial,Helvetica,sans-serif;
}
.border_b {
    border-bottom: 1px solid #e3e3e3;
}
.padding_10 {
    padding: 10px;
}
.font_bold {
    font-weight: bold;
}
.font_size12 {
    font-size: 12px;
}
.page_color, .bg_color {
    background: #FAFAFA;
}
.bg_color_white {
    background: #FFF;
}
</style>
<body  style="height: 100%;overflow: hidden" class="page_color">
    <form style="height: 100%;display: block;" enctype="multipart/form-data" name="uploadForm" method="post" id="form_upload" action="/seeyon/fileUpload.do?method=processUpload"   target="uploadIframe">
        <input type="hidden"  id="type" name="type" value="0"> <input type="hidden" name="extensions"
            id="extensions" value=""> <input type="hidden" name="applicationCategory"
            id="applicationCategory" value="1"> <input type="hidden"
            name="destDirectory" id="destDirectory" value=""> <input type="hidden"
            name="destFilename" id="destFilename" value=""> <input type="hidden"
            name="maxSize" id="maxSize" value=""> <input type="hidden" name="isEncrypt"
            id="isEncrypt" value=""> <input type="hidden" id="form_action"
            value="/seeyon/fileUpload.do"> <input type="hidden" id="fileStr" value="">
        
         
            <input type="hidden" name="callMethod" id="callMethod" value="autoSet_LayoutNorth_Height">
        
        
            <input type="hidden" name="attachmentTrId" id="attachmentTrId" value="Att">
        
         
        
            <input type="hidden" name="takeOver" id="takeOver" value="false">
        
         
              
             
        
        
            
            
                <table class="popupTitleRight font_size12" width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="20" class="padding_10 font_bold border_b">上传本地文件</td>
		</tr>
		<tr>
			<td class="bg_color_white" align="top" style="padding:0;">
				<div id="scroll_div" style="height:160px;overflow-y:auto;">
				<table width="385" border="0" cellspacing="0" cellpadding="0">
		
        <tr>
            <td height="20" style="background:#fff;">
                <div class="margin_l_10">选择您要上传的文件(单次上传小于50 MB)</div>
            </td>
        </tr>
		<tr>
			<td id="upload1" class="bg-advance-middel padding_10" style="vertical-align: top;background:#fff;">
                <div class="file_box" >
			                <div id="fileInputDiv" style="height: 30px;float:right;width:70px;margin-left:5px;">
                    <div id="fileInputDiv1" style="" class="file_unload clearfix">
                        <a class="common_button common_button_icon file_click" href="###"><em class="ico16 affix_16"></em>添加
                        <INPUT type="file" size="51" name="file1" id="file1" onchange="addNextInput(this)" >
                        </a>
                    </div>
                </div>
                
                
			                <ul id="fileNameDiv" class="file_select  border_all clearfix" style="float:left;width:270px;padding:0px 5px;margin:0px;">
                    <li><a>&nbsp;</a></li>
                </ul>
                
                </div>
                
                
			</td>
		</tr>
		<tr id="uploadprocee" style="display:none;">
			<td  style="background:#fff;" align="center" class="bg-advance-middel padding_10">
				<table width="240" height="45" border="0" cellspacing="0" cellpadding="0" >
				  <tr>				    
				    <td align='center' height='30' valign='bottom'>上传中...</td>			    
				  </tr>
				  <tr> 
				    <td align='center'><span class='process'>&nbsp;</span></td>
				  </tr>
				</table>
			</td>
		</tr>	
					</table>
					</div>
				</td>
			</tr>
		<tr>
			<td height="28" align="right" class="bg-advance-bottom padding_lr_10 border_t">
                <a id="b1" class="button-default_emphasize" style="cursor: pointer;" onclick="checks()">确定</a>
                <a id="b2" class="common_button common_button_gray" style="cursor: pointer;" onclick="windowClose()">取消</a>
                
			</td>
		</tr>
	</table>	

            
        
    </form>
    <iframe name="uploadIframe" frameborder="0" height="0" width="0" class="hidden" style="display:none" scrolling="no" marginheight="0" marginwidth="0"></iframe>
</body>
</html>
