<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
basePath = path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'testdatatable.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

	<!-- include the minified jstree source -->
	<!-- 包含tab标签的切换bootstrap.js -->
		
	 <link href="<%=path %>/css/bootstrap.min.css" rel="stylesheet">
	 
	 <link href="<%=path %>/resource/html5/css/flat/blue.css" rel="stylesheet">
	
	<link
		href="<%=path %>/css/datatables.net-bs/css/dataTables.bootstrap.min.css"
		rel="stylesheet">
	<link
		href="<%=path %>/css/datatables.net-scroller-bs/css/scroller.bootstrap.min.css"
		rel="stylesheet">
		  <link href="<%=path %>/css/custom.min.css" rel="stylesheet">
		 <script src="<%=path %>/resource/html5/js/jquery.min.js"></script>
	 <script src="<%=path %>/resource/html5/js/bootstrap.min.js"></script>
		<script src="<%=path %>/office/html5/datatable/js/fastclick.js"></script>
	<!-- NProgress -->
	<script src="<%=path %>/office/html5/datatable/js/nprogress.js"></script>
	<!-- iCheck -->
	<script src="<%=path %>/office/html5/datatable/iCheck/icheck.min.js"></script>
		<script src="<%=path %>/office/html5/datatable/js/jquery.dataTables.js"></script>
	    <script	src="<%=path %>/office/html5/datatable/js/dataTables.bootstrap.js"></script>
	<script
		src="<%=path %>/office/html5/datatable/js/dataTables.scroller.min.js"></script>
	<script src="<%=path %>/resource/html5/js/custom.min.js"></script>	

  </head>
  
  <body style="background:#ffffff">
  <table id="datatable"
											class="table table-striped table-bordered jambo_table bulk_action">
											<thead>
												<tr class="headings" style="/*display:none*/">
													<th><input type="checkbox" id="check-all" class="flat">
													</th>
												<th>序号</th>
													<th>id</th>
													<th>name</th>
													 <th>操作</th> 
												</tr>
											</thead>
										</table>
										<style>
										.paging_full_numbers {
										    width: 600px;
										 }
										 .row {
										    margin-right: 0px; 
										    margin-left: 0px; 
										}
										</style>
  <script>
		var t=$(document).ready(function() {
			$('#datatable').dataTable({
		       "bStateSave" : false,  
            "bJQueryUI" : true,  
            "bPaginate" : true,// 分页按钮  
            "bFilter" : false,// 搜索栏  
            "iDisplayStart": 0,
            "iDisplayLength" : 5,// 每页显示行数  
            "bSort" : true,// 排序  
            "bInfo" : true,// Showing 1 to 10 of 23 entries 总记录数没也显示多少等信息  
            "bAutoWidth": false,
            "bScrollCollapse" : true,  
            "sPaginationType" : "full_numbers", // 分页，一共两种样式full_numbers, 另一种为two_button // 是datatables默认  
            "bProcessing" : true,  
            "bServerSide" : true,  
            "bDestroy" : true,  
             "bLengthChange": true,         //是否允许用户自定义每页显示条数。 
            "bSortCellsTop" : true,  
            "sAjaxSource" : "<%=path %>/select/SelectAction_getPerson4Page.action",  
            "sScrollY": "100%",  
         //   "bAutoWidth": false,
            "fnInitComplete": function() {  
                this.fnAdjustColumnSizing(true);  
             },  
            "fnServerParams" : function(aoData) {  
             return aoData;
            }, 
            "language": {
           'lengthMenu': '每页显示 _MENU_ 记录', 
'zeroRecords': '没有数据 - 抱歉', 
          'info': ' 第_PAGE_ 页/共 _PAGES_页 共_TOTAL_条记录', 
          'infoEmpty': '没有符合条件的记录', 
'search': '查找', 
         'infoFiltered': '(从  _MAX_ 条记录中过滤)', 
'paginate': { "first":  "<<", "last": ">>", "next": ">","previous": "<"} 

       },
        "aoColumns": [  {
				      "mDataProp": null,
				      "defaultContent": '<input type="checkbox" class="icheckbox_flat-blue" name="table_records">',
				"width": "6%",
				  'sClass': "text-center"
				    },{
				    "mDataProp":null,
				"width": "8%",
				"bSortable" : false,
				    'sClass': "text-center"
				    },
				             {"mDataProp":"userId","bSortable" : true,"width": "40%"},
				             {"mDataProp":"userName","bSortable" : true,"width": "40%"},
				             { "mDataProp": "userId","width": "6%","bSortable" : false}
				             ], 
				              "aaSorting": [[2, "desc"],[3, "asc"]],//默认的排序//从第0列开始，第2列倒序排序
	 
            "aoColumnDefs": [
                 {
                     "aTargets": [4],
                     "mData": "操作",
                     "width": "6%",
                     "mRender": function (data, type, full) {
                         return '<a href="javascript:void(0);" class="delete" tag=' + data + '>删除</a>';
                     }
                 },
                 {
            "searchable": false,
            "orderable": false,
            "targets": 0
        } 
                ],
                             "fnRowCallback" : function(nRow, aData, iDisplayIndex) {//相当于对字段格式化  
                if (aData["name"] == '李璐丰') {  
                    $('td:eq(2)', nRow).html("结束");  
                } else if (aData["name"] == 1) {  
                    $('td:eq(2)', nRow).html("进行中");  
                } else if (aData["name"] == 2) {  
                    $('td:eq(2)', nRow).html("完成");  
                } else if (aData["name"] == 3) {  
                    $('td:eq(2)', nRow).html("驳回");  
                }  
            },  
            "fnDrawCallback": function ( oSettings ) {
	             for ( var i=0, iLen=oSettings.aiDisplay.length ; i<iLen ; i++ ){
	            $('td:eq(1)', oSettings.aoData[ oSettings.aiDisplay[i] ].nTr ).html(oSettings. _iDisplayStart+i+1 );
	            }
	            var oTable = $('#datatable').dataTable();
           $('#redirect').keyup(function(e){
               if(e.keyCode==13){
               
if($(this).val() && $(this).val()>0){
                   var redirectpage = $(this).val()-1;
               }else{
                   var redirectpage = 0;
               }
               oTable.fnPageChange( redirectpage );
               }
           });  
     
            }, 
		    "fnServerData" : function(sSource, aoData, fnCallback) {  
                $.ajax({  
                    "type" : 'get',  
                    "url" : sSource,  
                    "dataType" : "json",  
                    "data" : {  
                        aoData : JSON.stringify(aoData)  
                    },  
                    "success" : function(resp) {  
                        fnCallback(resp);  
                    }  
                });  
            },
             "dom": '<<t>lfip>'
		
			});
			
			$('#datatable tbody').on( 'click', 'tr', function () {
		        $(this).toggleClass('selected');
		    } );
		   
		});
		
	</script>
  </body>
</html>
