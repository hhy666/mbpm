<%@page pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML>
<html>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<head>
	 
<jsp:include page="/foundation/common/taglib.jsp"/>
<jsp:include page="/foundation/common/resource.jsp"/>

<script>
	
  
	
	//弹出选择部件窗口
    function showSelectPartsDialog(){
    	var uuid = document.getElementById("uuid").value;
		MDialog3.initSrc = "<%=request.getContextPath()%>/portal/partsAction_findAllParts.action?uuid="+uuid;
		Matrix.showWindow('Dialog3');
	}
	//选择完部件，窗口关闭时
	function onDialog3Close(data){
		var items = Matrix.getAllDataGridData('DataGrid001');
		var uuids=[];
		for(var i = 0;i<items.length;i++){
			uuids[i]=items[i].uuid;
		}
		for(var i=0;i<data.size();i++){
			if(uuids.contains(data[i].uuid)){
				continue;
			}else{
				MDataGrid001.addData(data[i]);
			}
		}
	}
	function deleteSelections(){
		var selects = MDataGrid001.getSelection();
		isc.confirm("确认删除?",function(value){
			if(value){
				if(selects.length>0&&selects!=null){
					Matrix.deleteDataGridData("DataGrid001");
				}else{
					isc.warn("请先选中数据!");
				}
			}
		});
	}
	function moveUp(){
		 //数据表格所有记录集合
        var items = Matrix.getAllDataGridData('DataGrid001');
         //获得选中的当前行
        var item = Matrix.getDataGridSelection('DataGrid001');
		if(item.length==1){
             var idx = MDataGrid001.getFocusRow(item);      
             if(idx!=0){
                 var targetItem=items.get(idx-1);
		    	 items.set(idx-1,item.get(0));
		    	 items.set(idx,targetItem);   
                 MDataGrid001.setData(items);
             }
         }else if(item.length==0){
                isc.warn("没有数据被选中，不能执行此操作。");
                return null;
         }else{
				isc.warn("只能选择一条数据进行上移操作!");
				return;
		}
	}
	function moveDown(){
		  var dataGrid = Matrix.getMatrixComponentById("DataGrid001");
		if(dataGrid){
		 	if(!dataGrid.getSelection() || dataGrid.getSelection().length==0){
				isc.warn("没有数据被选中，不能执行此操作。");
				return null;
			}
			if(dataGrid.getSelection() && dataGrid.getSelection().length>1){
				isc.warn("只能选择一条数据进行下移操作!");
				return null;
			}
			var recordData = dataGrid.getData();
			var selectedRecord = dataGrid.getSelection()[0];
			var recordIndex = recordData.indexOf(selectedRecord);
			var listSize = recordData.getLength();
			if(recordIndex<listSize-1){
			    recordIndex++;
			    //获取上条数据记录
			    var afterRecord = recordData.get(recordIndex);
			    //交换数据记录，更新数据表格
			    recordData.set(recordIndex,selectedRecord);
			    recordData.set(recordIndex-1,afterRecord);
			}
		}
	}
	function saveLastSelections(){
		
		MDataGrid001.saveAllEdits();
		var data = Matrix.getAllDataGridData('DataGrid001');
		var portalId = Matrix.getFormItemValue('uuid');
		var jsonStr = "[";
      	for(var i = 0;i < data.length;i++){
      		var dataWidth = data[i].width;
      	    var dataHeight = data[i].height;
      	  	var re_n = new RegExp("^([0-9]+((.[1-9]+)?)((%|px|em)?))?$");//匹配高度或宽度数值
      	  	debugger;
      	    if(!re_n.test(dataWidth) || !re_n.test(dataHeight)){
      	    	Matrix.warn("请输入正确格式的高度和宽度！");
				return;
			}
      		if(i!=data.length-1){
      			jsonStr+="{'partId':'"+data[i].uuid+"',";
      			jsonStr+="'width':"+(data[i].width==null?"''":"'"+data[i].width+"'")+",";
      			jsonStr+="'index':'"+i+"',";
      			jsonStr+="'height':"+(data[i].height==null?"''":"'"+data[i].height+"'")+",";
      			jsonStr+="'rows':'"+data[i].rows+"',";
      			jsonStr+="'cols':'"+data[i].cols+"'},";
      		}else{
      			jsonStr+="{'partId':'"+data[i].uuid+"',";
      			jsonStr+="'width':"+(data[i].width==null?"''":"'"+data[i].width+"'")+",";
      			jsonStr+="'index':'"+i+"',";
      			jsonStr+="'height':"+(data[i].height==null?"''":"'"+data[i].height+"'")+",";
      			jsonStr+="'rows':'"+data[i].rows+"',";
      			jsonStr+="'cols':'"+data[i].cols+"'}";
      		}
      	}
      	jsonStr += "]";
      	var url = "<%=request.getContextPath()%>/portal/partsAction_saveSelectParts.action?type=${param.type}";
      	Matrix.sendRequest(url,{'data':jsonStr,'portalId':portalId},function(data){
      		debugger;
      		document.getElementById('uuid').value=data.data;
      		isc.say("保存成功!");	
      	});
	}
</script>
</head>
<body>
<div id='loading' name='loading' class='loading'><script>Matrix.showLoading();</script></div>

<script> var Mform0=isc.MatrixForm.create({
				ID:"Mform0",
				name:"Mform0",
				position:"absolute",
				action:"<%=request.getContextPath()%>/matrix.rform",
				fields:[
				{name:'form0_hidden_text',width:0,height:0,displayId:'form0_hidden_text_div'}
				]});
</script>
<div style="width:100%;height:100%;overflow:auto;position:relative;">
<form id="form0" name="form0" eventProxy="Mform0" method="post" 
	action="<%=request.getContextPath()%>/portal/partsAction_findPartsByPortalId.action" 
	style="margin:0px;position:relative;overflow:auto;width:100%;height:100%;" 
	enctype="application/x-www-form-urlencoded">
<input type="hidden" name="form0" value="form0" />
<input type="hidden" id="mode" name="mode" value="debug" />
<input type="hidden" id="matrix_form_tid" name="matrix_form_tid" />
<input type="hidden" id="matrix_form_datagrid_form0" name="matrix_form_datagrid_form0" value="" />
<div type="hidden" id="form0_hidden_text_div" name="form0_hidden_text_div" style="position:absolute;width:0;height:0;z-index:-9999999999;top:0;left:0;display:none;"></div>
<input type="hidden" name="javax.matrix.faces.ViewState" id="javax.matrix.faces.ViewState" value="" />
		<!-- 存储从portalList页面传来的portalId-->
<input type="hidden" id="uuid" name="uuid" value="${param.uuid}"/>
<input type="hidden" id="DataGridId" name="DataGridId" value="DataGrid001">
<div id="TabContainer001_div" class="matrixComponentDiv" style="width:100%;height:100%;position:relative;" >
				<script> 
					var MTabContainer001 = isc.TabSet.create({
							ID:"MTabContainer001",
							displayId:"TabContainer001_div",
							height: "100%",width: "100%",
							position: "relative",
							align: "center",
							tabBarPosition: "top",
							tabBarAlign: "left",
							showPaneContainerEdges: false,
							showTabPicker: true,
							showTabScroller: true,
							selectedTab: 1,
							tabBarControls : [
								isc.MatrixHTMLFlow.create({
									ID:"MTabBar001",
									width:"300px",
									contents:"<div id='TabBar001_div' style='text-align:right;' ></div>"}) 
								],
								tabs: [ 
									{title: "设置内容",
									 autoDraw: false,
									 pane:isc.MatrixHTMLFlow.create(
									 	{ID:"MTabPanel001",
									 	 autoDraw: false,
									 	 width: "100%",
									 	 height: "100%",
									 	 overflow: "hidden",
									 	 contents:"<div id='TabPanel001_div' style='width:100%;height:100%'></div>"})} ] });document.getElementById('TabContainer001_div').style.display='';MTabPanel001.draw();isc.Page.setEvent("load","MTabContainer001.selectTab(0);");</script></div>
<div id="TabPanel001_div2" style="width:100%;height:100%;overflow:hidden;" class="matrixInline">
	<table class="maintain_form_content" style="width:100%;height:100%">
		<tr>
			<td class="query_form_toolbar" colspan="2">
				<script>
						isc.ToolStripButton.create({
							ID:"MtoolBarItem001",
							icon:"<%=request.getContextPath()%>/resource/images/moveup.png",
							title: "上移",
							showDisabledIcon:false,showDownIcon:false 
						});
						MtoolBarItem001.click=function(){
							moveUp();
						}
				</script>
				<script>
						isc.ToolStripButton.create({
							ID:"MtoolBarItem002",
							icon:"<%=request.getContextPath()%>/resource/images/movedown.png",
							title: "下移",
							showDisabledIcon:false,
							showDownIcon:false 
						});
						MtoolBarItem002.click=function(){
							moveDown();
						}
				</script>
				<script>
					isc.ToolStripButton.create({
						ID:"MtoolBarItem003",
						icon:"<%=request.getContextPath()%>/resource/images/delete.png",
						title: "删除",
						showDisabledIcon:false,
						showDownIcon:false 
					});
					MtoolBarItem003.click=function(){
						Matrix.showMask();
						deleteSelections();
						Matrix.hideMask();
					
					}
				</script>
				<script>
					isc.ToolStripButton.create({
						ID:"MtoolBarItem004",
						icon:"<%=request.getContextPath()%>/resource/images/edit.png",
						title: "设置部件",
						showDisabledIcon:false,
						showDownIcon:false 
					});
					MtoolBarItem004.click=function(){
						Matrix.showMask();
						showSelectPartsDialog();
						Matrix.hideMask();
					}
				</script>
				<script>
						isc.ToolStripButton.create({
							ID:"MtoolBarItem005",
							icon:"<%=request.getContextPath()%>/resource/images/submit.png",
							title: "保存",
							showDisabledIcon:false,
							showDownIcon:false 
						});
						MtoolBarItem005.click=function(){
							saveLastSelections();
						}
				</script>
				<script>
						isc.ToolStripButton.create({
							ID:"MtoolBarItem006",
							icon:"<%=request.getContextPath()%>/resource/images/preview.png",
							title: "预览",
							showDisabledIcon:false,
							showDownIcon:false 
						});
						MtoolBarItem006.click=function(){
							var portalId = document.getElementById("uuid").value;
							window.open("<%=request.getContextPath()%>/portal/portalAction_previewOfficePortal.action?portalId="+portalId);
							
						}
				</script>
				<script>
				var flag = false;
						isc.ToolStripButton.create({
							ID:"MtoolBarItem000",
							icon:"<%=request.getContextPath()%>/resource/images/back.png",
							title: "返回门户列表",
							showDisabledIcon:false,
							showDownIcon:false 
						});
						MtoolBarItem000.click=function(){
							//window.open("<%=request.getContextPath()%>/portal/partsAction_saveSelectParts.action");
							isc.confirm("退出前请先保存数据！否则数据会丢失！是否继续离开？",function(value){
							flag = true;
								if(value){
									//saveLastSelections();
									document.getElementById("form0").action="<%=request.getContextPath()%>/portal/portalAction_findAllPortal.action?type=${param.type}";
									document.getElementById("form0").submit();
								}
							});
	
						}
						
						//页面离开事件
						window.onbeforeunload = function(){
							if(!flag){
							return "离开前请先保存数据，否则数据将丢失！";
							}
						}
				</script>
				<div id="QueryForm59ca4db3ea95422cac1938910af18114_tb_div"  style="width:100%;height:30px;;overflow:hidden;position:absolute;top:0px;"  >
					<script>
						isc.ToolStrip.create({
							ID:"MQueryForm59ca4db3ea95422cac1938910af18114_tb",
							displayId:"QueryForm59ca4db3ea95422cac1938910af18114_tb_div",
							width: "100%",height: "100%",
							position: "relative",
							members: [ 
								MtoolBarItem004,
								MtoolBarItem001,
								MtoolBarItem002,
								MtoolBarItem003,
								MtoolBarItem005,
								MtoolBarItem006,
								MtoolBarItem000
							] 
							
						});
						isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"MQueryForm59ca4db3ea95422cac1938910af18114_tb.resizeTo(0,0);MQueryForm59ca4db3ea95422cac1938910af18114_tb.resizeTo('100%','100%');",null);},isc.Page.FIRE_ONCE);
				</script>
			</div>
		</td>
	</tr>

<tr>
		<td colspan="2"
			style="border-style: none; width: 100%;height:95%; margin: 0px; padding: 0px;position:absolute;top:31px;">
		<div id="DataGrid001_div" class="matrixComponentDiv"
			style="width: 100%; height: 100%;">
			<script> 
			var MDataGrid001_DS=<%=request.getAttribute("data")%>;
			isc.MatrixListGrid.create({
			ID:"MDataGrid001",name:"DataGrid001",displayId:"DataGrid001_div",position:"relative",width:"100%",height:"100%",
			
			fields:[
			
			{title:"序号",
				name:"MRowNum",
				canSort:false,
				canExport:false,
				canDragResize:false,
				showDefaultContextMenu:false,
				autoFreeze:true,
				autoFitEvent:'none',
				width:45,
				canEdit:false,
				canFilter:false,
				autoFitWidth:false,
				//计算行数
				formatCellValue:function(value, record, rowNum, colNum,grid){
					if(grid.startLineNumber==null)
						return '&nbsp;';
					return grid.startLineNumber+rowNum;
				}},
			{title:"标题",matrixCellId:"title",name:"title",canEdit:false,editorType:'Text',type:'text'},
			{title:"宽度",matrixCellId:"width",name:"width",canEdit:true,editorType:'Text',type:'text'},
			{title:"高度",matrixCellId:"height",name:"height",canEdit:true,editorType:'Text',type:'text'},
			{title:"行数",matrixCellId:"rows",name:"rows",canEdit:true,editorType:'Text',type:'text'},
			{title:"列数",matrixCellId:"cols",name:"cols",canEdit:true,editorType:'Text',type:'text'}
			],
			autoSaveEdits:false,
			isMLoaded:false,
			autoDraw:false,
			autoFetchData:true,
			selectionType:"multiple",
			selectionAppearance:"rowStyle",
			alternateRecordStyles:true,
			canSort:false,
			autoFitFieldWidths:false,
			startLineNumber:1,
			canCustomFilter:false,
			exportCells:[
				{id:'title',title:'标题'},
				{id:'width',title:'宽度'},
				{id:'height',title:'高度'}
				
			],
			showRecordComponents:true,
			showRecordComponentsByCell:true
			});
			isc.Page.setEvent(
			isc.EH.LOAD,
			function(){
			MDataGrid001.isMLoaded=true;
			MDataGrid001.draw();
			MDataGrid001.setData(MDataGrid001_DS);
			MDataGrid001.resizeTo('100%','100%');
			isc.Page.setEvent(
			isc.EH.RESIZE,
			function(){
			isc.Page.setEvent(
			isc.EH.RESIZE,
			"MDataGrid001.resizeTo(0,0);MDataGrid001.resizeTo('100%','100%');",null);},
			isc.Page.FIRE_ONCE);},isc.Page.FIRE_ONCE);
			if(Matrix.getDataGridIdsHiddenOfForm('form0')){
				Matrix.getDataGridIdsHiddenOfForm('form0').value=Matrix.getDataGridIdsHiddenOfForm('form0').value+',DataGrid001'}
			</script>
			</div>
					<input id="DataGrid001_selection" name="DataGrid001_selection" type="hidden" />
					
	</tr>
	
</table>

</div>
</form></div>
<script>
	function getParamsForDialog3(){
		var params='&';
		var value;
		return params;
	}
	isc.Window.create({
		ID:"MDialog3",
		id:"Dialog3",
		name:"Dialog3",
		autoCenter: true,
		position:"absolute",
		height: "87%",
		width: "80%",
		title: "部件列表",
		canDragReposition: false,
		showMinimizeButton:true,
		showMaximizeButton:true,
		showCloseButton:true,
		showModalMask: false,
		modalMaskOpacity:0,
		isModal:true,
		autoDraw: false,
		headerControls:["headerIcon","headerLabel","closeButton"],
		
		});
		</script>
		<script>MDialog3.hide();
		</script>
		<script>
	function getParamsForDialog3(){
		var params='&';
		var value;
		return params;
	}
	isc.Window.create({
		ID:"MDialog0",
		id:"Dialog0",
		name:"Dialog0",
		autoCenter: true,
		position:"absolute",
		height: "70%",
		width: "60%",
		title: "部件列表",
		canDragReposition: false,
		showMinimizeButton:true,
		showMaximizeButton:true,
		showCloseButton:true,
		showModalMask: false,
		modalMaskOpacity:0,
		isModal:true,
		autoDraw: false,
		headerControls:["headerIcon","headerLabel","closeButton"],
		
		});
		</script>
		<script>MDialog0.hide();
		</script>
<script>document.getElementById('TabPanel001_div').appendChild(document.getElementById('TabPanel001_div2'));</script><div id="TabBar001_div2" style="text-align:right"  class="matrixInline"></div>
<script>document.getElementById('TabBar001_div').appendChild(document.getElementById('TabBar001_div2'));</script><script>document.getElementById('TabContainer001_div').style.display='';</script>

<script>Mform0.initComplete=true;Mform0.redraw();isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"Mform0.redraw()",null);},isc.Page.FIRE_ONCE);</script></body>
</html>
