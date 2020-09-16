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
	<title>H5数据唯一列表</title>
	<%@ include file="/form/html5/admin/html5Head.jsp"%>
	<style type="text/css">
		div{
			box-sizing: border-box;
			-webkit-user-select: none;
		    -khtml-user-select: none;
		    -moz-user-select: none;
		    -ms-user-select: none;
		    -o-user-select: none;
		    user-select: none;
		}
	</style>
</head>
<body>
	<div style="position: absolute;height: 100%;width: 100%;">
	   <form id="form0" name="form0" eventProxy="Mform0" method="post" action="" style="margin: 0px; position: relative; overflow: hidden; width: 100%; height: 100%;overflow: auto;" enctype="application/x-www-form-urlencoded">
		 <input type="hidden" name="form0" value="form0" />
		 <input type="hidden" id="unionPKText" name="unionPKText" value="${param.unionPKText}"/>
		 <div style="height:calc(100% - 54px);overflow: auto;">
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
								contentType : "application/x-www-form-urlencoded",  //必须配置 不然queryParams传参后台获取不到
								url: "<%=path%>/union/un_getH5UnionPk.action", 
								search: false,    //是否启用搜索框
								sortable: false,  //是否启用排序
								pagination:false, //是否启用分页
								sidePagination: "server",  //指定服务器端分页
								queryParams: queryParams,   //传参
								formatLoadingMessage: function() {
						            return '请稍等，正在加载中...';
							    },
								formatNoMatches: function() {
						            return '无符合条件的记录';
						        },
							    columns: [							       
								   {
							         title : '序号',
							         align: "center",
							         width: 50,
							         formatter: function (value, row, index) {
							        	  //获取每页显示的数量
							        	  var pageSize=$('#DataGrid001_table').bootstrapTable('getOptions').pageSize;  
							        	  //获取当前是第几页  
							        	  var pageNumber=$('#DataGrid001_table').bootstrapTable('getOptions').pageNumber;
							        	  //返回序号，注意index是从0开始的，所以要加上1
							        	  return pageSize * (pageNumber - 1) + index + 1;
							          }				 
								    },            
							        {title:"编码",field:"propertyId",sortable:true,clickToSelect:true,editorType:'Text',type:'text',visible:false},
							        {title:"表单数据",field:"formData",sortable:true,clickToSelect:true,editorType:'Text',type:'text'},
							        {
								      checkbox:true,
								      width: 50,
								      formatter: function (value, row, index) {
							    		 if (row.check == "true"){
							    			return {
							    	           checked : true	//设置选中
							    	        };
							        	 }else{
							        		return {
							    	           checked : false   //不选中
							    	        };
							        	 }
								      }
								    },
							    ],
							    singleSelect:false,  //多选
							    clickToSelect:true,  //设置true将在点击行时自动选择checkbox
							});
					     });
						
						 function queryParams(params) {
						      var temp = {   
						    	  unionPKText: $("#unionPKText").val()						        
						      };
						      return temp;
						 };
						</script>
					</td>
				</tr>
				<tr>
						<td class="" colspan="2" style="height:20px;width:100%;">
						</td>
				</tr>		
	   	 </table>
	   	</div>
	   	<div class="cmdLayout">
			<input type="button" class="x-btn ok-btn" name="确定" value="确定" id="submit" >
			<input type="button" class="x-btn cancel-btn" name="取消" value="取消" id="btn" >
			<script type="text/javascript">
		        $(".ok-btn").on("click",function(){
		    		var unionPKText;
		    		var unionPKValue;
		    		var selections = $('#DataGrid001_table').bootstrapTable('getSelections');
		    		if (selections != null && selections.length > 0) {
		    			for ( var j = 0; j < selections.length; j++) {
		    				var record = selections[j];
		    				if(j==0){
			    				unionPKText="{"+record.formData+"}";
			    				unionPKValue=record.propertyId;
		    				}else{
			    				unionPKText+="{"+record.formData+"}";
			    				unionPKValue+=record.propertyId;
		    				}
		    				var p1 = record.propertyId.split(".");
		    				var p2;
		    				if(j!=selections.length-1){p2=selections[j+1].propertyId.split(".")}
		    				if((j!=selections.length-1)&&p1[0]!=p2[0]){
		    						unionPKText+=" ";
		    						unionPKValue+=" ";
		    				}else{
		    					if(j!=selections.length-1){
		    						unionPKText+=",";
		    						unionPKValue+=",";
		    					}
		    				}
		    			}
		    			var data='{\"unionPKText\":\"';
		    			data+=unionPKText;
		    			data+='\",\"unionPKValue\":\"';
		    			data+=unionPKValue;
		    			data+='\"}';
	    				var json = eval("("+data+")");
		    			Matrix.closeWindow(json);
		    		} else {
		    			var data = {};
		    			data.unionPKText = "";
		    			data.unionPKValue = "";
		    			Matrix.closeWindow(data);
		    		}					        	
		        });
		        
		        $(".cancel-btn").on("click",function(){
		        	Matrix.closeWindow();
		        })
			</script>
		</div>
	   </form>
	  </div>
	</body>
</html>
