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
    
    <title>My JSP 'testtable.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<link rel="stylesheet" href="<%=path %>/office/html5/assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=path %>/office/html5/assets/bootstrap-table/src/bootstrap-table.css">
   
    <link rel="stylesheet" href="<%=path %>/office/html5/assets/examples.css">
    <script src="<%=path %>/office/html5/assets/jquery.min.js"></script>
    <script src="<%=path %>/office/html5/assets/bootstrap/js/bootstrap.min.js"></script>
 <script src="<%=path %>/office/html5/assets/bootstrap-table/src/bootstrap-table.js"></script>
 <script src="<%=path %>/office/html5/assets/ga.js"></script>
  
 
  
<table id="cusTable"  >  
      
     
</table>  
 
  <script type="text/javascript">            
      function initTable() {  
        //先销毁表格  
        $('#cusTable').bootstrapTable('destroy');  
              //初始化表格,动态从服务器加载数据  
        $("#cusTable").bootstrapTable({  
          classes: 'table table-hover',
            method: "get",  //使用get请求到服务器获取数据  
            url: "<%=path %>/select/SelectAction_getPerson4Page.action", 
            showToggle: true,
            showColumns: true,
            singleSelect:true,
            sortable:true,
            height:$(window).height()-100,
            showPaginationSwitch:true,                                        
            toolbar:'#toolbar',
            striped: true,  //表格显示条纹  
            pagination: true, //启动分页  
            pageSize: 10,  //每页显示的记录数  
            pageNumber:1, //当前第几页  
            pageList: [5, 10, 15, 20, 25],  //记录数可选列表  
            search: false,  //是否启用查询  
            showColumns: true,  //显示下拉框勾选要显示的列  
            showRefresh: true,  //显示刷新按钮  
            sidePagination: "server", //表示服务端请求  
            clickToSelect: true, //是否启用点击选中行
            showExport: true,                     //是否显示导出
            exportDataType: "basic",
            //设置为undefined可以获取pageNumber，pageSize，searchText，sortName，sortOrder  
            //设置为limit可以获取limit, offset, search, sort, order  
            queryParamsType : "limit",   
            queryParams: function queryParams(params) {   //设置查询参数  
              var param = {    
                  pageNumber: params.offset,
                          pageSize: params.limit,
                  orderNum : $("#orderNum").val()  
              };    
              return param;                   
            },
              columns: [
              {
                    checkbox:true,
                  
                },
              {
                    field: 'userId',
                    title: 'userId',
                    align: 'center',  //单元格水平居中
                    hlign:'center',   //单元格标题头的水平居中
                   sortable:true,
                }, {
                    field: 'userName',
                    title: '测试标识',
                    align: 'center',
                     sortable:true,
                     order:'desc'
                },{
                    field: 'action',
                    title: '操作',
                    align: 'center',
                    formatter:function(value,row,index){
                        //通过formatter可以自定义列显示的内容
                        //value：当前field的值，即id
                        //row：当前行的数据
                        var a = '<a href="" >测试</a>';
                        return a;
                    }} ,
                     {
                  
                    title: '数据项1',
                    align: 'center',  //单元格水平居中
                    hlign:'center',   //单元格标题头的水平居中
                 
                }
                ],  
            onLoadSuccess: function(){  //加载成功时执行  
              
            },  
            onLoadError: function(){  //加载失败时执行  
              alert("加载数据失败", {time : 1500, icon : 2});  
            }  
          });  
      }  

      $(document).ready(function () {          
          //调用函数，初始化表格  
          initTable();  
  
      });  
</script>  
  </body>
</html>
