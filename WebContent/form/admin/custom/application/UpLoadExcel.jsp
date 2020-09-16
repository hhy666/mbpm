<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset='utf-8'/>
<%@ include file="/form/html5/admin/html5Head.jsp"%>
<link href='<%=request.getContextPath() %>/resource/html5/css/fileinput.min.css' rel="stylesheet"></link>
<script src='<%=request.getContextPath() %>/resource/html5/js/fileinput.min.js'></script>
<script src='<%=request.getContextPath() %>/resource/html5/js/zh.js'></script>

<script type="text/javascript">
	$(function(){  
		$('#uploadFile').fileinput({
			 language: 'zh',
			 enctype: 'multipart/form-data',
			 allowedFileExtensions: ['xls','xlsx'],
			 uploadAsync: false,   //同步上传 默认异步上传
			 showUpload: false,   //是否显示上传按钮
			 showRemove: false,   //是否显示删除/清空按钮。默认值true
			 showPreview: false,   //是否显示文件的预览图。默认值true
			 showCaption: false,  //是否显示文件标题，默认为true
			 showBrowse: true,    //是否显示文件浏览/选择按钮。默认值true
			 showCancel: false,     //是否显示文件上传取消按钮以中止正在进行的上传
			 msgPlaceholder: '请选择excel格式的文件',   //未选择文件时的提示信息
		 });
		 
		 $('#button001').click(function() {
			 if($('.file-caption-name').val()=='' || $('.file-caption-name').attr('title')=='验证错误'){
				 layer.alert('请选择一个excel文件！');
				 return false;
			 }
			 var templateId = Matrix.getFormItemValue('templateId');
				
			 var importType = document.getElementsByName('radioGroup001');
			 if(importType!=null && importType.length>0){
				if(importType[0].checked){  
					importType = '3';   //默认
				}else if(importType[1].checked){
					importType = '1';   //覆盖
				}else if(importType[2].checked){
					importType = '2';   //覆盖
				}
			 }
			 var url = "<%=request.getContextPath()%>/ApplicationSetServlet?type=import&templateId="+templateId+"&importType="+importType;
			 document.getElementById('form0').action=url;
		     document.getElementById('form0').submit();
		 });
			
		 $('#button002').click(function() {
			 var index = parent.layer.getFrameIndex(window.name);
			 parent.layer.close(index);
		 });
	})
</script>
</head>
<body>
<div style="width: 100%; height: 100%; overflow: auto; position: relative; margin: 0 auto; zoom: 1; padding: 10px 10px;" id="context">
  <form id="form0" name="form0" eventProxy="Mform0" method="post" style="margin:0px;position:relative;overflow:auto;width:100%;height:100%;" enctype="multipart/form-data">
	<input type="hidden" name="form0" value="form0" />
	<input type="hidden" id="mode" name="mode" value="debug" />
	<input type="hidden" id="iframewindowid" name="iframewindowid" value="${param.iframewindowid}"/>
	<input type="hidden" id="templateId" name="templateId" value="${param.templateId}"/>
	<table id="table001" class="tableLayout" style="width: 100%;">
		<tr>
			<td class="tdLayout" style="width: 40%; text-align: center; vertical-align: middle; background-color: rgb(248, 248, 248)">
				<label class="control-label">导入说明：</label>
			</td>
			<td class="tdLayout" style="width: 60%;">
				<label class="control-label" style="padding-left: 3px;color: red">只能导入excel文件：</label>
			</td>
		</tr>
		<tr>
			<td class="tdLayout" style="width: 40%; text-align: center; vertical-align: middle; background-color: rgb(248, 248, 248)">
				<label class="control-label ">导入设置：</label>
			</td>
			<td class="tdLayout" style="width: 60%;">
				<div id="radioGroup001_div" style="display: inline-block;">
					<input id="radioGroup001_0" name="radioGroup001" type="radio" class="box" value="3" checked/>
				</div>
				<label class="control-label" style="vertical-align: middle;">
					不允许重复
				</label>	
				<div id="radioGroup001_1_div" style="display: inline-block;" >
					<input id="radioGroup001_1" name="radioGroup001" type="radio" class="box" value="1" />
				</div>
				<label class="control-label" style="vertical-align: middle;">
					重复时跳过
				</label>
				<div id="radioGroup001_2_div" style="display: inline-block;" >
					<input id="radioGroup001_2" name="radioGroup001" type="radio" class="box" value="2" />
				</div>
				<label class="control-label" style="vertical-align: middle;">
					重复时覆盖
				</label>
			</td>
		</tr>
		<tr>
			<td class="tdLayout" style="width:40%;text-align:center;vertical-align:middle;background-color:rgb(248, 248, 248)">
				<label class="control-label ">选择文件：</label>
			</td>
			<td class="tdLayout" style="width:60%;">
				<input id="uploadFile" name="file" type="file" data-show-caption="true">
			</td>
		</tr>
		<tr>
			<td class="cmdLayout" colspan="2" rowspan="1">
				<button type="button" id="button001" class="x-btn ok-btn ">确认</button>
				<button type="button" id="button002" class="x-btn cancel-btn ">取消</button>
			</td>
		</tr>
	</table>
  </form>
 </div>
</body>
</html>
