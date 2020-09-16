<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML >
<html>
    <head>
        <meta http-equiv="pragma" content="no-cache">
        <meta http-equiv="cache-control" content="no-cache">
        <meta http-equiv="expires" content="0">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <title>
            导入BPMN文件
        </title>
        
		<jsp:include page="/form/admin/common/taglib.jsp"/>
		<jsp:include page="/form/admin/common/resource.jsp"/>
		<script type="text/javascript">
	
		
		</script>

    </head>
    
    <body>
       <jsp:include page="/form/admin/common/loading.jsp"/>
        <div id="j_id1" jsId="j_id1" style="position:relative;_layout:flowlayout;width:100%;height:100%">
            <script>
                var MForm0 = isc.MatrixForm.create({
                    ID: "MForm0",
                    name: "MForm0",
                    position: "absolute",
                    action: "<%=request.getContextPath() %>/file/importfile?importType=bpmn",
                    enctype:"multipart/form-data",
                    fields: [{
                        name: 'Form0_hidden_text',
                        width: 0,
                        height: 0,
                        displayId: 'Form0_hidden_text_div'
                    }]
                });
            </script>
            <form id="Form0" name="Form0" eventProxy="MForm0" method="post" action="<%=request.getContextPath() %>/file/importfile?importType=bpmn"
            style="margin:0px;height:100%;" enctype="multipart/form-data">
                <input id="iframewindowid" name="iframewindowid" type="hidden" value="${param.iframewindowid}" />
                <input id="processId" name="processId" type="hidden" value="${param.processId}" />
                <div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div"
                style="position:absolute;width:0;height:0;z-index:-9999999999;top:0;left:0;display:none;">
                </div>

                        <table id="j_id3" jsId="j_id3" class="maintain_form_content" style="height:100%;">
                        	<tr>
                        		<td colSpan="2" style="height:20px;">
                        			<%
										Object state = request.getAttribute("importState");
										if (state != null) {
									%>
									<div style="color:red;">导入失败!</div>
									<%}%>
                        			<span style="color:red;">*选择xml类型的BPMN文件进行导入</span>
                        		</td>
                        	</tr>
                            <tr id="j_id4" jsId="j_id4" >
                                <td id="j_id5" jsId="j_id5" class="maintain_form_label" colspan="1" rowspan="1">
                                   
                                    <label id="j_id6" name="j_id6" style="margin-left:10px">
                                        选择文件：
                                    </label>
                                </td>
                                <td id="j_id7" jsId="j_id7" class="maintain_form_input"  colspan="1" rowspan="1">
                                    <script>
                                        var  isTrueType = false;//上传类型是否正确标识
                                        var UploadFile0_file_annexType = 'xml';
                                
                                        function UploadFile0_file_showMessage(msg) {
                                            isc.warn(msg,{ width:160,height:70});
                                        }
                                        
                                        function validateUploadFile(vId) {
                                            var vObj = document.getElementById(vId);
                                            var filePath = vObj.value;
                                            fileType = filePath.substring(filePath.lastIndexOf(".") + 1);
                                           
                                            if (!Matrix.validateUploadFileType(vId, UploadFile0_file_annexType)) {
                                           		 isTrueType = false;
                                                UploadFile0_file_showMessage(fileType + '类型的文件不在允许的上传范围内');
                                                return false;
                                            }else{
                                               isTrueType = true;
                                            }
                                        }
                                        
                                        
                                      
                                    </script>
                                    <div id="UploadFile0Div">
                                       
                            <input id="uploadFile" name="uploadFile" type="file" onchange="validateUploadFile('uploadFile')" size="30" />
                                     
                                    </div>
                                </td>
                            </tr>
                            <tr id="j_id8" jsId="j_id8" >
                                <td id="j_id9" jsId="j_id9" class="maintain_form_command" style="height:25px" colspan="2"
                                rowspan="1">
                                    <div id="dataFormSubmitButton_div" class="matrixInline matrixInlineIE" style="position:relative;;width:100px;;height:22px;">
                                        <script>
                                            isc.Button.create({
                                                ID: "MdataFormSubmitButton",
                                                name: "dataFormSubmitButton",
                                                title: "确认",
                                                displayId: "dataFormSubmitButton_div",
                                                position: "absolute",
                                                top: 0,
                                                left: 0,
                                                width: "100%",
                                                height: "100%",
												icon:Matrix.getActionIcon("save"),
                                                showDisabledIcon: false,
                                                showDownIcon: false,
                                                showRollOverIcon: false
                                            });
                                            MdataFormSubmitButton.click = function() {
                                                Matrix.showMask();
                                              var fullPath =  document.getElementById("uploadFile").value;
                                              if(fullPath!=null&&fullPath.length>0){//是否上传
                                              	if(!isTrueType){//格式是否正确
	                                                isc.warn("请选择正确的文件格式!",{ width:160,height:70});
	                                                Matrix.hideMask();
	                                               	return false;
                                               }
                                           		 document.getElementById('Form0').submit();
                                              
                                              }else{
                                              	isc.warn("请先选择上传的文件!",{ width:160,height:70});
                                            
                                              }
                                                Matrix.hideMask();
                                            };
                                        </script>
                                    </div>
                                    <div id="dataFormCancelButton_div" class="matrixInline matrixInlineIE" style="position:relative;;width:100px;;height:22px;">
                                        <script>
                                            isc.Button.create({
                                                ID: "MdataFormCancelButton",
                                                name: "dataFormCancelButton",
                                                title: "关闭",
                                                displayId: "dataFormCancelButton_div",
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
                                            MdataFormCancelButton.click = function() {
                                                Matrix.closeWindow();
                                            };
                                        </script>
                                    </div>
                                </td>
                            </tr>
                        </table>
            </form>
            <script>
                MForm0.initComplete = true;
                MForm0.redraw();
                isc.Page.setEvent(isc.EH.RESIZE, "MForm0.redraw()", null);
            </script>
        </div>
    </body>

</html>