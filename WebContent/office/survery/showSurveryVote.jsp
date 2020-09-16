<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="/form/html5/admin/html5Head.jsp"%>
</head>
<style>
	#DataGrid001_table th{
		background-color:rgb(181, 219, 235);
	}
</style>
<script type='text/javascript' src="<%=path%>/js/office.js"></script>
<script>
	function searchSelect(){
		$('#DataGrid001_table').bootstrapTable('refreshOptions',{pageNumber:1});
		Matrix.refreshDataGridData('DataGrid001');
	}
	
	function showNotVote(){
		var invesInfoId = document.getElementById('invesInfoId').value;
		var url = "<%=path%>/investigation/investigation_showNotVote.action?invesInfoId="+invesInfoId;
		Matrix.sendRequest(url,null,function(data){
			 if(data!=null){
				 var str = data.data;
				 layer.open({
				    	id:'layer01',
						type : 2,
						
						title : ['查看未投票人'],
						shadeClose: false, //开启遮罩关闭
						area : [ '60%', '80%' ],
						content : "<%=path%>/office/survery/showNotVote.jsp?iframewindowid=layer01&userStr="+encodeURI(str)
					});
			 }
	  });
	
	}
	
	function lookVoteByUserId(userId){
		  var invesInfoId = document.getElementById('invesInfoId').value; 
		  var url = "<%=path%>/office/survery/QuestionsList.jsp?invesInfoId="+invesInfoId+"&userId="+userId+"&infoRes=1";
		  openCtpWindow({'url':url,'title':'调查问卷'});

   }
</script>
<body style="overflow:auto;">
 <div style="height:10px;margin-top:0px;">
    <form id="formSearch" class="form-horizontal" method="post">
           <div class="form-group">
                        <label class="control-label col-sm-1" for="txt_search_departmentname">姓名</label>
                        <div class="col-sm-3">
                            <input type="text" class="form-control" id="userName">
                        </div>
                        <label class="control-label col-sm-1" for="txt_search_statu">部门</label>
                        <div class="col-sm-3">
                            <input type="text" class="form-control" id="depName">
                        </div>
                       <div class="col-sm-4" style="text-align:left;">
                            <button type="button" id="btn_query" class="x-btn ok-btn" onclick="searchSelect();">查询</button>
                             <input type="button" value="查看未投票人" onclick="showNotVote();"/>
                        </div>
          </div>
          <input type="hidden" id="invesInfoId" name="invesInfoId" value="${param.invesInfoId}"/>
    </form>
    
  </div>
                   
 
  <table class="query_form_content" style="height:100%;width:100%;overflow:hidden;border-collapse: collapse;border-spacing:0px;table-layout:fixed;">
	<tr>
		<td colspan="2" style="border-style:none;width:100%;margin:0px;padding:0px;vertical-align: top;">
			<table id="DataGrid001_table" style="width:100%;height:100%;">
			</table>
			
			<script> 
			$(document).ready(function(){ 
				var invesInfoId = "${param.invesInfoId}";  //调查主键
				$("#DataGrid001_table").bootstrapTable({           
					classes: 'table table-hover table-no-bordered',
					method: "post", 
					contentType: "application/x-www-form-urlencoded",
					url: "<%=path%>/investigation/investigation_showSurveryVote.action?invesInfoId="+invesInfoId, 
					search: false, 
					clickToSelect: true,
					sortable: false, 
					pagination:true,//是否分页
					sidePagination:'server',//指定服务器端分页
					pageNumber: 1, //初始化加载第一页，默认第一页
				    pageSize:10,//单页记录数
					pageList:[10,20,30,40], //分页步进值
					queryParams: function (params) {//自定义参数，这里的参数是传给后台的，我这是是分页用的  
			            return {//这里的params是table提供的  
			            	offset: params.offset,//从数据库第几条记录开始查
	                        limit: params.limit,//找多少条   	
	                        userName:$('#userName').val(),
	                        depName:$('#depName').val()
			            };  
			        },  
					//showColumns:true,
					//得到查询的参数
					formatLoadingMessage: function() {
			            return '请稍等，正在加载中...';
				    },
					formatNoMatches: function() {
			            return '无符合条件的记录';
			        },
				    columns: [
						{
							title:'&nbsp;',
							 formatter: function (value, row, index) { 
								var pageSize = $("#DataGrid001_table").bootstrapTable('getOptions').pageSize;
								var pageNumber = $("#DataGrid001_table").bootstrapTable('getOptions').pageNumber;
						        return pageSize * (pageNumber - 1) + index + 1;  
						     }
						},
				        {title:"姓名",field:"userName",sortable:true,clickToSelect:true,editorType:'Text',type:'text'},
				    	{title:"所属部门",field:"depName",sortable:true,clickToSelect:true,editorType:'Text',type:'text'},
				    	{title:"投票时间",field:"joinDate",sortable:true,clickToSelect:true,editorType:'Text',type:'text'},
				    	{title: "操作",field: "operate",align:"center",valign:"middle",formatter:operateFormatter}
				    ],
				  });
				 function operateFormatter (value, row, index) {
					    var userId = row.userId;
					    var result = "";
					    result += "<a onclick=\"lookVoteByUserId('" + userId + "', view='view')\" title='查看投票详情'>投票详情</a>";
					    return result;
		          } ;

			 });
			</script>
	</tr>
 </table>
</body>
</html>