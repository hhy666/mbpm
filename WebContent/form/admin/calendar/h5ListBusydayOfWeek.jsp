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

	//创建
	function createBusydayOfWeek(){
		var calendarId = $("#calendarId").val();
		layer.open({
			type:2,
			title:['添加每周工作时间'],
			area:['65%','100%'],
			content:'<%=path%>/calendar/calendarAction_loadSaveBusyDayOfWeek.action?iframewindowid=EditBusydayOfWeek&operationType=add&calendarId='+calendarId
		});	
	}
	
	
	function onEditBusydayOfWeekClose(data){
		if(data){
			var operationType = data.operationType;
			var url = null;
			if(operationType=='add'){
				url = '<%=path%>/calendar/calendarAction_createBusinessDayOfWeek.action';
			}else if(operationType=='update'){
				url = '<%=path%>/calendar/calendarAction_updateBusinessDayOfWeek.action';
			}
			Matrix.sendRequest(url,data,function(){
				Matrix.refreshDataGridData('DataGrid001');
			});
		}
	}
	
	
	//编辑
	function updateBusydayOfWeek(busyDayOfWeekId){
		var calendarId = $("#calendarId").val();
		layer.open({
			type:2,
			title:['修改每周工作时间'],
			area:['65%','100%'],
			content:'<%=path%>/calendar/calendarAction_getBusinessDayOfWeek.action?iframewindowid=EditBusydayOfWeek&busyDayOfWeekId='+busyDayOfWeekId+'&operationType=update&calendarId='+calendarId
		});	
	}
	
	//按钮编辑
	function updateBusyDayOfWeekByButton(){
		var select = Matrix.getGridSelection('DataGrid001');
		if(select!=null&&select.length>0){
			if(select.length==1){
				var busyDayOfWeekId = select[0].busyDayOfWeekId;
				updateBusydayOfWeek(busyDayOfWeekId);
			}else{
				Matrix.warn('只能选中一条工作时间！');
			}
		}else{
			Matrix.warn('请选中一条工作时间！');
		}
	}
	
	
	//删除
	function deleteBusyDayOfWeeks(){
		var select = Matrix.getGridSelection('DataGrid001');
		if(select!=null&&select.length>0){
			var deleteIds ="";
			for(var i=0;i<select.length;i++){
				var busyDayOfWeekId = select[i].busyDayOfWeekId;
				if(i!=select.length-1){
					deleteIds += busyDayOfWeekId+',';
				}else{
					deleteIds += busyDayOfWeekId;
				}
			}
		    var url = "<%=path%>/calendar/calendarAction_deleteBusinessDayOfWeek.action?deleteIds="+deleteIds;
		    Matrix.sendRequest(url,null,function(data){
		    	Matrix.refreshDataGridData('DataGrid001');
		    });
		}else{
			Matrix.warn('请选择要删除的每周工作时间！');
		}
	}
</script>
<title>每周工作日列表</title>
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
							url:'<%=path%>/calendar/calendarAction_h5GetBusyDayOfWeekList.action',
							search: false, 
							sidePagination: "server", 
							singleSelect: false,
							clickToSelect: true, 
							sortable: false,   
							//pagination: false,
							onDblClickRow:function(row){
								updateBusydayOfWeek(row.busyDayOfWeekId);
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
								field:'dayOfWeek',
								title:'周几',
								editorType:'Text',
								clickToSelect: true,
								type:'text',
								formatter:function(value,row,index){
									var text = "-";
									if(value=='2'){
										text = '周一';
									}else if(value=='3'){
										text = '周二';
									}else if(value=='4'){
										text = '周三';
									}else if(value=='5'){
										text = '周四';
									}else if(value=='6'){
										text = '周五';
									}else if(value=='7'){
										text = '周六';
									}else if(value=='1'){
										text = '周日';
									}
									return text;
								}
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
			    		<div id="button000" class="matrixInline" >
							<input type="button" class="x-btn ok-btn " value="创建"  onclick="createBusydayOfWeek()">
						</div>
						<div id="button001" class="matrixInline" >
							<input type="button" class="x-btn ok-btn " value="修改"  onclick="updateBusyDayOfWeekByButton()">
						</div>
						<div id="button002" class="matrixInline" >
							<input type="button" class="x-btn ok-btn " value="删除"  onclick="deleteBusyDayOfWeeks()">
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