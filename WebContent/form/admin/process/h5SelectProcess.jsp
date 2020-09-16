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
	//点击选择
	function singleClickSelect(row, element){
		$('.changeColor').removeClass('changeColor');//去除之前选中的行的，选中样式
		$(element).addClass('changeColor');
	}
	
	//双击行事件
	function doubleClickSelect(row){
		var record = row;
		
		var upgradeTargetPkgTmplId = record.pkgTid;
		var upgradePkgTmplId = document.getElementById('upgradePkgTmplId').value;
		var processId = document.getElementById('processId').value;
		var iframewindowid = document.getElementById('iframewindowid').value;
		parent.layer.open({
			type:2,
			title:["流程模板迁移"],
			area:['60%','80%'],
			content:"<%=path%>/process/processTmplAction_processMigrationPkgTmplId.action?iframewindowid="+iframewindowid+"&processId="+processId+"&upgradePkgTmplId="+upgradePkgTmplId+"&upgradeTargetPkgTmplId="+upgradeTargetPkgTmplId
		});
	}

	function selectPkgTmpl(){
		var $tr = $('#DataGrid001_table').find('tr.changeColor');   //选中行
		if($tr!=null && $tr.length==1){
			var index = $tr.data('index');  //获得选中的行的index
       		var item = Matrix.getGridData('DataGrid001');   //所有数据
       		var record = item[index];  //当前选中行
       		
       		doubleClickSelect(record);
		}else{
			Matrix.warn("请选择要迁移的流程模板!");
		}
	}
</script>
</head>
<body>
	<form id="Form0" name="Form0" eventProxy="MForm0" method="get" action="<%=request.getContextPath()%>/process/processTmplAction_processMigrationPkgTmplId.action" style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
		<div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div" style="position: absolute; width: 0; height: 0; z-index: -9999999999; top: 0; left: 0; display: none;"></div>
		<input type="hidden" name="Form0" value="Form0" /> 
		<input type="hidden" id="processId" name="processId" value="${param.processId}">
		<input type="hidden" id="dataGridId" name="dataGridId" value="DataGrid0">
		<input type="hidden" id="upgradePkgTmplId" name="upgradePkgTmplId" value="${upgradePkgTmplId}">
		<input type="hidden" id="upgradeTargetPkgTmplId" name="upgradeTargetPkgTmplId" value="${upgradeTargetPkgTmplId}">
		<input type="hidden" id="selection" name="selection" value="${selection}">
		<input type="hidden" id="iframewindowid" name="iframewindowid" value="${iframewindowid}">
		<div style="display: block;">
			<table id="DataGrid001_table" style="width:100%;height:100%;">
    			<script>
   	    			$(document).ready(function(){
						/* var title = document.getElementById('title').value;
						var conditionType = document.getElementById('conditionType').value; */
						$("#DataGrid001_table").bootstrapTable({
							classes:'table table-hover table-no-bordered',
							method:'post',
							contentType : "application/x-www-form-urlencoded",
							url:'<%=path%>/process/processTmplAction_h5QuerySelectedPkgTemplates.action',
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
			        				upgradePkgTmplId : document.getElementById('upgradePkgTmplId').value,
			        				processId : document.getElementById('processId').value
					        	}
					        	return temp;
					        },
					        formatNoMatches: function() {
					            return '无符合条件的记录';
					        },
							columns:[
							{
								title:'序号',
								width:'50',
								align:'center',
							    formatter: function (value, row, index) { 
								   var pageSize = $("#DataGrid001_table").bootstrapTable('getOptions').pageSize;
								   var pageNumber = $("#DataGrid001_table").bootstrapTable('getOptions').pageNumber;
			                       return pageSize * (pageNumber - 1) + index + 1;  
			                    }
							},{
								field:'PACKAGE_NAME',
								title:'名称',
								editorType:'Text',
								clickToSelect: true,
								type:'text'
							},{
								field:'RH_VERSION',
								title:'版本',
								editorType:'Text',
								clickToSelect: true,
								type:'Text'
							},{
								field:'PKG_SUBMIT_TIME',
								title:'最后更新时间',
								editorType:'Text',
								clickToSelect: true,
								type:'Text'
							},{
								field:'RH_PUB_STATUS',
								title:'状态',
								editorType:'Text',
								clickToSelect: true,
								type:'Text'
							},{
								field:'PACKAGE_OWNER',
								title:'当前操作人',
								editorType:'Text',
								clickToSelect: true,
								type:'Text'
							},{
								field:'PKG_SUBMIT_ID',
								title:'最后更新人',
								editorType:'Text',
								clickToSelect: true,
								type:'Text'
							}],
							singleSelect:true,  //设置true将禁止多选
							onClickRow:function(row, $element){   //单击行事件
						    	singleClickSelect(row, $element);
							},
						    onDblClickRow:function(row){   //双击行事件
						    	doubleClickSelect(row);
							},
						});
					});
				</script>
       		</table>
		</div>
		<div style="display: block;">
			<table class="query_form_content">
    			<tr>
    				<td  class="cmdLayout" style="text-align: center;">
			    		<div id="button000" class="matrixInline">
							<input type="button" class="x-btn ok-btn " value="确认" onclick="selectPkgTmpl()">
						</div>
						<div id="button001" class="matrixInline">
							<input type="button" class="x-btn cancel-btn " value="取消" onclick="Matrix.closeWindow()">
						</div>
					</td>
				</tr>
			</table>
		</div>
	</form>
</body>
</html>