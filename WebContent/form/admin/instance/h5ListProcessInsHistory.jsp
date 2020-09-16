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

	//重置搜索框与列表
	function refreshQuery(){
		document.getElementById('queryPiid').value = '';
		document.getElementById('queryDesc').value = '';
		Matrix.refreshDataGridData('DataGrid001');
	}

	//播放流程实例
	function videoProcess(){
		var select = Matrix.getGridSelections('DataGrid001');
		if(select!=null&&select.length>0){
			if(select.lenght=1){
				var piid = select[0].PROCESS_INS_ID;
				if(piid!=null&&piid.length>0){
					layer.open({
						type:2,
						title:['播放流程实例'],
						area:['60%','80%'],
						content:'<%=path%>/process/processTmplAction_designProcess.action?simulationType=1&piid='+piid
					});				
				}
			}else{
				Matrix.warn("只能选中一条数据！");
			}
		}else{
			Matrix.warn("请选中要播放的的流程实例！");
		}
	}
	
	//双击查看详细流程实例
	function viewDetail(piid) {
		if(piid!=null && piid.trim().length>0){
			layer.open({
				type:2,
				title:['流程实例详细信息'],
				area:['70%','90%'],
				content:"<%=path%>/instance/processInstance_loadProcInsDetailMainPage.action?piid="+piid+"&detailType=history"
			});		
		}
	}
</script>
</head>
<body>
	<form id="Form0" name="Form0" method="post" action="" style="padding-left:10px; margin: 0px; overflow: hidden; width: 100%; height: 100%;" enctype="application/x-www-form-urlencoded">
	    <input type="hidden" name="Form0" value="Form0" />
	    <input type="hidden" name="dataGridId" id="dataGridId" value="DataGrid0" />
	    <input type="hidden" name="processDID" id="processDID" value="${requestScope.processDID}" />
	    <div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div" style="position: absolute; width: 0; height: 0; z-index: 0; top: 0; left: 0; display: none;"></div>
		<div style="display: block;padding-top: 15px;height: 110px"">
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
										<input class="form-control" type="text" style="" name="queryPiid" id="queryPiid" >
									</div>
								</td>
								<td id="td003" jsId="td003" class="query_form_label" colspan="1" rowspan="1">
									<label id="label002" name="label002"> 描述： </label>
								</td>
								<td id="td004" jsId="td004" class="query_form_input" colspan="1" rowspan="1">
									<div style="padding-right: 5px;display: inline-block;">
										<input class="form-control" type="text" style="" name="queryDesc" id="queryDesc" >
									</div>
								</td>
							</tr>
							<tr id="tr002" jsId="tr002" style="">
								<td class="td005" style="height: 10%;text-align:center;padding:10px;" colspan="4" >
									<div id="button1" class="matrixInline">
										<input type="button" class="x-btn ok-btn" value="查询" onclick="Matrix.refreshDataGridData('DataGrid001')">
									</div>
									<div id="button2" class="matrixInline">
										<input type="button" class="x-btn ok-btn" value="重置" onclick="refreshQuery()">
									</div>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
	    </div>
	    <div style="display: block;height: calc(100% - 110px - 30px);overflow: auto">
			<table id="DataGrid001_table" style="width:100%;height:100%;">
				<script>
					$(document).ready(function(){
						/* var title = document.getElementById('title').value;
						var conditionType = document.getElementById('conditionType').value; */
						$("#DataGrid001_table").bootstrapTable({
							classes:'table table-bordered table-striped',
							method:'post',
							contentType : "application/x-www-form-urlencoded",
							url:'<%=path%>/instance/processInstance_h5QueryHistoryProcessInses.action',
							search: false, 
							sidePagination: "server", 
							singleSelect: true,
							clickToSelect: true, 
							sortable: false,   
							pagination: true,
							onDblClickRow:function(row){
								viewDetail(row.PROCESS_INS_ID);
							},
							queryParams: function(params){
								
								var param = {
									offset: params.offset,
									limit:params.limit,
								}
								param["queryPiid"] = document.getElementById('queryPiid').value;
								param["queryDesc"] = document.getElementById('queryDesc').value;
					            var form = document.getElementById('Form0');
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
								field:'PROCESS_INS_ID',
								title:'流程实例编码',
								editorType:'Text',
								clickToSelect: true,
								type:'text'
							},{
								field:'DESCRIPTION',
								title:'描述',
								editorType:'Text',
								clickToSelect: true,
								type:'Text'
							},{
								field:'STARTED_DATE',
								title:'启动时间',
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