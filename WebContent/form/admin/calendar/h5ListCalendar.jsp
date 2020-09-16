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
	//添加业务日历
	function calendarAdd(){
		layer.open({
			type:2,
			title:['添加业务日历'],
			area:['65%','65%'],
			content:'<%=path%>/calendar/calendarAction_loadCalendarSavePage.action?operationType=add&iframewindowid=EditCalendar'
		});	
	}
	
	//双击编辑业务日历
	function calendarUpdate(calendarId){
		layer.open({
			type:2,
			title:['编辑业务日历'],
			area:['65%','65%'],
			content:'<%=path%>/calendar/calendarAction_loadCalendarSavePage.action?operationType=update&iframewindowid=EditCalendar&calendarId='+calendarId
		});	
	}
	
	//添加业务日历回调
	function onEditCalendarClose(data){
		if(data!=null){
			var operationType = data.operationType;
			var url;
			if(operationType=="add"){
			    url = "<%=path%>/calendar/calendarAction_createBusinessCalendar.action";
			}else if(operationType=="update"){
				url = "<%=path%>/calendar/calendarAction_updateBusinessCalendar.action";
			}
			Matrix.sendRequest(url,data,function(data){
				Matrix.refreshDataGridData('DataGrid001');
			});
		}
	}
	
	//查看内容
	function calendarContent(){
		var select = Matrix.getGridSelection('DataGrid001');
		if(select!=null&&select.length>0){
			if(select.length=1){
				var calendarId = select[0].calendarId;
				layer.open({
					type:2,
					title:['业务日历详细'],
					area:['80%','85%'],
					content:'<%=path%>/calendar/calendarAction_loadDetailMain.action?iframwindowid=Content&calendarId='+calendarId
				});
			}else{
				Matrix.warn('只能选择一条业务日历查看！');
			}
		}else{
			Matrix.warn('请选择要查看内容的业务日历！');
		}
	}
	
	//浏览业务日历
	function previewCalendar(){
		var select = Matrix.getGridSelection('DataGrid001');
		if(select!=null&&select.length>0){
			if(select.length=1){
				var calendarId = select[0].calendarId;
				var url ='<%=path%>/calendar/calendarAction_previewContentOfCalendar.action?fromPlace=list&calendarId='+calendarId
				document.getElementById('Form0').action = url;
				document.getElementById('Form0').submit();
			}else{
				Matrix.warn('只能选择一条业务日历浏览！');
			}
		}else{
			Matrix.warn('请选择要浏览的业务日历！');
		}
	}
	
	//删除业务日历
	function deleteCalendars(){
		var select = Matrix.getGridSelection('DataGrid001');
		if(select!=null&&select.length>0){
			var calendarIds ="";
			for(var i=0;i<select.length;i++){
				var calendarId = select[i].calendarId;
				if(i!=select.length-1){
					calendarIds += calendarId+',';
				}else{
					calendarIds += calendarId;
				}
			}
			Matrix.confirm("确定要删除么？",function(data){
				if(!data){
					 var url = "<%=path%>/calendar/calendarAction_deleteBusinessCalendar.action?calendarIds="+calendarIds;
					 Matrix.sendRequest(url,null,function(data){
						 var json = isc.JSON.decode(data.data);
						 if(json.message == true){
							 Matrix.refreshDataGridData('DataGrid001');
							 Matrix.say('删除成功！');
						 }else if(json.message == false){
							 Matrix.refreshDataGridData('DataGrid001');
							 Matrix.warn('默认业务日历不能被删除！');
						 }
						 
					 });
				}
			});
		}else{
			Matrix.warn('请选择要删除的业务日历！');
		}
	}
</script>
<title>业务日历列表</title>
</head>
<body>
	<form id="Form0" name="Form0" method="post" action="" style="margin:0px;overflow:hidden;height:100%;padding:5px" enctype="application/x-www-form-urlencoded">
		<input type="hidden" name="calendarsJson" id="calendarsJson" value="${calendarsJson}">
		<div style="display: block;">
			<table class="query_form_content" style="overflow:auto;width:100%;height:100%;">
				<tr>
					<td id="td111" style="width:100%;height:30px;padding:5px;vertical-align:bottom;border:0 " name="td111" styleClass="tdLayout">
						<span id="label011" style="font-size:16px;vertical-align:bottom; " name="label011"/>业务日历管理</span>
		            </td>
				</tr>
			</table>
		</div>
		<div style="display: block">
			<table class="query_form_content" style="height:100%;width:100%;overflow:hidden;border-collapse: collapse;border-spacing:0px;table-layout:fixed;">
	   			<tr style=" height: 0px">
					<td class="query_form_toolbar"icolspan="2" style="padding: 3px;background: #f8f8f8;text-align: left;border: 1px solid #E6E9ED">
						<div style="padding-left:15px;padding-right: 15px;display: inline-block;">
							<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/new.png">
							<input type="button" value="新建" class="btn  btn-default toolBarItem" id="MtoolBarItemAdd" style="padding:0px;margin:0px;border:0;background: transparent" onclick="calendarAdd()">
						</div>	
						<div style="padding-right: 15px;display: inline-block;">
							<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/file.png">
							<input type="button" value="内容" class="btn  btn-default toolBarItem" id="MtoolBarItemUpdate" style="padding:0px;margin:0px;border:0;background: transparent" onclick="calendarContent()">
						</div>
						<div style="padding-right: 15px;display: inline-block;">
							<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/query.png">
							<input type="button" value="浏览" class="btn  btn-default toolBarItem" id="MtoolBarItemUpMove" style="padding:0px;margin:0px;border:0;background: transparent" onclick="previewCalendar()" / >
						</div>
						<div style="padding-right: 15px;display: inline-block;">
							<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/deletex.png">
							<input type="button" value="删除" class="btn  btn-default toolBarItem" id="MtoolBarItemDownMove" style="padding:0px;margin:0px;border:0;background: transparent" onclick="deleteCalendars()" / >
						</div>
					</td>
				</tr>
			</table>
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
							url:'<%=path%>/calendar/calendarAction_h5GetBusinessCalendars.action',
							search: false, 
							sidePagination: "server", 
							singleSelect: false,
							clickToSelect: true, 
							sortable: false,   
							//pagination: false,
							onDblClickRow:function(row){
								calendarUpdate(row.calendarId);
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
				        			calendarsJson : document.getElementById('calendarsJson').value
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
								field:'calendarId',
								title:'编码',
								editorType:'Text',
								clickToSelect: true,
								type:'text'
							},{
								field:'calendarName',
								title:'名称',
								editorType:'Text',
								clickToSelect: true,
								type:'Text'
							},{
								field:'description',
								title:'描述',
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