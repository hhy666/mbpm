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
	function showPenetration(piid){
		parent.parent.layer.open({
			type:2,
			title:['穿透查询'],
			area:['85%','85%'],
			content:'<%=path%>/performance/pen_countEfficiency.action?startTime=${param.startTime}&endTime=${param.endTime}&templetId=${param.templetId}&piid='+piid
		});
	}
</script>
<title>效率分析列表</title>
</head>
<body style="overflow:auto">
	<form id="Form0" name="Form0" method="post" action="" style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
		<input type="hidden" id="str" name="str" value="${str}">
		<table id="DataGrid001_table" style="width:100%;height:100%;">
   			<script>
    			$(document).ready(function(){
					$("#DataGrid001_table").bootstrapTable({
						classes:'table table-bordered table-striped',
						method:'post',
						contentType : "application/x-www-form-urlencoded",
						url:'<%=path%>/performance/per_h5CountEfficiency.action',
						search: false, 
						sidePagination: "server", 
						singleSelect: false,
						clickToSelect: true, 
						sortable: false,   
						//pagination: false,
						onDblClickRow:function(row){
							showPenetration(row.piid);
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
							title:'流程标题',
							editorType:'Text',
							clickToSelect: true,
							type:'text'
						},{
							field:'term',
							title:'基准时长',
							editorType:'Text',
							clickToSelect: true,
							type:'Text'
						},{
							field:'runTime',
							title:'运行时长',
							editorType:'Text',
							clickToSelect: true,
							type:'Text'
						},{
							field:'effici',
							title:'运行效率',
							editorType:'Text',
							clickToSelect: true,
							type:'Text'
						}]
					});
				});
			</script>
       	</table>
	</form>
</body>
</html>