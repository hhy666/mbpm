<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>
<!DOCTYPE html>
<html>
 <head>
  <meta charset="utf-8" />
<%@ include file="/form/html5/admin/html5Head.jsp"%>
  <style>

</style> 
 </head> 
 <body style="background-color: #f8f8f8;"> 
  <input type="hidden" id="validateType" name="validateType" value="jquery" /> 
  <div style="width:100%;height:100%;overflow:auto;position:relative;margin:0 auto;padding:3px;zoom:1" id="context">
   <form id="form0" name="form0" eventproxy="Mform0" method="post" action="/<%=path %>/matrix.mform" style="margin:0px;position:relative;overflow:auto;width:100%;height:100%;" enctype="application/x-www-form-urlencoded"> 
    <input type="hidden" name="form0" value="form0" /> 
    <input type="hidden" id="mode" name="mode" value="debug" /> 
    <input type="hidden" name="is_mobile_request" /> 
    <input type="hidden" name="mHtml5Flag" value="true" /> 
    <input type="hidden" id="matrix_form_tid" name="matrix_form_tid" /> 
    <input type="hidden" id="matrix_form_datagrid_form0" name="matrix_form_datagrid_form0" value="" /> 
    <div type="hidden" id="form0_hidden_text_div" name="form0_hidden_text_div" style="position:absolute;width:0;height:0;z-index:-9999999999;top:0;left:0;display:none;"></div> 
    <table id="centerTable" class="query_form_content" style="height:100%;width:100%;overflow:hidden;border-collapse: collapse;border-spacing:0px;table-layout:fixed;"> 
     <tbody>
      <tr style="height:0px;"> 
       <td class="query_form_toolbar" colspan="2"> 
        <div id="QueryForm001_tb" style=" width:100%;height:38px;border: none;" class="x_panel panel_color"> 
         <label id="QueryField005_Label" name="QueryField005_Label" class="control-label "> 编码</label>
		 <div id="QueryField005_div" class="input-group default-width col-md-12 " style="display: inline-table; vertical-align: middle;  "> 
		  <input id="QueryField005" name="QueryField005" type="text" class="form-control " style=" width:100%;height:100%;padding-left: 5px;" autocomplete="off" > 
		 </div>
         <label id="QueryField002_Label" name="QueryField002_Label" class="control-label "> 名称 </label> 
         <div id="QueryField002_div" class="input-group default-width col-md-12 " style="display: inline-table; vertical-align: middle;  "> 
          <input id="QueryField002" name="QueryField002" type="text" class="form-control " style=" width:100%;height:100%;padding-left: 5px;" autocomplete="off" /> 
         </div> 
         <label id="QueryField001_Label" name="QueryField001_Label" class="control-label "> 类型 </label> 
         <div id="QueryField001_div" class="input-group default-width  col-md-12 " style="display: inline-table; vertical-align: middle;   "> 
	         <select class="form-control" id="QueryField001" name="QueryField001" tabindex="-1" style=" width:100%;height:100%;" >
	         	<option value="" selected="selected"></option>
	         	<option value="14">表单</option>
	         	<option value="15">逻辑服务</option>
	         	<option value="16">业务对象</option>
	         	<option value="17">协同流程</option>
	         </select>
         </div> 
         
         <button type="button" id="toolBarItem001" class="btn  btn-default toolBarItem" style=" " onclick="toolBarItem001onclick();"> 查询 </button>
          
         <script>
					function toolBarItem001onclick(){
						 $("#DataGrid002_table").bootstrapTable('refresh');
					}
		</script> 
		<button type="button" id="toolBarItem002" class="btn  btn-default toolBarItem" style=" " onclick="controlCondition();">重置</button>
			<script type="text/javascript">
				function controlCondition(){
					$(":input","#centerTable").not(':button,:submit,:reset').val('').removeAttr('checked').removeAttr('checked');
				}
			</script>
			<button type="button" id="toolBarItem0011" class="btn  btn-default toolBarItem" style=" " onclick="toolBarItem0011onclick();"> 导出 </button>
							<script>
							var uuids;
							function toolBarItem0011onclick(){
								 var selections = $("#DataGrid002_table").bootstrapTable('getSelections');
								 if(selections.length == 0){
									 layer.alert('请选择导出项！');
								 }else{
									 var uuidArray = new Array();
									 for(var i in selections){
										 var iuuid = selections[i].uuid;
										 uuidArray[i] = iuuid;
									 }
									 uuids = JSON.stringify(uuidArray);
									 layer.open({
									    	id:'layerNewsubdirectoryOut',
											type : 2,//iframe 层
											
											title : ['选择导出模式'],
											closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
											shadeClose: false, //开启遮罩关闭
											area : [ '50%', '50%' ],
											content : '<%=request.getContextPath() %>/form/html5/admin/catalog/selectType.jsp?flag=export&type=2&mode=list',
											//end	: function(){
												//$('#container').jstree(true).refresh_node(parentId);
											//}
									 });
								 }
							}
							</script>
							<button type="button" id="toolBarItem0021" class="btn  btn-default toolBarItem" style=" " onclick="toolBarItem0021onclick();"> 导入 </button>
							<script>
							function toolBarItem0021onclick(){
								layer.open({
							    	id:'layerNewsubdirectoryIn',
									type : 2,//iframe 层
									
									title : ['导入模式和导入文件'],
									closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
									shadeClose: false, //开启遮罩关闭
									area : [ '50%', '50%' ],
									content : '<%=request.getContextPath()%>/form/html5/admin/catalog/selectFile.jsp?contentFlag=contents&type=2&flag=import&mode=list',
									//end	: function(){
									//	$('#container').jstree(true).refresh_node(parentId);
									//}
								});
							}
							</script>
		<button type="button" id="toolBarItem003" class="btn  btn-default toolBarItem" style="float: right; " onclick="controlHiddentable();">
			<span class="glyphicon glyphicon-chevron-down" aria-hidden="true"></span>
		</button>
			<script type="text/javascript">
				function controlHiddentable(){
					$('#hiddenTable').slideToggle(200,function(){
						if($('#hiddenTable').is(':hidden')){
							$('#toolBarItem003 > span').attr("class", "glyphicon glyphicon-chevron-down");
//							$('#DataGrid002_table').height(100);
						$('#DataGrid002_table').bootstrapTable('resetView');
						}else{
							$('#toolBarItem003 > span').attr("class", "glyphicon glyphicon-chevron-up");
//							$('#DataGrid002_table').height(200);
//							$('#DataGrid002_table').bootstrapTable('resetView');
						}
					});
				}
			</script>
        </div> </td> 
      </tr> 
      <tr style="height:0px;">
      <td  colspan="2" style="border-top: 1px solid rgb(196, 196, 196);border-bottom: 1px solid rgb(196, 196, 196); background-color: white;">
	      <table style="display:none; width:100%;" id="hiddenTable" >
		      <tr style="height:0px;">
		      <td class="query_form_toolbar" colspan="2" width='60%'>
		      	<label id="QueryField004_Label" name="QueryField004_Label" class="control-label "> 创建人 </label> 
		         <div id="QueryField004_div" class="input-group default-width col-md-12 " style="display: inline-table; vertical-align: middle;  "> 
		          <input id="QueryField004Backup" type="text" class="form-control " style=" width:100%;height:100%;padding-left: 5px;" autocomplete="off" readonly="true" /> 
		          <input id="QueryField004" name="QueryField004" type="hidden" />
		          <span class="input-group-addon addon-udSelect udSelect" onclick="selectCreateUser();">
		          	<i class="fa fa-search" aria-hidden="true"></i>
		          </span>
		         </div>
		         <span class="udSelect" onclick="clearUsername('QueryField004');" >
		         	<i class="fa fa-times" ></i>
		         </span> 
		         &nbsp;
		         &nbsp;
		      	<label id="QueryField003_Label" name="QueryField003_Label" class="control-label "> 创建时间 </label> 
		         <label id="j_id0" name="j_id0" class="control-label "> &nbsp;从&nbsp; </label> 
		         <div id="QueryField003_div" class="date-default-width col-md-12  input-prepend input-group " style="display: inline-table; vertical-align: middle; "> 
		          <input id="QueryField003" name="QueryField003" class="form-control layer-date  " style="width:100%;height:100%;padding-left: 5px;" onclick="laydate({istime:false, format: 'YYYY-MM-DD'})" /> 
		          <span class="input-group-addon addon-udSelect udSelect" onclick="laydate({elem:'#QueryField003',istime:false, format: 'YYYY-MM-DD'})"> <i class="fa fa-calendar"></i> </span> 
		         </div> 
		         <label id="j_id1" name="j_id1" class="control-label "> &nbsp;至&nbsp; </label> 
		         <div id="QueryField003_IntervalBehind_div" class="date-default-width col-md-12  input-prepend input-group " style="display: inline-table; vertical-align: middle; "> 
		          <input id="QueryField003_IntervalBehind" name="QueryField003_IntervalBehind" class="form-control layer-date  " style="width:100%;height:100%;padding-left: 5px;" onclick="laydate({istime:false, format: 'YYYY-MM-DD'})" /> 
		          <span class="input-group-addon addon-udSelect udSelect" onclick="laydate({elem:'#QueryField003_IntervalBehind',istime:false, format: 'YYYY-MM-DD'})"> <i class="fa fa-calendar"></i> </span> 
		         </div>
		         </td >
		         <td rowspan="2" align="right">
		         </td>
		      </tr>
		      <tr style="height:0px;">
		      <td class="query_form_toolbar" colspan="2" width='60%'>
		      	<label id="QueryField0041_Label" name="QueryField0041_Label" class="control-label "> 修改人 </label> 
		         <div id="QueryField0041_div" class="input-group default-width col-md-12 " style="display: inline-table; vertical-align: middle;  "> 
		          <input id="QueryField0041Backup"  type="text" class="form-control " aria-label="Text input with segmented button dropdown" style=" width:100%;height:100%;padding-left: 5px;" autocomplete="off" readonly="true" /> 
		          <input id="QueryField0041" name="QueryField0041" type="hidden" />
		           <span class=" input-group-addon addon-udSelect udSelect" onclick="selectModifyUser();">
		          	<i class="fa fa-search" aria-hidden="true"></i>
		          </span> 
		          </div> 
		         </div>
		         <span class="udSelect" onclick="clearUsername('QueryField0041');" >
		         	<i class="fa fa-times" ></i>
		         </span> 
		         &nbsp;
		         &nbsp; 
		      	<label id="QueryField0031_Label" name="QueryField0031_Label" class="control-label "> 修改时间 </label> 
		         <label id="j_id01" name="j_id01" class="control-label "> &nbsp;从&nbsp; </label> 
		         <div id="QueryField0031_div" class="date-default-width col-md-12  input-prepend input-group " style="display: inline-table; vertical-align: middle; "> 
		          <input id="QueryField0031" name="QueryField0031" class="form-control layer-date  " style="width:100%;height:100%;padding-left: 5px;" onclick="laydate({istime:false, format: 'YYYY-MM-DD'})" /> 
		          <span class="input-group-addon addon-udSelect udSelect" onclick="laydate({elem:'#QueryField0031',istime:false, format: 'YYYY-MM-DD'})"> <i class="fa fa-calendar"></i> </span> 
		         </div> 
		         <label id="j_id11" name="j_id11" class="control-label "> &nbsp;至&nbsp; </label> 
		         <div id="QueryField0031_IntervalBehind_div" class="date-default-width col-md-12  input-prepend input-group " style="display: inline-table; vertical-align: middle; "> 
		          <input id="QueryField0031_IntervalBehind" name="QueryField0031_IntervalBehind" class="form-control layer-date  " style="width:100%;height:100%;padding-left: 5px;" onclick="laydate({istime:false, format: 'YYYY-MM-DD'})" /> 
		          <span class="input-group-addon addon-udSelect udSelect" onclick="laydate({elem:'#QueryField0031_IntervalBehind',istime:false, format: 'YYYY-MM-DD'})"> <i class="fa fa-calendar"></i> </span> 
		         </div> 
		         </td>
		      </tr>
		      <script>
		      	function selectCreateUser(){
		      		layer.open({
				    	id:'layerCreate',
						type : 2,//iframe 层 
						
						title : ['选择创建人'],
						closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
						shadeClose: false, //开启遮罩关闭
						area : [ '50%', '85%' ],
						content : '<%=request.getContextPath()%>/office/html5/select/SingleSelectPerson.jsp?iframewindowid=layerCreate',
					});
		      	}
		      	function selectModifyUser(){
		      		layer.open({
				    	id:'layerModify',
						type : 2,//iframe 层 
						
						title : ['选择修改人'],
						closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
						shadeClose: false, //开启遮罩关闭
						area : [ '50%', '85%' ],
						content : '<%=request.getContextPath()%>/office/html5/select/SingleSelectPerson.jsp?iframewindowid=layerModify',
					});
		      	}
		      	function onlayerCreateClose(data){
		      		if(data!=null){
		      		var names = data.names;
		      		var ids = data.ids;
		      		document.getElementById('QueryField004Backup').value=names;
		      		document.getElementById('QueryField004').value=ids;
		      		}else{
		      		//document.getElementById('input001').value='11';
		      		}
		      	}
		      	function onlayerModifyClose(data){
		      		if(data!=null){
		      		var names = data.names;
		      		var ids = data.ids;
		      		document.getElementById('QueryField0041Backup').value=names;
		      		document.getElementById('QueryField0041').value=ids;
		      		}else{
		      		//document.getElementById('input001').value='11';
		      		}
		      	}
		      	
		      	function clearUsername(username){
		      		if(username == "QueryField0041"){
			      		document.getElementById('QueryField0041Backup').value="";
			      		document.getElementById('QueryField0041').value="";
		      		}
		      		if(username == "QueryField004"){
		      			document.getElementById('QueryField004Backup').value="";
			      		document.getElementById('QueryField004').value="";
		      		}
		      	}
		      </script>
	      </table>
	      </td>
      </tr>
      <tr> 
       <td colspan="2" style="border-style:none;width:100%;margin:0px;padding:0px;vertical-align: top;"> 
        <table id="DataGrid002_table" style="width:100%;height:100%;"> 
        </table>
        <div>
         <input type="text" name="notautosubmit" style="display:none" /> <script>
					$(document).ready(
								function() {
								    $("#DataGrid002_table").bootstrapTable({
								        classes: 'table table-hover table-no-bordered',
								        method: "post",
								        url:"<%=path %>/html5Catalog_queryCatalog.action",
								        contentType: "application/x-www-form-urlencoded",
								        showToggle: false,
								        sortable: true,
								        striped: true,
								        height:$(window).height() - 60,
								        pagination: true,
								        pageSize: 20,
								        pageNumber: 1,
								        pageList: [10, 25, 50, 100],
								        search: false,
								        sidePagination: "server",
								        clickToSelect: true,
								        formatLoadingMessage: function() {
								            return '请稍等，正在加载中...';
								        },
								        formatNoMatches: function() {
								            return '无符合条件的记录';
								        },
								        showExport: true,
								        exportDataType: "basic",
								        queryParamsType: "limit",
								        queryParams: function queryParams(params) {
								            var param = {
								                pageNumber: params.offset,
								                pageSize: params.limit,
								                sort: params.sort,
								                order: params.order
								            };
								            param["QueryField002"] = document.getElementById('QueryField002').value;
								            param["QueryField001"] = document.getElementById('QueryField001').value;
								            param["QueryField003"] = document.getElementById('QueryField003').value;
								            param["QueryField004Backup"] = document.getElementById('QueryField004Backup').value;
								            var form = document.getElementById('form0');
								            var tagElements = form.getElementsByTagName('input');
								            for (var j = 0; j < tagElements.length; j++) {
								                param[tagElements[j].name] = tagElements[j].value;
								            };
								            return param;
								        },
								        columns: [{
								            title: "序号",
								            width: '8px',
								            valign: 'top',
								            checkbox: true,
								            formatter: function(value, row, index) {
								                var page = $("#DataGrid002_table").bootstrapTable("getPage");
								                return page.pageSize * (page.pageNumber - 1) + index + 1;
								            }
								        },
								        {
								            title: "编码",
								            field: "mid",
								            sortable: true,
								            clickToSelect: true,
								            editorType: 'Text',
								            type: 'text'
								        },
								        {
								            title: "名称",
								            field: "name",
								            sortable: true,
								            clickToSelect: true,
								            editorType: 'Text',
								            type: 'text'
								        },
								        {
								            title: "类型",
								            field: "type",
								            sortable: true,
								            clickToSelect: true,
								            editorType: 'Text',
								            type: 'text',
								            formatter: function(value, row, index) {
								            	switch (value) {
												case 14:
													return "表单";
												case 15:
													return "逻辑服务";
												case 16:
													return "业务对象";
												case 17:
													return "协同流程";
												}
								            }
								        },
								        {
								            title: "路径",
								            field: "entity",
//								            sortable: true,
								            clickToSelect: true,
								            editorType: 'Text',
								            type: 'text'
								        },
								        {
								            title: "创建时间",
								            field: "createdDate",
								            sortable: true,
								            clickToSelect: true,
								            editorType: 'DateItem',
								            type: 'date'
								        },
								        {
								            title: "创建人",
								            field: "createdUser",
								            sortable: true,
								            clickToSelect: true,
								            editorType: 'Text',
								            type: 'text'
								        },
								        {
								            title: "最后修改时间",
								            field: "lastModifyDate",
								            sortable: true,
								            clickToSelect: true,
								            editorType: 'DateItem',
								            type: 'date'
								        },
								        {
								            title: "最后修改人",
								            field: "lastModifyUser",
								            sortable: true,
								            clickToSelect: true,
								            editorType: 'Text',
								            type: 'text'
								        }],
								        singleSelect: false
								    });
								}); 
				</script>
				</div>
      </tr> 
     </tbody>
    </table> 
   </form> 
  </div>   
 </body>
</html>