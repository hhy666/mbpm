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
		//设置方式初始赋值
		var setupMode = "${dimensionItem.setupMode}";
		if(setupMode!=null&&setupMode.trim().length>0){
			$("#setupMode option[value='"+setupMode+"']").attr("selected","selected"); 
			if(setupMode==1){
				$('#subitemTable').css('display','none');
				$('#subitemTools').css('display','none');
			}else if(setupMode==2){
				$('#subitemTable').css('display','');
				$('#subitemTools').css('display','');
			}
		}
		
		//设置是否为统计项初始赋值
		var isStatisticsItem = "${dimensionItem.isStatisticsItem}";
		if(isStatisticsItem!=null&&isStatisticsItem.trim().length>0)
			$("#isStatisticsItem option[value='"+isStatisticsItem+"']").attr("selected","selected"); 
		//设置日期间隔初始赋值
		var dateInterval = "${dimensionItem.dateInterval}";
		if(dateInterval!=null&&dateInterval.trim().length>0)
			$("#dateInterval option[value='"+dateInterval+"']").attr("selected","selected"); 
		
		//根据字段类型显示隐藏
		var entityProType = $('#entityProType').val();
		if(entityProType==1){
			$('#tr004').css('display','none');
			$('#tr005').css('display','none');
		}else if(entityProType==2||entityProType==3||entityProType==4||entityProType==5||entityProType==9){
			$('#tr004').css('display','');
			$('#tr005').css('display','none');
		}else if(entityProType==7){
			$('#tr004').css('display','none');
			$('#tr005').css('display','');
			if($("#dateInterval option:selected").val()==6){
				$('#tr006').css('display','');
			}else{
				$('#tr006').css('display','none');
			}
		}
		
		//添加时屏蔽范围子项按钮
		var type = $('#type').val();
		if(type=='add'){
			$('#MtoolBarItemAdd').attr('disabled','disabled');
			$('#MtoolBarItemDel').attr('disabled','disabled');
			$('#MtoolBarItemUpdate').attr('disabled','disabled');
			$('#MtoolBarItemUpMove').attr('disabled','disabled');
			$('#MtoolBarItemDownMove').attr('disabled','disabled');
		}
	}

	//日期间隔切换时间
	function dataIntervalChange(){
		var dateInterval = $("#dateInterval option:selected").val();
		if(dateInterval==6){
			$('#tr006').css('display','');
		}else{
			$('#tr006').css('display','none');
		}
	}
	
	//弹出选择变量
	function chooseEntityPro(){
		var formId = $('#formId').val();
		//parent.parent.setWindow(this);
		layer.open({
	    	id:'ChooseEntityPro',
			type : 2,
			
			title : ['选择字段'],
			shade: [0.1, '#000'],
			shadeClose: false, //开启遮罩关闭
			area : [ '75%', '95%' ],
			content : "<%=path%>/statistic/chooseEntityPro.jsp?iframewindowid=ChooseEntityPro&formId="+formId
		});
	}
	
	//添加统计项字段回调
	function onChooseEntityProClose(data){
		var type = data.type;
		$('#entityProType').val(type);
		$('#entityProName').val(data.name);
		$('#entityProId').val(data.mid);
		var name = $('#name').val();
		if(name==null||name==''){
			$('#name').val(data.name);
		}
		if(type==1){//字符类型
			$('#tr004').css('display','none');
			$('#tr005').css('display','none');
		}else if(type==2||type==3||type==4||type==5||type==9){//数字类型
			$('#tr004').css('display','');
			$('#tr005').css('display','none');
		}else if(type==7){//时间类型
			$('#tr004').css('display','none');
			$('#tr005').css('display','');
			if($("#dateInterval option:selected").val()==6){
				$('#tr006').css('display','');
			}else{
				$('#tr006').css('display','none');
			}
		}
		var entity = data.entity;
		var json = {};
		json.entity = entity;
		$.ajax({
			type:'post',
			url:'<%=path %>/statistic/statisticAction_chooseEntityBack.action',
			data:json,
			dataType:'text',
			success:function(data){
				$('#tableName').val(data);
			}
		});
	}
	
	//保存
	function saveData(flag){
		var dimensionId = $('#dimensionId').val();
		var id = $('#id').val();
		var name = $('#name').val();
		nameData = {};
		nameData.name = name;
		nameData.id = id;
		nameData.dimensionId = dimensionId;
		$.ajax({
			type:'post',
			url:'<%=path %>/statistic/statisticAction_validataDimensionItemName.action',
			data:nameData,
			dataType:'text',
			success:function(data){
				if(data=="true"){
					var type = $('#type').val();
					var entityProId = $('#entityProId').val();
					var entityProType = $('#entityProType').val();
					var setupMode = $('#setupMode').val();
					var dateInterval = $('#dateInterval').val();
					var numberInterval = $('#numberInterval').val();
					var dayCount = $('#dayCount').val();
					var isStatisticsItem = $('#isStatisticsItem').val();
					var formId = $('#formId').val();
					var tableName = $('#tableName').val();
					if(name!=null&&name.trim()!=""&&entityProId!=null&&entityProId.trim()!=""){
						var json = {};
						json.dimensionId = dimensionId;
						json.type = type;
						json.id = id;
						json.name = name;
						json.entityProId = entityProId;
						json.entityProType = entityProType;
						json.setupMode = setupMode;
						json.dateInterval = dateInterval;
						json.numberInterval = numberInterval;
						json.dayCount = dayCount;
						json.isStatisticsItem = isStatisticsItem;
						json.formId = formId;
						json.tableName = tableName;
						$.ajax({
							type:'post',
							url:'<%=path %>/statistic/statisticAction_createOrUpdateDimensionItem.action',
							data:json,
							dataType:'text',
							success:function(data){
								if(data!=null){
									if(flag=='close'){
										Matrix.closeWindow(data);
									}else{
										$('#MtoolBarItemAdd').attr('disabled',false);
										$('#MtoolBarItemDel').attr('disabled',false);
										$('#MtoolBarItemUpdate').attr('disabled',false);
										$('#MtoolBarItemUpMove').attr('disabled',false);
										$('#MtoolBarItemDownMove').attr('disabled',false);
										parent.onAddDimensionItemClose(data);
										$('#type').val('edit');
										Matrix.success('保存成功！');
									}
								}
							}
						});
					}else{
						Matrix.warn('名称和变量不能为空！');
						return false;
					}
				}else if(data=="false"){
					Matrix.warn('名称不能重复！');		
					return false;
				}
			}
		});
	}
	
	//设置方式改变
	function onSetupModeChange(){
		var setupMode = $('#setupMode').val();
		if(setupMode==1){
			$('#subitemTable').css('display','none');
			$('#subitemTools').css('display','none');
			var type = $('#entityProType').val();
			if(type==1){//字符类型
				$('#tr004').css('display','none');
				$('#tr005').css('display','none');
			}else if(type==2||type==3||type==4||type==5||type==9){//数字类型
				$('#tr004').css('display','');
				$('#tr005').css('display','none');
			}else if(type==7){//时间类型
				$('#tr004').css('display','none');
				$('#tr005').css('display','');
				if($("#dateInterval option:selected").val()==6){
					$('#tr006').css('display','');
				}else{
					$('#tr006').css('display','none');
				}
			}
		}else if(setupMode==2){
			$('#subitemTable').css('display','');
			$('#subitemTools').css('display','');
			$('#tr004').css('display','none');
			$('#tr005').css('display','none');
			$('#tr006').css('display','none');
		}
	}
	
	//添加范围子项
	function addSubitem(){
		var dimensionItemId = $('#id').val();
		layer.open({
			id:'AddSubitem',
			type : 2,
			
			title : ['添加范围子项'],
			shade: [0.1, '#000'],
			shadeClose: false, //开启遮罩关闭
			area : [ '65%', '50%' ],
			content : "<%=path%>/statistic/statisticAction_toAddDimensionSubitem.action?type=add&iframewindowid=AddSubitem&dimensionItemId="+dimensionItemId
		});
	}
	
	//添加回调方法
	function onAddSubitemClose(data){
		if(data=="true"){
			Matrix.success('保存成功！');
			$('#DataGrid001_table').bootstrapTable('refresh');
		}else if(data=="false"){
			Matrix.warn('保存失败！请联系管理员！');
		}
	}
	
	//工具栏修改范围子项
	function editSubitem(){
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
	
	//修改范围子项
	function doubleClickUpdate(id){
		var dimensionItemId = $('#id').val();
		layer.open({
			id:'EditSubitem',
			type : 2,
			
			title : ['修改范围子项'],
			shade: [0.1, '#000'],
			shadeClose: false, //开启遮罩关闭
			area : [ '50%', '50%' ],
			content : "<%=path%>/statistic/statisticAction_toEditDimensionSubitem.action?type=edit&iframewindowid=EditSubitem&id="+id+"&dimensionItemId="+dimensionItemId
		});
	}
	
	//修改回调方法
	function onEditSubitemClose(data){
		if(data=="true"){
			Matrix.success('保存成功！');
			$('#DataGrid001_table').bootstrapTable('refresh');
		}else if(data=="false"){
			Matrix.warn('保存失败！请联系管理员！');
		}
	}
	
	//删除范围子项
	function deleteSubitem(){
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
				url:'<%=path %>/statistic/statisticAction_deleteDimensionSubitem.action',
				data:json,
				dataType:'text',
				success:function(data){
					if(data=="true"){
						Matrix.success('删除成功！');
						$('#DataGrid001_table').bootstrapTable('refresh');
					}else{
						Matrix.warn('删除失败！请联系管理员！');
					}
				}
			});
		}else{
			Matrix.warn('至少选中一条统计范围！');
		}
	}
	
	//设置表达式
	function editCondition(){
		var flag = Matrix.getFormItemValue('flag');
		var subitemCondition = Matrix.getFormItemValue('subitemCondition');
		if(subitemCondition=='无'){
			subitemCondition = '';
		}
	    var formId = $('#formId').val();
		var formFlag = formId + "EntityVar";
	    //parent.iframeJs = this;
	    layer.open({
	    	id:'EditCondition',
			type : 2,
			
			title : ['设置表达式'],
			shade: [0.1, '#000'],
			shadeClose: false, //开启遮罩关闭
			area : [ '75%', '90%' ],
			content : "<%=path%>/condition/condition_loadConditionSet.action?iframewindowid=EditCondition&entrance=SysCondition&formFlag="+formFlag+"&flag="+flag+"&formId="+formId+"&firstCondition="+encodeURI(subitemCondition)
		});		
	}
	
	//设置表达式回调
    function onEditConditionClose(data){
		if(data!=null && data!=""){
			var selectSubitemId = $('#selectSubitemId').val();
			var formId = $('#formId').val();
			var type = "edit";
			var json = {};
			json.type = type;
			json.subitemCondition = data.conditionText;
			json.subitemConditionId = data.conditionVal;
			json.formId = formId;
			json.selectSubitemId = selectSubitemId;
			$.ajax({
				type:'post',
				url:'<%=path %>/statistic/statisticAction_saveSubitemCondition.action',
				data:json,
				dataType:'text',
				success:function(data){
					if(data=="true"){
						Matrix.success('保存成功！');
						$('#DataGrid001_table').bootstrapTable('refresh');
					}else if(data=="false"){
						Matrix.warn("保存失败！请联系管理员!");
					}
				}
			});
	    }
    }
	
	//上移
	function moveUp(){
		var select =  $('#DataGrid001_table').bootstrapTable("getSelections");
		if(select == null || select.length==0){
			Matrix.warn("没有数据被选中，不能执行此操作！");
		}else{
			if(select != null && select.length>1){
				Matrix.warn("只能选择一条数据进行上移操作！");
			}else{
				var recordData = $('#DataGrid001_table').bootstrapTable('getData',true);
				var recordIndex = recordData.indexOf(select[0]);
				var listSize = recordData.length;
				if(recordIndex==0){
					Matrix.warn("首行数据不能上移！");
				}else{
					var afterRecord = recordData[recordIndex-1];
					var lastUuid = afterRecord.id;
					var nextUuid = select[0].id;
					var json = {};
					json.lastUuid = lastUuid;
					json.nextUuid = nextUuid;
					$.ajax({
						type:'post',
						url:'<%=path %>/statistic/statisticAction_moveDimensionSubitem.action',
						data:json,
						dataType:'text',
						success:function(data){
							$('#DataGrid001_table').bootstrapTable('refresh');
						}
					});
				}
			}
		}
	}
	
	//下移
	function moveDown(){
		var select =  $('#DataGrid001_table').bootstrapTable('getSelections');
		if(select == null || select.length==0){
			Matrix.warn("没有数据被选中，不能执行此操作！");
		}else{
			if(select != null && select.length>1){
				Matrix.warn("只能选择一条数据进行下移操作！");
			}else{
				var recordData = $('#DataGrid001_table').bootstrapTable('getData',true);
				var recordIndex = recordData.indexOf(select[0]);
				var listSize = recordData.length;
				if(recordIndex==listSize-1){
					Matrix.warn("末行数据不能下移！");
				}else{
					var afterRecord = recordData[recordIndex+1];
					var lastUuid = select[0].id;
					var nextUuid = afterRecord.id;
					var json = {};
					json.lastUuid = lastUuid;
					json.nextUuid = nextUuid;
					$.ajax({
						type:'post',
						url:'<%=path %>/statistic/statisticAction_moveDimensionSubitem.action',
						data:json,
						dataType:'text',
						success:function(data){
							$('#DataGrid001_table').bootstrapTable('refresh');
						}
					});
				}
			}
		}
	}
</script>
</head>
<body style="padding:5px">
	<input type="hidden" id="tableName" name="tableName" value="${dimensionItem.tableName}">
	<input type="hidden" id="type" name="type" value="${param.type}">
	<input type="hidden" id="formId" name="formId" value="${param.formId}">
	<input type="hidden" id="entityProId" name="entityProId" value="${dimensionItem.entityProId}">
	<input type="hidden" id="entityProType" name="entityProType" value="${entityProType}">
	<input type="hidden" id="dimensionId" name="dimensionId" value="${param.dimensionId}">
	<input type="hidden" id="id" name="id" value="${id}">
	<input type="hidden" id="subitemCondition" name="subitemCondition" value="">
	<input type="hidden" id="subitemConditionId" name="subitemConditionId" value="">
	<input type="hidden" id="selectSubitemId" name="selectSubitemId">
	<table id="table001" class="tableLayout" style="width:100%;height:25%">
		<tr id="tr001">
			<td id="td001" class="tdLabelCls" style="width:30%;">
				<label>名称</label>
			</td>
			<td id="td002" class="tdValueCls" style="width:70%;">
				<input id="name" name="name" value="${dimensionItem.name}" type="text" class="form-control" style="height:100%;width:100%;" autocomplete="off">
			</td>
		</tr>
		<tr id="tr002">
			<td id="td003" class="tdLabelCls" style="width:30%;">
				<label>设置方式</label>
			</td>
			<td id="td004" class="tdValueCls" style="width:70%;">
				<select onchange="onSetupModeChange()" id="setupMode" name="setupMode" class="form-control select2-accessible">
					<option value="1">普通</option>
					<option value="2">高级</option>
				</select>
			</td>
		</tr>
		<tr id="tr003">
			<td id="td005" class="tdLabelCls" style="width:30%;">
				<label>字段</label>
			</td>
			<td id="td006" class="tdValueCls" style="width:70%;">
				<div class="input-group" style="width:100%;">
					<input id="entityProName" name="entityProName" value="${entityProName}" readonly="readonly" type="text" class="form-control" style="height:100%;width:100%;" autocomplete="off" >
					<span class="input-group-addon addon-udSelect udSelect" onclick="chooseEntityPro()"><i class="fa fa-search"></i></span>
				</div>
			</td>
		</tr>
		<tr id="tr004" style="display:none">
			<td id="td007" class="tdLabelCls" style="width:30%;">
				<label>数字间隔</label>
			</td>
			<td id="td008" class="tdValueCls" style="width:70%;">
				<input id="numberInterval" name="numberInterval" value="${dimensionItem.numberInterval}" type="number" class="form-control" style="height:100%;width:100%;" autocomplete="off">
			</td>
		</tr>
		<tr id="tr005" style="display:none">
			<td id="td009" class="tdLabelCls" style="width:30%;">
				<label>日期间隔</label>
			</td>
			<td id="td010" class="tdValueCls" style="width:70%;">
				<select id="dateInterval" name="dateInterval" class="form-control select2-accessible" onchange="dataIntervalChange()">
					<option value="1">年</option>
					<option value="2">季</option>
					<option value="3">月</option>
					<option value="4">周</option>
					<option value="5">日</option>
					<option value="6">其他</option>
				</select>
			</td>
		</tr>
		<tr id="tr006" style="display:none">
			<td id="td011" class="tdLabelCls" style="width:30%;">
				<label>日期天数</label>	
			</td>
			<td id="td012" class="tdValueCls" style="width:70%;">
				<input id="dayCount" name="dayCount" value="${dimensionItem.dayCount}" type="number" class="form-control" style="height:100%;width:100%;" autocomplete="off">
			</td>
		</tr>
		<tr style="display:none" id="tr007">
			<td id="td013" class="tdLabelCls" style="width:30%;">
				<label>是否为统计项</label>	
			</td>
			<td id="td014" class="tdValueCls" style="width:70%;">
				<select id="isStatisticsItem" name="isStatisticsItem" class="form-control select2-accessible">
					<option value="1">是</option>
					<option value="2" select>否</option>
				</select>
			</td>
		</tr>
		<tr id="tr008">
			<td id="td015" class="cmdLayout">
				<button class="x-btn ok-btn" type="button" onclick="saveData()">保存</button>
				<button class="x-btn ok-btn" type="button" onclick="saveData('close')">保存并关闭</button>
				<button class="x-btn ok-btn" type="button" onclick="Matrix.closeWindow()">关闭</button>
			</td>
		</tr>
	</table>
	<div id="subitemTools" style="height:80px;display: block;display:none">
		<table class="query_form_content" style="height:100%;width:100%;overflow:hidden;border-collapse: collapse;border-spacing:0px;table-layout:fixed;">
			<tr>
				<td>
					<label style="font-size:16px;padding-left:5px">统计范围子项</label>
				</td>
			</tr>
   			<tr style=" height: 0px">
				<td class="query_form_toolbar" colspan="2" style="padding: 3px">
					<div style="/* padding:4px; */background: #f8f8f8;text-align: left;vertical-align: middle;height: 44px;border: 1px solid #E6E9ED;line-height: 44px;">
						<div style="padding-right: 15px;display: inline-block;">
							<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/new.png">
							<input type="button" value="添加" class="btn  btn-default toolBarItem" id="MtoolBarItemAdd" style="padding:0px;margin:0px;border:0;background: transparent" onclick="addSubitem()">
						</div>	
						<div style="padding-right: 15px;display: inline-block;">
							<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/editflow.png">
							<input type="button" value="修改" class="btn  btn-default toolBarItem" id="MtoolBarItemUpdate" style="padding:0px;margin:0px;border:0;background: transparent" onclick="editSubitem()">
						</div>
						<div style="padding-right: 15px;display: inline-block;">
							<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/deletex.png">
							<input type="button" value="删除" class="btn  btn-default toolBarItem" id="MtoolBarItemDel" style="padding:0px;margin:0px;border:0;background: transparent" onclick="deleteSubitem()" / >
						</div>
						<div id="moveUpDiv" style="padding-right: 15px;display: inline-block;">
							<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/moveup.png">
							<input type="button" value="上移" class="btn  btn-default toolBarItem" id="MtoolBarItemUpMove" style="padding:0px;margin:0px;border:0;background: transparent" onclick="moveUp()" / >
						</div>
						<div id="moveDownDiv" style="padding-right: 15px;display: inline-block;">
							<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/movedown.png">
							<input type="button" value="下移" class="btn  btn-default toolBarItem" id="MtoolBarItemDownMove" style="padding:0px;margin:0px;border:0;background: transparent" onclick="moveDown()" / >
						</div>
					</div>
				</td>
			</tr>
		</table>
	</div>
	<div id="subitemTable" style="display: block;height:cals(75% - 120px);display:none">
		<table id="DataGrid001_table" style="width:100%;height:100%;">
			<script>
				$(document).ready(function(){
					$("#DataGrid001_table").bootstrapTable({
						classes:'table table-bordered table-striped',
						method:'post',
						contentType : "application/x-www-form-urlencoded",
						url:'<%=path%>/statistic/statisticAction_getDimensionSubitemList.action',
						search: false, 
						sidePagination: "server", 
						singleSelect: false,
						clickToSelect: true, 
						sortable: false,   
						//pagination: true,
						onClickRow:function(row){
							Matrix.setFormItemValue('subitemCondition',row.subitemCondition);
							Matrix.setFormItemValue('subitemConditionId',row.subitemConditionId);
							Matrix.setFormItemValue('selectSubitemId',row.id);
						},
						onDblClickRow:function(row){
							doubleClickUpdate(row.id);
						},
						queryParams: function(params){
							var param = {
								offset: params.offset,
								limit:params.limit,
								name:$('#name').val(),
								dimensionItemId:$('#id').val()
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
							field:'name',
							title:'名称',
							editorType:'Text',
							clickToSelect: true,
							type:'text'
						},{
							field:'subitemCondition',
							title:'表达式',
							editorType:'Text',
							clickToSelect: true,
							type:'text'
						},{
							field:'option',
							title:'操作',
							width:'100px',
							clickToSelect: true,
							type:'text',
							formatter: function (value, row, index){
								return [
									'<a href="javascript:editCondition()">表达式</a>'
								].join("")
							}
						}]
					});
				});
			</script>
		</table>
	</div>
</body>
</html>