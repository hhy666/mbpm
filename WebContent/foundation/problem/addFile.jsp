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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:include page="/foundation/common/taglib.jsp"/>
<jsp:include page="/foundation/common/resource.jsp"/>	
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
	action="<%=request.getContextPath()%>/problem/fileOperatorAction_upLoadFile.action" 
	style="margin:0px;position:relative;overflow:auto;width:100%;height:100%;" 
	enctype="multipart/form-data">

<input type="hidden" name="form0" value="form0" />
<input type="hidden" id="mode" name="mode" value="debug" />
<input type="hidden" id="matrix_form_tid" name="matrix_form_tid" />
<input type="hidden" id="matrix_form_datagrid_form0" name="matrix_form_datagrid_form0" value="" />
<input type="hidden" id="uuid" name="uuid" value="${param.uuid }"/>
<input type="hidden" id="fileFlag" name="fileFlag" value="${param.fileFlag }"/>
<input type="hidden" id="iframewindowid" name="iframewindowid" value="${param.iframewindowid}"/>
<input type="hidden" id="userId" name="userId" value="admin"/>
<div type="hidden" id="form0_hidden_text_div" name="form0_hidden_text_div" style="position:absolute;width:0;height:0;z-index:-9999999999;top:0;left:0;display:none;"></div>
<input type="hidden" name="javax.matrix.faces.ViewState" id="javax.matrix.faces.ViewState" value="" />
 <table id="j_id3" jsId="j_id3" class="maintain_form_content" style="height:100%;">
                        	<tr>
                        		<td colSpan="2" style="height:20px;">
                        			
                        			<span style="color:red;">*请选择需要上传的附件</span>
                        		</td>
                        	</tr>
                            <tr id="j_id4" jsId="j_id4" >
                                <td id="j_id5" jsId="j_id5" class="maintain_form_label" colspan="1" rowspan="1">
                                   
                                    <label id="j_id6" name="j_id6" style="margin-left:10px;">
                                        选择文件：
                                    </label>
                                </td>
                                <td id="j_id7" jsId="j_id7" class="maintain_form_input"  colspan="1" rowspan="1">
                                    
                                    <div id="fileDiv">
                                       
                            <input id="file" name="file" type="file"  size="30" onchange="fileChange(this,'file');" />
                                     
                                    </div>
                                </td>
                            </tr>
                            <tr id="j_id8" jsId="j_id8" >
                                <td id="j_id9" jsId="j_id9" class="maintain_form_command" style="height:25px" colspan="2"
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
                                       		if(!true){
                                       			Matrix.hideMask();
                                       			Mbutton001.setDisabled(false);
                                       			return false;
                                       		}
                                       		if(!Mform0.validate()){
                                       			Matrix.hideMask();
                                       			Mbutton001.setDisabled(false);
                                       			 return false;}
                                       			var vituralbuttonHidden = document.getElementById('matrix_command_id');
                                       			if(vituralbuttonHidden)
                                       				vituralbuttonHidden.parentNode.removeChild(vituralbuttonHidden);
                                       				var currentForm = document.getElementById('form0');
                                       				var buttonHidden = document.createElement('input');
                                       				buttonHidden.type='hidden';
                                       				buttonHidden.name='matrix_command_id';
                                       				buttonHidden.id='matrix_command_id';
                                       				buttonHidden.value='button001';
                                       				currentForm.appendChild(buttonHidden);
                                       				var buttonIdHidden = document.createElement('input');
                                       				buttonIdHidden.type='hidden';
                                       				buttonIdHidden.name='button001';
                                       				buttonIdHidden.value='确认';
                                       				document.getElementById('form0').appendChild(buttonIdHidden);
                                       				var _mgr=Matrix.convertDataGridDataOfForm('form0');
                                       				if(_mgr!=null&&_mgr==false){
                                       					Matrix.hideMask();
                                       					return false;
                                       				}
                                       				Matrix.convertFormItemValue('form0');
                                       				document.getElementById('form0').submit();
                                       				Matrix.hideMask();
                                       			};</script>
                                    </div>
                                    <div id="dataformCancelButton_div" class="matrixInline matrixInlineIE" style="position:relative;;width:100px;;height:22px;">
                                        <script>
                                            isc.Button.create({
                                                ID: "MdataformCancelButton",
                                                name: "dataformCancelButton",
                                                title: "关闭",
                                                displayId: "dataformCancelButton_div",
                                                position: "absolute",
                                                top: 0,
                                                left: 0,
                                                width: "100%",
                                                height: "100%",
												icon:Matrix.getActionIcon("exit"),
                                                showDisabledIcon: false,
                                                showDownIcon: false,
                                                showRollOverIcon: false
                                            });
                                            MdataformCancelButton.click = function() {
                                                Matrix.closeWindow();
                                            };
                                        </script>
                                    </div>
                                </td>
                            </tr>
                        </table>

		

</form></div><script>Mform0.initComplete=true;Mform0.redraw();isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"Mform0.redraw()",null);},isc.Page.FIRE_ONCE);</script></body>
</html>
