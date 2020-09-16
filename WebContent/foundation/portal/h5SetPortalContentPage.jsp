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
	//添加部件
	function AddSelectParts(){
    	var portalId = document.getElementById("portalId").value;
    	var type = document.getElementById("type").value;
			layer.open({
			type:2,
			title:['部件列表'],
			area:['80%','80%'],
			content:"<%=path%>/portal/partsAction_findAllParts.action?iframewindowid=AddSelectParts&portalId="+portalId+"&type="+type
		});
	}
	
	function onAddSelectPartsClose(data){
		var portalId = document.getElementById('portalId').value;
		if(data!=null){
			var jsonStr = "[";
			for(var i=0;i<data.length;i++){
				if(i!=data.length-1){
					jsonStr+="{'partId':'"+data[i].uuid+"',";
	      			jsonStr+="'width':"+(data[i].width==null?"''":"'"+data[i].width+"'")+",";
	      			jsonStr+="'index':'"+data[i].index+"',";
	      			jsonStr+="'height':"+(data[i].height==null?"''":"'"+data[i].height+"'")+",";
	      			jsonStr+="'rows':'"+data[i].rows+"',";
	      			jsonStr+="'cols':'"+data[i].cols+"'},";
				}else{
					jsonStr+="{'partId':'"+data[i].uuid+"',";
	      			jsonStr+="'width':"+(data[i].width==null?"''":"'"+data[i].width+"'")+",";
	      			jsonStr+="'index':'"+data[i].index+"',";
	      			jsonStr+="'height':"+(data[i].height==null?"''":"'"+data[i].height+"'")+",";
	      			jsonStr+="'rows':'"+data[i].rows+"',";
	      			jsonStr+="'cols':'"+data[i].cols+"'}";
				}
			}
			jsonStr += "]";
			var url = "<%=path%>/portal/partsAction_saveSelectParts.action?type=${param.type}";
			Matrix.sendRequest(url,{'data':jsonStr,'portalId':portalId},function(data){
	      		document.getElementById('portalId').value=data.data;
	      		Matrix.refreshDataGridData('DataGrid001');
	      		Matrix.say("保存成功!");	
	      	});
		}
	}
	//返回门户管理列表
	function back(){
		var type = $('#type').val();
		document.getElementById("form0").action="<%=path%>/portal/portalAction_findAllPortal.action?type="+type
		document.getElementById("form0").submit();
	}
	
	function updateSelectParts(){
		var select = Matrix.getGridSelections('DataGrid001');
		if(select!=null&&select.length>0){
			if(select.length>1){
				Matrix.warn('只能选择一条数据修改！');
			}else{
				var partId = select[0].uuid;
				var portalId = document.getElementById('portalId').value;
				doubleClickUpdate(partId,portalId);
			}
		}else{
			Matrix.warn('请先选中数据！');
		}
	}
	
	//双击修改
	function doubleClickUpdate(partId,portalId){
		var type = ${param.type};
		layer.open({
			type:2,
			title:["编辑部件"],
			area:['45%','60%'],
			content:"<%=path%>/portal/partsAction_refreshtoEdit.action?iframewindowid=UpdateSelectParts&partId="+partId +"&portalId="+portalId+"&type="+type
		});
	}
	
	function onUpdateSelectPartsClose(data){
		if(data!=null){
			var result = isc.JSON.decode(data.data);
			if(result[0].result==true){
				document.getElementById('portalId').value = result[1].portalId;
				Matrix.refreshDataGridData('DataGrid001');
				Matrix.warn("修改成功!");
			}else if(result.result == false){
				Matrix.warn("默认门户不能修改！");
			}
		}
	} 
	
	//删除
	function deleteSelectParts(){
		var portalId = document.getElementById('portalId').value;
		var select = Matrix.getGridSelection('DataGrid001');
		if(select!=null&&select.length>0){
			var ids = "";
			for(var i=0;i<select.length;i++){
				if(i!=select.length-1){
					ids+= select[i].uuid;
					ids+= ",";
				}else{
					ids+= select[i].uuid;
				}
			}
			Matrix.confirm("确认删除?",function(value){
				if(!value){
					var url = "<%=path%>/portal/partsAction_deleteSelectParts.action?type=${param.type}";
					var newdata = "{'partIds':'"+ids+"','portalId':'"+portalId+"'}";	
					var synJson = isc.JSON.decode(newdata);
					Matrix.sendRequest(url,synJson,function(data){
						if(data.data){
							var json = isc.JSON.decode(data.data);
							if(json[0].result==true){
								document.getElementById('portalId').value = json[1].portalId;
								Matrix.refreshDataGridData('DataGrid001');
								Matrix.warn("删除成功！");
							}else if(json[0].result==false){
								Matrix.warn('默认门户不能删除！');
							}else{
								Matrix.warn('删除失败！');
							}
						}
					});
				}
			});
		}else{
			Matrix.warn("请先选中数据！");
		}
	}
	
	//预览
	function previewPortal(){
		var portalId = document.getElementById('portalId').value;
		window.open("<%=request.getContextPath()%>/portal/portalAction_previewOfficePortal.action?portalId="+portalId+'&isView=1');
	}
	
	function moveUp(){
		var portalId = document.getElementById('portalId').value;
		var select = Matrix.getGridSelections("DataGrid001");
		if(select == null || select.length==0){
			Matrix.warn("没有数据被选中，不能执行此操作。");
		}else{
			if(select != null && select.length>1){
				Matrix.warn("只能选择一条数据进行上移操作!");
			}else{
				var recordData = Matrix.getGridData('DataGrid001');
				var recordIndex = recordData.indexOf(select[0]);
				var listSize = recordData.length;
				if(recordIndex==0){
					isc.warn("首行数据不能上移!");
				}else{
					var afterRecord = recordData[recordIndex-1];
					var lastUuid = afterRecord.uuid;
					var nextUuid = select[0].uuid;
					var json = "{'lastUuid':'"+lastUuid+"','nextUuid':'"+nextUuid+"','portalId':'"+portalId+"'}";
					var synJson = isc.JSON.decode(json);
					var url = "<%=path%>/portal/partsAction_moveContentUp.action";
					Matrix.sendRequest(url,synJson,function(data){
						Matrix.refreshDataGridData("DataGrid001");
					});
				}
			}
		}
	}
	
	function moveDown(){
		var portalId = document.getElementById('portalId').value;
		var select = Matrix.getGridSelections("DataGrid001");
		if(select == null || select.length==0){
			isc.warn("没有数据被选中，不能执行此操作。");
		}else{
			if(select != null && select.length>1){
				isc.warn("只能选择一条数据进行下移操作!");
			}else{
				var recordData = Matrix.getGridData('DataGrid001');
				var recordIndex = recordData.indexOf(select[0]);
				var listSize = recordData.length;
				if(recordIndex==listSize-1){
					isc.warn("末行数据不能下移!");
				}else{
					var afterRecord = recordData[recordIndex+1];
					var lastUuid = select[0].uuid;
					var nextUuid = afterRecord.uuid;
					var json = "{'lastUuid':'"+lastUuid+"','nextUuid':'"+nextUuid+"','portalId':'"+portalId+"'}";
					var synJson = isc.JSON.decode(json);
					var url = "<%=path%>/portal/partsAction_moveContentDown.action";
					Matrix.sendRequest(url,synJson,function(data){
						Matrix.refreshDataGridData("DataGrid001");
					});
				}
			}
		}
	}
</script>
</head>
<body style="padding:6px">
	<div style="padding-left: 5px;padding-top: 5px">
		<span id="label011" style="font-size:18px;vertical-align:bottom; " name="label011"/>
			设置内容
		</span>
	</div>
	<div style="width:100%;height:100%;overflow:auto;position:relative;">
	    <form id="form0" name="form0" eventProxy="Mform0" method="post" action="<%=request.getContextPath()%>/portal/partsAction_findPartsByPortalId.action" style="margin:0px;position:relative;overflow:auto;width:100%;height:100%;" enctype="application/x-www-form-urlencoded">
	        <input type="hidden" name="form0" value="form0" />
	        <input type="hidden" id="mode" name="mode" value="debug" />
	        <input type="hidden" id="type" name="type" value="${type}"/>
	        <input type="hidden" id="matrix_form_tid" name="matrix_form_tid" />
	        <input type="hidden" id="matrix_form_datagrid_form0" name="matrix_form_datagrid_form0" value="" />
	        <div type="hidden" id="form0_hidden_text_div" name="form0_hidden_text_div" style="position:absolute;width:0;height:0;z-index:-9999999999;top:0;left:0;display:none;"></div>
	        <input type="hidden" name="javax.matrix.faces.ViewState" id="javax.matrix.faces.ViewState" value="" />
	        <!-- 存储从portalList页面传来的portalId-->
	        <input type="hidden" id="uuid" name="uuid" value="${param.uuid}" />
	        <input type="hidden" id="portalId" name="portalId" value="${portalId}" />
	        <input type="hidden" id="DataGridId" name="DataGridId" value="DataGrid001">
	        <div id="TabContainer001_div" class="matrixComponentDiv" style="width:100%;height:100%;position:relative;">
	        	<div style="display: block">
		        	<table class="maintain_form_content" style="width:100%;height:100%">
		        		<tr>
		        			<td class="query_form_toolbar" colspan="2" style="padding: 3px">
		        				<div style="height:40px;padding:8px;background: #f8f8f8;text-align: left;border: 1px solid #E6E9ED ">
									<div style="padding-right: 15px;display: inline-block;vertical-align: middle;">
										<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/edit.png">
										<input type="button" value="添加部件" class="btn  btn-default toolBarItem" id="MtoolBarItemSetParts" style="padding:0px;margin:0px;border:0;background: transparent" onclick="AddSelectParts()">
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
										<input type="button" value="删除" class="btn  btn-default toolBarItem" id="MtoolBarItemDel" style="padding:0px;margin:0px;border:0;background: transparent" onclick="deleteSelectParts()" / >
									</div>
									<div style="padding-right: 15px;display: inline-block;">
										<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/editflow.png">
										<input type="button" value="编辑" class="btn  btn-default toolBarItem" id="MtoolBarItemUpdate" style="padding:0px;margin:0px;border:0;background: transparent" onclick="updateSelectParts()">
									</div>
									<div style="padding-right: 15px;display: inline-block;">
										<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/preview.png">
										<input type="button" value="预览" class="btn  btn-default toolBarItem" id="MtoolBarItemPreview" style="padding:0px;margin:0px;border:0;background: transparent" onclick="previewPortal()" / >
									</div>
									<div style="padding-right: 15px;display: inline-block;">
										<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/file.png">
										<input type="button" value="返回门户列表" class="btn  btn-default toolBarItem" id="MtoolBarItemBack" style="padding:0px;margin:0px;border:0;background: transparent" onclick="back()" / >
									</div>
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
								url:'<%=path%>/portal/partsAction_h5FindPartsByPortalId.action',
								search: false, 
								sidePagination: "server", 
								singleSelect: false,
								clickToSelect: true, 
								sortable: false,   
								//pagination: false,
								onDblClickRow:function(row){
									var portalId = document.getElementById('portalId').value;
									doubleClickUpdate(row.uuid,portalId);
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
					        			portalId : document.getElementById('portalId').value
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
									field:'title',
									title:'标题',
									editorType:'Text',
									clickToSelect: true,
									type:'text'
								},{
									field:'width',
									title:'宽度',
									editorType:'Text',
									clickToSelect: true,
									type:'Text'
								},{
									field:'height',
									title:'高度',
									editorType:'Text',
									clickToSelect: true,
									type:'Text'
								},{
									field:'rows',
									title:'行数',
									editorType:'Text',
									clickToSelect: true,
									type:'Text'
								},{
									field:'cols',
									title:'列数',
									editorType:'Text',
									clickToSelect: true,
									type:'Text'
								}]
							});
						});
					</script>
 		        	</table>
 		        </div>
			</div>
		</form>
	</div>
</body>
</html>