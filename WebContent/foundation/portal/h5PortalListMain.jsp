<%@page pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML>
<html>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<head>
<jsp:include page="/form/html5/admin/html5Head.jsp"/>
<script>


	function addPortal(){
		var type = document.getElementById('type').value;
		layer.open({
			type:2,
			title:['新增门户信息'],
			area:['550px','450px'],
			content:"<%=path%>/portal/portalAction_addPortal.action?type="+ type +"&iframewindowid=AddPortal"
		});
	}
	
	function onAddPortalClose(){
		Matrix.refreshDataGridData('DataGrid001');
	}
	
	function updatePortal(){
		var select = Matrix.getGridSelection('DataGrid001');
		if(select!=null&&select.length>0){
			if(select.length>1){
				Matrix.warn('只能选择一条数据修改!');
			}else if(select.length==1){
				var uuid = select[0].uuid; 
				var type = select[0].type;
				doubleClickUpdatePortal(uuid,type);
			}
		}else{
			Matrix.warn('请选择一条数据!');
		}
		
	}
	
	function doubleClickUpdatePortal(uuid,type){
		layer.open({
			type:2,
			title:['修改门户信息'],
			area:['550px','450px'],
			content:"<%=path%>/portal/portalAction_updatePortal.action?type="+ type +"&iframewindowid=UpdatePortal&uuid="+uuid
		});
	}
	
	function onUpdatePortalClose(){
		Matrix.refreshDataGridData('DataGrid001');
	}
	
	function deletePortal(){
		var select = Matrix.getGridSelections('DataGrid001');
		if(select.length>0&&select!=null){
			var ids ="";
			for(var i=0;i<select.length;i++){
				if(i!=select.length-1){
					ids+= select[i].uuid;
					ids+= ',';
				}else{
					ids+= select[i].uuid;
				}
			}
			Matrix.confirm('确认删除?',function(value){
				if(!value){
					var url = "<%=path%>/portal/portalAction_deletePortal.action";
					var newData = "{'uuid':'"+ids+"'}";
					var synJson = isc.JSON.decode(newData);
					Matrix.sendRequest(url,synJson,function(data){
						if(data.data){
							var json = isc.JSON.decode(data.data);
							if(json.result==true){
								Matrix.refreshDataGridData('DataGrid001');
							}else if(json.result == 'default'){
								Matrix.warn('禁止删除默认门户！');
							}
						}
					});
				}
			});
		}else{
			Matrix.warn('请选择数据！');
		}
	}
	
	function authorizationPortal(){
		var select = Matrix.getGridSelections('DataGrid001');
		if(select!=null && select.length>0){
			if(select.length>1){
				Matrix.warn('只能选择一条数据!');
			}else{
				var portaluuid = select[0].uuid;
				layer.open({
					type:2,
					title:['门户授权'],
					area:['1050px','600px'],
					content:'<%=path%>/portal/portalAction_authList.action?iframewindowid=AuthorizationPortal&portaluuid='+portaluuid
				});
			}
		}else{
			Matrix.warn('请选择门户数据!');
		}
	}
	
	
	function editContent(){
		var select = Matrix.getGridSelections('DataGrid001');
		if(select!=null && select.length>0){
			if(select.length>1){
				Matrix.warn('只能选择一条数据!');
			}else{
				var uuid = select[0].uuid;
				window.location.href="<%=path%>/portal/partsAction_findPartsByPortalId.action?type=${param.type}&uuid="+uuid;
			}
		}else{
			Matrix.warn('请选择门户数据!');
		}
	}
	
	function previewPortal(){
		var select = Matrix.getGridSelections('DataGrid001');
		if(select!=null && select.length>0){
			if(select.length>1){
				Matrix.warn('只能选择一条数据!');
			}else{
				var portalId = select[0].uuid;
				window.open("<%=path%>/portal/portalAction_previewOfficePortal.action?portalId="+portalId);
			}
		}else{
			Matrix.warn('请选择数据!');
		}
	}
	
	function moveUp(){
		var select = Matrix.getGridSelections("DataGrid001");
		if(select == null || select.length==0){
			Matrix.warn("没有数据被选中，不能执行此操作。");
		}else{
			if(select != null && select.length>1){
				Matrix.warn("只能选择一条数据进行上移操作!");
			}else{
				var recordData = Matrix.getGridData('DataGrid001');
				var recordIndex = recordData.indexOf(select[0]);
				var listSize = recordData.length;
				if(recordIndex==0){
					isc.warn("首行数据不能上移!");
				}else{
					var afterRecord = recordData[recordIndex-1];
					var lastUuid = afterRecord.uuid;
					var nextUuid = select[0].uuid;
					var json = "{'lastUuid':'"+lastUuid+"','nextUuid':'"+nextUuid+"','matrix_user_command':'moveUp'}";
					var synJson = isc.JSON.decode(json);
					var url = "<%=path%>/portal/portalAction_movePortalUp.action";
					Matrix.sendRequest(url,synJson,function(data){
						Matrix.refreshDataGridData("DataGrid001");
					});
				}
			}
		}
	}
	
	
	function moveDown(){
		var select = Matrix.getGridSelections("DataGrid001");
		if(select == null || select.length==0){
			isc.warn("没有数据被选中，不能执行此操作。");
		}else{
			if(select != null && select.length>1){
				isc.warn("只能选择一条数据进行下移操作!");
			}else{
				var recordData = Matrix.getGridData('DataGrid001');
				var recordIndex = recordData.indexOf(select[0]);
				var listSize = recordData.length;
				if(recordIndex==listSize-1){
					isc.warn("末行数据不能下移!");
				}else{
					var afterRecord = recordData[recordIndex+1];
					var lastUuid = select[0].uuid;
					var nextUuid = afterRecord.uuid;
					var json = "{'lastUuid':'"+lastUuid+"','nextUuid':'"+nextUuid+"','matrix_user_command':'moveUp'}";
					var synJson = isc.JSON.decode(json);
					var url = "<%=path%>/portal/portalAction_movePortalDown.action";
					Matrix.sendRequest(url,synJson,function(data){
						Matrix.refreshDataGridData("DataGrid001");
					});
				}
			}
		}
	}
</script>
</head>
	<body style="padding:6px">
		<form id="form0" name="form0" eventProxy="Mform0" method="post"	action="" style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
		<input type="hidden" name="form0" id="form0" value="form0"/>
		<input name="version" id="version" type="hidden"/>
		<input type="hidden" name="dataGridId" id="dataGridId" value="DataGrid001"/>
		<input name="type" id="type" type="hidden" value="${param.type }"/>
		<input name="parentNodeId" id="parentNodeId" type="hidden" value="${param.entityId }"/>
		<div style="padding-left: 5px;padding-top: 5px">
			<span id="label011" style="font-size:18px;vertical-align:bottom; " name="label011"/>
				门户管理
			</span>
		</div>
    	<div style="width:100%;height:100%;overflow:auto;position: relative;" >
    		<div style="display: block">
				<table class="query_form_content" style="height:100%;width:100%;overflow:hidden;border-collapse: collapse;border-spacing:0px;table-layout:fixed;">
	    			<tr style=" height: 0px">
						<td class="query_form_toolbar" colspan="2">
							<div style="padding:8px;background: #f8f8f8;text-align: left; ">
								<label style="padding-left: 5px">标题:</label>
								<div style="padding-right: 5px;display: inline-block;">
									<input type="text" name="title" id="title" class="form-control">
								</div>
								<div style="padding-right: 15px;display: inline-block;">
									<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/query.png">
									<input type="button" value="查询" class="btn  btn-default toolBarItem" id="MtoolBarItemQue" style="padding:0px;margin:0px;border:0;background: transparent" onclick="Matrix.refreshDataGridData('DataGrid001')">
								</div>
								<div style="padding-right: 15px;display: inline-block;">
									<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/new.png">
									<input type="button" value="添加" class="btn  btn-default toolBarItem" id="MtoolBarItemAdd" style="padding:0px;margin:0px;border:0;background: transparent" onclick="addPortal()">
								</div>	
								<div style="padding-right: 15px;display: inline-block;">
									<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/editflow.png">
									<input type="button" value="修改" class="btn  btn-default toolBarItem" id="MtoolBarItemUpdate" style="padding:0px;margin:0px;border:0;background: transparent" onclick="updatePortal()">
								</div>
								<div style="padding-right: 15px;display: inline-block;">
									<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/moveup.png">
									<input type="button" value="上移" class="btn  btn-default toolBarItem" id="MtoolBarItemUpMove" style="padding:0px;margin:0px;border:0;background: transparent" onclick="moveUp()" / >
								</div>
								<div style="padding-right: 15px;display: inline-block;">
									<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/movedown.png">
									<input type="button" value="下移" class="btn  btn-default toolBarItem" id="MtoolBarItemDownMove" style="padding:0px;margin:0px;border:0;background: transparent" onclick="moveDown()" / >
								</div>
								<div style="padding-right: 15px;display: inline-block;">
									<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/deletex.png">
									<input type="button" value="删除" class="btn  btn-default toolBarItem" id="MtoolBarItemDel" style="padding:0px;margin:0px;border:0;background: transparent" onclick="deletePortal()" / >
								</div>
								<div style="padding-right: 15px;display: inline-block;">
									<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/setAuth.png">
									<input type="button" value="授权" class="btn  btn-default toolBarItem" id="MtoolBarItemAuthorization" style="padding:0px;margin:0px;border:0;background: transparent" onclick="authorizationPortal()" / >
								</div>
								<div style="padding-right: 15px;display: inline-block;">
									<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/edit.png">
									<input type="button" value="设置内容" class="btn  btn-default toolBarItem" id="MtoolBarItemSetContent" style="padding:0px;margin:0px;border:0;background: transparent" onclick="editContent()" / >
								</div>
								<div style="padding-right: 15px;display: inline-block;">
									<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/preview.png">
									<input type="button" value="预览" class="btn  btn-default toolBarItem" id="MtoolBarItemPreview" style="padding:0px;margin:0px;border:0;background: transparent" onclick="previewPortal()" / >
								</div>
							</div>
						</td>
					</tr>
				</table>
    		</div>
    		<div style="display: block">
    			<table id="DataGrid001_table" style="width:100%;height:100%;">
					<script>
						$(document).ready(function(){
							/* var title = document.getElementById('title').value;
							var conditionType = document.getElementById('conditionType').value; */
							$("#DataGrid001_table").bootstrapTable({
								classes:'table table-hover table-no-bordered',
								method:'post',
								contentType : "application/x-www-form-urlencoded",
								url:'<%=path%>/portal/portalAction_h5FindAllPortal.action',
								search: false, 
								sidePagination: "server", 
								singleSelect: false,
								clickToSelect: true, 
								sortable: false,   
								pagination: true,
								onClickRow:function(row){
									parent.panel2(row.uuid);
								},
								onDblClickRow:function(row){
									doubleClickUpdatePortal(row.uuid,row.type);
								},
								queryParams: function(params){
									var param = {
										offset: params.offset,
										limit:params.limit
									}
									param["title"] = document.getElementById('title').value;
						            var form = document.getElementById('form0');
						            var tagElements = form.getElementsByTagName('input');
						            for (var j = 0; j < tagElements.length; j++) {
						                param[tagElements[j].name] = tagElements[j].value;
						            };
									return param;
								},
								//singleSelect:true,
								//sortable:false,
								pageSize:20,
								pageList:[10,20,30,40],
								formatLoadingMessage: function() {
					            return '请稍等，正在加载中...';
						        },
						        formatNoMatches: function() {
						            return '无符合条件的记录';
						        },
								columns:[{
									title:' ',
						            checkbox: true
						        },{
									title:'序号',
									 formatter: function (value, row, index) { 
										var pageSize = $("#DataGrid001_table").bootstrapTable('getOptions').pageSize;
										var pageNumber = $("#DataGrid001_table").bootstrapTable('getOptions').pageNumber;
				                            return pageSize * (pageNumber - 1) + index + 1;  
				                        }
								},{
									field:'title',
									title:'门户标题',
									editorType:'Text',
									clickToSelect: true,
									type:'text'
								},{
									field:'layout',
									title:'默认列数',
									editorType:'Text',
									clickToSelect: true,
									type:'Text'
								},{
									field:'status',
									title:'状态',
									editorType:'Text',
									clickToSelect: true,
									type:'Text',
									formatter: function (value, row, index){ // 单元格格式化函数
										var text = '-';
										if (value == 1) {
										    text = "已禁用";
										} else if (value == 0) {
										    text = "已启用";
										}
										return text;
									}
								}]
							});
						});
					</script>
				</table>
    		</div>
    	</div>
    	</form>
	</body>
</html>