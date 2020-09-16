<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%> 
<html>
<head>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>授权信息</title>
		<%@ include file="/form/html5/admin/html5Head.jsp"%>
		<script type="text/javascript">
			function doubleClickSelect(record){
				if(record!=null){
					Matrix.closeWindow(record);
				}else{
					Matrix.warn("请选择授权信息！");
				}
			}
		
		</script>
</head>	

<body style="overflow: auto;">

<div id="j_id1" jsId="j_id1" style="position: relative; _layout: flowlayout; width: 100%; height: 100%">
 <form id="Form0" name="Form0" eventProxy="MForm0" method="post" action="" style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="Form0" value="Form0"/>
	<input name="version" id="version" type="hidden"/>
	<input name="processType" id="processType" type="hidden" value="${param.processType}"/>
	<input name="flag" id="flag" type="hidden" value="${param.flag}"/>
	<table class="query_form_content" style="height:100%;width:100%;overflow:hidden;border-collapse: collapse;border-spacing:0px;table-layout:fixed;">
		<tr>
			<td colspan="2" style="border-style:none;width:100%;margin:0px;padding:0px;vertical-align: top;">
				<table id="DataGrid001_table" style="width:100%;height:100%;">
					
				</table>
				
				<script>
				$(document).ready(function() {   
					var processType = $('#processType').val();
					$("#DataGrid001_table").bootstrapTable({           
						classes: 'table table-hover table-no-bordered',
						method: "post", 
						url: "<%=path%>/mobile/flowEdit_loadNodeAuthList.action?processType="+processType+"", 
						search: false, sidePagination: "server", clickToSelect: true,  
					    columns: [{checkbox:true},
					        //{title:"编码",field:"uuid",sortable:true,clickToSelect:true,editorType:'Text',type:'text',visible:false},
					        {title:"名称",field:"groupName",sortable:true,clickToSelect:true,editorType:'Text',type:'text'}
					    ],
					    singleSelect:true,
					    onDblClickRow:function(row){   //双击行事件
					    	doubleClickSelect(row);
						},
					});
			     });
				</script>
			</td>
		</tr>
		<tr>
				<td class="" colspan="2" style="height:54px;width:100%;">
				</td>
		</tr>		
		<tr>
				<td class="cmdLayout" colspan="2">
					<input type="button" class="x-btn ok-btn" name="确定" value="确定" id="submit" >
					<input type="button" class="x-btn cancel-btn" name="取消" value="取消" id="btn" >
					<script type="text/javascript">
				        $(".ok-btn").on("click",function(){
				        	 var select = Matrix.getGridSelections("DataGrid001");
				     		 if(select!=null&&select.length==1){
				     			Matrix.closeWindow(select[0]);
				     		 }else{
				     			//Matrix.warn("请选择授权信息！");
				     			var data = {};
				     			data.uuid = "";
				     			data.groupName = "";
				     			
				     			var flag = $('#flag').val();
				     			if(flag == 'false'){   //非H5页面弹出
				     				parent.onpopupSelectDialogSecClose(data);
				     				var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
				     				parent.layer.close(index);
				     			}else{
				     				Matrix.closeWindow(data);
				     			}
				     			
				     		 }
				        });
				        
				        $(".cancel-btn").on("click",function(){
				        	if(flag == 'false'){   //非H5页面弹出
				        		var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
				    			parent.layer.close(index);
			     			}else{
			     				Matrix.closeWindow();
			     			}
				        })
					</script>
				</td>
		</tr>
   </table>
</form>
</div>
</body>
</html>