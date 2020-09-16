<%@ page
	language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%@page import="commonj.sdo.DataObject"%>
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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src="<%=path %>/resource/html5/js/jquery.min.js"></script>
<script src="<%=path %>/resource/html5/js/layer.min.js"></script>
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
		if(filePath.toLowerCase().endsWith(".xls")){
			return true;
		}
		Matrix.warn('请上传xls文件格式!');
		return false;
	}
	function toWait(){
		Matrix.closeWindow();
	}
	
	function submitForm(){
		var filePath = Matrix.getFormItemValue('file');
		if(filePath!=null && filePath.length>0 && filePath!='undefined'){
			document.getElementById('msg').innerText = "*正在执行导入，请稍候……";
			
			var type = filePath.substring(filePath.lastIndexOf(".")+1).toLowerCase();
			var url = "<%=request.getContextPath()%>/ReadExcelServlet?type="+type;
	        document.getElementById('form0').action=url;
	        document.getElementById('form0').submit();
	        return true;
        }else{
        	Matrix.warn("请先选择xls文件！");
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
<input type="hidden" id="mode" name="mode" value="debug" />
<input type="hidden" id="matrix_form_tid" name="matrix_form_tid" />
<input type="hidden" id="matrix_form_datagrid_form0" name="matrix_form_datagrid_form0" value="" />
<input type="hidden" id="iframewindowid" name="iframewindowid" value="${param.iframewindowid}"/>
<div type="hidden" id="form0_hidden_text_div" name="form0_hidden_text_div" style="position:absolute;width:0;height:0;z-index:-9999999999;top:0;left:0;display:none;"></div>
<input type="hidden" name="javax.matrix.faces.ViewState" id="javax.matrix.faces.ViewState" value="" />
 <table id="j_id3" jsId="j_id3" class="maintain_form_content" style="height:100%;">
                        	<tr id="j_id9" jsId="j_id9" style="height:50px">
                        		<td colSpan="4" style="height:50px;">
                        			<DIV style="float:left;"><span id = "shuoming" style="margin:0 auto;margin-left:10px;float:left;">导入excel说明：</span>
                        			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label>1、只能导入xls文件</label>
                        			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label>2、重复导入会覆盖相同日期段的数据</label>
                        			</DIV>
                        			<DIV style="float:left;"><span id = "msg" style="color:red;margin-left:20px;"></span></DIV>
                        		</td>
                        	</tr>
                            <tr id="j_id4" jsId="j_id4" >
                                <td id="j_id5" jsId="j_id5"  class="maintain_form_label2" colspan="1" rowspan="1" style="width:25%;">
                                   
                                    <label id="j_id6" name="j_id6" style="margin-left:10px;">
                                        导入EXCEL文件：
                                    </label>
                                </td>
                                <td id="j_id7" jsId="j_id7" class="maintain_form_input" style="width:75%" colspan="3" rowspan="1">
                                    
                                    <div id="fileDiv">
                                       
                            <input id="file" name="file" type="file"  size="30"  onchange="checkFileType()" />
                                     
                                    </div>
                                </td>
                            </tr>
                           
                            <tr id="j_id8" jsId="j_id8" >
                                <td id="j_id9" jsId="j_id9" class="maintain_form_command" style="height:40px" colspan="4"
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
                                       	};</script>
                                    </div>
                                   
                                </td>
                            </tr>
                        </table>

		

</form></div><script>Mform0.initComplete=true;Mform0.redraw();isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"Mform0.redraw()",null);},isc.Page.FIRE_ONCE);</script></body>
</html>
