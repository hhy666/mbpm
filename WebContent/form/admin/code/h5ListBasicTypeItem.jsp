<%@page pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML>
<html>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<head>
<jsp:include page="/form/html5/admin/html5Head.jsp"/>
<title>基本类型项</title>
	<script type="text/javascript">
	
		function returnData(gridId){
			var data = $('#'+gridId+'_table').bootstrapTable('getData',true);
			return data;
		}
	
		function addBasicItem(){
			layer.open({
				type:2,
				title:['添加部件信息'],
				area:['65%','65%'],
				content:'<%=path%>/code/code_loadSaveBasicItemPage.action?iframewindowid=Add&oType=add&parentUUID=${parentUUID}'
			});
		}
		
		function onAddClose(data,oType){
			if(data!=null){
				var parentUUID = document.getElementById("uuid").value;
				var id = data.id;
				var name = data.name;
				var flag = data.flag;
				var isEnable = data.isEnable;
				var synData ="{'id':'"+id+"','name':'"+name+"','flag':"+flag+",'isEnable':'"+isEnable+"','parentUUID':'"+parentUUID+"'}";
				var cbDataStr = isc.JSON.decode(synData);
				url = "<%=path%>/code/code_addBasicItem.action";
				Matrix.sendRequest(url,cbDataStr,function(data){
					var cdata = data.data;
				    var callbackObj =isc.JSON.decode(cdata);
				    var message = callbackObj.message;
				    if(message==true){
				    	Matrix.refreshDataGridData('DataGrid001');
			   			Matrix.info("添加成功");
				    }
				});

			}
		}
	
		function updateBasic(){
			var select = Matrix.getGridSelection('DataGrid001');
			if(select!=null&&select.length>0){
				if(select.length==1){
					var uuid = select[0].uuid;
					doubleClickUpdate(uuid);
				}else{
					Matrix.warn("只能选中一条基本类型！");
				}
			}else{
				Matrix.warn("请选中一条基本类型项！");
			}
		} 
	
		function doubleClickUpdate(uuid){
			layer.open({
				type:2,
				title:['更改部件信息'],
				area:['65%','65%'],
				content:'<%=path%>/code/code_loadUpdateCodeBasicItem.action?iframewindowid=Update&oType=update&uuid='+uuid
			});
		}
		
		function onUpdateClose(data,oType){
			if(data!=null){
				var parentUUID = document.getElementById("uuid").value;
				var id = data.id;
				var uuid = data.uuid;
				var name = data.name;
				var isEnable = data.isEnable;
				var synData ="{'id':'"+id+"','name':'"+name+"','isEnable':'"+isEnable+"','uuid':'"+uuid+"'}";
				var cbDataStr = isc.JSON.decode(synData);
				var url = "<%=request.getContextPath()%>/code/code_updateBasicItem.action";
				Matrix.sendRequest(url,cbDataStr,function(data){
					var cdata = data.data;
					var callbackObj =isc.JSON.decode(cdata);
				    var message = callbackObj.message;
				    if(message==true){
				    	Matrix.refreshDataGridData('DataGrid001');
				    	Matrix.info('更新成功!');
				    }else{
				    	Matrix.warn('更新失败！');
				    }

				});
			}
		}
		
		function deleteCodeItem(){
			var select = Matrix.getGridSelection('DataGrid001');
			if(select!=null&&select.length>0){
				if(select.length==1){
					var uuid = select[0].uuid;
					var url ="<%=path%>/code/code_deleteCodeItem.action?uuid="+uuid;
					Matrix.sendRequest(url,null,function(data){
						var backStr = data.data;
						var backData = isc.JSON.decode(backStr);
						if(backData.message==true){
							Matrix.refreshDataGridData('DataGrid001');
				    	 	Matrix.info("删除成功!");
						}else{
							Matrix.warn("删除失败!");
						}
					});
				}else{
					Matrix.warn("只能选中一条基本类型！");
				}
			}else{
				Matrix.warn("请选中一条基本类型项！");
			}
		}
		
		function moveUp(){
			var select =  $('#DataGrid001_table').bootstrapTable("getSelections");
			if(select == null || select.length==0){
				layer.msg("没有数据被选中，不能执行此操作。",{icon:0});
			}else{
				if(select != null && select.length>1){
					layer.msg("只能选择一条数据进行上移操作!",{icon:0});
				}else{
					var recordData = returnData('DataGrid001');
					var recordIndex = recordData.indexOf(select[0]);
					var listSize = recordData.length;
					if(recordIndex==0){
						layer.msg("首行数据不能上移!",{icon:0});
					}else{
						var afterRecord = recordData[recordIndex-1];
						var lastUuid = afterRecord.uuid;
						var nextUuid = select[0].uuid;
						var json = {'data':"{'entityId':'"+lastUuid+"','preEntityId':'"+nextUuid+"'}"};
						var url = "<%=path%>/code/code_moveUpBasicItem.action";
						Matrix.sendRequest(url,json,function(data){
							$('#DataGrid001_table').bootstrapTable('refresh');
						});
					}
				}
			}
		}
		
		
		function moveDown(){
			var select =  $('#DataGrid001_table').bootstrapTable('getSelections');
			if(select == null || select.length==0){
				layer.msg("没有数据被选中，不能执行此操作。",{icon:0});
			}else{
				if(select != null && select.length>1){
					layer.msg("只能选择一条数据进行下移操作!",{icon:0});
				}else{
					var recordData = returnData('DataGrid001');
					var recordIndex = recordData.indexOf(select[0]);
					var listSize = recordData.length;
					if(recordIndex==listSize-1){
						layer.msg("末行数据不能下移!",{icon:0});
					}else{
						var afterRecord = recordData[recordIndex+1];
						var lastUuid = select[0].uuid;
						var nextUuid = afterRecord.uuid;
						var json = {'data':"{'entityId':"+lastUuid+",'afterEntityId':"+nextUuid+"}"};
						var url = "<%=path%>/code/code_moveDownBasicItem.action";
						Matrix.sendRequest(url,json,function(data){
							$('#DataGrid001_table').bootstrapTable('refresh');
						});
					}
				}
			}
		}
	</script>
</head>
<body>	
	<form id="Form0" name="Form0" method="post"  action="" style="overflow:auto;padding:10px;margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
		<input type="hidden" id="uuid" name="uuid" value="${parentUUID}">
		<div style="display: block">
			<table class="query_form_content" style="height:100%;width:100%;overflow:hidden;border-collapse: collapse;border-spacing:0px;table-layout:fixed;">
	   			<tr style=" height: 0px">
					<td class="query_form_toolbar"icolspan="2" style="padding: 3px;background: #f8f8f8;text-align: left;border: 1px solid #E6E9ED">
						<div style="padding-left:15px;padding-right: 15px;display: inline-block;">
							<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/new.png">
							<input type="button" value="添加" class="btn  btn-default toolBarItem" id="MtoolBarItemAdd" style="padding:0px;margin:0px;border:0;background: transparent" onclick="addBasicItem()">
						</div>	
						<div style="padding-right: 15px;display: inline-block;">
							<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/editflow.png">
							<input type="button" value="修改" class="btn  btn-default toolBarItem" id="MtoolBarItemUpdate" style="padding:0px;margin:0px;border:0;background: transparent" onclick="updateBasic()">
						</div>
						<div style="padding-right: 15px;display: inline-block;">
							<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/moveup.png">
							<input type="button" value="上移" class="btn  btn-default toolBarItem" id="MtoolBarItemUpMove" style="padding:0px;margin:0px;border:0;background: transparent" onclick="moveUp()" / >
						</div>
						<div style="padding-right: 15px;display: inline-block;">
							<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/movedown.png">
							<input type="button" value="下移" class="btn  btn-default toolBarItem" id="MtoolBarItemDownMove" style="padding:0px;margin:0px;border:0;background: transparent" onclick="moveDown()" / >
						</div>
						<div style="padding-right: 15px;display: inline-block;">
							<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/deletex.png">
							<input type="button" value="删除" class="btn  btn-default toolBarItem" id="MtoolBarItemDel" style="padding:0px;margin:0px;border:0;background: transparent" onclick="deleteCodeItem()" / >
						</div>
					</td>
				</tr>
			</table>
		</div>
		<div style="display: block;padding-top: 5px">
			<table id="DataGrid001_table" style="width:100%;height:100%;">
				<script>
		   			$(document).ready(function(){
						$("#DataGrid001_table").bootstrapTable({
							classes:'table table-bordered table-striped',
							method:'post',
							contentType : "application/x-www-form-urlencoded",
							url:'<%=path%>/code/code_h5GetCodeBasicItem.action',
							search: false, 
							sidePagination: "server", 
							singleSelect: true,
							clickToSelect: true, 
							sortable: false,   
							//pagination: false,
							onDblClickRow:function(row){
								doubleClickUpdate(row.uuid);
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
				        			uuid : document.getElementById('uuid').value
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
								width:'5%',
								 formatter: function (value, row, index) { 
									var pageSize = $("#DataGrid001_table").bootstrapTable('getOptions').pageSize;
									var pageNumber = $("#DataGrid001_table").bootstrapTable('getOptions').pageNumber;
			                            return pageSize * (pageNumber - 1) + index + 1;  
			                        }
							},{
								field:'id',
								title:'选项值',
								editorType:'Text',
								clickToSelect: true,
								type:'text'
							},{
								field:'name',
								title:'选择选项值',
								editorType:'Text',
								clickToSelect: true,
								type:'Text'
							},{
								field:'isEnable',
								title:'状态',
								editorType:'Text',
								clickToSelect: true,
								type:'Text',
								formatter:function(value,row,index){
									var text = "-";
									if(value=="1"){
										text = "启用";
									}else if(value=="2"){
										text = "禁用";
									}
									return text;
								}
							}]
						});
					});
				</script>
			</table>
		</div>
	</form>
</body>
</html>