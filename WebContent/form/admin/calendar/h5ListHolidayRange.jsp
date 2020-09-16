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
	
	
	function deleteHolidayRanges(){
		var select = Matrix.getGridSelection('DataGrid001');
		if(select!=null&&select.length>0){
			var deleteIds ="";
			for(var i=0;i<select.length;i++){
				var holidayRangeId = select[i].holidayRangeId;
				if(i!=select.length-1){
					deleteIds += holidayRangeId+',';
				}else{
					deleteIds += holidayRangeId;
				}
			}
		    var url = "<%=path%>/calendar/calendarAction_deleteHolidayRange.action?deleteIds="+deleteIds;
		    Matrix.sendRequest(url,null,function(data){
		    	Matrix.refreshDataGridData('DataGrid001');
		    });
		}else{
			Matrix.warn('请选择要删除的公共假日！');
		}
	}
	
	
	function createHolidayRanges(){
		var calendarId = $("#calendarId").val();
		layer.open({
			type:2,
			title:['添加公共假日'],
			area:['65%','100%'],
			content:'<%=path%>/calendar/calendarAction_loadSaveHolidayRange.action?iframewindowid=EditHoliday&operationType=add&calendarId='+calendarId
		});	
	}
	
	
	function updateHolidayRange(holidayRangeId){
		var calendarId = $("#calendarId").val();
		layer.open({
			type:2,
			title:['修改公共假日'],
			area:['65%','100%'],
			content:'<%=path%>/calendar/calendarAction_getHolidayRange.action?iframewindowid=EditHoliday&holidayRangeId='+holidayRangeId+'&operationType=update&calendarId='+calendarId
		});	
	}
	
	
	//按钮编辑
	function updateHolidayRangeByButton(){
		debugger;
		var select = Matrix.getGridSelection('DataGrid001');
		if(select!=null&&select.length>0){
			if(select.length==1){
				var holidayRangeId = select[0].holidayRangeId;
				
				updateHolidayRange(holidayRangeId);
			}else{
				Matrix.warn('只能选中一条公共假日！');
			}
		}else{
			Matrix.warn('请选中一条公共假日！');
		}
	}
	
	
	function onEditHolidayClose(data){
		if(data){
			var operationType = data.operationType;
			var url = null;
			if(operationType=='add'){
				url = '<%=path%>/calendar/calendarAction_createHolidayRange.action';
			}else if(operationType=='update'){
				url = '<%=path%>/calendar/calendarAction_updateHolidayRange.action';
			}
			Matrix.sendRequest(url,data,function(){
				Matrix.refreshDataGridData('DataGrid001');
			});
		}
	}
</script>
<title>公共假日列表</title>
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
							url:'<%=path%>/calendar/calendarAction_h5GetHolidayRangeList.action',
							search: false, 
							sidePagination: "server", 
							singleSelect: false,
							clickToSelect: true, 
							sortable: false,   
							//pagination: false,
							onDblClickRow:function(row){
								updateHolidayRange(row.holidayRangeId);
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
								field:'fromDate',
								title:'开始时间',
								editorType:'Text',
								clickToSelect: true,
								type:'Text'
							},{
								field:'toDate',
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
			    		<div id="button000" class="matrixInline" >
							<input type="button" class="x-btn ok-btn " value="创建"  onclick="createHolidayRanges()">
						</div>
						<div id="button001" class="matrixInline" >
							<input type="button" class="x-btn ok-btn " value="修改"  onclick="updateHolidayRangeByButton()">
						</div>
						<div id="button002" class="matrixInline" >
							<input type="button" class="x-btn ok-btn " value="删除"  onclick="deleteHolidayRanges()">
						</div>
						<div id="button003" class="matrixInline" >
							<input type="button" class="x-btn cancel-btn " value="关闭"  onclick="parent.Matrix.closeWindow()">
						</div>
					</td>
				</tr>
			</table>
		</div>
	</form>
</body>
</html>