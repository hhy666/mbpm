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

	//添加变量
	function addEntityPro(){
	   var selects = $('#DataGrid001_table').bootstrapTable('getSelections');
	   if(selects!=null&&selects.length>0){
		   doubleClickSelect(selects[0]);
	   }else{
		   Matrix.warn('请先选中变量！');
	   }
	}
	
	function doubleClickSelect(selects){
		Matrix.closeWindow(selects);
	}

</script>
</head>
<body style="padding:5px">
	<input type="hidden" id="formId" name="formId" value="${param.formId}">
	<div style="display: block">
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
							<input type="button" value="确认" class="btn  btn-default toolBarItem" id="MtoolBarItemAdd" style="padding:0px;margin:0px;border:0;background: transparent" onclick="addEntityPro()">
						</div>
					</div>
				</td>
			</tr>
		</table>
 	</div>
	<div style="display: block;overflow:auto;height:90%;padding:5px">
		<table id="DataGrid001_table" style="width:100%;height:100%;">
			<script>
				$(document).ready(function(){
					$("#DataGrid001_table").bootstrapTable({
						classes:'table table-bordered table-striped',
						method:'post',
						contentType : "application/x-www-form-urlencoded",
						url:'<%=path%>/statistic/statisticAction_getEntityProIdList.action',
						search: false, 
						sidePagination: "server", 
						singleSelect: true,
						clickToSelect: true, 
						sortable: false,   
						//pagination: true,
						onClickRow:function(row){
						},
						onDblClickRow:function(row){
							doubleClickSelect(row);
						},
						queryParams: function(params){
							var param = {
								offset: params.offset,
								limit:params.limit,
								formId:$('#formId').val(),
								name:$('#name').val()
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
		                        }
						},{
							field:'name',
							title:'名称',
							editorType:'Text',
							clickToSelect: true,
							type:'Text'
						}]
					});
				});
			</script>
		</table>
	</div>
</body>
</html>