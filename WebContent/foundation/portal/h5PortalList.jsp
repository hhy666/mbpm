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
<jsp:include page="/foundation/common/taglib.jsp"/>
<jsp:include page="/foundation/common/resource.jsp"/>
<jsp:include page="/form/admin/common/loading.jsp" />
<script>

	//普通用户屏蔽以下功能
	window.onload = function(){
		var phaseId = $('#phaseId').val();
		if(phaseId==5){
			$('#title').css('display','none');
			$('#titleLabel').css('display','none');
			$('#queryDiv').css('display','none');
			$('#moveUpDiv').css('display','none');
			$('#moveDownDiv').css('display','none');
			$('#AuthorizationDiv').css('display','none');
		}
	}

	function returnData(gridId){
		var data = $('#'+gridId+'_table').bootstrapTable('getData',true);
		   return data;
	}

	function panel2(uuid){
		MBorderPanel001Panel2.setContentsURL('<%=path%>/portal/portalAction_previewOfficePortal.action?portalId='+uuid+'&isView=1');
	}
	
	//新增门户信息
	function addPortal(){
		var type = document.getElementById('type').value;
		layer.open({
			type:2,
			title:['新增门户信息'],
			area:['48%','60%'],
			content:"<%=path%>/portal/portalAction_addPortal.action?type="+ type +"&iframewindowid=AddPortal"
		});
	}
	
	//新增门户信息回调
	function onAddPortalClose(){
		$('#DataGrid001_table').bootstrapTable('refresh');
	}
	
	//修改门户信息
	function updatePortal(){
		var select = $('#DataGrid001_table').bootstrapTable('getSelections');
		if(select!=null&&select.length>0){
			if(select.length>1){
				layer.msg('只能选择一条数据修改!',{icon:0});
			}else if(select.length==1){
				var portalId = select[0].uuid; 
				var type = select[0].type;
				doubleClickUpdatePortal(portalId,type);
			}
		}else{
			layer.msg('请选择一条数据!',{icon:0});
		}
		
	}
	
	//双击修改操作
	function doubleClickUpdatePortal(portalId,type){
		var phaseId = $('#phaseId').val();
		layer.open({
			type:2,
			title:['修改门户信息'],
			area:['48%','60%'],
			content:"<%=path%>/portal/portalAction_updatePortal.action?type="+ type +"&iframewindowid=UpdatePortal&portalId="+portalId+"&phaseId="+phaseId
		});
	}
	//修改回调
	function onUpdatePortalClose(){
		$('#DataGrid001_table').bootstrapTable('refresh');
	}
	
	//删除门户信息
	function deletePortal(){
		var select =  $('#DataGrid001_table').bootstrapTable('getSelections');
		if(select.length>0&&select!=null){
			var ids ="";
			for(var i=0;i<select.length;i++){
				if(i!=select.length-1){
					ids+= select[i].uuid;
					ids+= ',';
				}else{
					ids+= select[i].uuid;
				}
			}
			layer.confirm('确认删除?',{
				btn:['确定','取消'],
				yes:function(index){
					layer.close(index);
					var url = "<%=path%>/portal/portalAction_deletePortal.action";
					var newData = "{'portalId':'"+ids+"'}";
					var synJson = isc.JSON.decode(newData);
					Matrix.sendRequest(url,synJson,function(data){
						if(data.data){
							var json = isc.JSON.decode(data.data);
							if(json.result==true){
								$('#DataGrid001_table').bootstrapTable('refresh');
							}else if(json.result == 'default'){
								layer.msg('禁止删除默认门户！',{icon:0});
							}
						}
					});
				}
			});
		}else{
			layer.msg('请选择数据！',{icon:0});
		}
	}
	
	//授权
	function authorizationPortal(){
		var select =  $('#DataGrid001_table').bootstrapTable('getSelections');
		if(select!=null && select.length>0){
			if(select.length>1){
				layer.msg('只能选择一条数据!',{icon:0});
			}else{
				var portaluuid = select[0].uuid;
				layer.open({
					type:2,
					title:['门户授权'],
					area:['90%','99%'],
					content:'<%=path%>/portal/portalAction_authList.action?iframewindowid=AuthorizationPortal&portaluuid='+portaluuid
				});
			}
		}else{
			layer.msg('请选择门户数据!',{icon:0});
		}
	}
	
	//门户设置内容
	function editContent(){
		var phaseId = $('#phaseId').val();
		var select =  $('#DataGrid001_table').bootstrapTable('getSelections');
		var type = document.getElementById('type').value;
		if(select!=null && select.length>0){
			if(select.length>1){
				layer.msg('只能选择一条数据!',{icon:0});
			}else{
				var portalId = select[0].uuid;
				window.location.href="<%=path%>/portal/partsAction_findPartsByPortalId.action?type=${param.type}&portalId="+portalId+"&type="+type+"&phaseId="+phaseId;
			}
		}else{
			layer.msg('请选择门户数据!',{icon:0});
		}
	}
	
	//预览
	function previewPortal(){
		var select =  $('#DataGrid001_table').bootstrapTable('getSelections');
		if(select!=null && select.length>0){
			if(select.length>1){
				layer.msg('只能选择一条数据!',{icon:0});
			}else{
				var portalId = select[0].uuid;
				window.open("<%=path%>/portal/portalAction_previewOfficePortal.action?portalId="+portalId+'&isView=1');
			}
		}else{
			layer.msg('请选择数据!',{icon:0});
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
					var json = "{'lastUuid':'"+lastUuid+"','nextUuid':'"+nextUuid+"','matrix_user_command':'moveUp'}";
					var synJson = isc.JSON.decode(json);
					var url = "<%=path%>/portal/portalAction_movePortalUp.action";
					Matrix.sendRequest(url,synJson,function(data){
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
					var json = "{'lastUuid':'"+lastUuid+"','nextUuid':'"+nextUuid+"','matrix_user_command':'moveDown'}";
					var synJson = isc.JSON.decode(json);
					var url = "<%=path%>/portal/portalAction_movePortalDown.action";
					Matrix.sendRequest(url,synJson,function(data){
						$('#DataGrid001_table').bootstrapTable('refresh');
					});
				}
			}
		}
	}
</script>
</head>
	<body style="">
		<form id="form0" name="form0" eventProxy="Mform0" method="post"	action="" style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
			<input type="hidden" name="form0" id="form0" value="form0"/>
			<input name="version" id="version" type="hidden"/>
			<input type="hidden" name="dataGridId" id="dataGridId" value="DataGrid001"/>
			<input name="phaseId" id="phaseId" type="hidden" value="${phaseId}"/>
			<input name="type" id="type" type="hidden" value="${param.type }"/>
			<input name="parentNodeId" id="parentNodeId" type="hidden" value="${param.entityId }"/>
			<input id="DataGrid001_selection" name="DataGrid001_selection" type="hidden" />
			<input id="DataGrid001_data_entity" name="DataGrid001_data_entity" value="foundation.portal.Portal" type="hidden" />
			<div id="VerticalContainer001_div" class="matrixInline" style="width:100%;height:100%;;overflow:hidden;padding: 6px">
			    <script>
			        isc.VLayout.create({
			            ID: "MVerticalContainer001",
			            displayId: "VerticalContainer001_div",
			            position: "relative",
			            height: "100%",
			            width: "100%",
			            align: "center",
			            overflow: "auto",
			            defaultLayoutAlign: "center",
			            members: [isc.HTMLPane.create({
			                ID: "MBorderPanel001Panel1",
			                width: "100%",
			                height: '50%',
			                overflow: "hidden",
			                showResizeBar: true,
			                showEdges: false,
			                contentsType: "page",
			                contents:"<div id='BorderPanel001Panel1_div' class='matrixComponentDiv'></div>"
			            }), isc.HTMLPane.create({
			                ID: "MBorderPanel001Panel2",
			                width: "100%",
			                overflow: "hidden",
			                showEdges: false,
			                contentsType: "page",
			                contentsURL: "<%=path%>/foundation/portal/portalFirst.jsp?count=<%=request.getAttribute("totalSize")%>'"
			            })],
			            canSelectText: true
			        });
			    </script>
			</div>
			<div id="BorderPanel001Panel1_div2" style="width:100%;height:100%;overflow:auto;" class="matrixInline">
				<div style="padding-left: 5px;padding-top: 5px">
					<span id="label011" style="font-size:18px;vertical-align:bottom; " name="label011"/>
						门户管理
					</span>
				</div>
			    	<div style="width:100%;height:100%;position: relative;" >
			    		<div style="display: block">
							<table class="query_form_content" style="height:100%;width:100%;overflow:hidden;border-collapse: collapse;border-spacing:0px;table-layout:fixed;">
				    			<tr style=" height: 0px">
									<td class="query_form_toolbar"icolspan="2" style="padding: 3px">
										<div style="/* padding:4px; */background: #f8f8f8;text-align: left;vertical-align: middle;height: 44px;border: 1px solid #E6E9ED;line-height: 44px;">
											<label id="titleLabel" style="padding-left: 5px">标题:</label>
											<div style="padding-right: 5px;display: inline-block;vertical-align:middle;">
												<input class="form-control" type="text" style="" name="title" id="title" >
											</div>
											<div id="queryDiv" style="padding-right: 15px;display: inline-block;">
												<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/query.png">
												<input type="button" value="查询" class="btn  btn-default toolBarItem" id="MtoolBarItemQue" style="padding:0px;margin:0px;border:0;background: transparent" onclick="$('#DataGrid001_table').bootstrapTable('refresh')">
											</div>
											<div style="padding-right: 15px;display: inline-block;">
												<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/new.png">
												<input type="button" value="添加" class="btn  btn-default toolBarItem" id="MtoolBarItemAdd" style="padding:0px;margin:0px;border:0;background: transparent" onclick="addPortal()">
											</div>	
											<div style="padding-right: 15px;display: inline-block;">
												<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/editflow.png">
												<input type="button" value="修改" class="btn  btn-default toolBarItem" id="MtoolBarItemUpdate" style="padding:0px;margin:0px;border:0;background: transparent" onclick="updatePortal()">
											</div>
											<div id="moveUpDiv" style="padding-right: 15px;display: inline-block;">
												<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/moveup.png">
												<input type="button" value="上移" class="btn  btn-default toolBarItem" id="MtoolBarItemUpMove" style="padding:0px;margin:0px;border:0;background: transparent" onclick="moveUp()" / >
											</div>
											<div id="moveDownDiv" style="padding-right: 15px;display: inline-block;">
												<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/movedown.png">
												<input type="button" value="下移" class="btn  btn-default toolBarItem" id="MtoolBarItemDownMove" style="padding:0px;margin:0px;border:0;background: transparent" onclick="moveDown()" / >
											</div>
											<div style="padding-right: 15px;display: inline-block;">
												<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/deletex.png">
												<input type="button" value="删除" class="btn  btn-default toolBarItem" id="MtoolBarItemDel" style="padding:0px;margin:0px;border:0;background: transparent" onclick="deletePortal()" / >
											</div>
											<div id="AuthorizationDiv" style="padding-right: 15px;display: inline-block;">
												<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/setAuth.png">
												<input type="button" value="授权" class="btn  btn-default toolBarItem" id="MtoolBarItemAuthorization" style="padding:0px;margin:0px;border:0;background: transparent" onclick="authorizationPortal()" / >
											</div>
											<div style="padding-right: 15px;display: inline-block;">
												<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/edit.png">
												<input type="button" value="设置内容" class="btn  btn-default toolBarItem" id="MtoolBarItemSetContent" style="padding:0px;margin:0px;border:0;background: transparent" onclick="editContent()" / >
											</div>
											<div style="padding-right: 15px;display: inline-block;">
												<img style="VERTICAL-ALIGN: middle" align="absMiddle" width="16" height="16" src="<%=path%>/resource/images/preview.png">
												<input type="button" value="预览" class="btn  btn-default toolBarItem" id="MtoolBarItemPreview" style="padding:0px;margin:0px;border:0;background: transparent" onclick="previewPortal()" / >
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
											url:'<%=path%>/portal/portalAction_h5FindAllPortal.action',
											search: false, 
											sidePagination: "server", 
											singleSelect: false,
											clickToSelect: true, 
											sortable: false,   
											pagination: true,
											onClickRow:function(row){
												panel2(row.uuid);
											},
											onDblClickRow:function(row){
												doubleClickUpdatePortal(row.uuid,row.type);
											},
											queryParams: function(params){
												var param = {
													offset: params.offset,
													limit:params.limit
												}
												param["title"] = document.getElementById('title').value;
									            var form = document.getElementById('form0');
									            var tagElements = form.getElementsByTagName('input');
									            for (var j = 0; j < tagElements.length; j++) {
									                param[tagElements[j].name] = tagElements[j].value;
									            };
												return param;
											},
											//singleSelect:true,
											//sortable:false,
											pageSize:20,
											pageList:[10,20,30,40],
											formatLoadingMessage: function() {
								            return '请稍等，正在加载中...';
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
												title:'门户标题',
												editorType:'Text',
												clickToSelect: true,
												type:'text'
											},{
												field:'layout',
												title:'默认列数',
												editorType:'Text',
												clickToSelect: true,
												type:'Text'
											},{
												field:'status',
												title:'状态',
												editorType:'Text',
												clickToSelect: true,
												type:'Text',
												formatter: function (value, row, index){ // 单元格格式化函数
													var text = '-';
													if (value == 1) {
													    text = "已禁用";
													} else if (value == 0) {
													    text = "已启用";
													}
													return text;
												}
											}]
										});
									});
								</script>
							</table>
			    		</div>
			    	</div>
				</div>
			<script>
				document.getElementById('BorderPanel001Panel1_div').appendChild(document.getElementById('BorderPanel001Panel1_div2'));
				<%-- var type = document.getElementById('type').value;
			    MBorderPanel001Panel1.setContentsURL('<%=path%>/foundation/portal/h5PortalListMain.jsp?type='+type);
			    MBorderPanel001Panel2.setContentsURL('<%=path%>/foundation/portal/portalFirst.jsp?count=<%=request.getAttribute("totalSize")%>');
			    function panel2(uuid){
			    	MBorderPanel001Panel2.setContentsURL('<%=path%>/portal/portalAction_previewOfficePortal.action?portalId='+uuid);
			    }--%>
			</script>
		</form>
	</body>
</html>