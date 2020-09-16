<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML >
<html>
<head>
	<meta charset="UTF-8">
	<title>表单变量域</title>
	<%@ include file="/form/html5/admin/html5Head.jsp"%>
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
				Matrix.warn("请选择表单变量域！");
			}
		}
	</script>
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
					url: "<%=path%>/select/SelectAction_getFormVariable.action?flag=${param.flag}", 
					search: false, 
					sidePagination: "server",
				    columns: [
				        {title:"编码",field:"opid",sortable:true,clickToSelect:true,editorType:'Text',type:'text',visible:false},
				        {title:"表单变量域",field:"formvariable",sortable:true,clickToSelect:true,editorType:'Text',type:'text'}
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
	</tr>
	<tr>
			<td class="" colspan="2" style="height:40px;width:100%;">
			</td>
	</tr>		
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
			     			Matrix.warn("请选择表单变量域！");
			     		 }
			        });
			        
			        $(".cancel-btn").on("click",function(){
			        	Matrix.closeWindow();
			        })
				</script>
			</td>
	</tr>
	</table>
</body>
</html>