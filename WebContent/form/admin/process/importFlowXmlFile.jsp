<%@ page
	language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%@page import="commonj.sdo.DataObject"%>
<!DOCTYPE HTML>
<html>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<head>
<title>导入流程文件</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>	
<script>
	function fileChange(target, id) {
  		var fileSize = 0;
        var isIE = /msie/i.test(navigator.userAgent) && !window.opera;
        if (isIE && !target.files) {
            var filePath = target.value;
            var fileSystem = new ActiveXObject("Scripting.FileSystemObject");
            if (!fileSystem.FileExists(filePath)) {
                var file = document.getElementById(id);
                file.outerHTML = file.outerHTML;
                return false;
            }
            var file = fileSystem.GetFile(filePath);
            fileSize = file.Size;
        } else {
            fileSize = target.files[0].size;
        }
        var size = fileSize / (1024 * 1024);
        if (size > 1) {
        	Matrix.warn("附件大小不能大于1M！");
            var file = document.getElementById(id);
            file.outerHTML = file.outerHTML;
            return false;
        }
        if (size <= 0) {
        	Matrix.warn("附件大小不能为0M！");
            var file = document.getElementById(id);
            file.outerHTML = file.outerHTML;
            return false;
        }
        return true;
    } 
      
    //上传文件时检查文件类型
	function checkFileType(){
		var filePath = Matrix.getFormItemValue('file');
		if(filePath.toLowerCase().endsWith(".xml")){
			return true;
		}
		Matrix.warn('请上传流程XML格式的文件!');
		return false;
	}
	function toWait(){
		Matrix.closeWindow();
	}
	
	function submitForm(){
		var filePath = Matrix.getFormItemValue('file');
		if(filePath!=null && filePath.length>0 && filePath!='undefined'){
			
			//var url = "<%=request.getContextPath()%>/ReadExcelServlet?type="+type;
			var url = "<%=request.getContextPath()%>/FlowDesignerServlet?command=upload";
	        document.getElementById('form0').action=url;
	        document.getElementById('form0').submit();
	        //Matrix.send('form0');
	        return true;
        }else{
        	Matrix.warn("请先选择流程XML格式的文件！");
        	return false;
        }
        
	}
</script>
</head>
<body >
<div id='loading' name='loading' class='loading'><script>Matrix.showLoading();</script></div>

<script> var Mform0=isc.MatrixForm.create({
				ID:"Mform0",
				name:"Mform0",
				position:"absolute",
				enctype:"multipart/form-data",
				fields:[
				{name:'form0_hidden_text',width:0,height:0,displayId:'form0_hidden_text_div'}
				]});
</script>
<div style="width:100%;height:100%;overflow:auto;position:relative;">
<form id="form0" name="form0" eventProxy="Mform0" method="post" 
	action="" 
	style="margin:0px;position:relative;overflow:auto;width:100%;height:100%;" 
	enctype="multipart/form-data">

<input type="hidden" name="form0" value="form0" />
<input type="hidden" id="command" name="command" value="upload" />
<input type="hidden" id="iframewindowid" name="iframewindowid" value="${param.iframewindowid}"/>
<div type="hidden" id="form0_hidden_text_div" name="form0_hidden_text_div" style="position:absolute;width:0;height:0;z-index:-9999999999;top:0;left:0;display:none;"></div>
<input type="hidden" name="javax.matrix.faces.ViewState" id="javax.matrix.faces.ViewState" value="" />
 <table id="j_id3" jsId="j_id3" class="maintain_form_content" style="">
                        	
                            <tr id="j_id4" jsId="j_id4" >
                                <td id="j_id5" jsId="j_id5"  class="maintain_form_label2" colspan="1" rowspan="1" style="width:25%;">
                                   
                                    <label id="j_id6" name="j_id6" style="margin-left:10px;">
                                        导入流程xml文件：
                                    </label>
                                </td>
                                <td id="j_id7" jsId="j_id7" class="maintain_form_input" style="width:75%" colspan="3" rowspan="1">
                                    
                                    <div id="fileDiv">
                                       
                            <input id="file" name="file" type="file"  size="30"  onchange="checkFileType()" />
                                     
                                    </div>
                                </td>
                            </tr>
                           
                            <tr id="j_id8" jsId="j_id8" >
                                <td id="j_id9" jsId="j_id9" class="maintain_form_command" style="height:40px;width:100%" colspan="4"
                                rowspan="1">
                                   <div id="button001_div" class="matrixInline matrixInlineIE" style="position:relative;;width:100px;height:22px;">
                                       <script>
                                       	isc.Button.create({
                                       		ID:"Mbutton001",
                                       		name:"button001",
                                       		title:"确认",
                                       		displayId:"button001_div",
                                       		position:"absolute",
                                       		top:0,left:0,
                                       		width:"100%",
                                       		height:"100%",
                                       		icon:"[skin]/images/matrix/actions/save.png",
                                       		showDisabledIcon:false,
                                       		showDownIcon:false,
                                       		showRollOverIcon:false
                                       	});
                                       	Mbutton001.click=function(){
                                       		Mbutton001.setDisabled(true);
                                       		Matrix.showMask();
                                       		if(!submitForm()){
	                                       		Matrix.hideMask();
                                       		}
                                       		Mbutton001.setDisabled(false);
                                       	};</script>
                                    </div>
                                   <div id="button002_div" class="matrixInline matrixInlineIE" style="position:relative;;width:100px;height:22px;">
                                       <script>
                                       	isc.Button.create({
                                       		ID:"Mbutton002",
                                       		name:"button002",
                                       		title:"关闭",
                                       		displayId:"button002_div",
                                       		position:"absolute",
                                       		top:0,left:0,
                                       		width:"100%",
                                       		height:"100%",
                                       		icon:"[skin]/images/matrix/actions/delete.png",
                                       		showDisabledIcon:false,
                                       		showDownIcon:false,
                                       		showRollOverIcon:false
                                       	});
                                       	Mbutton002.click=function(){
                                       		Matrix.showMask();
	                                       //	Matrix.closeWindow();
	                                       window.close();	
	                                       	Matrix.hideMask();
                                       		
                                       	};</script>
                                    </div>
                                </td>
                            </tr>
                        </table>

		

</form></div><script>Mform0.initComplete=true;Mform0.redraw();isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"Mform0.redraw()",null);},isc.Page.FIRE_ONCE);</script></body>
</html>
