<%@page pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:include page="/form/html5/admin/html5Head.jsp"/>
<title>Insert title here</title>
<script type="text/javascript">
	
	//添加统计范围
	function addDimension(){
		parent.setWindow(this);
		var formId = $('#formId').val();
		var diagramId = $('#diagramId').val();
		parent.layer.open({
			id:'AddDimension',
			type : 2,
			
			title : ['添加统计范围'],
			shade: [0.1, '#000'],
			shadeClose: false, //开启遮罩关闭
			area : [ '65%', '80%' ],
			content : "<%=path%>/statistic/statisticAction_toAddDimension.action?iframewindowid=AddDimension&diagramId="+diagramId+"&type=add&formId="+formId
		});
	}
	
	
	//工具栏修改统计范围
	function editDimension(){
		var selects = $('#DataGrid001_table').bootstrapTable('getSelections');
		if(selects!=null&&selects.length>0){
			if(selects.length==1){
				var id = selects[0].id;
				doubleClickUpdate(id);
			}else{
				Matrix.warn('只能选择一条数据！');
			}
		}else{
			Matrix.warn('请先选择数据！');
		}
	}
	
	//双击修改统计范围
	function doubleClickUpdate(id){
		parent.setWindow(this);
		var formId = $('#formId').val();
		var diagramId = $('#diagramId').val();
		parent.layer.open({
			id:'EditDimension',
			type : 2,
			
			title : ['修改统计范围'],
			shade: [0.1, '#000'],
			shadeClose: false, //开启遮罩关闭
			area : [ '65%', '80%' ],
			content : "<%=path%>/statistic/statisticAction_toEditDimension.action?iframewindowid=EditDimension&id="+id+"&formId="+formId+"&diagramId="+diagramId+"&type=edit"
		});
	}
	
	//删除选中统计范围
	function deleteDimension(){
		var selects = $('#DataGrid001_table').bootstrapTable('getSelections');
		if(selects!=null&&selects.length>0){
			var ids = "";
			for(var i=0;i<selects.length;i++){
				ids += selects[i].id + ',';
			}
			ids = ids.substring(0,ids.length-1);
			json = {};
			json.ids = ids;
			$.ajax({
				type:'post',
				url:'<%=path %>/statistic/statisticAction_deleteDimension.action',
				data:json,
				dataType:'text',
				success:function(){
					Matrix.success('删除成功！');
					$('#DataGrid001_table').bootstrapTable('refresh');
				}
			});
		}else{
			Matrix.warn('至少选中一条统计范围！');
		}
	}
	
	//确认选择统计范围
	function chooseDimension(){
		var selects = $('#DataGrid001_table').bootstrapTable('getSelections');
		if(selects!=null&&selects.length>0){
			if(selects.length==1){
				Matrix.closeWindow(selects);
			}else{
				Matrix.warn('只能选择一条数据！');
			}
		}else{
			Matrix.warn('请先选择数据！');
		}
	}

</script>
</head>
<body>
	<input type="hidden" id="diagramId" name="diagramId" value="${param.diagramId}">
	<input type="hidden" id="formId" name="formId" value="${param.formId}">
	<div style="width:100%;height:100%;overflow:hidden;padding:5px" class="matrixInline">
    	<div style="width:100%;height:100%;overflow:auto;position: relative;" >
    		<div style="height:50px;display: block">
				<table class="query_form_content" style="height:100%;width:100%;overflow:hidden;border-collapse: collapse;border-spacing:0px;table-layout:fixed;">
	    			<tr style=" height: 0px">
						<td class="query_form_toolbar"icolspan="2" style="padding: 3px">
							<div style="/* padding:4px; */background: #f8f8f8;text-align: left;vertical-align: middle;height: 44px;border: 1px solid #E6E9ED;line-height: 44px;">
								<label id="titleLabel" style="padding-left: 5px">名称:</label>
								<div style="padding-right: 5px;display: inline-block;vertical-align:middle;">
									<input class="form-control" type="text" style="" name="name" id="name" >
								</div>
								<div id="queryDiv" style="padding-right: 15px;display: inline-block;">
									<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/query.png">
									<input type="button" value="查询" class="btn  btn-default toolBarItem" id="MtoolBarItemQue" style="padding:0px;margin:0px;border:0;background: transparent" onclick="$('#DataGrid001_table').bootstrapTable('refresh')">
								</div>
								<div style="padding-right: 15px;display: inline-block;">
									<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/new.png">
									<input type="button" value="添加" class="btn  btn-default toolBarItem" id="MtoolBarItemAdd" style="padding:0px;margin:0px;border:0;background: transparent" onclick="addDimension()">
								</div>	
								<div style="padding-right: 15px;display: inline-block;">
									<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/editflow.png">
									<input type="button" value="修改" class="btn  btn-default toolBarItem" id="MtoolBarItemUpdate" style="padding:0px;margin:0px;border:0;background: transparent" onclick="editDimension()">
								</div>
								<div style="padding-right: 15px;display: inline-block;">
									<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/deletex.png">
									<input type="button" value="删除" class="btn  btn-default toolBarItem" id="MtoolBarItemDel" style="padding:0px;margin:0px;border:0;background: transparent" onclick="deleteDimension()" / >
								</div>
								<div style="padding-right: 15px;display: inline-block;">
									<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/setAuth.png">
									<input type="button" value="确认" class="btn  btn-default toolBarItem" id="MtoolBarItemDel" style="padding:0px;margin:0px;border:0;background: transparent" onclick="chooseDimension()" / >
								</div>
							</div>
						</td>
					</tr>
				</table>
    		</div>
    		<div style="display: block;/* height:calc(100% - 140px) */">
    			<table id="DataGrid001_table" style="width:100%;height:100%;">
					<script>
						$(document).ready(function(){
							$("#DataGrid001_table").bootstrapTable({
								classes:'table table-bordered table-striped',
								method:'post',
								contentType : "application/x-www-form-urlencoded",
								url:'<%=path%>/statistic/statisticAction_getDimensionList.action',
								search: false,
								sidePagination: "server",
								singleSelect: false,
								clickToSelect: true,
								sortable: false,
								//pagination: true,
								onClickRow:function(row){
								},
								onDblClickRow:function(row){
									doubleClickUpdate(row.id);
								},
								queryParams: function(params){
									var param = {
										offset: params.offset,
										limit:params.limit,
										name:$('#name').val(),
										diagramId:$('#diagramId').val()
									}
									return param;
								},
								//singleSelect:true,
								//sortable:false,
								//pageSize:20,
								//pageList:[10,20,30,40],
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
				                     },
				                     width:'20px'
								},{
									field:'name',
									title:'名称',
									editorType:'Text',
									clickToSelect: true,
									type:'text'
								}/* ,{
									field:'entityProId',
									title:'变量名',
									editorType:'Text',
									clickToSelect: true,
									type:'Text'
								} */]
							});
						});
					</script>
				</table>
    		</div>
    	</div>
	</div>
</body>
</html>