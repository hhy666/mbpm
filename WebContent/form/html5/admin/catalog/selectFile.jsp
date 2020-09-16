<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.matrix.form.admin.catalog.model.CatalogInfo"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>

<!DOCTYPE HTML><html><head><meta charset='utf-8'/>
<%@ include file="/form/html5/admin/html5Head.jsp"%>
<script type="text/javascript">
	$(function(){
		var trheight = $('#tr002').height();
		$('#tr001').height(trheight);
		$('#tr004').height(trheight);
		var fileUpload001fileBaseDivWidth = $('#fileUpload001fileBaseDiv').width();
		var fileUpload001InputDIVWidth = $('#fileUpload001InputDIV').width();
		$('#fileUpload001fileNameDIV').width(fileUpload001fileBaseDivWidth - 84);
	});
</script>
</head>
<body>

<% 
	String uuid = request.getParameter("uuid");
	String flag = request.getParameter("flag");
	String parentNodeId = request.getParameter("parentNodeId");
	String type = request.getParameter("type");
 %>


<div style="width:100%;height:100%;overflow:auto;position:relative;margin:0 auto;zoom:1;padding:10px 10px;" id="context">
<form id="form0" name="form0" eventProxy="Mform0" method="post" style="margin:0px;position:relative;overflow:auto;width:100%;height:100%;"  enctype="multipart/form-data">
<table id="table001" class="tableLayout" style="width:99%;"><tr id="tr001" height="20%">
<td id="td001" class="tdLayout" colspan="2" rowspan="1" style="border: none;width:100%;background-color:rgb(255, 255, 255)">
<font id="midfont" color="red" >
<% 
	String message = (String)request.getAttribute("statusMessage");
	if(message != null){
%>
<%=message %>
<%		
	}else{
%>
请选择模块导入模式
<%		
	}
%>
</font>
</td>
<tr id="tr004"><td id="td007" class="tdLayout" style="width:40%;text-align:center;vertical-align:middle;background-color:rgb(248, 248, 248)"><label id="label001" name="label003" id="label003" class="control-label ">
选择文件：</label></td>
<td id="td006" class="tdLayout" style="width:60%;">
	<div id = "fileUpload001fileBaseDiv" style="width:80%;">
		<div id="fileUpload001box">
			<table width="100%">
				<tbody>
					<tr>
						<td>
							<div id="fileUpload001InputDIV" style="height: 30px;float:right;width:70px;margin-left:0px;">
								<div id="fileUpload001InputDIV1" class="file_unload clearfix">
									<a class="common_button common_button_icon file_click" href="###">
										<em class="ico16 affix_16"></em>
										添加
										<input type="file" size="51" name="fileUpload001" id="fileUpload001" onchange="addNextInput(this)">
									</a>
								</div>
							</div>
							<ul id="fileUpload001fileNameDIV" class="file_select  border_all clearfix" style="float:left;padding:0px 5px;margin:0px;  border-right: none; border: 1px solid #e3e3e3;">
								<li><a>&nbsp;</a></li>
							</ul>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<script>
		var fileUpload001annexSize =16;
		var fileUpload001annexType ='null';
		function GetJsonData(fileId) {
			var json="entity=null&name=null&id=null&mappingType=null&type=delete&idValue="+fileId;
			json+="&contents=null";
			json+="&storeType=null";
			return json;
		}
		function fileUpload001delView(rowId,fileId){
			if(confirm('是否删除该文件，删除后不可恢复！')){
			  $.ajax({ type: "post",  url: "<%=path %>/uploadFileHelperServlet",  data:GetJsonData(fileId) });
			var tabObj = document.getElementById("fileUpload001fileBaseViewTab");
			for(j=0;j<=tabObj.tBodies[0].rows.length;j++){
				if(tabObj.tBodies[0].rows[j].id==rowId){
					tabObj.deleteRow(j);
					break;
				}
			}
		}
		document.getElementById("fileUpload001box").style.cssText="display:block";
	}
	</script>
	<script>var quantity = 9999;var isA8geniusAdded = false;var files = new Properties();var number = 0;function fileUpload001showMessage(msg){alert(msg);}function checks(){if(number == 0 || files.isEmpty()){ alert("选择您要上传的文件(单次上传小于50 MB)");    return ;}$("#b1").disable();show();for(var i = 1; i <= index; i++){ var o = document.getElementById("file" + i);if(!o){ continue;}if(!o.value){ document.getElementById("fileUpload001InputDIV" + i).parentNode.removeChild(document.getElementById("fileUpload001InputDIV" + i));  }}document.getElementById('form_upload').submit();}function checkExtensions(obj,enableType){var filePath = obj.value;if (!filePath) {  return false;}fileType = filePath.substring(filePath.lastIndexOf(".")+1);if(enableType!=null && enableType!="" && enableType.toUpperCase().indexOf(fileType.toUpperCase())==-1){return false;}return true; }function show(){}var index = 1;var geniusNum = 0;function addNextInput(obj){if(!validateFileSize(obj,obj.id, 16)){return false;} number++; var s = obj.value.lastIndexOf("\\"); if(s < 0){s = obj.value.lastIndexOf("/");}var filename = obj.value.substring(s + 1);var nameHTML = "";nameHTML += "<li id='fileUpload001fileNameDIV" + index + "' class='margin_r_10'>"; nameHTML += "<span title='"+filename+"'>"; nameHTML += filename; nameHTML += "</span>";nameHTML += "</li>";document.getElementById("fileUpload001fileNameDIV").innerHTML = "<li><a>&nbsp;</a></li>"+ nameHTML; files.put(index, obj.value);index++; addInput(index);return true;}function deleteOne(i){var pos = getIndex(i);removeInput(i); if(!isA8geniusAdded){number-- ; }files.remove(i);}function removeInput(i){var errorNode = false; var pos = getIndex(i);try{document.getElementById("fileUpload001InputDIV" + i).parentNode.removeChild(document.getElementById("fileUpload001InputDIV" + i)); }catch(e){ errorNode = true; }try{document.getElementById("fileUpload001fileNameDIV" + i).parentNode.removeChild(document.getElementById("fileUpload001fileNameDIV" + i));}catch(e){ errorNode = true;}if(isA8geniusAdded&&!errorNode){ var UFIDA_Upload1 = document.getElementById("UFIDA_Upload1");UFIDA_Upload1.DeleteItemFromList(i-1);   number--;  }}function addInput(i){var e = document.createElement("div");e.setAttribute("id","fileUpload001InputDIV" + i); e.className = "file_unload clearfix"; var fileNameIndexFlag = i;if(quantity==1)fileNameIndexFlag = 1; if(isA8geniusAdded){    }else{ var inputHTML1 = ""; inputHTML1+="<a class=\"common_button common_button_icon file_click\" href=\"###\"><em class=\"ico16 affix_16\"></em>添加";inputHTML1+= "<INPUT type=\"file\" name=\"fileUpload001s\" id=\"fileUpload001s\" onchange=\"addNextInput(this)\" onkeydown=\"return false\" onkeypress=\"return false\" style=\"width: 100%\"/>";inputHTML1+="</a>"; e.innerHTML=inputHTML1;}}function getIndex(index){var name = 'fileUpload001fileNameDIV' + index;var container = document.getElementById("fileUpload001fileNameDIV"); var children = container.getElementsByTagName('div'); var len = children.length; var result = 0;for(i = 0;i<len;i++){ var element = children[i];  result ++; if(name == element.id )  {return result;}}return -1;}</script></td></tr>

</tr>
<tr id="tr002"><td id="td003" class="tdLayout" style="width:40%;text-align:center;vertical-align:middle;background-color:rgb(248, 248, 248)"><label id="label001" name="label001" id="label001" class="control-label ">
导入模式：</label></td>
<td id="td004" class="tdLayout" style="width:60%;"><div id="comboBox001_div" class="input-group col-md-12 " style=" width:80%; "> 
<select class="form-control js-states" id="EmportType" name="importType" tabindex="-1" style=" width:100%;height:100%;">
<option value="1">替换</option>
<option value="2">覆盖</option>
</select></div> 
</td>
</tr>
</tr>
<tr id="tr003"><td id="td005" class="cmdLayout" colspan="2" rowspan="1" >
<button type="button"  id="button001" class="x-btn ok-btn " >确定</button>
<button type="button"  id="button002" class="x-btn cancel-btn " >取消</button>



<script type="text/javascript">
	$('#button001').click(function(data){
		var url;
		var mode = '<%=request.getParameter("mode") %>';
		var EmportTypeValue = $('#EmportType').val();
		if(mode == 'list'){
			if(EmportTypeValue == 1){
				url = "<%=request.getContextPath() %>/Html5OperatorModuleHelper?flag=<%=flag %>&importType=replace&mode=list";
			}else if(EmportTypeValue == 2){
				url = "<%=request.getContextPath() %>/Html5OperatorModuleHelper?flag=<%=flag %>&importType=cover&mode=list";
			}
			
		}else{
			var ctype = '<%=type %>';
			if(ctype == '1'){
				if(EmportTypeValue == 1){
					url = "<%=request.getContextPath() %>/Html5OperatorContentsHelper?uuid=<%=uuid %>&flag=<%=flag %>&parentNodeId=<%=parentNodeId %>&importType=replace";
				}else if(EmportTypeValue == 2){
					url = "<%=request.getContextPath() %>/Html5OperatorContentsHelper?uuid=<%=uuid %>&flag=<%=flag %>&parentNodeId=<%=parentNodeId %>&importType=cover";
				}
			}
			if(ctype == '2'){
				if(EmportTypeValue == 1){
					url = "<%=request.getContextPath() %>/Html5OperatorModuleHelper?uuid=<%=uuid %>&flag=<%=flag %>&parentNodeId=<%=parentNodeId %>&importType=replace";
				}else if(EmportTypeValue == 2){
					url = "<%=request.getContextPath() %>/Html5OperatorModuleHelper?uuid=<%=uuid %>&flag=<%=flag %>&parentNodeId=<%=parentNodeId %>&importType=cover";
				}
			}
		}
		$('#form0').attr("action", url);
		$('#form0').submit();
	});
	
	$('#button002').click(function(){
		var index = parent.layer.getFrameIndex(window.name);
		parent.layer.close(index);
	});
</script>

</td>
</tr>
</table>

</form></div></body>
</html>
