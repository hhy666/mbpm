<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>载入字段列表</title>
<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>
<script type="text/javascript">
	//提交时 选中数据
	function submitSelectData(){
		var seRecords = MDataGrid0.getSelection();
		if(seRecords!=null&&seRecords.length>0){
			var selectedDataStr = "["+Matrix.itemsToJson(seRecords,MDataGrid0)+"]";
			var columnObjs = isc.JSON.decode(selectedDataStr);
			Matrix.closeWindow(columnObjs);
		
		}
	
	}

</script>
</head>
<body>
<jsp:include page="/form/admin/common/loading.jsp" />

<script>
	 var MForm0=isc.MatrixForm.create({
	 		ID:"MForm0",
	 		name:"MForm0",
	 		position:"absolute",
	 		action:"",
	 		fields:[{
	 			name:'Form0_hidden_text',
	 			width:0,
	 			height:0,
	 			displayId:'Form0_hidden_text_div'
	 		}]
	  });
</script>

<form id="Form0" name="Form0" eventProxy="MForm0" method="post"
	action="<%=request.getContextPath()%>/process/processTmplAction_queryPkgTemplates.action"
	style="margin: 0px; height: 100%;"
	enctype="application/x-www-form-urlencoded">
	<div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div" style="position: absolute; width: 0; height: 0; z-index: -9999999999; top: 0; left: 0; display: none;"></div>
	<input type="hidden" name="Form0" value="Form0" /> 
	

<table id="dataTable" jsId="dataTable" cellpadding="0px"
	cellspacing="0px" style="width: 100%; height: 100%;">
	

	<tr id="j_id7" jsId="j_id7">
		<td id="j_id9" jsId="j_id9" rowspan="1"
			style="border-style: none; width: 100%;">
			<div id="DataGrid0_div" class="matrixComponentDiv"
				style="width: 100%; height: 100%;">
				<script>
					var displayValueMap = {'1':'字符型','2':'整型','3':'长整型','4':'单精度小数','5':'双精度小数','6':'布尔型','7':'日期时间','8':'二进制','9':'数值','14':'任意对象','13':'关联对象'};
				
				
					var gridData = eval(${pkgTmpls}); 
					isc.MatrixListGrid.create({
						ID:"MDataGrid0",
						name:"DataGrid0",
						canSort:true,
						displayId:"DataGrid0_div",
						position:"relative",
						selectionAppearance:"checkbox",
						alternateRecordStyles:true,
						width:"100%",
						height:"100%",
						fields:[
						  {title:"编码",	name:"mid",canEdit:false},
						  {title:"名称",name:"name",canEdit:false},
						  {title:"字段名",name:"colName",canEdit:false},
						  {
							  title:"类型",
							  name:"type" ,
							  
							  type:'integer',
							  valueMap:['1','2','3','4','5','6','7','8','9','14','13'],
							  autoFetchDisplayMap:true,
							  editorProperties:{
					  			displayValueMap: displayValueMap	 	
					  		  },
					  		  formatCellValue:function(value, record, rowNum, colNum,grid){
					  			if(value==null){
					  				return "";
					  			}
					  			return displayValueMap[value];
					  		 },
							  canEdit:false
						   }
						],
						data:gridData,
						autoFetchData:true,
						alternateRecordStyles:true,
						canAutoFitFields:false,
					
						
						recordDoubleClick:function(viewer, record, recordNum, field, fieldNum, value, rawValue) {
		                     
		                }
					});
			 		MDataGrid0.setData(${requestScope.epListJson});
					//isc.Page.setEvent(isc.EH.LOAD,"MDataGrid0.resizeTo('100%','100%');");
					isc.Page.setEvent(isc.EH.RESIZE,"MDataGrid0.resizeTo(0,0);MDataGrid0.resizeTo('100%','100%');",null);
			 		
				</script>
			</div>
		</td>
	</tr>
	
	 <tr id="j_id9" jsId="j_id9" height="20px">
                            <td id="j_id10" jsId="j_id10" colspan="2" rowspan="1">
                               
                                
                                 <script>
                                isc.ToolStripButton.create({
                                    ID: "MToolBarItem1",
									icon:Matrix.getActionIcon("save"),
                                    title: "确认",
                                    
                                    showDisabledIcon: false,
                                    showDownIcon: false
                                });
                                MToolBarItem1.click = function() {
                                    Matrix.showMask();
                                    submitSelectData();
                                    Matrix.hideMask();
                                }
                            </script>
                            <script>
                                isc.ToolStripButton.create({
                                    ID: "MToolBarItem2",
                                    icon:Matrix.getActionIcon("exit"),
                                    title: "关闭",
                                    showDisabledIcon: false,
                                    showDownIcon: false
                                });
                                MToolBarItem2.click = function() {
                                    Matrix.showMask();
                                    Matrix.closeWindow();
                                    Matrix.hideMask();
                                }
                            </script>
                            
                                <div id="ToolBar0_div" style="width: 100%; overflow: hidden;">
                                    <script>
                                        isc.ToolStrip.create({
                                            ID: "MToolBar0",
                                            displayId: "ToolBar0_div",
                                            width: "100%",
                                            height: "*",
                                            position: "relative",
                                            align: "center",
                                            members: [MToolBarItem1, "separator", MToolBarItem2]
                                        });
                                        isc.Page.setEvent(isc.EH.RESIZE, "MToolBar0.resizeTo(0,0);MToolBar0.resizeTo('100%','100%');", null);
                                    </script>
                                </div>
                            </td>
                        </tr>
</table>
</form>
<script>
	MForm0.initComplete=true;
	MForm0.redraw();
	isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);
	
</script>
</body>
</html>