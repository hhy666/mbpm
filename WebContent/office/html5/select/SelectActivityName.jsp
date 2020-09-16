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
<body style="overflow:auto;">

<table class="query_form_content" style="height:100%;width:100%;overflow:hidden;border-collapse: collapse;border-spacing:0px;table-layout:fixed;">
<tr>
	<td colspan="2" style="border-style:none;width:100%;margin:0px;padding:0px;vertical-align: top;">
		<table id="DataGrid001_table" style="width:100%;height:100%;">
		</table>

		<script>
		$(document).ready(function() {   
			$("#DataGrid001_table").bootstrapTable({           
				classes: 'table table-hover table-no-bordered',
				method: "post", 
				url: "<%=path%>/select/SelectAction_getActivityName.action?piid=${param.piid}&adid=${param.adid}", 
				search: false, sidePagination: "server", clickToSelect: true, 
				formatLoadingMessage: function() {
		            return '请稍等，正在加载中...';
			    },
				formatNoMatches: function() {
		            return '无符合条件的记录';
		        },
			    columns: [{checkbox:true},
			        {
						title:'&nbsp;',
						formatter: function (value, row, index) {  
                            return index+1;  
                        }  
					},
			        {title:"活动编码",field:"adid",sortable:true,clickToSelect:true,editorType:'Text',type:'text'},
			        {title:"活动名称",field:"activityName",sortable:true,clickToSelect:true,editorType:'Text',type:'text'}
			    ],
			    singleSelect:true });
			  });
		</script>
</tr>
<tr>
		<td class="" colspan="2" style="height:40px;width:100%;">
		</td>
</tr>		
<tr>
		<td class="cmdLayout" colspan="2" style="text-align:center;">
			<input type="button" class="x-btn ok-btn" name="确定" value="确定" id="submit" >
			<input type="button" class="x-btn cancel-btn" name="取消" value="取消" id="btn" >
			<script type="text/javascript">
	
        $(".ok-btn").on("click",function(){
        	 var selections = $('#DataGrid001_table').bootstrapTable('getSelections');
        	 if(selections!=null && selections.length>0){
        		layer.confirm('确认回退?', {
     		    	btn: ['确认','取消'] //按钮
     		    }, function(index){ 		    	
     		    	var data = {};
		           	data.adid=selections[0].adid;
		           	data.activityName=selections[0].activityName;	
		           	Matrix.closeLayerWindow(data);
     		        //layer.close(index);
     		    });
        	 }else{
        		 layer.msg("请选择回退环节！");
        	 }
        	
        });
        
        $(".cancel-btn").on("click",function(){
        	Matrix.closeLayerWindow();
        })
</script>
		</td>
</tr>
</table>

</body>
</html>