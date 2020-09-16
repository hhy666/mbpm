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
	
	//添加测量值
	function addMeasure(){
		var templateId = $('#templateId').val();
		var formId = $('#formId').val();
		layer.open({
			id:'AddMeasure',
			type : 2,
			
			title : ['添加测量值'],
			shade: [0.1, '#000'],
			shadeClose: false, //开启遮罩关闭
			area : [ '90%', '90%' ],
			content : "<%=path%>/statistic/statisticAction_toAddMeasure.action?iframewindowid=AddMeasure&formId="+formId+"&type=add&templateId="+templateId
		});
	}
	
	//添加回调方法
	function onAddMeasureClose(data){
		if(data!=null){
			Matrix.success('添加成功！');
			$('#DataGrid001_table').bootstrapTable('refresh');
		}
	}
	
	//单击工具栏修改
	function editMeasure(){
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

	//修改测量值
	function doubleClickUpdate(id){
		var templateId = $('#templateId').val();
		var formId = $('#formId').val();
		layer.open({
			id:'EditMeasure',
			type : 2,
			
			title : ['修改测量值'],
			shade: [0.1, '#000'],
			shadeClose: false, //开启遮罩关闭
			area : [ '90%', '90%' ],
			content : "<%=path%>/statistic/statisticAction_toEditMeasure.action?iframewindowid=EditMeasure&id="+id+"&formId="+formId+"&type=edit&templateId="+templateId
		});
	}
	
	//修改回调方法
	function onEditMeasureClose(data){
		if(data!=null){
			Matrix.success('修改成功！');
			$('#DataGrid001_table').bootstrapTable('refresh');
			if(parent.$('#' + data.id + '_span')[0]){
				parent.$('#' + data.id + '_span')[0].innerHTML = data.name;
			}
			parent.parent.save();
		}
	}
	
	//删除选中测量值
	function deleteMeasure(){
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
				url:'<%=path %>/statistic/statisticAction_deleteMeasure.action',
				data:json,
				dataType:'text',
				success:function(data){
					if(data=="true"){
						Matrix.success('删除成功！');
						$('#DataGrid001_table').bootstrapTable('refresh');
					}else if(data=="false"){
						Matrix.warn("所选测量值被统计模型使用中,不可删除!");
					}
				}
			});
		}else{
			Matrix.warn('至少选中一条测量值！');
		}
	}
	
	//确认选择测量值
	function chooseMeasure(){
		var selects = $('#DataGrid001_table').bootstrapTable('getSelections');
		if(selects!=null&&selects.length>0){
			Matrix.closeWindow(selects);
		}else{
			Matrix.warn('请先选择数据！');
		}
	}
</script>
</head>
<body>
	<input type="hidden" id="templateId" name="templateId" value="${param.templateId}">
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
									<input type="button" value="添加" class="btn  btn-default toolBarItem" id="MtoolBarItemAdd" style="padding:0px;margin:0px;border:0;background: transparent" onclick="addMeasure()">
								</div>	
								<div style="padding-right: 15px;display: inline-block;">
									<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/editflow.png">
									<input type="button" value="修改" class="btn  btn-default toolBarItem" id="MtoolBarItemUpdate" style="padding:0px;margin:0px;border:0;background: transparent" onclick="editMeasure()">
								</div>
								<%-- <div id="moveUpDiv" style="padding-right: 15px;display: inline-block;">
									<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/moveup.png">
									<input type="button" value="上移" class="btn  btn-default toolBarItem" id="MtoolBarItemUpMove" style="padding:0px;margin:0px;border:0;background: transparent" onclick="moveUp()" / >
								</div>
								<div id="moveDownDiv" style="padding-right: 15px;display: inline-block;">
									<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/movedown.png">
									<input type="button" value="下移" class="btn  btn-default toolBarItem" id="MtoolBarItemDownMove" style="padding:0px;margin:0px;border:0;background: transparent" onclick="moveDown()" / >
								</div> --%>
								<div style="padding-right: 15px;display: inline-block;">
									<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/delete.png">
									<input type="button" value="删除" class="btn  btn-default toolBarItem" id="MtoolBarItemDel" style="padding:0px;margin:0px;border:0;background: transparent" onclick="deleteMeasure()" / >
								</div>
								<div style="padding-right: 15px;display: inline-block;">
									<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/submit.png">
									<input type="button" value="选择带回" class="btn  btn-default toolBarItem" id="MtoolBarItemSelect" style="padding:0px;margin:0px;border:0;background: transparent" onclick="chooseMeasure()" / >
								</div>
								<div style="padding-right: 15px;display: inline-block;">
									<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/deletex.png">
									<input type="button" value="关闭" class="btn  btn-default toolBarItem" id="MtoolBarItemClose" style="padding:0px;margin:0px;border:0;background: transparent" onclick="Matrix.closeWindow()" / >
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
								url:'<%=path%>/statistic/statisticAction_getMeasureList.action',
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
										templateId:$('#templateId').val()
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
    		<!-- <div style="display: block;padding-top:5px">
	    		<table class="query_form_content" style="height:100%;width:100%;overflow:hidden;border-collapse: collapse;border-spacing:0px;table-layout:fixed;">
		    		<tr style=" height: 0px">
		    			<td id="td007" class="tdLabelCls" style="width:30%;">
							<label id="titleLabel" style="padding-left: 5px">当前选择测量值:</label>
						</td>
						<td id="td008" class="tdValueCls" style="width:70%;">
	    					<input type="text" class="form-control" style="width:100%;">
						</td>
	    			</tr>
	    			<tr style=" height: 0px">
		    			<td class="cmdLayout" style="width:100%;">
		    				<button style="width:85px" class="x-btn ok-btn" type="button" onclick="saveData()">保存</button>
							<button style="width:85px" class="x-btn ok-btn" type="button" onclick="Matrix.closeWindow()">取消</button>
						</td>
	    			</tr>
    			</table>
    		</div> -->
    	</div>
	</div>
</body>
</html>