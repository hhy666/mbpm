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
</head>
<body>
	<form id="Form0" name="Form0" method="post"	action="" style="margin: 0px; height: 500px;" enctype="application/x-www-form-urlencoded">
		<input type="hidden" id="actityInsData" name="actityInsData" value="${actityInsData }" />
		<input type="hidden" name="Form0" value="Form0" />
		<div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div" style="position: absolute; width: 0; height: 0; z-index: 0; top: 0; left: 0; display: none;"></div>
		<div id="j_id1_div2" style="width: 100%; height: 100%; overflow: auto;"	class="matrixInline">
			<table id="DataGrid001_table" style="width:100%;height:100%;">
    			<script>
   	    			$(document).ready(function(){
						/* var title = document.getElementById('title').value;
						var conditionType = document.getElementById('conditionType').value; */
						$("#DataGrid001_table").bootstrapTable({
							classes:'table table-bordered table-striped',
							method:'post',
							contentType : "application/x-www-form-urlencoded",
							url:'<%=path%>/instance/processInstance_h5GetActivtityInsesByPiid.action',
							search: false, 
							sidePagination: "server", 
							singleSelect: false,
							clickToSelect: true, 
							sortable: false,   
							//pagination: false,
							//singleSelect:true,
							//sortable:false,
							pageSize:20,
							//pageList:[10,20,30,40],
							formatLoadingMessage: function() {
				            return '请稍等，正在加载中...';
					        },
					        queryParams: function(params){
					        	var temp = {
				        			actityInsData : document.getElementById('actityInsData').value,
					        	}
					        	return temp;
					        },
					        formatNoMatches: function() {
					            return '无符合条件的记录';
					        },
							columns:[{
								title:'序号',
								width:'2%',
								 formatter: function (value, row, index) { 
									var pageSize = $("#DataGrid001_table").bootstrapTable('getOptions').pageSize;
									var pageNumber = $("#DataGrid001_table").bootstrapTable('getOptions').pageNumber;
			                            return pageSize * (pageNumber - 1) + index + 1;  
			                        }
							},{
								field:'aiid',
								width:'35%',
								title:'活动实例编码',
								editorType:'Text',
								clickToSelect: true,
								type:'text'
							},{
								field:'acName',
								title:'活动名称',
								width:'5%',
								editorType:'Text',
								clickToSelect: true,
								type:'Text'
							},{
								field:'acDesc',
								width:'20%',
								title:'描述',
								editorType:'Text',
								clickToSelect: true,
								type:'Text'
							},{
								field:'acType',
								width:'15%',
								title:'类型',
								editorType:'Text',
								clickToSelect: true,
								type:'Text',
								formatter:function(value,row,index){
									var text = "-";
									if (value == 1){
										text = "逻辑活动";
									}else if(value == 2){
										text = "活动集";
									}else if(value == 3){
										text = "子流程";
									}else if(value == 4){
										text = "人工活动";
									}else if(value == 6){
										text = "自动活动";
									}
									return text;
								}
							},{
								field:'acStatus',
								title:'状态',
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