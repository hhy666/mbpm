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

	window.onload = function(){
		//约束条件初始赋值
		var isRestrainCondition = "${dimension.isRestrainCondition}";
		if(isRestrainCondition!=null&&isRestrainCondition.trim().length>0)
			$("#isRestrainCondition option[value='"+isRestrainCondition+"']").attr("selected","selected"); 
		//添加时屏蔽范围项按钮
		var type = $('#type').val();
		if(type=='add'){
			$('#MtoolBarItemAdd').attr('disabled','disabled');
			$('#MtoolBarItemDel').attr('disabled','disabled');
			$('#MtoolBarItemUpdate').attr('disabled','disabled');
		}
	}

	//保存
	function saveAndClose(flag){
		var id = $('#id').val();
		var diagramId = $('#diagramId').val();
		var name = $('#name').val();
		nameData = {};
		nameData.name = name;
		nameData.id = id;
		$.ajax({
			type:'post',
			url:'<%=path %>/statistic/statisticAction_validataDimensionName.action',
			data:nameData,
			dataType:'text',
			success:function(data){
				if(data=="true"){
					var type = $('#type').val();
					var description = $('#description').val();
					var diagramId = $('#diagramId').val();
					var isRestrainCondition = $('#isRestrainCondition').val();
					if(name!=null&&name.trim()!=""){
						var json = {};
						json.type = type;
						json.id = id;
						json.name = name;
						json.description = description;
						json.isRestrainCondition = isRestrainCondition;
						json.diagramId = diagramId;
						$.ajax({
							type:'post',
							url:'<%=path %>/statistic/statisticAction_createOrUpdateDimension.action',
							data:json,
							dataType:'text',
							success:function(data){
								if(data!=null){
									if(flag=="close"){
										Matrix.closeWindow(data);
									}else{
										var window = parent.getWindow();
										var windowDom = window.document.getElementById('layui-layer-iframe1').contentWindow;
										windowDom.$('#DataGrid001_table').bootstrapTable('refresh');
										Matrix.success('添加成功！');
										$('type').val('edit');
										$('#MtoolBarItemAdd').attr('disabled',false);
										$('#MtoolBarItemDel').attr('disabled',false);
										$('#MtoolBarItemUpdate').attr('disabled',false);
									}
								}
							}
						});
					}else{
						Matrix.warn('名称不能为空！');
						return false;
					}
				}else if(data=="false"){
					Matrix.warn('名称不能重复！');	
					return false;
				}
			}
		});
	}
	
	//添加范围项
	function addDimensionItem(){
		var formId = $('#formId').val();
		var dimensionId = $('#dimensionId').val();
		parent.setWindow(this);
		parent.layer.open({
			id:'AddDimensionItem',
			type : 2,
			
			title : ['添加范围项'],
			shade: [0.1, '#000'],
			shadeClose: false, //开启遮罩关闭
			area : [ '65%', '80%' ],
			content : "<%=path%>/statistic/statisticAction_toAddDimensionItem.action?iframewindowid=AddDimensionItem&dimensionId="+dimensionId+"&type=add&formId="+formId
		});
	}
	
	//单击工具栏修改
	function editDimensionItem(){
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
	
	//双击修改范围项
	function doubleClickUpdate(id){
		var formId = $('#formId').val();
		var dimensionId = $('#dimensionId').val();
		parent.setWindow(this);
		parent.layer.open({
			id:'EditDimensionItem',
			type : 2,
			
			title : ['修改范围项'],
			shade: [0.1, '#000'],
			shadeClose: false, //开启遮罩关闭
			area : [ '65%', '80%' ],
			content : "<%=path%>/statistic/statisticAction_toEditDimensionItem.action?iframewindowid=EditDimensionItem&id="+id+"&formId="+formId+"&type=edit&dimensionId="+dimensionId
		});
	}

	
	//删除范围项
	function deleteDimensionItem(){
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
				url:'<%=path %>/statistic/statisticAction_deleteDimensionItem.action',
				data:json,
				dataType:'text',
				success:function(){
					$('#DataGrid001_table').bootstrapTable('refresh');
					Matrix.success('删除成功！');
					parent.parent.save();
				}
			});
		}else{
			Matrix.warn('至少选中一条统计范围项！');
		}
	}
	
	
	//表格刷新后更改父统计范围项
	function onBack(){
		var selects = $('#DataGrid001_table').bootstrapTable('getData');
		parent.$('#dimensionUl').empty();
		var dimensionItemIds = '';
		if(selects!=null && selects!=""){
			var html = "";
			for(var i=0;i<selects.length;i++){
				html += "<li ondragenter='dimensionDragen(event)' draggable='true' ondrop='diagramItemDrop(event)' ondragover='allowDrop(event)' ondragstart='drag(event)' id='"+selects[i].id+"' class='axis-tag fx_dash_field_dimension' style='min-width:50px;display:inline-block;margin-left: 5px;margin-top: 5px;margin-right: 5px'>";
				html += "<div class='field-config fui_tag closable' style='height: 24px; line-height: 24px;'>";
				html += "<div style='padding-left: 16px' class='tag-wrapper style-custom'>";
				html += "<span style='max-width:150px;overflow:hidden' class='tag-text'>"+selects[i].name+"</span>";
				html += "<i id='"+selects[i].id+"_i' class='icon-close-circle' onclick='deleteDimensionItemli(this)''>";
				html += "</i>";
				html += "</div>";
				html += "</div>";
				html += "</li>";
				dimensionItemIds += selects[i].id + ',';
			}
			dimensionItemIds = dimensionItemIds.substring(0,dimensionItemIds.length-1);
			parent.$('#dimensionItemIds').val(dimensionItemIds);
			parent.$('#dimensionUl').append(html);
	    }
	}
	
</script>
</head>
<body style="padding:5px">
	<input type="hidden" id="formId" name="formId" value="${param.formId}">
	<input type="hidden" id="diagramId" name="diagramId" value="${param.diagramId}">
	<input type="hidden" id="type" name="type" value="${param.type}">
	<input type="hidden" id="dimensionId" name="dimensionId" value="${param.dimensionId}">
	<%--
	<input type="hidden" id="id" name="id" value="${id}">
	 <table id="table001" class="tableLayout" style="width:100%;">
		<tr id="tr001">
			<td id="td001" class="tdLabelCls" style="width:30%;">
				<label>名称</label>
			</td>
			<td id="td002" class="tdValueCls" style="width:70%;">
				<input id="name" name="name" value="${dimension.name}" type="text" class="form-control" style="height:100%;width:100%;" autocomplete="off">
			</td>
		</tr>
		<tr id="tr002">
			<td id="td003" class="tdLabelCls" style="width:30%;">
				<label>是否为约束条件</label>
			</td>
			<td id="td004" class="tdValueCls" style="width:70%;">
				<select id="isRestrainCondition" name="isRestrainCondition" class="form-control select2-accessible">
					<option value="1">是</option>
					<option value="2">否</option>
				</select>
			</td>
		</tr>
		<tr id="tr003">
			<td id="td005" class="tdLabelCls" style="width:30%;">
				<label>描述</label>
			</td>
			<td id="td006" class="tdValueCls" style="width:70%;">
				<textarea id="description" name="description" class="form-control" style="resize: none;height:100%;width:100%;" autocomplete="off">${dimension.description}</textarea>	
			</td>
		</tr>
		<tr id="tr004">
			<td id="td007" class="cmdLayout" style="width:100%;">
				<button style="width:85px" class="x-btn ok-btn" type="button" onclick="saveAndClose()">保存</button>
				<button style="width:100px" class="x-btn ok-btn" type="button" onclick="saveAndClose('close')">保存并关闭</button>
				<button style="width:85px" class="x-btn ok-btn" type="button" onclick="Matrix.closeWindow()">取消</button>
			</td>
		</tr>
	</table> --%>
	<div style="display: block">
		<table class="query_form_content" style="height:100%;width:100%;overflow:hidden;border-collapse: collapse;border-spacing:0px;table-layout:fixed;">
			<!-- <tr>
				<td class="query_form_toolbar"> 
					<span style="padding: 5px;font-size: 16px;">
						统计范围项列表
					</span>
				</td>
			</tr> -->
   			<tr style=" height: 0px">
				<td class="query_form_toolbar" colspan="2" style="padding: 3px">
					<div style="/* padding:4px; */background: #f8f8f8;text-align: left;vertical-align: middle;height: 44px;border: 1px solid #E6E9ED;line-height: 44px;">
						<div style="padding-right: 15px;display: inline-block;">
							<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/new.png">
							<input type="button" value="添加" class="btn  btn-default toolBarItem" id="MtoolBarItemAdd" style="padding:0px;margin:0px;border:0;background: transparent" onclick="addDimensionItem()">
						</div>	
						<div style="padding-right: 15px;display: inline-block;">
							<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/editflow.png">
							<input type="button" value="修改" class="btn  btn-default toolBarItem" id="MtoolBarItemUpdate" style="padding:0px;margin:0px;border:0;background: transparent" onclick="editDimensionItem()">
						</div>
						<div style="padding-right: 15px;display: inline-block;">
							<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/delete.png">
							<input type="button" value="删除" class="btn  btn-default toolBarItem" id="MtoolBarItemDel" style="padding:0px;margin:0px;border:0;background: transparent" onclick="deleteDimensionItem()" / >
						</div>
						<div style="padding-right: 15px;display: inline-block;">
							<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/deletex.png">
							<input type="button" value="关闭" class="btn  btn-default toolBarItem" id="MtoolBarItemDel" style="padding:0px;margin:0px;border:0;background: transparent" onclick="Matrix.closeWindow()" / >
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
					$("#DataGrid001_table").bootstrapTable({
						classes:'table table-bordered table-striped',
						method:'post',
						contentType : "application/x-www-form-urlencoded",
						url:'<%=path%>/statistic/statisticAction_getDimensionItemList.action',
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
								dimensionId:$('#dimensionId').val()
							}
							return param;
						},
						onLoadSuccess: function(){
							onBack();
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
						} ,{
							field:'setupMode',
							title:'设置方式',
							editorType:'Text',
							clickToSelect: true,
							type:'text',
							formatter: function (value, row, index){ // 单元格格式化函数
								var text = '-';
								if (value == 1) {
								    text = "普通";
								} else if (value == 2) {
								    text = "高级";
								}
								return text;
							}
						}]
					});
				});
			</script>
		</table>
	</div>
</body>
</html>