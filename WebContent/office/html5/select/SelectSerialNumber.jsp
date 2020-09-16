<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>选择流水号</title>
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
			var prefixName="getNextSeqNo({流水号";
	       	prefixName=prefixName+"(";
	       	prefixName=prefixName+record.name;
	       	prefixName=prefixName+")})"
	       	 
	       	var id = record.id;
	       	var data = {};
	       	data.name=prefixName;
	       	data.id = id
			Matrix.closeWindow(data);
		}else{
			Matrix.warn("请选择流水号！");
		}
	}	
	//模糊查询
	function searchSelect(){
		var code = document.getElementById('code').value;
		var name = document.getElementById('name').value;
		var templateClass = "${param.templateClass}";
		var mid = "${param.mid}";
		$.ajax({ 
			 url: '<%=path%>/select/SelectAction_getSerialNumber.action?templateClass='+templateClass+'&mid='+mid+'&code='+code+'&name='+name,
	         type: "post", 
	         dataType: "json", 
	         success: function(data){ 
	        	 $("#DataGrid001_table").bootstrapTable('load', data);
             } 
         });
	
	}
</script>
</head>
<body style="overflow:auto;">
 <div style="height:10px;margin-top:0px;">
    <form id="formSearch" class="form-horizontal" method="post">
           <div class="form-group">
                        <label class="control-label col-sm-1" for="txt_search_departmentname">编码</label>
                        <div class="col-sm-3">
                            <input type="text" class="form-control" id="code">
                        </div>
                        <label class="control-label col-sm-1" for="txt_search_statu">名称</label>
                        <div class="col-sm-3" style="padding-right:0px;">
                            <input type="text" class="form-control" id="name">
                        </div>
                       <div class="col-sm-4" style="padding-left:0px;">
                           <span class="input-group-addon addon-udSelect udSelect" onclick="searchSelect()" style="border:0px;height:34px;width:30px;"><i class="fa fa-search"></i></span>
                        </div>
          </div>
    </form>
  </div>
      
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
				url: "<%=path%>/select/SelectAction_getSerialNumber.action?templateClass=${param.templateClass}&mid=${param.mid}", 
				search: false, 
				sidePagination: "server",
				formatLoadingMessage: function() {
		            return '请稍等，正在加载中...';
			    },
				formatNoMatches: function() {
		            return '无符合条件的记录';
		        },
			    columns: [
			        {title:"编码",field:"id",sortable:true,clickToSelect:true,editorType:'Text',type:'text'},
					{title:"名称",field:"name",sortable:true,clickToSelect:true,editorType:'Text',type:'text'},
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
	<td class="cmdLayout" colspan="2">
					<input type="button" class="x-btn ok-btn" id="btn-primary" name="确定" value="确定" id="submit" >
					<input type="button" class="x-btn cancel-btn" name="取消" value="取消" id="btn" >
					<script type="text/javascript">
						$("#btn-primary").on("click",function(){
				        	 var $tr = $('#DataGrid001_table').find('tr.changeColor');   //选中行
				        	 
				     		 if($tr!=null && $tr.length==1){
				     			var index = $tr.data('index');  //获得选中的行的index
					        	var item = Matrix.getGridData('DataGrid001');   //所有数据
					        	var record = item[index];  //当前选中行
				     		
				     			 var prefixName="getNextSeqNo({流水号";
				            	 prefixName=prefixName+"(";
				            	 prefixName=prefixName+record.name;
				            	 prefixName=prefixName+")})"
				            	 
				            	 var id = record.id;
				            	 var data = {};
				            	 data.name=prefixName;
				            	 data.id = id
				          		 Matrix.closeLayerWindow(data);
				     		 }else{
				     			Matrix.warn("请选择流水号！");
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