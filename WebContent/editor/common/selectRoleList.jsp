<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%> 
<!DOCTYPE HTML >
<html>
<meta charset="UTF-8">
<head>
<jsp:include page="/form/html5/admin/html5Head.jsp"/>
<title>角色选择列表</title>
<script type="text/javascript">
	//点击选择
	function singleClickSelect(row, element){
		$('.changeColor').removeClass('changeColor');//去除之前选中的行的，选中样式
		$(element).addClass('changeColor');
	}
	
	//双击确认
	function doubleClickSelect(record){
		if(record!=null){
			Matrix.closeWindow(record);
		}else{
			Matrix.warn("请选择角色！");
		}
	}		
</script>
</head>
<body>
	<form id="Form0" name="Form0" method="post" action="" style="margin:0px;overflow:auto;height:100%;padding:5px" enctype="application/x-www-form-urlencoded">
		<div style="display: block">
			<table class="query_form_content" style="height:100%;width:100%;overflow:hidden;border-collapse: collapse;border-spacing:0px;table-layout:fixed;">
    			<tr style=" height: 0px">
					<td class="query_form_toolbar"icolspan="2" style="padding: 3px">
						<div style=";padding:4px;background: #f8f8f8;text-align: left;border: 1px solid #E6E9ED ">
							<label style="padding-left: 5px">角色名称:</label>
							<div style="padding-right: 5px;display: inline-block;vertical-align:middle;">
								<input class="form-control" type="text" style="" name="roleName" id="roleName" >
							</div>
							<div style="padding-right: 15px;display: inline-block;">
								<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/query.png">
								<input type="button" value="查询" class="btn  btn-default toolBarItem" id="roleNameText" style="padding:0px;margin:0px;border:0;background: transparent" onclick="$('#DataGrid001_table').bootstrapTable('refresh')">
							</div>
						</div>
					</td>
				</tr>
			</table>
   		</div>
		<div style="display: block">
			<table id="DataGrid001_table" style="width:100%;height:100%;">
					
			</table>
			
			<script>
			$(document).ready(function() {   
				$("#DataGrid001_table").bootstrapTable({           
					classes: 'table table-hover table-no-bordered',
					method: "post", 
					url: "<%=path%>/processVersion_getRoleList.action", 
					search: false, 
					sidePagination: "server",
					queryParams: function(params){
			        	var temp = {
			        		roleName : document.getElementById('roleName').value
			        	};
			        	return temp;
			        },
					formatLoadingMessage: function() {
			            return '请稍等，正在加载中...';
				    },
					formatNoMatches: function() {
			            return '无符合条件的记录';
			        },
				    columns: [
				        {title:"角色编码",field:"id",sortable:true,clickToSelect:true,editorType:'Text',type:'text',visible:false},
				        {title:"角色名称",field:"text",sortable:true,clickToSelect:true,editorType:'Text',type:'text'}
				    ],
				    singleSelect:true,
				    onClickRow:function(row, $element){   //单击行事件
				    	singleClickSelect(row, $element);
					},
				    onDblClickRow:function(row){   //双击行事件
				    	doubleClickSelect(row);
					},
				});
		     });
			</script>
       	</div>
    	<div style="display: block">
    		<table class="query_form_content" style="height:100%;width:100%;overflow:hidden;border-collapse: collapse;border-spacing:0px;table-layout:fixed;">
	    		<tr>
	    			<td class="cmdLayout">
						<input type="button" class="x-btn ok-btn" name="确定" value="确定" id="submit" >
						<input type="button" class="x-btn cancel-btn" name="取消" value="取消" id="btn" >
						<script type="text/javascript">
					        $(".ok-btn").on("click",function(){
					        	 var $tr = $('#DataGrid001_table').find('tr.changeColor');   //选中行
					        	 
					     		 if($tr!=null && $tr.length==1){
					     			var index = $tr.data('index');  //获得选中的行的index
						        	var item = Matrix.getGridData('DataGrid001');   //所有数据
						        	var record = item[index];  //当前选中行
					     			Matrix.closeWindow(record);
					     		 }else{
					     			 var data = {};
						       		 data.id = "";
						       		 data.text = "";
						  	    	 Matrix.closeWindow(data);
					     		 }			 
					        });
					        
					        $(".cancel-btn").on("click",function(){
					        	Matrix.closeWindow();
					        })
						</script>
					</td>
				</tr>
			</table>
       	</div>
	</form>
</body>
</html>