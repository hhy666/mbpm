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
	<script type="text/javascript">
		//添加
		function addPart(){
			layer.open({
				type:2,
				title:['添加流水号定义'],
				area:['65%','85%'],
				content:'<%=path%>/number/serialNumber_loadSavePage.action?opType=add&iframewindowid=AddSerialNum'
			});
		}
		
		function onAddSerialNumClose(data){
			if(data){
				Matrix.refreshDataGridData('DataGrid001');
			}
		}
		
		//编辑		
		function updatePate(){
			var select = Matrix.getGridSelection('DataGrid001');	
			if(select.length>0&&select!=null){
				var uuid = select[0].uuid;
				doubleClickUpdate(uuid);
			}else{
				Matrix.warn('请选中一条数据!');
			}
		}
		
		//双击编辑
		function doubleClickUpdate(uuid){
			layer.open({
				type:2,
				title:['编辑流水号定义'],
				area:['65%','85%'],
				content:'<%=path%>/number/serialNumber_loadSavePage.action?opType=update&uuid='+uuid+'&iframewindowid=UpdateSerialNum'
			});
		}
		
		function onUpdateSerialNumClose(data){
			if(data){
				Matrix.refreshDataGridData('DataGrid001');
			}
		}
		
		//删除
		function deletePart(){
			var select = Matrix.getGridSelection('DataGrid001');	
			if(select.length>0&&select!=null){
				if(select.length!=1){
					Matrix.warn('只能选择一条数据！');
					return false;
				}
				var uuid = select[0].uuid;
				Matrix.confirm('是否确认删除？',function(value){
					if(!value){
						var url = '<%=path%>/number/serialNumber_deleteSerialNum.action?uuid='+uuid;
						Matrix.sendRequest(url,null,function(data){
							if(data.data=='true'){
								Matrix.refreshDataGridData('DataGrid001');
								Matrix.info('删除成功!');
							}else if(data.data=='false'){
								Matrix.warn('删除失败!');
							}
						});
					}else{
						Matrix.warn('删除失败!');
					}
				});
			}else{
				Matrix.warn('请选中一条数据!');
			}
		}
	</script>
<title>流水号列表</title>
</head>
<body>
	<form id="form" name="form" method="post" action="" style="margin:0px;position:relative;overflow:hidden;width:100%;height:100%;padding: 6px" enctype="application/x-www-form-urlencoded">
		<div style="display: block">
			<div style="padding: 5px">
				<span id="label011" style="font-size:18px;vertical-align:bottom; " name="label011"/>
					流水号列表
				</span>
			</div>
			<div style="background: #f8f8f8;text-align: left;border: 1px solid #E6E9ED ">
				<table class="query_form_content" style="height:100%;width:100%;overflow:hidden;border-collapse: collapse;border-spacing:0px;table-layout:fixed;">
	    			<tr style=" height: 0px">
						<td class="query_form_toolbar"icolspan="2" style="padding: 3px">
							<div style="padding-left: 15px;padding-right: 15px;display: inline-block;">
								<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/new.png">
								<input type="button" value="添加" class="btn  btn-default toolBarItem" id="toolBarItemAdd" style="padding:0px;margin:0px;border:0;background: transparent" onclick="addPart()">
							</div>	
							<div style="padding-right: 15px;display: inline-block;">
								<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/editflow.png">
								<input type="button" value="修改" class="btn  btn-default toolBarItem" id="toolBarItemUpd" style="padding:0px;margin:0px;border:0;background: transparent" onclick="updatePate()">
							</div>
							<div style="padding-right: 15px;display: inline-block;">
								<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/deletex.png">
								<input type="button" value="删除" class="btn  btn-default toolBarItem" id="toolBarItemDel" style="padding:0px;margin:0px;border:0;background: transparent" onclick="deletePart()" / >
							</div>
						</td>
					</tr>
				</table>
			</div>
		</div>		
		<div style="display: block;padding-top: 5px">
			<table id="DataGrid001_table" style="width:100%;height:100%;">
   				<script>
	   				$(document).ready(function(){
						/* var title = document.getElementById('title').value;
						var conditionType = document.getElementById('conditionType').value; */
						$("#DataGrid001_table").bootstrapTable({
							classes:'table table-bordered table-striped',
							method:'post',
							contentType : "application/x-www-form-urlencoded",
							url:'<%=path%>/number/serialNumber_h5GetSerialNumbers.action',
							search: false, 
							sidePagination: "server", 
							singleSelect: true,
							clickToSelect: true, 
							sortable: false,   
							//pagination: false,
							onDblClickRow:function(row){
								//var portalId = document.getElementById('portalId').value;
								doubleClickUpdate(row.uuid);
							},
							//singleSelect:true,
							//sortable:false,
							pageSize:20,
							//pageList:[10,20,30,40],
							formatLoadingMessage: function() {
				            return '请稍等，正在加载中...';
					        },
					        queryParams: function(params){
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
								field:'id',
								title:'编码',
								editorType:'Text',
								clickToSelect: true,
								type:'text'
							},{
								field:'name',
								title:'名称',
								editorType:'Text',
								clickToSelect: true,
								type:'Text'
							},{
								field:'prefix',
								title:'前缀',
								editorType:'Text',
								clickToSelect: true,
								type:'Text'
							},{
								field:'postfix',
								title:'后缀',
								editorType:'Text',
								clickToSelect: true,
								type:'Text'
							},{
								field:'rule',
								title:'周期规则',
								editorType:'Text',
								clickToSelect: true,
								type:'Text',
								formatter: function (value, row, index){ // 单元格格式化函数
									var text = '-';
									if (value == 'N') {
									    text = "无";
									} else if (value == 'Y') {
									    text = "年";
									} else if (value == 'YM') {
									    text = "年月";
									} else if (value == 'YMD') {
									    text = "年月日";
									} else if (value == 'SY') {
									    text = "两位年";
									}
									return text;
								}
							},{
								field:'seperator',
								title:'间隔符号',
								editorType:'Text',
								clickToSelect: true,
								type:'Text'
							},{
								field:'resetRule',
								title:'重置规则',
								editorType:'Text',
								clickToSelect: true,
								type:'Text',
								formatter: function (value, row, index){ // 单元格格式化函数
									var text = '-';
									if (value == '0') {
									    text = "按周期";
									} else if (value == '1') {
									    text = "不重置";
									} 
									return text;
								}
							},{
								field:'startNum',
								title:'起始值',
								editorType:'Text',
								clickToSelect: true,
								type:'Text'
							},{
								field:'step',
								title:'步长',
								editorType:'Text',
								clickToSelect: true,
								type:'Text'
							},{
								field:'length',
								title:'位数',
								editorType:'Text',
								clickToSelect: true,
								type:'Text'
							},{
								field:'isStaticLength',
								title:'固定长度',
								editorType:'Text',
								clickToSelect: true,
								type:'Text',
								formatter: function (value, row, index){ // 单元格格式化函数
									var text = '-';
									if (value == 'true') {
									    text = "是";
									} else if (value == 'false') {
									    text = "否";
									} 
									return text;
								}
							},{
								field:'state',
								title:'状态',
								editorType:'Text',
								clickToSelect: true,
								type:'Text',
								formatter: function (value, row, index){ // 单元格格式化函数
									var text = '-';
									if (value == 1) {
									    text = "启用";
									} else if (value == 0) {
									    text = "禁用";
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
</body>
</html>