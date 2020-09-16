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
	

	var status ='<%=request.getAttribute("status")%>';
	var replyStatus = <%=request.getAttribute("replyStatus")%>;
	
	function checkReportContent(){
		//提出问题/回复问题 判断sysId 有值 系统编号不能修改
		var sysId = Matrix.getFormItemValue('sysId');
		
		MtoolBarItem001.setDisabled(true);
		if(status=='null'){ 
			document.getElementById("reply").style.display='none';
			document.getElementById("split").style.display='none';
			MreplyName.setRequired(false);
			MreplyDate.setRequired(false);
			MreplyContent.setRequired(false);
			MreplyEmail.setRequired(false);
			MreplyTelephone.setRequired(false);
			//MreplySysId.setRequired(false);
			Mbutton001.setDisabled(false);
			MDataGrid001.showField('operate');
			MDataGrid002.showField('operate');
			document.getElementById('button001_div').style.display="";
			document.getElementById('button003_div').style.display="";
			document.getElementById('button002_div').style.display="none";
			
		}else if(status == 'read'){
			MtoolBarItem002.setDisabled(true);//回复  的添加附件按钮禁用
			document.getElementById("reply").style.display='';
			Mtitle.setCanEdit(false);
			MreportDate.setCanEdit(false);
			MproblemDesc.setCanEdit(false);
			MreportorEmail.setCanEdit(false);
  			MreportorTelephone.setCanEdit(false);
			//MreportorSysId.setCanEdit(false);
			MreplyDate.setCanEdit(false);
			MreplyContent.setCanEdit(false);
			MreplyEmail.setCanEdit(false);
			MreplyTelephone.setCanEdit(false);
			//MreplySysId.setCanEdit(false);
			//Mbutton001.setDisabled(true);
			MDataGrid001.hideField('operate');
			MDataGrid002.hideField('operate');
			document.getElementById('button001_div').style.display="none";
			document.getElementById('button003_div').style.display="none";
			document.getElementById('button002_div').style.display="";
			
			var replyFiles = Matrix.getAllDataGridData('DataGrid002');
			
			
		}else if(status =='reply'&&replyStatus==0){
			
			Mtitle.setCanEdit(false);
			MreportDate.setCanEdit(false);
			MproblemDesc.setCanEdit(false);
			MreplyDate.setCanEdit(false);
			MreplyContent.setCanEdit(true);
			MreplyEmail.setCanEdit(true);
			MreplyTelephone.setCanEdit(true);
			Mbutton001.setDisabled(false);
			MreportorEmail.setCanEdit(false);
  			MreportorTelephone.setCanEdit(false);
			//MreportorSysId.setCanEdit(false);
			MtoolBarItem002.setDisabled(false);//回复  的添加附件按钮启用
			MDataGrid001.hideField('operate');
			MDataGrid002.showField('operate');
			document.getElementById('button001_div').style.display="";
			document.getElementById('button003_div').style.display="";
			document.getElementById('button002_div').style.display="none";
		}else if(status=='reply'&& replyStatus==1){
			Mtitle.setCanEdit(false);
			MreportDate.setCanEdit(false);
			MproblemDesc.setCanEdit(false);
			MreplyDate.setCanEdit(false);
			MreplyContent.setCanEdit(false);
			MreplyEmail.setCanEdit(false);
			MreplyTelephone.setCanEdit(false);
			
			
			
			MreportorEmail.setCanEdit(false);
  			MreportorTelephone.setCanEdit(false);
			//MreportorSysId.setCanEdit(false);
			MtoolBarItem002.setDisabled(true);//回复  的添加附件按钮禁用
			//Mbutton001.show(false);
			MDataGrid001.hideField('operate');
			MDataGrid002.hideField('operate');
			document.getElementById('button001_div').style.display="none";
			document.getElementById('button003_div').style.display="none";
			document.getElementById('button002_div').style.display="";
		}
	}
	function titleValidate(item, validator, value, record){
		if(value.length>100){
			return false;
		}
		return true;
	}
	//内容的长度验证
	function contentValidate(item, validator, value, record){
		if(value.length>500){
			return false;
		}
		return true;
	}
/******************************************************************************************/
	//打开附件添加窗口
	function showAddFileDialog(){
		Matrix.setFormItemValue('fileFlag','report');
		
		Matrix.setFormItemValue('iframewindowid','Dialog1');
		
		var uuid = Matrix.getFormItemValue("uuid");
		MDialog1.initSrc = "<%=request.getContextPath()%>/problem/fileOperatorAction_loadAddFile.action?fileFlag=report&uuid="+uuid;
		MDialog1.setHeight('200px');
		MDialog1.setWidth('450px;');
		Matrix.showWindow("Dialog1");
		
	}
	//打开附件回复窗口
	function showReplyFileDialog(){
		Matrix.setFormItemValue('fileFlag','reply');
		Matrix.setFormItemValue('iframewindowid','Dialog2');
		var uuid = Matrix.getFormItemValue("uuid");
		MDialog2.initSrc = "<%=request.getContextPath()%>/problem/fileOperatorAction_loadAddFile.action?fileFlag=reply&uuid="+uuid;
		MDialog2.setHeight('200px');
		MDialog2.setWidth('450px;');
		Matrix.showWindow("Dialog2");
	}
	
	function onDialog2Close(data){
		var dataList = isc.JSON.decode(data);
		MDataGrid002.setData(dataList);
		
	}
	function onDialog1Close(data){
		var dataList = isc.JSON.decode(data);
		MDataGrid001.setData(dataList);
		
	}
	
	//链接 删除 文件
	function deleteFiles(recordId){
		var url = "<%=request.getContextPath()%>/problem/fileOperatorAction_deleteFile.action?uuid="+recordId;
		Matrix.sendRequest(url,null,function(data){
			var data = isc.JSON.decode(data.data);
			if(data.result == true){
				//删除成功  查询
				refreshDataGridData();
			}
		
		});
	}
	//刷新数据表格
	function refreshDataGridData(){
		var uuid = Matrix.getFormItemValue('uuid');
				var fileFlag = Matrix.getFormItemValue('fileFlag');
				var url = "<%=request.getContextPath()%>/problem/fileOperatorAction_findAllFile.action?uuid="+uuid+"&fileFlag="+fileFlag;
				Matrix.sendRequest(url,null,function(data){
					var dialog = Matrix.getFormItemValue('iframewindowid');
					var dataList = isc.JSON.decode(data.data);
					if(dialog=='Dialog1'){//问题报告
						MDataGrid001.setData(dataList);
					}else{//问题回复
						MDataGrid002.setData(dataList);
					}
				});
	}
	//下载文件
	function download(recordId){
		window.location.href="<%=request.getContextPath()%>/problem/fileOperatorAction_fileDownLoad.action?uuid="+recordId;
	}
	function deleteFlag(status,replyStatus,uuid){
		var deleteFlag = "<a id='delReportFile' style=text-decoration:none; href=\"javascript:deleteFiles('"+uuid+"')\">删除</a>";
		if(status=='read'||replyStatus==1){
		   deleteFlag = "";
		}
		return deleteFlag;
	}
/******************************************************************************************/
</script>
</head>
<body onload="checkReportContent();">
<div id='loading' name='loading' class='loading'><script>Matrix.showLoading();</script></div>

<script> var Mform0=isc.MatrixForm.create({
				ID:"Mform0",
				name:"Mform0",
				position:"absolute",
				action:"/demo/matrix.rform",
				fields:[
				{name:'form0_hidden_text',width:0,height:0,displayId:'form0_hidden_text_div'}
				]});
</script>
<div style="width:100%;height:100%;overflow:auto;position:relative;">
<form id="form0" name="form0" eventProxy="Mform0" method="post" 
	action="" 
	style="margin:0px;position:relative;overflow:auto;width:100%;height:100%;" 
	enctype="application/x-www-form-urlencoded">
<input type="hidden" name="form0" value="form0" />
<input type="hidden" id="mode" name="mode" value="debug" />
<input type="hidden" id="matrix_form_tid" name="matrix_form_tid" />
<input type="hidden" id="matrix_form_datagrid_form0" name="matrix_form_datagrid_form0" value="" />
<input type="hidden" id="fileFlag" name="fileFlag"/>
<input type="hidden" id="iframewindowid" name="iframewindowid"/>
<input type="hidden" id="uuid" name="uuid" value="${param.uuid }"/>
<input type="hidden" id="sendUserId" name="sendUserId" value="${param.sendUserId }"/>
<input type="hidden" id="curUserId" name="curUserId" value="${FormValue.userId }"/>
<input type="hidden" id="sysId" name="sysId" value="${param.sysId }"/>
<input type="hidden" id="dataGridId" name="dataGridId" />
<div type="hidden" id="form0_hidden_text_div" name="form0_hidden_text_div" style="position:absolute;width:0;height:0;z-index:-9999999999;top:0;left:0;display:none;"></div>
<input type="hidden" name="javax.matrix.faces.ViewState" id="javax.matrix.faces.ViewState" value="" />
<table class="maintain_form_content" id="report" style="width:100%;">
	<tr>
		<td class="maintain_form_label2">
			<label id="j_id0" name="j_id0">
				标题
			</label>
		</td>
		<td class="maintain_form_input2" colspan="3">
			<div id="title_div" eventProxy="Mform0" class="matrixInline" style="">
			</div>
				<script> var title=isc.TextItem.create({
						ID:"Mtitle",
						name:"title",
						value:"${title}",
						editorType:"TextItem",
						displayId:"title_div",
						position:"relative",
						required:true,
						canEdit:true,
						width:580,
						length:100,
						validators:[{
						type:"custom",
						condition:function(item, validator, value, record){
							return titleValidate(item, validator, value, record);
						},
						errorMessage:"标题必须在100个字符之内!"}]
					});
					Mform0.addField(title);
				</script>
			<span id="validateIdMsg" style="width: 20px; height: 20px; color: #FF0000">
                 *
            </span>
		</td>
	</tr>
	<tr>
		<td class="maintain_form_label2" style="width:15%;">
			<label id="j_id1" name="j_id1">
				报告人姓名
			</label>
		</td>
		<td class="maintain_form_input2">
			<div id="reportorName_div" eventProxy="Mform0" class="matrixInline" style="width:35%;">
				
			</div>
				<script> var reportorName=isc.TextItem.create({
						ID:"MreportorName",
						name:"reportorName",
						value:"${reportorName}",
						editorType:"TextItem",
						displayId:"reportorName_div",
						position:"relative",
						required:true,
						canEdit:false,
						width:220,
						length:100
						
					});
					Mform0.addField(reportorName);
				</script>
			<span id="validateIdMsg" style="width:10px; height:20px; color: #FF0000;float:right;">
                 *
            </span>
		</td>
	<!--  
	</tr>
	<tr>
	-->
		<td class="maintain_form_label2" style="width:15%;" >
			<label id="j_id2" name="j_id2">
				报告时间
			</label>
		</td>
		<td class="maintain_form_input2" >
			<div id="reportDate_div" eventProxy="Mform0" class="matrixInline"  style="width:35%;"></div>
	<script> var reportDate_value=null; 
				var reportDate=
				isc.DateItem.create({
				ID:"MreportDate",
				name:"reportDate",
				value:'${reportDate}',
				type:"date",
				required:true,
				displayId:"reportDate_div",
				formatPattern:"yyyy-MM-dd",
				autoDraw:false,
				useTextField:true,
				enforceDate:true,
				position:"relative",
				canEdit:false
				});
				Mform0.addField(reportDate);
					</script>
			</td>
	</tr>
	<tr>
		<td class="maintain_form_label2">
			<label id="j_id9" name="j_id9">
				邮箱
			</label>
		</td>
		<td class="maintain_form_input2">
			<div id="reportorEmail_div" eventProxy="Mform0" class="matrixInline" style="width:35%;">
				
			</div>
				<script> var reportorEmail=isc.TextItem.create({
						ID:"MreportorEmail",
						name:"reportorEmail",
						value:"${reportorEmail}",
						editorType:"TextItem",
						displayId:"reportorEmail_div",
						position:"relative",
						required:true,
						canEdit:true,
						width:220,
						length:100,
						validators:[{
							type:"custom",
							condition:function(item, validator, value, record){
								return Matrix.validateEmail(value);},
								errorMessage:"邮箱格式不正确!"
							}]
					});
					Mform0.addField(reportorEmail);
				</script>
		</td>
		<td class="maintain_form_label2">
			<label id="j_id10" name="j_id10">
				电话
			</label>
		</td>
		<td class="maintain_form_input2">
			<div id="reportorTelephone_div" eventProxy="Mform0" class="matrixInline" style="width:35%;">
				
			</div>
				<script> var reportorTelephone=isc.TextItem.create({
						ID:"MreportorTelephone",
						name:"reportorTelephone",
						value:"${reportorTelephone}",
						editorType:"TextItem",
						displayId:"reportorTelephone_div",
						position:"relative",
						required:true,
						canEdit:true,
						width:220,
						length:100,
						validators:[{
							type:"custom",
							condition:function(item, validator, value, record){
								return Matrix.validateMobileTelephone(value);},
								errorMessage:"手机号码不正确!"}]
						
					});
					Mform0.addField(reportorTelephone);
				</script>
		</td>
	</tr>
	<!--  
	<tr>
		<td class="maintain_form_label2">
			<label id="j_id11" name="j_id11">
				系统编码
			</label>
		</td>
		<td class="maintain_form_input2" colspan="3">
			<div id="reportorSysId_div" eventProxy="Mform0" class="matrixInline" style="width:35%;">
				
			</div>
				<script> var reportorSysId=isc.TextItem.create({
						ID:"MreportorSysId",
						name:"reportorSysId",
						value:"${reportorSysId}",
						editorType:"TextItem",
						displayId:"reportorSysId_div",
						position:"relative",
						required:true,
						canEdit:true,
						width:500,
						length:100
						
					});
					Mform0.addField(reportorSysId);
				</script>
		</td>
	</tr>
	-->
	<tr>
		<td class="maintain_form_label2" >
			<label id="j_id3" name="j_id3">
				内容描述
			</label>
		</td>
		<td class="maintain_form_input2" colspan="3">
			<div id="problemDesc_div" eventProxy="Mform0" class="matrixInline" style=""></div>
				<script> 
					var MproblemDesc_value=null;
					var problemDesc=isc.TextAreaItem.create({
								ID:"MproblemDesc",
								name:"problemDesc",
								value:'${problemDesc}',
								editorType:"TextAreaItem",
								displayId:"problemDesc_div",
								position:"relative",
								width:600,
								height:100,
								canEdit:true,
								required:true,
								validators:[{
									type:"custom",
									condition:function(item, validator, value, record){
										return contentValidate(item, validator, value, record);
									},
									errorMessage:"内容长度必须在500个字符之内!"}]
								});
							Mform0.addField(problemDesc);
					</script>
					
				</td>
	</tr>
	<tr>
		<td id="td002" class="maintain_form_label2" colspan="4">
		<label id="j_id8" name="j_id8" >
				上传文件
			</label>
		</td>
		</tr>
		<tr>
		<td colspan='4'>
       		<table class="query_form_content" style="height:100%;width:100%;overflow:hidden;border-collapse: collapse;border-spacing:0px;table-layout:fixed;">
	<tr>
		<td class="query_form_toolbar" style="width:100%;height:30px;margin:0px;padding:0px;" >
		<script>isc.ToolStripButton.create({
			ID:"MtoolBarItem001",
			icon:"[skin]/images/matrix/actions/add.png",
			title: "附件",
			showDisabledIcon:false,
			showDownIcon:false 
		});
		MtoolBarItem001.click=function(){
			Matrix.showMask();
			showAddFileDialog();
			Matrix.hideMask();
		}
	</script>
	<div id="QueryForm001_tb_div"  style="width:100%;height:30px;;overflow:hidden;padding:0;"  >
		<script>isc.ToolStrip.create({
			ID:"MQueryForm001_tb",
			displayId:"QueryForm001_tb_div",
			width: "100%",height: "100%",
			position: "relative",
			members: [ MtoolBarItem001 ] });
			isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"MQueryForm001_tb.resizeTo(0,0);MQueryForm001_tb.resizeTo('100%','100%');",null);},isc.Page.FIRE_ONCE);</script></div></td>
</tr>
<tr><td  style="border-style:none;width:100%;height:100px;margin:0px;padding:0px;">
		<div id="DataGrid001_div" class="matrixComponentDiv" style="width:100%;height:100%;">
			<script> var MDataGrid001_DS=<%=request.getAttribute("reportFileList")%>;
					isc.MatrixListGrid.create({
						ID:"MDataGrid001",
						name:"DataGrid001",
						displayId:"DataGrid001_div",
						position:"relative",
						width:"100%",
						height:"100%",
						fields:[
						    {title:"&nbsp;",name:"MRowNum",canSort:false,canExport:false,canDragResize:false,showDefaultContextMenu:false,autoFreeze:true,autoFitEvent:'none',width:45,canEdit:false,canFilter:false,autoFitWidth:false,formatCellValue:function(value, record, rowNum, colNum,grid){if(grid.startLineNumber==null)return '&nbsp;';return grid.startLineNumber+rowNum;}},
						    {title:"文件名称",matrixCellId:"fileName",name:"fileName",canEdit:false,editorType:'Text',type:'text',formatCellValue:function(value, record, rowNum, colNum,grid){return Matrix.conditionFormatter(value,[{_value:record.fileName,_link:'javascript:download(\''+record.uuid+'\');',_condition:true,_type:'link_type'}],record, rowNum, colNum,grid);},displayType:"Custom_Type"},
						    {title:"操作",name:"operate",formatCellValue:function(value, record, rowNum, colNum,grid){
								      return deleteFlag(status,replyStatus,record.uuid);
								  }
							}
						   ],
						autoSaveEdits:true,
						isMLoaded:false,
						autoDraw:false,
						autoFetchData:true,
						selectionType:"single",
						selectionAppearance:"rowStyle",
						alternateRecordStyles:true,
						canSort:true,
						autoFitFieldWidths:false,
						startLineNumber:1,
						editEvent:"doubleClick",
						canCustomFilter:true,
						exportCells:[{id:'fileName',title:'文件名称'}],
						showRecordComponents:true,
						showRecordComponentsByCell:true
					});
					isc.MatrixDataSource.create({
						ID:'MDataGrid001_custom_filter_ds',
						fields:[
							{title:"文件名称",name:"fileName",type:'text',editorType:'Text'}
						]
					});
					isc.FilterBuilder.create({
						ID:'MDataGrid001_custom_filter',
						dataSource:MDataGrid001_custom_filter_ds,
						topOperatorAppearance:"none"
					});
					isc.Button.create({
						ID:'MDataGrid001_custom_filter_btn',
						title:"确认",
						autoDraw:false,
						click:"MDataGrid001.hideCustomFilter()"});
						isc.Button.create({
							ID:'MDataGrid001_custom_filter_btn_cancel',
							title:"取消",
							autoDraw:false,
							click:"MDataGrid001_custom_filter_window.hide()"
						});
						isc.Window.create({
							ID:'MDataGrid001_custom_filter_window',
							title:"高级查询",
							autoCenter:true,
							overflow:"auto",
							isModal:true,
							autoDraw:false,
							height:300,
							width:500,
							canDragResize:true,
							showMaximizeButton:true,
							items: [MDataGrid001_custom_filter],
							showFooter:true,
							footerHeight:20,
							footerControls:[
								isc.HTMLFlow.create(
									{width:'30%',contents:"&nbsp;",autoDraw:false}
								),
							MDataGrid001_custom_filter_btn,
							isc.HTMLFlow.create(
								{width:'5%',contents:"&nbsp;",autoDraw:false}
							),
							MDataGrid001_custom_filter_btn_cancel,
							isc.HTMLFlow.create(
								{width:'30%',contents:"&nbsp;",autoDraw:false}
							)
						]
					});
					isc.Page.setEvent(isc.EH.LOAD,function(){
									MDataGrid001.isMLoaded=true;
									MDataGrid001.draw();
									MDataGrid001.setData(MDataGrid001_DS);
									MDataGrid001.resizeTo('100%','100%');
									isc.Page.setEvent(isc.EH.RESIZE,function(){
											isc.Page.setEvent(isc.EH.RESIZE,"MDataGrid001.resizeTo(0,0);MDataGrid001.resizeTo('100%','100%');",null);
									},
									isc.Page.FIRE_ONCE);
							},
					isc.Page.FIRE_ONCE
				);
				if(Matrix.getDataGridIdsHiddenOfForm('form0')){
					Matrix.getDataGridIdsHiddenOfForm('form0').value=Matrix.getDataGridIdsHiddenOfForm('form0').value+',DataGrid001'}
				</script>
				</div><input id="DataGrid001_data_entity" name="DataGrid001_data_entity" value="com.matrix.client.foundation.problem.model.Problem" type="hidden" /></td>
</tr>

</table>
       </td>		
	  
	</tr>
	<tr id="split">
		<td colspan="4" class="maintain_form_label2" style="height:10px; width:100%;"></td>
	</tr>
	<tr id="replyTr">
		<td colspan="4">
	<table class="maintain_form_content" id="reply" style="width:100%;">
	<tr>
		<td class="maintain_form_label2" style="width:15%;">
			<label id="j_id4" name="j_id4">
				回复人姓名
			</label>
		</td>
		<td class="maintain_form_input2">
			<div id="replyName_div" eventProxy="Mform0" class="matrixInline" style="width:35%;">
			</div>
				<script> var replyName=isc.TextItem.create({
						ID:"MreplyName",
						name:"replyName",
						value:"${replyName}",
						editorType:"TextItem",
						displayId:"replyName_div",
						position:"relative",
						required:true,
						canEdit:false,
						width:220,
						length:100
					});
					Mform0.addField(replyName);
				</script>
			<span id="validateIdMsg" style="width: 10px; height: 20px; color: #FF0000; float:right;">
                 *
            </span>
		</td>
	
		<td class="maintain_form_label2" style="width:15%;">
			<label id="j_id5" name="j_id5">
				回复时间
			</label>
		</td>
		<td class="maintain_form_input2" >
			<div id="replyDate_div" eventProxy="Mform0" class="matrixInline"  style="width:35%;"></div>
	<script> var replyDate_value=null; 
				var replyDate=
				isc.DateItem.create({
				ID:"MreplyDate",
				name:"replyDate",
				value:'${replyDate}',
				type:"date",
				displayId:"replyDate_div",
				formatPattern:"yyyy-MM-dd",
				autoDraw:false,
				required:true,
				useTextField:true,
				enforceDate:true,
				position:"relative",
				canEdit:false
				});
				Mform0.addField(replyDate);
					</script>
			</td>
	</tr>
	<tr>
		<td class="maintain_form_label2">
			<label id="j_id30" name="j_id30">
				邮箱
			</label>
		</td>
		<td class="maintain_form_input2">
			<div id="replyEmail_div" eventProxy="Mform0" class="matrixInline" style="width:35%;">
				
			</div>
				<script> var replyEmail=isc.TextItem.create({
						ID:"MreplyEmail",
						name:"replyEmail",
						value:"${replyEmail}",
						editorType:"TextItem",
						displayId:"replyEmail_div",
						position:"relative",
						required:true,
						canEdit:true,
						width:220,
						length:100,
						validators:[{
							type:"custom",
							condition:function(item, validator, value, record){
								return Matrix.validateEmail(value);},
								errorMessage:"邮箱格式不正确!"
							}]
					});
					Mform0.addField(replyEmail);
				</script>
		</td>
		<td class="maintain_form_label2">
			<label id="j_id31" name="j_id31">
				电话
			</label>
		</td>
		<td class="maintain_form_input2">
			<div id="replyTelephone_div" eventProxy="Mform0" class="matrixInline" style="width:35%;">
				
			</div>
				<script> var replyTelephone=isc.TextItem.create({
						ID:"MreplyTelephone",
						name:"replyTelephone",
						value:"${replyTelephone}",
						editorType:"TextItem",
						displayId:"replyTelephone_div",
						position:"relative",
						required:true,
						canEdit:true,
						width:220,
						length:100,
						validators:[{
							type:"custom",
							condition:function(item, validator, value, record){
								return Matrix.validateMobileTelephone(value);},
								errorMessage:"手机号码不正确!"}]
						
					});
					Mform0.addField(replyTelephone);
				</script>
		</td>
	</tr>
	<!-- 
	<tr>
		<td class="maintain_form_label2">
			<label id="j_id32" name="j_id32">
				系统编码
			</label>
		</td>
		<td class="maintain_form_input2" colspan="3">
			<div id="replySysId_div" eventProxy="Mform0" class="matrixInline" style="width:35%;">
				
			</div>
				<script> var replySysId=isc.TextItem.create({
						ID:"MreplySysId",
						name:"replySysId",
						value:"${replySysId}",
						editorType:"TextItem",
						displayId:"replySysId_div",
						position:"relative",
						required:true,
						canEdit:true,
						width:500,
						length:100
						
					});
					Mform0.addField(replySysId);
				</script>
		</td>
	</tr>
	 -->
	<tr>
		<td class="maintain_form_label2" >
			<label id="j_id6" name="j_id6">
				回复内容
			</label>
		</td>
		<td class="maintain_form_input2" colspan="3" >
			<div id="replyContent_div" eventProxy="Mform0" class="matrixInline" style=""></div>
				<script> 
					var MreplyContent_value=null;
					var replyContent=isc.TextAreaItem.create({
								ID:"MreplyContent",
								name:"replyContent",
								value:'${replyContent}',
								editorType:"TextAreaItem",
								displayId:"replyContent_div",
								position:"relative",
								width:600,
								required:true,
								height:100,
								canEdit:true,
								validators:[{
									type:"custom",
									condition:function(item, validator, value, record){
									return contentValidate(item, validator, value, record);
								},
								errorMessage:"内容长度必须在500个字符之内!"}]
								
							});
							Mform0.addField(replyContent);
					</script>
					
				</td>
	</tr>
	
	<tr>
		<td id="td003"  colspan='4' class="maintain_form_label2">
		    <label id="j_id21" name="j_id21">
				回复文件
		    </label>
		</td>
		</tr>
		<tr>
		<td colspan='4'>
	<table class="query_form_content" style="height:100%;width:100%;overflow:hidden;border-collapse: collapse;border-spacing:0px;table-layout:fixed;">
	<tr>
		<td class="query_form_toolbar" style="width:100%;height:30px;margin:0px;padding:0px;" >
		<script>isc.ToolStripButton.create({
			ID:"MtoolBarItem002",
			icon:"[skin]/images/matrix/actions/add.png",
			title: "附件",
			showDisabledIcon:false,
			showDownIcon:false 
		});
		MtoolBarItem002.click=function(){
			Matrix.showMask();
			showReplyFileDialog();
			Matrix.hideMask();
		}
	</script>
	<div id="QueryForm002_tb_div"  style="width:100%;height:30px;;overflow:hidden;"  >
		<script>isc.ToolStrip.create({
			ID:"MQueryForm002_tb",
			displayId:"QueryForm002_tb_div",
			width: "100%",height: "100%",
			position: "relative",
			members: [ MtoolBarItem002 ] });
			isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"MQueryForm002_tb.resizeTo(0,0);MQueryForm002_tb.resizeTo('100%','100%');",null);},isc.Page.FIRE_ONCE);</script></div></td>
</tr>
<tr><td  style="border-style:none;width:100%;height:100px;margin:0px;padding:0px;">
		<div id="DataGrid002_div" class="matrixComponentDiv" style="width:100%;height:100%;">
			<script> var MDataGrid002_DS=<%=request.getAttribute("replyFileList")%>;
					isc.MatrixListGrid.create({
						ID:"MDataGrid002",
						name:"DataGrid002",
						displayId:"DataGrid002_div",
						position:"relative",
						width:"100%",
						height:"100%",
						fields:[
						    {title:"&nbsp;",name:"MRowNum",canSort:false,canExport:false,canDragResize:false,showDefaultContextMenu:false,autoFreeze:true,autoFitEvent:'none',width:45,canEdit:false,canFilter:false,autoFitWidth:false,formatCellValue:function(value, record, rowNum, colNum,grid){if(grid.startLineNumber==null)return '&nbsp;';return grid.startLineNumber+rowNum;}},
						    {title:"文件名称",matrixCellId:"fileName",name:"fileName",canEdit:false,editorType:'Text',type:'text',formatCellValue:function(value, record, rowNum, colNum,grid){return Matrix.conditionFormatter(value,[{_value:record.fileName,_link:'javascript:download(\''+record.uuid+'\');',_condition:true,_type:'link_type'}],record, rowNum, colNum,grid);},displayType:"Custom_Type"},
						    {title:"操作",formatCellValue:function(value, record, rowNum, colNum,grid){
								  return deleteFlag(status,replyStatus,record.uuid);
								}
							}
						   ],
						autoSaveEdits:true,
						isMLoaded:false,
						autoDraw:false,
						autoFetchData:true,
						selectionType:"single",
						selectionAppearance:"rowStyle",
						alternateRecordStyles:true,
						canSort:true,
						autoFitFieldWidths:false,
						startLineNumber:1,
						editEvent:"doubleClick",
						canCustomFilter:true,
						exportCells:[{id:'fileName',title:'文件名称'}],
						showRecordComponents:true,
						showRecordComponentsByCell:true
					});
					isc.MatrixDataSource.create({
						ID:'MDataGrid002_custom_filter_ds',
						fields:[
							{title:"文件名称",name:"fileName",type:'text',editorType:'Text'}
						]
					});
					isc.FilterBuilder.create({
						ID:'MDataGrid002_custom_filter',
						dataSource:MDataGrid002_custom_filter_ds,
						topOperatorAppearance:"none"
					});
					isc.Button.create({
						ID:'MDataGrid002_custom_filter_btn',
						title:"确认",
						autoDraw:false,
						click:"MDataGrid002.hideCustomFilter()"});
						isc.Button.create({
							ID:'MDataGrid002_custom_filter_btn_cancel',
							title:"取消",
							autoDraw:false,
							click:"MDataGrid002_custom_filter_window.hide()"
						});
						isc.Window.create({
							ID:'MDataGrid002_custom_filter_window',
							title:"高级查询",
							autoCenter:true,
							overflow:"auto",
							isModal:true,
							autoDraw:false,
							height:300,
							width:500,
							canDragResize:true,
							showMaximizeButton:true,
							items: [MDataGrid002_custom_filter],
							showFooter:true,
							footerHeight:20,
							footerControls:[
								isc.HTMLFlow.create(
									{width:'30%',contents:"&nbsp;",autoDraw:false}
								),
							MDataGrid002_custom_filter_btn,
							isc.HTMLFlow.create(
								{width:'5%',contents:"&nbsp;",autoDraw:false}
							),
							MDataGrid002_custom_filter_btn_cancel,
							isc.HTMLFlow.create(
								{width:'30%',contents:"&nbsp;",autoDraw:false}
							)
						]
					});
					isc.Page.setEvent(isc.EH.LOAD,function(){
									MDataGrid002.isMLoaded=true;
									MDataGrid002.draw();
									MDataGrid002.setData(MDataGrid002_DS);
									MDataGrid002.resizeTo('100%','100%');
									isc.Page.setEvent(isc.EH.RESIZE,function(){
											isc.Page.setEvent(isc.EH.RESIZE,"MDataGrid002.resizeTo(0,0);MDataGrid002.resizeTo('100%','100%');",null);
									},
									isc.Page.FIRE_ONCE);
							},
					isc.Page.FIRE_ONCE
				);
				if(Matrix.getDataGridIdsHiddenOfForm('form0')){
					Matrix.getDataGridIdsHiddenOfForm('form0').value=Matrix.getDataGridIdsHiddenOfForm('form0').value+',DataGrid002'}
				</script>
				</div><input id="DataGrid002_data_entity" name="DataGrid002_data_entity" value="com.matrix.client.foundation.problem.model.Problem" type="hidden" />
		</td>
	</tr>
</table>
	</td>
		
</tr>
</table>
</td>
</tr>
<tr>
	
	<td class="maintain_form_command"  colspan='4' style="align:center;">
	<div id="button001_div" class="matrixInline" style="position:relative;;width:100px;;height:22px;">
	<script>
		isc.Button.create({
			ID:"Mbutton001",
			name:"button001",
			title:"保存",
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
			Matrix.showMask();
			if(!true){
				Matrix.hideMask();
				return false;
			}
			if(!Mform0.validate()){
				Matrix.hideMask(); 
				return false;
			}
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
				var _mgr=Matrix.convertDataGridDataOfForm('form0');
				if(_mgr!=null&&_mgr==false){
					Matrix.hideMask();
					return false;
				}
				var uuid=Matrix.getFormItemValue('uuid');
				var senduserId = Matrix.getFormItemValue('sendUserId');
				var curUserId = Matrix.getFormItemValue('curUserId');
				var userId = "";
				if(sendUserId!=null&&sendUserId.length>0){
					userId = sendUserId;
				}else{
					userId = curUserId;				
				}
				document.getElementById('form0').action="<%=request.getContextPath()%>/problem/problemAction_saveOrUpdateProblem.action?userId="+userId;
				//document.getElementById('form0').submit();
				
				
				var newData=null;
				var synJson=null;
				
				if(uuid!=null){
					newData="{'uuid':'"+uuid+"'}";
					synJson = isc.JSON.decode(newData);
				}
				
				Matrix.send('form0',synJson,function(data){
						var uuid = data.data;
						if(uuid!=null&&uuid.length!=0){
							Matrix.setFormItemValue('uuid',uuid);
							MtoolBarItem001.setDisabled(false);
							Matrix.say("操作成功!");
						}
					});
					Matrix.hideMask();
				};
			</script>
		</div>
		<div id="button003_div" class="matrixInline" style="position:relative;;width:100px;;height:22px;">
	<script>
		isc.Button.create({
			ID:"Mbutton003",
			name:"button003",
			title:"提交",
			displayId:"button003_div",
			position:"absolute",
			top:0,left:0,
			width:"100%",
			height:"100%",
			icon:"[skin]/images/matrix/actions/save.png",
			showDisabledIcon:false,
			showDownIcon:false,
			showRollOverIcon:false
		});
		Mbutton003.click=function(){
			Matrix.showMask();
			if(!true){
				Matrix.hideMask();
				return false;
			}
			if(!Mform0.validate()){
				Matrix.hideMask(); 
				return false;
			}
			var vituralbuttonHidden = document.getElementById('matrix_command_id');
			if(vituralbuttonHidden)
				vituralbuttonHidden.parentNode.removeChild(vituralbuttonHidden);
				var currentForm = document.getElementById('form0');
				var buttonHidden = document.createElement('input');
				buttonHidden.type='hidden';
				buttonHidden.name='matrix_command_id';
				buttonHidden.id='matrix_command_id';
				buttonHidden.value='button003';
				currentForm.appendChild(buttonHidden);
				var _mgr=Matrix.convertDataGridDataOfForm('form0');
				if(_mgr!=null&&_mgr==false){
					Matrix.hideMask();
					return false;
				}
				var uuid=Matrix.getFormItemValue('uuid');
				var senduserId = Matrix.getFormItemValue('sendUserId');
				var curUserId = Matrix.getFormItemValue('curUserId');
				var userId = "";
				if(sendUserId!=null&&sendUserId.length>0){
					userId = sendUserId;
				}else{
					userId = curUserId;				
				}
				document.getElementById('form0').action="<%=request.getContextPath()%>/problem/problemAction_saveOrUpdateProblem.action?userId="+userId;
				//document.getElementById('form0').submit();
				
				
				var newData=null;
				var synJson=null;
				
				if(uuid!=null){
					newData="{'uuid':'"+uuid+"'}";
					synJson = isc.JSON.decode(newData);
				}
				
				Matrix.send('form0',synJson,function(data){
						var uuid = data.data;
						if(uuid!=null&&uuid.length!=0){
							Matrix.setFormItemValue('uuid',uuid);
							//MtoolBarItem001.setDisabled(false);
							//Matrix.say("操作成功!");
							Matrix.closeWindow();
						}
					});
					Matrix.hideMask();
				};
			</script>
		</div>
		<div id="button002_div" class="matrixInline" style="position:relative;;width:100px;;height:22px;">
			<script>isc.Button.create({ID:"Mbutton002",name:"button002",title:"关闭",displayId:"button002_div",position:"absolute",
			top:0,left:0,width:"100%",height:"100%",icon:"[skin]/images/matrix/actions/exit.png",showDisabledIcon:false,showDownIcon:false,showRollOverIcon:false});Mbutton002.click=function(){Matrix.showMask();Matrix.closeWindow();Matrix.hideMask();};
			</script>
		</div>
	</td>
</tr>

</table>
<script>
	function getParamsForDialog1(){
		var params='&';
		var value;
	    return params;
	}
	isc.Window.create({
		ID:"MDialog1",
		id:"Dialog1",
		name:"Dialog1",
		autoCenter: true,
		position:"absolute",
		width: "400px",
		title: "添加附件",
		canDragReposition: false,
		showMinimizeButton:true,
		showMaximizeButton:true,
		showCloseButton:true,
		showModalMask: false,
		modalMaskOpacity:0,
		isModal:true,
		autoDraw: false,
		headerControls:["headerIcon","headerLabel","closeButton"],
		
		});
		</script>
		<script>MDialog1.hide();
		</script>
		<script>
	function getParamsForDialog2(){
		var params='&';
		var value;
	    return params;
	}
	isc.Window.create({
		ID:"MDialog2",
		id:"Dialog2",
		name:"Dialog2",
		autoCenter: true,
		position:"absolute",
		width: "400px",
		title: "添加附件",
		canDragReposition: false,
		showMinimizeButton:true,
		showMaximizeButton:true,
		showCloseButton:true,
		showModalMask: false,
		modalMaskOpacity:0,
		isModal:true,
		autoDraw: false,
		headerControls:["headerIcon","headerLabel","closeButton"],
		
		});
		</script>
		<script>MDialog2.hide();
		</script>

</form></div><script>Mform0.initComplete=true;Mform0.redraw();isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"Mform0.redraw()",null);},isc.Page.FIRE_ONCE);</script></body>
</html>
