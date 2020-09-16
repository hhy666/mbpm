<%@page pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
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
<jsp:include page="/form/html5/admin/html5Head.jsp"/>
<title>部件管理列表</title>
<script>

	function addPart(){
		layer.open({
			type:2,
			title:['添加部件信息'],
			area:['55%','80%'],
			content:"<%=path%>/portal/partsAction_addParts.action"
		});		
	}
	
	function deletePart(){
		var select = Matrix.getGridSelection('DataGrid001');
		if(select.length>0&&select!=null){
			var uuids="";
			for(var i=0;i<select.length;i++){
				if(i!=select.length-1){
					uuids+=select[i].uuid;
					uuids+=",";
				}else{
					uuids+=select[i].uuid;
				}
			}
			deleteByUuid(uuids)
		}else{
			isc.warn('请选择数据!');
		}
	}

	function deleteByUuid(uuids){
		Matrix.confirm(
			'确认删除?',
			function(value){
				if(!value){
					var url = "<%=request.getContextPath()%>/portal/partsAction_deleteParts.action";
					var newData = "{'uuid':'"+uuids+"'}";
					var synJson = isc.JSON.decode(newData);
					Matrix.sendRequest(url,synJson,function(data){
						if(data.data){
							var json = isc.JSON.decode(data.data);
							if(json.result==true){
								//MDataGrid001.removeSelectedData();
								Matrix.warn('删除成功');
								Matrix.refreshDataGridData('DataGrid001');
							}else{
								Matrix.warn('删除失败');
								Matrix.refreshDataGridData('DataGrid001');
							}
						}
					});
				}
			}
		);
	}
	
	function updatePate(){
		var select = Matrix.getGridSelection('DataGrid001');
		if(select.length>1&&select!=null){
			Matrix.warn('只能修改一条数据！');
		}else if(select.length==1){
			doubleClickUpdateFormVersion(select[0].uuid);
		}else{
			Matrix.warn('请先选中一条数据！');
		}
	}
	
	function doubleClickUpdateFormVersion(uuid){
		layer.open({
			type:2,
			title:['修改部件信息'],
			area:['55%','80%'],
			content:"<%=path%>/portal/partsAction_updateParts.action?uuid="+uuid	
		});		
	}
</script>
</head>
<body style="padding:6px">
	<div style="width: 100%; height: 100%; overflow: auto; position: relative;">
		<form id="form0" name="form0" eventProxy="Mform0" method="post" action="" style="margin:0px;position:relative;overflow:auto;width:100%;height:100%;" enctype="application/x-www-form-urlencoded">
			<input type="hidden" name="form0" value="form0" />
			<input type="hidden" name="uuid" id="uuid" value="${uuid}" />
			<input type="hidden" name="dataGridId" id="dataGridId" value="DataGrid001"/>
			<div type="hidden" id="form0_hidden_text_div"
				name="form0_hidden_text_div"
				style="position: absolute; width: 0; height: 0; z-index: -9999999999; top: 0; left: 0; display: none;"></div>
			<input type="hidden" name="javax.matrix.faces.ViewState"
				id="javax.matrix.faces.ViewState" value="" /> 
			<input type="hidden" id="matrix_form_datagrid_form0" name="matrix_form_datagrid_form0" value="" />
			<div style="display: block">
				<table class="query_form_content" style="height:100%;width:100%;overflow:hidden;border-collapse: collapse;border-spacing:0px;table-layout:fixed;">
					<tr id="tr111" name="tr111">
			            <td id="td111" style="width:100%;height:30px;padding-top:5px;vertical-align:bottom;border:0 " name="td111" styleClass="tdLayout">
			             	<label id="label011" style="font-size:18px;vertical-align:bottom;padding-bottom: 2px" name="label011">
								部件管理			             	
			             	</label>
		           		</td>
		          	</tr>
					<tr style=" height: 0px">
						<td class="query_form_toolbar"icolspan="2" style="padding: 3px">
							<div style=";padding:4px;background: #f8f8f8;text-align: left;border: 1px solid #E6E9ED ">
								<label style="padding-left: 5px">标题:</label>
								<div style="padding-right: 5px;display: inline-block;vertical-align: middle">
									<input class="form-control" type="text" style="" name="title" id="title" >
								</div>
								<div style="padding-right: 15px;display: inline-block;">
									<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/query.png">
									<input type="button" value="查询" class="btn  btn-default toolBarItem" id="MtoolBarItemQue" style="padding:0px;margin:0px;border:0;background: transparent" onclick="Matrix.refreshDataGridData('DataGrid001')">
								</div>
								<div style="padding-right: 15px;display: inline-block;">
									<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/new.png">
									<input type="button" value="添加" class="btn  btn-default toolBarItem" id="MtoolBarItemAdd" style="padding:0px;margin:0px;border:0;background: transparent" onclick="addPart()">
								</div>	
								<div style="padding-right: 15px;display: inline-block;">
									<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/editflow.png">
									<input type="button" value="修改" class="btn  btn-default toolBarItem" id="MtoolBarItemUpd" style="padding:0px;margin:0px;border:0;background: transparent" onclick="updatePate()">
								</div>
								<div style="padding-right: 15px;display: inline-block;">
									<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/deletex.png">
									<input type="button" value="删除" class="btn  btn-default toolBarItem" id="MtoolBarItemDel" style="padding:0px;margin:0px;border:0;background: transparent" onclick="deletePart()" / >
								</div>
										
							</div>
						</td>
					</tr>
					<tr>
						<td style="border-style:none;width:100%;margin:0px;padding:0px;vertical-align: top;">
							
						</td>
					</tr>
				</table>
			</div>
			<div style="display: block;">
				<table id="DataGrid001_table" style="width:100%;height:100%;">
					<script>
						$(document).ready(function(){
							/* var title = document.getElementById('title').value;
							var conditionType = document.getElementById('conditionType').value; */
							$("#DataGrid001_table").bootstrapTable({
								classes:'table table-bordered table-striped',
								method:'post',
								contentType : "application/x-www-form-urlencoded",
								url:'<%=path%>/portal/partsAction_h5FindAllParts.action',
								search: false, 
								sidePagination: "server", 
								singleSelect: false,
								clickToSelect: true, 
								sortable: false,   
								pagination: true,
								onDblClickRow:function(row){
									doubleClickUpdateFormVersion(row.uuid);
								},
								queryParams: function(params){
									var param = {
										offset: params.offset,
										limit:params.limit
									}
									param["title"] = document.getElementById('title').value;
									param["uuid"] = document.getElementById('uuid').value;
						            var form = document.getElementById('form0');
						            var tagElements = form.getElementsByTagName('input');
						            for (var j = 0; j < tagElements.length; j++) {
						                param[tagElements[j].name] = tagElements[j].value;
						            };
									return param;
								},
								//singleSelect:true,
								//sortable:false,
								pageSize:10,
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
									title:'标题',
									editorType:'Text',
									clickToSelect: true,
									type:'text'
								},{
									field:'urlValue',
									title:'部件链接',
									editorType:'Text',
									clickToSelect: true,
									type:'Text'
								},{
									field:'width',
									title:'默认宽度',
									editorType:'Text',
									clickToSelect: true,
									type:'Text'
								},{
									field:'height',
									title:'默认高度',
									editorType:'Text',
									clickToSelect: true,
									type:'Text'
								},{
									field:'rows',
									title:'默认行数',
									editorType:'Text',
									clickToSelect: true,
									type:'Text'
								},{
									field:'cols',
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
		</form>
	</div>
</body>
</html>