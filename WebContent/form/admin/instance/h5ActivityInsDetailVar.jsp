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
	<form id="Form0" name="Form0" method="post" action="" style="margin: 0px; height: 500px;" enctype="application/x-www-form-urlencoded">
		<input type="hidden" name="Form0" value="Form0" />
		<input type="hidden" name="aiid" id="aiid" value='${aiid}'/>
		<input type="hidden" name="detailType" id="detailType" value='${detailType }'/>
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
							url:'<%=path%>/instance/activityInsAction_h5GetActivityInsDetailVar.action',
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
					        			detailType : document.getElementById('detailType').value,
					        			aiid : document.getElementById('aiid').value
					        	}
					        	return temp;
					        },
					        formatNoMatches: function() {
					            return '无符合条件的记录';
					        },
							columns:[{
								title:'序号',
								 formatter: function (value, row, index) { 
									var pageSize = $("#DataGrid001_table").bootstrapTable('getOptions').pageSize;
									var pageNumber = $("#DataGrid001_table").bootstrapTable('getOptions').pageNumber;
			                            return pageSize * (pageNumber - 1) + index + 1;  
			                        }
							},{
								field:'varName',
								title:'名称',
								editorType:'Text',
								clickToSelect: true,
								type:'text'
							},{
								field:'varType',
								title:'类型',
								editorType:'Text',
								clickToSelect: true,
								type:'Text'
							},{
								field:'varValue',
								title:'值',
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