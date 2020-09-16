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
<script>
	function saveSelections(){
		var portalId = Matrix.getFormItemValue('uuid');
		var select = Matrix.getGridSelections('DataGrid001');
		if(select!=null&&select.length>0){
			var data = select;
			Matrix.closeWindow(data);
		}else{
			Matrix.warn('至少选择一条数据！');
		}
	}
</script>
</head>
<body>
	<div style="width: 100%; height: 100%; overflow: auto; position: relative;">
		<form id="form0" name="form0" eventProxy="Mform0" method="post" action="<%=request.getContextPath()%>/portal/partsAction_findAllParts.action" style="margin: 0px; position: relative; overflow:hidden; width: 100%; height: 100%;padding: 10px" enctype="application/x-www-form-urlencoded">
		    <input type="hidden" name="form0" value="form0" />
		    <input type="hidden" id="matrix_form_datagrid_form0" name="matrix_form_datagrid_form0" value="" />
		    <input type="hidden" name="uuid" id="uuid" value="${param.uuid }" />
		    <div type="hidden" id="form0_hidden_text_div" name="form0_hidden_text_div" style="position: absolute; width: 0; height: 0; z-index: -9999999999; top: 0; left: 0; display: none;"></div>
		
		    <input type="hidden" name="javax.matrix.faces.ViewState" id="javax.matrix.faces.ViewState" value="" />
		    <input type="hidden" name="dataGridId" id="dataGridId" value="DataGrid001" />
        	<div style="width:100%;height:100%;overflow:auto;position: relative;" >
			    <div style="display: block">
					<table class="query_form_content" style="height:100%;width:100%;overflow:hidden;border-collapse: collapse;border-spacing:0px;table-layout:fixed;">
						<tr>
							<td class="query_form_toolbar" colspan="2" style="border: 1px solid #E6E9ED">
								<div style="padding:8px;background: #f8f8f8;text-align: left; ">
									<label style="padding-left: 5px">标题:</label>
									<div style="padding-right: 5px;display: inline-block;">
										<input type="text" name="title" id="title" class="form-control">
									</div>
									<div style="padding-right: 15px;display: inline-block;">
										<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/query.png">
										<input type="button" value="查询" class="btn  btn-default toolBarItem" id="MtoolBarItemQue" style="padding:0px;margin:0px;border:0;background: transparent" onclick="Matrix.refreshDataGridData('DataGrid001')">
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
									}]
								});
							});
						</script>
					</table>
				</div>
				<div>
					<table>
						<tr>
							<td style="height:54px;">
								
							</td>
						</tr>
					</table>		
				</div>
				<div style="display: block;text-align: -webkit-center;position: absolute;bottom: 5px;left:  0px;margin: auto;right:  0px;">
					<table>
						<tr>
							<td class="cmdLayout" colspan="2">
								<div id="button003_div" class="matrixInline" >
									<input type="button" class="x-btn ok-btn " value="保存"  onclick="saveSelections()">
								</div>
								<div id="button004_div" class="matrixInline" >
									<input type="button" class="x-btn cancel-btn " value="取消"  onclick="Matrix.closeWindow()">
								</div>
							</td>
						</tr>
					</table>					
				</div>
			</div>
		</form>
	</div>
</body>
</html>