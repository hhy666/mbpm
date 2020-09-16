<%@page pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML>
<html>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<head>
<jsp:include page="/form/html5/admin/html5Head.jsp"/>
<script type="text/javascript">

	//删除业务日历
	function deleteBusyDayOfDates(){
		var select = Matrix.getGridSelection('DataGrid001');
		if(select!=null&&select.length>0){
			var deleteIds ="";
			for(var i=0;i<select.length;i++){
				var busyDayOfDateId = select[i].busyDayOfDateId;
				if(i!=select.length-1){
					deleteIds += busyDayOfDateId+',';
				}else{
					deleteIds += busyDayOfDateId;
				}
			}
		    var url = "<%=path%>/calendar/calendarAction_deleteBusinessCalendarDate.action?deleteIds="+deleteIds;
		    Matrix.sendRequest(url,null,function(data){
		    	Matrix.refreshDataGridData('DataGrid001');
		    });
		}else{
			Matrix.warn('请选择要删除的工作时间！');
		}
	}
	
	//创建业务日历
	function createBusydayOfDate(){
		var calendarId = $("#calendarId").val();
		layer.open({
			type:2,
			title:['添加特殊工作时间'],
			area:['65%','100%'],
			content:'<%=path%>/calendar/calendarAction_loadSaveBusyDayOfDate.action?iframewindowid=EditBusydayOfDate&operationType=add&calendarId='+calendarId
		});	
	}
	
	
	//通过按钮实现更新
	function updateBusyDayOfDateByButton(){
		var select = Matrix.getGridSelection('DataGrid001');
		if(select!=null&&select.length>0){
			if(select.length==1){
				var busyDayOfDateId = select[0].busyDayOfDateId;
				updateBusydayOfDate(busyDayOfDateId);
			}else{
				Matrix.warn('只能选中一条工作时间！');
			}
		}else{
			Matrix.warn('请选中一条工作时间！');
		}
	} 
	

	//双击 实现更新业务日历
	function updateBusydayOfDate(busyDayOfDateId){
		var calendarId = $("#calendarId").val();
		layer.open({
			type:2,
			title:['修改特殊工作时间'],
			area:['65%','100%'],
			content:'<%=path%>/calendar/calendarAction_getBusinessCalendarDate.action?iframewindowid=EditBusydayOfDate&busyDayOfDateId='+busyDayOfDateId+'&operationType=update&calendarId='+calendarId
		});	
	}
	
	
	function onEditBusydayOfDateClose(data){
		if(data){
			var operationType = data.operationType;
			var url = null;
			if(operationType=='add'){
				url = '<%=path%>/calendar/calendarAction_createBusinessCalendarDate.action';
			}else if(operationType=='update'){
				url = '<%=path%>/calendar/calendarAction_updateBusinessCalendarDate.action';
			}
			Matrix.sendRequest(url,data,function(){
				Matrix.refreshDataGridData('DataGrid001');
			});
		}
	}
	
</script>
<title>特殊工作日列表</title>
</head>
<body>
	<form id="Form0" name="Form0" method="post" action="" style="margin:0px;overflow:hidden;height:100%;" enctype="application/x-www-form-urlencoded">
		<input type="hidden" name="calendarId" id="calendarId" value="${param.calendarId}"/>
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
							url:'<%=path%>/calendar/calendarAction_h5GetBusyDayOfDateList.action',
							search: false, 
							sidePagination: "server", 
							singleSelect: false,
							clickToSelect: true, 
							sortable: false,   
							//pagination: false,
							onDblClickRow:function(row){
								updateBusydayOfDate(row.busyDayOfDateId);
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
				        			calendarId : document.getElementById('calendarId').value
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
								field:'dayOfDate',
								title:'日期',
								editorType:'Text',
								clickToSelect: true,
								type:'text'
							},{
								field:'fromTime',
								title:'开始时间',
								editorType:'Text',
								clickToSelect: true,
								type:'Text'
							},{
								field:'toTime',
								title:'结束时间',
								editorType:'Text',
								clickToSelect: true,
								type:'Text'
							}]
						});
					});
				</script>
	       	</table>
		</div>
		<div style="display: block;">
			<table class="query_form_content">
    			<tr>
    				<td class="cmdLayout" style="left:0px;text-align: -webkit-center;">
			    		<div id="button000" class="matrixInline">
							<input type="button" class="x-btn ok-btn " value="创建" onclick="createBusydayOfDate()">
						</div>
						<div id="button001" class="matrixInline">
							<input type="button" class="x-btn ok-btn " value="修改" onclick="updateBusyDayOfDateByButton()">
						</div>
						<div id="button002" class="matrixInline">
							<input type="button" class="x-btn ok-btn " value="删除" onclick="deleteBusyDayOfDates()">
						</div>
						<div id="button003" class="matrixInline">
							<input type="button" class="x-btn cancel-btn " value="关闭" onclick="parent.Matrix.closeWindow()">
						</div>
					</td>
				</tr>
			</table>
		</div>
	</form>
</body>
</html>