<%@page pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML>
<html>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<head>
<jsp:include page="/form/html5/admin/html5Head.jsp"/>
<script>
	function deleteAuth(){
		var select = Matrix.getGridSelection('DataGrid001');
		if(select!=null&&select.length>0){
			Matrix.confirm('确认要删除么？',function(value){
				if(!value){
					var newdata = "";
					for(var i=0;i<select.length;i++){
						if(i!=select.length-1){
							newdata += select[i].uuid;
							newdata += ',';
						}else{
							newdata += select[i].uuid;
						}
					}
					newdata = "{'uuids':'"+ newdata +"'}";
					var json = isc.JSON.decode(newdata);
					var url = "<%=path%>/portal/portalAction_deleteAuth.action";
					Matrix.sendRequest(url,json,function(data){
						var jsonResult = isc.JSON.decode(data.data);
						if(jsonResult.result == true){
		      				Matrix.refreshDataGridData("DataGrid001");
	      				}else{
	      					Matrix.warn("删除未成功!");
	      				}
					});
				}
			});
		}else{
			Matrix.warn('请先选中权限!');
		}
	}
	
	function selectAuth(){
			layer.open({
			type:2,
			title:['选择管理员'],
			area:['1000px','550px'],
			content:'<%=path%>/portal/portalAction_selectAuth.action?iframewindowid=SelectAuth'
		});
	}
	
	function onSelectAuthClose(data){
		if(data!=null){
			var portaluuid = document.getElementById('portaluuid').value;
			data.portaluuid = portaluuid;
			//var synJson = isc.JSON.encode(data);
			var jsonStr = JSON.stringify(data);
			var synJson = {'data':jsonStr};
			//var synJson = isc.JSON.decode(str);
			var url = '<%=path%>/portal/portalAction_saveAuth0.action';
		         Matrix.sendRequest(url,synJson,function(result){
		         	var dataStr = result.data;
		         	if(dataStr!=null){
		         		var dataJson = isc.JSON.decode(dataStr);
		         		if(dataJson.message==true){
		        			Matrix.refreshDataGridData('DataGrid001');
		         		}else{
		         			Matrix.warn('添加失败');
		         		}
		         	}
		         
		         });
		}
	}
</script>
</head>
	<body>
		<div style="width: 100%; height: 100%; overflow: auto; position: relative;">
		    <form id="form0" name="form0" eventProxy="Mform0" method="post" action="<%=request.getContextPath()%>/portal/portalAction_authList.action" style="margin: 0px; position: relative; overflow: hidden; width: 100%; height: 100%;padding: 10px" enctype="application/x-www-form-urlencoded">
		        <input type="hidden" name="form0" value="form0" />
		        <input type="hidden" id="matrix_form_datagrid_form0" name="matrix_form_datagrid_form0" value="" />
		        <input type="hidden" name="portaluuid" id="portaluuid" value="${param.portaluuid }">
		        <div type="hidden" id="form0_hidden_text_div" name="form0_hidden_text_div" style="position: absolute; width: 0; height: 0; z-index: -9999999999; top: 0; left: 0; display: none;"></div>
		
		        <input type="hidden" name="javax.matrix.faces.ViewState" id="javax.matrix.faces.ViewState" value="" />
		        <input type="hidden" name="dataGridId" id="dataGridId" value="DataGrid001" />
		        <div style="display: block">
			        <table class="query_form_content" style="height: 100%; width: 100%; overflow: hidden; border-collapse: collapse; border-spacing: 0px; table-layout: fixed;">
			        	<tr>
			        		<td class="query_form_toolbar" colspan="2" style="border: 1px solid #E6E9ED">
			        			<div style="padding-left: 15px;padding-right: 15px;display: inline-block;">
									<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/new.png">
									<input type="button" value="添加" class="btn  btn-default toolBarItem" id="MtoolBarItemAdd" style="padding:0px;margin:0px;border:0;background: transparent" onclick="selectAuth()">
								</div>	
								<div style="padding-right: 15px;display: inline-block;">
									<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/delete.png">
									<input type="button" value="删除" class="btn  btn-default toolBarItem" id="MtoolBarItemDel" style="padding:0px;margin:0px;border:0;background: transparent" onclick="deleteAuth()" / >
								</div>
								<div style="padding-right: 15px;display: inline-block;">
									<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/deletex.png">
									<input type="button" value="关闭" class="btn  btn-default toolBarItem" id="MtoolBarItemClo" style="padding:0px;margin:0px;border:0;background: transparent" onclick="Matrix.closeWindow()" / >
								</div>
			        		</td>
			        	</tr>
			        </table>
		        </div>
		        <div style="display: block">
    				<table id="DataGrid001_table" style="width:100%;height:100%;">
		        		<script>
						$(document).ready(function(){
							/* var title = document.getElementById('title').value;
							var conditionType = document.getElementById('conditionType').value; */
							$("#DataGrid001_table").bootstrapTable({
								classes:'table table-bordered table-striped',
								method:'post',
								contentType : "application/x-www-form-urlencoded",
								url:'<%=path%>/portal/portalAction_h5AuthList.action',
								search: false, 
								sidePagination: "server", 
								singleSelect: false,
								clickToSelect: true, 
								sortable: false,   
								//pagination: false,
								onDblClickRow:function(row){
									//doubleClickUpdateFormVersion(row.uuid);
								},
								//singleSelect:true,
								//sortable:false,
								pageSize:20,
								//pageList:[10,20,30,40],
								formatLoadingMessage: function() {
					            return '请稍等，正在加载中...';
						        },
						        queryParams: function(params){
						        	var temp = {
						        		portaluuid : document.getElementById('portaluuid').value
						        	}
						        	return temp;
						        },
						        formatNoMatches: function() {
						            return '无符合条件的记录';
						        },
								columns:[{
									title:' ',
						            checkbox: true
						        },{
									title:'序号',
									 formatter: function (value, row, index) { 
										var pageSize = $("#DataGrid001_table").bootstrapTable('getOptions').pageSize;
										var pageNumber = $("#DataGrid001_table").bootstrapTable('getOptions').pageNumber;
				                            return pageSize * (pageNumber - 1) + index + 1;  
				                        }
								},{
									field:'type',
									title:'类型',
									editorType:'Text',
									clickToSelect: true,
									type:'text',
									formatter: function (value, row, index){ // 单元格格式化函数
										var text = '-';
										if (value == 1) {
										    text = "用户";
										} else if (value == 2) {
										    text = "部门";
										} else if(value == 3) {
											text = "角色";
										}
										return text;
									}
								},{
									field:'userName',
									title:'用户名称',
									editorType:'Text',
									clickToSelect: true,
									type:'Text'
								},{
									field:'depName',
									title:'部门名称',
									editorType:'Text',
									clickToSelect: true,
									type:'Text'
								},{
									field:'roleName',
									title:'角色名称',
									editorType:'Text',
									clickToSelect: true,
									type:'Text'
								}]
							});
						});
					</script>
		        	</table>
		        </div>
			</form>
		</div>
	</body>
</html>