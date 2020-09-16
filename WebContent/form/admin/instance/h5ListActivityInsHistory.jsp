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
<script type="text/javascript">
//重置
function refreshQuery(){
	document.getElementById('queryHisActPIID').value = '';
	document.getElementById('queryHisActAIID').value = '';
	document.getElementById('queryHisActName').value = '';
	document.getElementById('queryHisActDesc').value = '';
	Matrix.refreshDataGridData('DataGrid001');
}
//双击查看详细信息
function viewDetail(aiid) {
	if(aiid!=null && aiid.trim().length>0){
		 layer.open({
			type:2,
			title:['活动实例详细信息'],
			area:['70%','90%'],
			content:"<%=path%>/instance/activityInsAction_loadActInsDetailMain.action?aiid="+aiid+"&detailType=activityIns"
		});		
	}
}
</script>
<jsp:include page="/form/html5/admin/html5Head.jsp"/>
</head>
<body>
	<form id="Form0" name="Form0" method="post" action="" style="padding-left:10px; margin: 0px; overflow: hidden; width: 100%; height: 100%;" enctype="application/x-www-form-urlencoded">
	    <input type="hidden" name="Form0" value="Form0" />
	    <input type="hidden" name="dataGridId" id="dataGridId" value="DataGrid0" />
	    <input type="hidden" name="processDID" id="processDID" value="${requestScope.processDID}" />
	    <div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div" style="position: absolute; width: 0; height: 0; z-index: 0; top: 0; left: 0; display: none;"></div>
	    <div style="display: block;padding-top: 15px;height: 140px">
		    <table class="query_form_content" style="width: 100%; height: 100%;">
				<tr>
					<td style="" colspan="2">
						<table id="table001" jsId="table001" class="query_form_content" style="">
							<tr id="tr001" jsId="tr001" style="">
								<td id="td001" jsId="td001" class="query_form_label" colspan="1" rowspan="1">
									<label id="label001" name="label001"> 流程实例编码： </label>
								</td>
								<td id="td002" jsId="td002" class="query_form_input" colspan="1" rowspan="1">
									<div style="padding-right: 5px;display: inline-block;">
										<input class="form-control" type="text" style="" name="queryHisActPIID" id="queryHisActPIID" >
									</div>
								</td>
								<td id="td003" jsId="td003" class="query_form_label" colspan="1" rowspan="1">
									<label id="label002" name="label002"> 活动实例编码： </label>
								</td>
								<td id="td004" jsId="td004" class="query_form_input" colspan="1" rowspan="1">
									<div style="padding-right: 5px;display: inline-block;">
										<input class="form-control" type="text" style="" name="queryHisActAIID" id="queryHisActAIID" >
									</div>
								</td>
							</tr>
							<tr id="tr002" jsId="tr002" style="">
								<td id="td005" jsId="td005" class="query_form_label" colspan="1" rowspan="1">
									<label id="label003" name="label003"> 活动名称： </label>
								</td>
								<td id="td006" jsId="td006" class="query_form_input" colspan="1" rowspan="1">
									<div style="padding-right: 5px;display: inline-block;">
										<input class="form-control" type="text" style="" name="queryHisActName" id="queryHisActName" >
									</div>
								</td>
								<td id="td007" jsId="td007" class="query_form_label" colspan="1" rowspan="1">
									<label id="label004" name="label004"> 描述： </label>
								</td>
								<td id="td008" jsId="td008" class="query_form_input" colspan="1" rowspan="1">
									<div style="padding-right: 5px;display: inline-block;">
										<input class="form-control" type="text" style="" name="queryHisActDesc" id="queryHisActDesc" >
									</div>
								</td>
							</tr>
							<tr id="tr003" jsId="tr003" style="">
								<td class="td009" style="height: 10%;text-align:center;padding:10px;" colspan="4" >
									<div id="button1" class="matrixInline" style="position: relative; width: 100px; height: 30px;">
										<input type="button" class="x-btn ok-btn " value="查询" style="position:absolute;top:0;left:0;width:100%;height: 100%" onclick="Matrix.refreshDataGridData('DataGrid001')">
									</div>
									<div id="button2" class="matrixInline" style="position: relative; width: 100px; height: 30px;">
										<input type="button" class="x-btn ok-btn " value="重置" style="position:absolute;top:0;left:0;width:100%;height: 100%" onclick="refreshQuery()">
									</div>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
	    </div>
	    <div style="display: block;height: calc(100% - 140px);overflow: auto">
  			<table id="DataGrid001_table" style="width:100%;height:100%;">
				<script>
					$(document).ready(function(){
						/* var title = document.getElementById('title').value;
						var conditionType = document.getElementById('conditionType').value; */
						$("#DataGrid001_table").bootstrapTable({
							classes:'table table-bordered table-striped',
							method:'post',
							contentType : "application/x-www-form-urlencoded",
							url:'<%=path%>/instance/activityInsAction_h5QueryHistoryActivityInses.action',
							search: false, 
							sidePagination: "server", 
							singleSelect: true,
							clickToSelect: true, 
							sortable: false,   
							pagination: true,
							onDblClickRow:function(row){
								viewDetail(row.ACTIVITY_INS_ID);
							},
							queryParams: function(params){
								var param = {
									offset: params.offset,
									limit:params.limit,
								}
								param["queryHisActName"] = document.getElementById('queryHisActName').value;
								param["queryHisActDesc"] = document.getElementById('queryHisActDesc').value;
								param["queryHisActPIID"] = document.getElementById('queryHisActPIID').value;
								param["queryHisActAIID"] = document.getElementById('queryHisActAIID').value;
					            var form = document.getElementById('Form0');
					            var tagElements = form.getElementsByTagName('input');
					            for (var j = 0; j < tagElements.length; j++) {
					                param[tagElements[j].name] = tagElements[j].value;
					            };
								return param;
							},
							//singleSelect:true,
							//sortable:false,
							pageSize:10,
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
								field:'ACTIVITY_INS_ID',
								title:'活动实例编码',
								editorType:'Text',
								clickToSelect: true,
								type:'text'
							},{
								field:'ACTIVITY_NAME',
								title:'活动名称',
								editorType:'Text',
								clickToSelect: true,
								type:'Text'
							},{
								field:'DESCRIPTION',
								title:'描述',
								editorType:'Text',
								clickToSelect: true,
								type:'Text'
							},{
								field:'RECEIVED_DATE',
								title:'启动时间',
								editorType:'Text',
								clickToSelect: true,
								type:'Text'
							},{
								field:'EXPIRED_DATE',
								title:'完成期限',
								editorType:'Text',
								clickToSelect: true,
								type:'Text'
							},{
								field:'COMPLETED_DATE',
								title:'完成时间',
								editorType:'Text',
								clickToSelect: true,
								type:'Text'
							},{
								field:'PRIORITY',
								title:'优先级',
								editorType:'Text',
								clickToSelect: true,
								type:'Text',
								formatter: function (value, row, index){ // 单元格格式化函数
									var text = '-';
									if (value == 0) {
									    text = "普通";
									} else if (value == 1) {
									    text = "中级";
									} else if (value == 2) {
									    text = "高级";
									} else if (value == 3) {
									    text = "特级";
									}
									return text;
								}
							},{
								field:'STATUS',
								title:'状态',
								editorType:'Text',
								clickToSelect: true,
								type:'Text',
								formatter: function (value, row, index){ // 单元格格式化函数
									var text = '-';
									if (value == "Running") {
									    text = "运行";
									} else if (value == "Suspended") {
									    text = "暂停";
									} else if (value == "Completed") {
									    text = "完成";
									} else if (value == "Terminated") {
									    text = "终止";
									} else if (value == "Ready"){
										text = "就绪";
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