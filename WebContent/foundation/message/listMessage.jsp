<%@page pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML>
<html>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<title>消息列表</title>
<head>
<jsp:include page="/foundation/common/taglib.jsp"/>
<jsp:include page="/foundation/common/resource.jsp"/>     
<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/office.js"></script>
<script type="text/javascript">
	//双击查看消息具体内容
	function doubleClickReadMessage(url,messageId){
	        if(url == null || url == ""){
	        	url="foundation/message_infoMessage.action?readMessage=true";
				MDialog0.initSrc = "<%=request.getContextPath() %>/"+url+"&flag=1&messageId="+messageId;
				Matrix.showWindow("Dialog0");
			}else if(url!=null &&url.indexOf("readMessage=true")>=0){//单纯的发消息
				MDialog0.initSrc = "<%=request.getContextPath()%>/"+url+"&flag=1&messageId="+messageId;
				Matrix.showWindow("Dialog0");
			}else{
				if(url.indexOf("FlowFrame")>=0){
					var tindex = url.indexOf("taskId=");
					var mindex = url.indexOf("&mBizId");
					var value = url.substring(tindex+7,mindex);
					var getStatusUrl = "<%=request.getContextPath()%>/foundation/message_getByTaskId.action?taskId="+value;
				Matrix.sendRequest(getStatusUrl,null,function(data){
					if(data!=null&&data.data!="")
							if(data.data==1){
								urlValue = "<%=request.getContextPath()%>/"+url;
								openCtpWindow({'url':urlValue,'title':'消息内容'});
							}if(data.data==2){
								Matrix.warn("该任务正在被别人处理！");
								return false;
							}if(data.data==3){
								Matrix.warn("该任务已被处理！");
								return false;
							}if(data.data==4){
								Matrix.warn("该任务已被别人处理！");
								return false;
							}
					});
				}else{
						urlValue = "<%=request.getContextPath()%>/"+url;
								openCtpWindow({'url':urlValue,'title':'消息内容'});
				}
				//打开之后 修改为已读
				if(messageId!=null && messageId.length>0){
					var updateStatusUrl = "<%=request.getContextPath()%>/foundation/message_updateMessageStatus.action?messageId="+messageId;
					Matrix.sendRequest(updateStatusUrl,null,function(){
						Matrix.refreshDataGridData('DataGrid001');
					});
				}
			}
	}
	function onDialog0Close(){
		Matrix.refreshDataGridData('DataGrid001');
	}
	//按钮删除
	function deleteByButton(selects){
		var messageIds=[];
		var flag = true;//默认都已读 
		var data="{'messageIds':'";
		if(selects.size() == 0){
			Matrix.warn('未选中消息!');
			return;
		}else{
			for(var i=0;i<selects.size();i++){
				messageIds.add(selects.get(i).messageId);
				if(selects.get(i).isReaded!=1){
					flag = false;
				}
				data+=selects.get(i).messageId;
				if(i!=selects.size()-1){
					data+=",";
				}
			}
			data+="'}";
			confirmFlag(flag,data,selects.size());
		}
		
		//if(select.length != 0){
		//	var isReaded = select.get(0).isReaded;
		//	var messageId = select.get(0).messageId;
		//	var subjectValue = select.get(0).subjectValue;
		//	confirmIsReaded(isReaded,messageId,subjectValue);
		//}else{
		//	Matrix.warn('未选中消息!');
		//}
	}
	function confirmFlag(flag,data,rows){
		if(flag == false){
			Matrix.confirm("有未读的消息,确认删除这"+rows+"条消息吗?",function(value){
				if(value){
					deleteMessages(data);
				}
			});
		}else{
			Matrix.confirm("确认删除这"+rows+"条消息吗?",function(value){
				if(value){
					deleteMessages(data);
				}
			});
		}
	}

	//链接删除
	//function deleteMessageByConnection(isReaded,messageId,subjectValue){
	//	if(isReaded!=null&&messageId!=null&&subjectValue!=null){
	//		confirmIsReaded(isReaded,messageId,subjectValue);
	//	}else{
	//		Matrix.warn('未选中消息!');
	//	}
	//}
	
	
	//function confirmIsReaded(isReaded,messageId,subjectValue){
	//	if(isReaded == '0'){
	//		Matrix.confirm(subjectValue+"还未读，确认删除吗?",function(value){
	//			if(value){
	//				deleteMessage(messageId);
	//			}
	//		});
	//	}else{
	//		Matrix.confirm("确认删除"+subjectValue+"吗?",function(value){
	//			if(value){
	//				deleteMessage(messageId);
	//			}
	//		});
	//	}
	//}
	// 删除 
	function deleteMessages(data){
		var url ="<%=request.getContextPath()%>/foundation/message_deleteMessage.action";
		var synJson = isc.JSON.decode(data);
		Matrix.sendRequest(url,synJson,function(data){
		    var json = isc.JSON.decode(data.data);
			if(json.result == true){
				Matrix.refreshDataGridData('DataGrid001');
				Matrix.say("删除成功!");
			}else{
				Matrix.warn("未能删除!");
			}
		});
	}
	function checkHasMessageId(){
		var messageId = Matrix.getFormItemValue('messageId');
		if(messageId!=null&&messageId.length>0){
			MDialog0.initSrc = "<%=request.getContextPath()%>/foundation/message_infoMessage.action?messageId="+messageId;
			Matrix.showWindow("Dialog0");
		}
	}
</script>
</head>
<body style="overflow:hidden;">
	
<div id='loading' name='loading' class='loading'><script>Matrix.showLoading();</script></div>

<script> var Mform0=isc.MatrixForm.create({
	ID:"Mform0",
	name:"Mform0",
	position:"absolute",
	action:"<%=request.getContextPath()%>/matrix.rform",
	fields:[{name:'form0_hidden_text',
			 width:0,
			 height:0,
			 displayId:'form0_hidden_text_div'
	}]});
</script>
<div
	style="width: 100%; height: 100%; overflow: auto; position: relative;">
	<form id="form0" name="form0" eventProxy="Mform0" method="post" action="" style="margin:0px;position:relative;overflow:hidden;width:100%;height:100%;" enctype="application/x-www-form-urlencoded">
		<input type="hidden" name="form0" value="form0" />
		<input type="hidden" id="dataGridId" name="dataGridId" value="DataGrid001"/>
		<input type="hidden" id="matrix_form_datagrid_form0" name="matrix_form_datagrid_form0" value="" />
		<input type="hidden" id="messageId" value="${param.messageId }">
		<div type="hidden" id="form0_hidden_text_div" name="form0_hidden_text_div" style="position:absolute;width:0;height:0;z-index:-9999999999;top:0;left:0;display:none;"></div>
			<input type="hidden" name="javax.matrix.faces.ViewState" id="javax.matrix.faces.ViewState" value="" />
			<table class="query_form_content" style="height:100%;width:100%;overflow:hidden;border-collapse: collapse;border-spacing:0px;table-layout:fixed;">
				<tr><td class="query_form_toolbar" colspan="2">
				<script> 
					var subjectValue=isc.TextItem.create({
							ID:"MsubjectValue",
							name:"subjectValue",
							editorType:"TextItem",
							displayId:"subjectValue_div",
							position:"relative"
						});
						Mform0.addField(subjectValue);
				</script>
				<script> 
	                var MconditionType_VM=[]; 
	                var conditionType=isc.SelectItem.create({
		                    ID:"MconditionType",
							name:"conditionType",
							editorType:"SelectItem",
							displayId:"conditionType_div",
							autoDraw:false,
							valueMap:[],
							value:"0",
							position:"relative",
							width:72
							
							
					});
					Mform0.addField(conditionType);
					MconditionType_VM=['0','1','-1'];
					MconditionType.displayValueMap={'0':'未读','1':'已读','-1':'全部'};
					MconditionType.setValueMap(MconditionType_VM);
					MconditionType.setValue('0');
				</script>
				<script>
					isc.ToolStripButton.create({
							ID:"MtoolBarItem",
							icon:"[skin]/images/matrix/actions/query.png",
							title: "查询",
							showDisabledIcon:false,
							showDownIcon:false 
						});
						MtoolBarItem.click=function(){
							Matrix.showMask();
							Matrix.refreshDataGridData('DataGrid001');
							
							Matrix.hideMask();
						}
				</script>
				<script>
			/*	isc.ToolStripButton.create({
							ID:"MtoolBarItemSend",
							icon:"[skin]/images/matrix/actions/add.png",
							title: "发送消息",
							showDisabledIcon:false,
							showDownIcon:false 
						});
						MtoolBarItemSend.click=function(){
							Matrix.showMask();
							var x = eval("Matrix.showWindow('send');");
							if(x!=null && x==false){
								Matrix.hideMask();
								return false;
							}
							Matrix.hideMask();
						}*/
				</script>
				<script>
					isc.ToolStripButton.create({
						ID:"MtoolBarItem001",
						icon:"[skin]/images/matrix/actions/edit.png",
						title: "查看",
						showDisabledIcon:false,
						showDownIcon:false 
					});
						MtoolBarItem001.click=function(){
							var select = MDataGrid001.getSelection();
							if(select.length != 0){
								doubleClickReadMessage(select[0].url,select[0].messageId);
							}else{
								Matrix.warn('未选中消息!');
							}
						}
				</script>
				<script>
                                function getParamsForDialog0() {
                                    var params = '&';
                                    var value;
                                    return params;
                                } 
                                isc.Window.create({
                                    ID: "MDialog0",
                                    id:"Dialog0",
                                    name:"Dialog0",
                                    autoCenter: true,
                                    position: "absolute",
                                    height:"95%",
                                    width:"60%",
                                    title: "消息信息",
                                    canDragReposition: false,
                                    showMinimizeButton: false,
                                    showMaximizeButton: false,
                                    showCloseButton: true,
                                    showModalMask: false,
                                    modalMaskOpacity: 0,
                                    isModal: true,
                                    autoDraw: false,
                                    headerControls: ["headerIcon", "headerLabel"]
                                });
                            </script>
                            <script>
                                MDialog0.hide();
                            </script>
				<script>
					isc.ToolStripButton.create({
						ID:"MtoolBarItem002",
						icon:"[skin]/images/matrix/actions/delete.png",
						title: "删除",
						showDisabledIcon:false,
						showDownIcon:false 
					});
					MtoolBarItem002.click=function(){
						var selects = Matrix.getDataGridSelection('DataGrid001');
						//var data = selects.get(0);
					 
						var select = MDataGrid001.getSelection();
						deleteByButton(selects);
					}
					</script>
				<div id="QueryForm59ca4db3ea95422cac1938910af18114_tb_div"  style="width:100%;height:40px;;overflow:hidden;"  >
					<script>
						isc.ToolStrip.create({
							ID:"MQueryForm59ca4db3ea95422cac1938910af18114_tb",
							displayId:"QueryForm59ca4db3ea95422cac1938910af18114_tb_div",
							width: "100%",height: "100%",
							position: "relative",
							members: [
								isc.MatrixHTMLFlow.create({
									ID:"MsubjectValue_Label",
									contents:"<div  id='MsubjectValue_Label_div'  style='margin-top:4px;'  class='toolBarItemOutputLabel' >主题:</div>"
								}),
								isc.MatrixHTMLFlow.create({
									ID:"subjectValue",
									contents:"<div id='subjectValue_div' eventProxy='Mform0' style='width:150px;' class='toolBarItemInputText' ></div>"
								}), 
								isc.MatrixHTMLFlow.create({
									ID:"MconditionType_Label",
									contents:"<div  id='MconditionType_Label_div'  style='margin-top:4px;'  class='toolBarItemOutputLabel' >状态:</div>"
								}),
								isc.MatrixHTMLFlow.create({
									ID:"conditionType",
									contents:"<div id='conditionType_div' eventProxy='Mform0' style='width:72px' class='toolBarItemInputText' ></div>"
								}),
								MtoolBarItem,
								//MtoolBarItemSend,
								MtoolBarItem001,
								MtoolBarItem002
							] 
							
						});
						isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"MQueryForm59ca4db3ea95422cac1938910af18114_tb.resizeTo(0,0);MQueryForm59ca4db3ea95422cac1938910af18114_tb.resizeTo('100%','100%');",null);},isc.Page.FIRE_ONCE);
				</script>
			</div>
		</td>
	</tr>
	<tr>
		<td colspan="2" style="border-style:none;width:100%;margin:0px;padding:0px;">
			<div id="DataGrid001_div" class="matrixComponentDiv" style="width:100%;height:100%;">
				<script> var MDataGrid001_DS=<%=request.getAttribute("lists")%>;
						 isc.MatrixListGrid.create({
						 	ID:"MDataGrid001",
						 	name:"DataGrid001",
						 	displayId:"DataGrid001_div",
						 	position:"relative",
						 	width:"100%",
						 	height:"100%",
						 	recordDoubleClick:function(viewer, record, recordNum, field, fieldNum, value, rawValue) {
                        		doubleClickReadMessage(record.url,record.messageId);
                     		},
						 	fields:[
						 		{title:"&nbsp;",name:"MRowNum",canSort:false,canExport:false,canDragResize:false,showDefaultContextMenu:false,autoFreeze:true,autoFitEvent:'none',width:45,canEdit:false,canFilter:false,autoFitWidth:false,formatCellValue:function(value, record, rowNum, colNum,grid){if(grid.startLineNumber==null)return '&nbsp;';return grid.startLineNumber+rowNum;}},
						 		{title:"主题",matrixCellId:"subjectValue",name:"subjectValue",canEdit:false,width:'35%',editorType:'Text',type:'text'},
						 		{title:"接收时间",matrixCellId:"createdDate",name:"createdDate",canEdit:false,width:'30%',align:"left",editorType:'DateItem',type:'date',formatCellValue:function(value, record, rowNum, colNum,grid){return Matrix.formatter(value,'date','yyyy年MM月dd日 HH时mm分', record, rowNum, colNum,grid);}
						 		},
						 		{title:"是否已读",matrixCellId:"isReaded",name:"isReaded",canEdit:false,width:'30%',editorType:'Text',type:'text',valueMap:{'0':'未读','1':'已读'}},
						 		{title:"",matrixCellId:"url",name:"url",canEdit:false,width:'0',editorType:'hidden',type:'hidden'}
						 		//{title:"操作",formatCellValue:function(value, record, rowNum, colNum,grid){
								//返回一个超链接删除
								//	return "<a style=text-decoration:none; href=\"javascript:deleteMessageByConnection('"+record.isReaded+"','"+record.messageId+"','"+record.subjectValue+"')\">[删除]</a>";
								//}}
						 	],
						 	autoSaveEdits:false,
						 	isMLoaded:false,
						 	autoDraw:false,
						 	autoFetchData:true,
						 	selectionType:"multiple",
						 	selectionAppearance:"rowStyle",
						 	canDragSelect:true,
						 	alternateRecordStyles:true,
						 	canSort:true,
						 	autoFitFieldWidths:false,
						 	startLineNumber:1,
						 	editEvent:"doubleClick",
						 	canCustomFilter:true,
						 	exportCells:[
						 		{id:'subjectValue',title:'主题'},
						 		{id:'contentValue',title:'内容'},
						 		{id:'createdDate',title:'创建时间'},
						 		{id:'isReaded',title:'是否已读'}
						 	],
						 	showRecordComponents:true,
						 	showRecordComponentsByCell:true
						 });
						 isc.MatrixDataSource.create({
						 	ID:'MDataGrid001_custom_filter_ds',
						 	fields:[
						 		{title:"主题",name:"subjectValue",type:'text',editorType:'Text'},
						 		{title:"内容",name:"contentValue",type:'text',editorType:'Text'},
						 		{title:"创建时间",name:"createdDate",type:'date',editorType:'DateItem'},
						 		{title:"是否已读",name:"isReaded",type:'text',editorType:'Text'}
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
						 	click:"MDataGrid001.hideCustomFilter()"
						 });
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
						 		isc.HTMLFlow.create({
						 			width:'30%',
						 			contents:"&nbsp;",
						 			autoDraw:false
						 		}),
						 		MDataGrid001_custom_filter_btn,
						 		isc.HTMLFlow.create({
						 			width:'5%',
						 			contents:"&nbsp;",
						 			autoDraw:false
						 		}),
						 		MDataGrid001_custom_filter_btn_cancel,
						 		isc.HTMLFlow.create({
						 			width:'30%',
						 			contents:"&nbsp;",
						 			autoDraw:false
						 		})
						 	]
						 });
						 isc.Page.setEvent(isc.EH.LOAD,function(){MDataGrid001.isMLoaded=true;MDataGrid001.draw();MDataGrid001.setData(MDataGrid001_DS);MDataGrid001.resizeTo('100%','100%');
						 isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"MDataGrid001.resizeTo(0,0);MDataGrid001.resizeTo('100%','100%');",null);},isc.Page.FIRE_ONCE);},isc.Page.FIRE_ONCE);
						 if(Matrix.getDataGridIdsHiddenOfForm('form0')){
						 	Matrix.getDataGridIdsHiddenOfForm('form0').value=Matrix.getDataGridIdsHiddenOfForm('form0').value+',DataGrid001'}
			</script>
			<script>
				var	curPageNum = <%=request.getAttribute("curPageNum")%>;
				var totalPageNum = <%=request.getAttribute("totalPageNum")%>;
				var totalSize = <%=request.getAttribute("totalSize")%>;
			isc.Page.setEvent("load","Matrix.fillDataPaginator('blpageDataGrid001',"+curPageNum+","+totalPageNum+",5,'DataGrid001',"+totalSize+")",isc.Page.FIRE_ONCE);</script>
			<script>
			isc.Page.setEvent("load","Matrix.fillDataPaginator('brpageDataGrid001',"+curPageNum+","+totalPageNum+",5,'DataGrid001',"+totalSize+")",isc.Page.FIRE_ONCE);</script>
			
			</div>
				<input id="DataGrid001_selection" name="DataGrid001_selection" type="hidden" />
				<input id="DataGrid001_data_entity" name="DataGrid001_data_entity" value="foundation.portal.Portal" type="hidden" />
		</td>
	</tr>
	<tr style="width: 100%; height:35px;">
		<td class="toolStrip"
			style="border-top: 1px solid #c4c4c4; border-bottom: 1px solid #c4c4c4; border-left: 1px solid #c4c4c4; border-right: 0px; height: 28px; margin: 0px; padding: 0px;">
			<span id="blpageDataGrid001" class="paginator">
				<span id="blpageDataGrid001:status" class="paginator_status">
				</span>
			</span>
		</td>
		<td class="toolStrip" 
			style="border-top: 1px solid #c4c4c4; border-bottom: 1px solid #c4c4c4; border-right: 1px solid #c4c4c4; border-left: 0px; height: 28px; text-align: right; margin: 0px; padding: 0px;">
			<span id="brpageDataGrid001" class="paginator" style="float:right;">
				<span id="brpageDataGrid001:first" class="paginator_first">
					<img id="brpageDataGrid001_fI" src="<%=request.getContextPath()%>/matrix/resource/images/paginator/first_gray.gif" border="0" line-height="30px"/>
				</span>
				<span id="brpageDataGrid001:previous" class="paginator_previous">
					<img id="brpageDataGrid001_pI" src="<%=request.getContextPath()%>/matrix/resource/images/paginator/pre_gray.gif" border="0" line-height="30px"/>
				</span>
				<span class='paginator_separator'>
					<img src="<%=request.getContextPath()%>/matrix/resource/isomorphic/skins/Enterprise/images/ToolStrip/separator.png" border="0" line-height="30px"/>
				</span>
				<span id="brpageDataGrid001:go" class="paginator_go" >
					<span class="go_prefix" line-height="30px">
						第
					</span>
					<span id="brpageDataGrid001:goText" class="paginator_go_text" >
					</span>
					<span class="go_suffix" line-height="30px">
						页
					</span>
				</span>
				<span class='paginator_separator'>
					<img src="<%=request.getContextPath()%>/matrix/resource/isomorphic/skins/Enterprise/images/ToolStrip/separator.png" border="0" line-height="30px"/>
				</span>
				<span id="brpageDataGrid001:next" class="paginator_next">
					<img id="brpageDataGrid001_nI" src="<%=request.getContextPath()%>/matrix/resource/images/paginator/next_gray.gif" border="0" line-height="30px"/>
				</span>
				<span id="brpageDataGrid001:last" class="paginator_last" line-height="30px">
					<img id="brpageDataGrid001_lI" src="<%=request.getContextPath()%>/matrix/resource/images/paginator/last_gray.gif"	border="0" line-height="30px"/>
				</span>
				<span class="paginator_clean" line-height="30px">
				</span>
				<span class='paginator_separator'>
					<img src="<%=request.getContextPath()%>/matrix/resource/isomorphic/skins/Enterprise/images/ToolStrip/separator.png" border="0" line-height="30px"/>
				</span>
				<span id="brpageDataGrid001:refresh" class="paginator_refresh" line-height="30px">
					<a href="javascript:#"></a>
				</span>
				<span>
					&nbsp;&nbsp;
				</span>
				<span id="DataGrid001_brpageDataGrid001_dynamic_perpage_count_div" eventProxy="Mform0" class="matrixInline" line-height="30px">
				</span>
			<script>var DataGrid001_brpageDataGrid001_dynamic_perpage_count=
				isc.SelectItem.create({ID:"MDataGrid001_brpageDataGrid001_dynamic_perpage_count",
									   name:"DataGrid001_brpageDataGrid001_dynamic_perpage_count",
									   paginator:"brpageDataGrid001",
									   editorType:"SelectItem",
									   width:80,
									   displayId:"DataGrid001_brpageDataGrid001_dynamic_perpage_count_div",
									   value:"0",
									   valueMap:{'0':'每页记录','10':'每页10条','20':'每页20条','30':'每页30条','40':'每页40条','50':'每页50条','-1':'全部数据'}});
									   Mform0.addField(DataGrid001_brpageDataGrid001_dynamic_perpage_count);
									   MDataGrid001_brpageDataGrid001_dynamic_perpage_count.observe(MDataGrid001_brpageDataGrid001_dynamic_perpage_count,
									   "changed",
									   "Matrix.dynamicPagingDataGridData('DataGrid001','brpageDataGrid001',MDataGrid001_brpageDataGrid001_dynamic_perpage_count.getValue())");
			 </script>
		</span>
	</td>
</tr>
</table>
</form>

<script>function getParamsForsend(){var params='&';var value;return params;}
		isc.Window.create({
			ID:"Msend",
			id:"send",
			name:"send",
			autoCenter: true,
			position:"absolute",
			height: "90%",width: "80%",
			title: "消息发送",
			canDragReposition: false,
			showMinimizeButton:true,
			showMaximizeButton:false,
			showCloseButton:true,
			showModalMask: false,
			modalMaskOpacity:0,
			isModal:true,
			autoDraw: false,
			headerControls:["headerIcon","headerLabel","closeButton"],
			getParamsFun:getParamsForsend,
			initSrc:"<%=request.getContextPath()%>/SendMessage.rform",
			src:"<%=request.getContextPath()%>/SendMessage.rform",
			showFooter: false 
		});
		</script>
		<script>Msend.hide();</script>
</div>
<script>Mform0.initComplete=true;Mform0.redraw();isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"Mform0.redraw()",null);},isc.Page.FIRE_ONCE);</script></body>
</html>