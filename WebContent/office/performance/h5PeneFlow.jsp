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
<title>流程统计穿透查询</title>
<script type="text/javascript">
	function load(){
		var str = "<%=path%>/performance/pen_priPenComprehensive.action?flowType=${param.flowType}&startTime=${param.startTime}&endTime=${param.endTime}&type=${param.type}&piid=${param.piid}&depId=${param.depId}";
		Matrix.setFormItemValue('url',str);  
		window.open('<%=path%>/office/performance/print.jsp');
	}  
	
	//导出
	function exportExcel(){
		var searchForm = document.getElementById("Form0") ;
		searchForm.action = "<%=path%>/performance/pen_exportFlow.action?flowType=${param.flowType}&startTime=${param.startTime}&endTime=${param.endTime}&type=${param.type}&piid=${param.piid}&depId=${param.depId}";
		searchForm.target = "penTarget";
		searchForm.submit();
	}
</script>
</head>
<body>
	<form id="Form0" name="Form0" method="post" action="" style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
		<input type="hidden" id="str" name="str" value="${str}">
		<input type="hidden" id="url" name="url">
		<div style="display: block;">
			<table class="query_form_content" style="height:100%;width:100%;overflow:hidden;border-collapse: collapse;border-spacing:0px;table-layout:fixed;">
				<tr>
					<td class="tdLayout" style="padding-left: 15px">
						<div style="padding-right: 15px;display: inline-block;">
							<input type="button" value="打印" class="btn  btn-default toolBarItem" id="MtoolBarItemQue" style="padding:0px;margin:0px;border:0;background: transparent" onclick="load()">
						</div>
						<div style="padding-right: 15px;display: inline-block;">
							<input type="button" value="导出" class="btn  btn-default toolBarItem" id="MtoolBarItemAdd" style="padding:0px;margin:0px;border:0;background: transparent" onclick="exportExcel()">
						</div>	
					</td>
				</tr>
			</table>
		</div>
		<div style="display: block;">
			<table id="DataGrid001_table" style="width:100%;height:100%;">
	   			<script>
	    			$(document).ready(function(){
						$("#DataGrid001_table").bootstrapTable({
							classes:'table table-bordered table-striped',
							method:'post',
							contentType : "application/x-www-form-urlencoded",
							url:'<%=path%>/performance/pen_h5CountFlow.action',
							search: false, 
							sidePagination: "server", 
							singleSelect: false,
							clickToSelect: true, 
							sortable: false,   
							//pagination: false,
							onDblClickRow:function(row){
								//showPenetration(row.templateId);
							},
							//singleSelect:true,
							//sortable:false,
							pageSize:20,
							//pageList:[10,20,30,40],
							formatLoadingMessage: function() {
				            return '请稍等，正在加载中...';
					        },
					        queryParams: function(params){
					        	var temp = {
				        			str : document.getElementById('str').value
					        	}
					        	return temp;
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
								field:'starter',
								title:'发起人',
								editorType:'Text',
								clickToSelect: true,
								type:'Text'
							},{
								field:'username',
								title:'处理人',
								editorType:'Text',
								clickToSelect: true,
								type:'Text'
							},{
								field:'startDate',
								title:'收到时间',
								editorType:'Text',
								clickToSelect: true,
								type:'Text'
							},{
								field:'completeDate',
								title:'处理时间',
								editorType:'Text',
								clickToSelect: true,
								type:'Text'
							},{
								field:'overTime',
								title:'超时时长',
								editorType:'Text',
								clickToSelect: true,
								type:'Text'
							},{
								field:'term',
								title:'处理期限',
								editorType:'Text',
								clickToSelect: true,
								type:'Text'
							},{
								field:'isover',
								title:'是否结束',
								editorType:'Text',
								clickToSelect: true,
								type:'Text'
							}]
						});
					});
				</script>
	       	</table>
		</div>
	</form>
</body>
</html>