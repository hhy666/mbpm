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
	<title>扩展属性</title>
	<%@ include file="/form/html5/admin/html5Head.jsp"%>
	<style type="">
		font{
			font-size:14px;
			margin-left:10px;
			font-weight:bold;
		}
		#td001{
			width:100%;
			height:30px;
			background:#F8F8F8;
		}
	</style>
	<script type="text/javascript">
	//点击选择
	function singleClickSelect(row, element){
		$('.changeColor').removeClass('changeColor');//去除之前选中的行的，选中样式
		$(element).addClass('changeColor');
	}
	
	var selectionData = {};//记录选中行
	//双击编辑扩展属性
	function doubleClickSelect(record){
		if(record!=null){
			selectionData = record;
			parent.data = record;          //editFlowProMainPage.jsp记录data
			Matrix.setFormItemValue('expandProperty',convertExpandProperty(record.expandProperty));
			Matrix.setFormItemValue('propertyName',record.propertyName);
			Matrix.setFormItemValue('propertyType',convertPropertyType(record.propertyType));
			Matrix.setFormItemValue('propertyValue',record.propertyValue);
			
			var propertyName = Matrix.getFormItemValue('propertyName');
			var expandProperty = Matrix.getFormItemValue('expandProperty');
			var propertyType = Matrix.getFormItemValue('propertyType');
			var propertyValue = Matrix.getFormItemValue('propertyValue');
			parent.openEditExpandInsProperty(this,propertyName,expandProperty,propertyType,propertyValue);     //loadBasicActivityTreeNodePage.jsp弹出
		}
	
	}		
	/**选中单击编辑*/
	function editExpandInsProperty(){
		var $tr = $('#DataGrid001_table').find('tr.changeColor');   //选中行
		var index = $tr.data('index'); //获得选中的行的index
		var activityId = Matrix.getFormItemValue('activityId');
		if($tr!=null && $tr.length==1){
			var record = $("#DataGrid001_table").bootstrapTable('getData')[index];  //当前选中行
			selectionData = record;
			parent.data = record;      //editFlowProMainPage.jsp记录data
			Matrix.setFormItemValue('expandProperty',convertExpandProperty(record.expandProperty));
			Matrix.setFormItemValue('propertyName',record.propertyName);
			Matrix.setFormItemValue('propertyType',convertPropertyType(record.propertyType));
			Matrix.setFormItemValue('propertyValue',record.propertyValue);
			
			var propertyName = Matrix.getFormItemValue('propertyName');
			var expandProperty = Matrix.getFormItemValue('expandProperty');
			var propertyType = Matrix.getFormItemValue('propertyType');
			var propertyValue = Matrix.getFormItemValue('propertyValue');
			parent.openEditExpandInsProperty(this,propertyName,expandProperty,propertyType,propertyValue);     //loadBasicActivityTreeNodePage.jsp弹出
		}else{
			Matrix.warn('请先选择一条数据!');
		}
	}
	
	//保存
	function saveExtendProperties(){
		debugger;
		var data = Matrix.getGridData('DataGrid001');   //所有数据
		if(data!=null && data.length>0){
			var str = "[";
			for(var i = 0;i<data.length;i++){
				var obj = data[i];
				str += "{\\'expandProperty\\':\\'"+convertExpandProperty(obj.expandProperty)+"\\',";
				str +="\\'propertyName\\':\\'"+obj.propertyName+"\\',";
				str +="\\'propertyType\\':\\'"+convertPropertyType(obj.propertyType)+"\\',";
				str +="\\'propertyValue\\':\\'"+obj.propertyValue+"\\'}";
				if(i<data.length-1){
					str+=",";
				}
			}
			str+="]";
			var activityId = Matrix.getFormItemValue('activityId');
			var containerId = Matrix.getFormItemValue('containerId');
			var json = "{'data':'"+str+"','activityId':'"+activityId+"','containerId':'"+containerId+"'}";
			var synJson = isc.JSON.decode(json);
			var url = "<%=request.getContextPath()%>/editor/process_saveExpandProperty.action";
			Matrix.sendRequest(url,synJson,function(){
				
			});
		}
		
	}
	
	function convertExpandProperty(expandProperty){
		if(expandProperty == '扩展属性A'){
			return 'exttributeA';
		}else if(expandProperty == '扩展属性B'){
			return 'exttributeB';
		}else if(expandProperty == '扩展属性C'){
			return 'exttributeC';
		}else if(expandProperty == '扩展属性D'){
			return 'exttributeD';
		}else if(expandProperty == '扩展属性E'){
			return 'exttributeE';
		}else if(expandProperty == '扩展属性F'){
			return 'exttributeF';
		}else if(expandProperty == '扩展属性G'){
			return 'exttributeG';
		}else if(expandProperty == '扩展属性H'){
			return 'exttributeH';
		}
	}
	
	function convertPropertyType(propertyType){
		if(propertyType == '流程变量'){
			return '1';
		}else if(propertyType == '静态'){
			return '2';
		}
	}
	
	function convertPropertyType(propertyType){
		if(propertyType == '流程变量'){
			return '1';
		}else if(propertyType == '静态'){
			return '2';
		}
	}
	
	window.onblur=function(){
		saveExtendProperties();
	}
	</script>
</head>
<body>
<div id="j_id1" jsId="j_id1" style="position: relative; _layout: flowlayout; width: 100%; height: 100%">
 <form id="Form0" name="Form0" eventProxy="MForm0" method="post" action=""
	style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
	<input type="hidden" id="propertyValue" name="propertyValue"/>
	<input type="hidden" id="propertyType" name="propertyType"/>
	<input type="hidden" id="propertyName" name="propertyName"/>
	<input type="hidden" id="expandProperty" name="expandProperty"/>
	<table id="table001" class="tableLayout" style="width: 100%; height: 100%;">
		<tr id="tr001">
			<td id="td001" class="tdLabelCls" style="width: 100%; height:30px; text-align:left;"><font>扩展属性</font></td>
		</tr>
		<tr id="tr002">
			<td id="td002" class="tdLabelCls" style="width: 100%; height: 93%; text-align:left;">
				<table class="query_form_content" style="height: 100%; width: 100%; overflow: hidden; border-collapse: collapse; border-spacing: 0px; table-layout: fixed;">
					<tr>
						<td style="height: 30px;" colspan="2">
							<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemAdd" style="padding-left:5px;padding-right:5px;margin:0px;border:0;" onclick="editExpandInsProperty();">
								<img src="<%=path%>/resource/images/edit.png" style="padding-right: 2px;">编辑
							</button>
						</td>
					</tr>
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
									url: "<%=path%>/editor/process_getProcessPropertyList.action", 
									search: false,    //是否启用搜索框
									sortable: false,  //是否启用排序
									pagination:false, //是否启用分页
									sidePagination: "server",								
									formatLoadingMessage: function() {
							            return '请稍等，正在加载中...';
								    },
									formatNoMatches: function() {
							            return '无符合条件的记录';
							        },
								    columns: [
								        {title:"扩展属性",field:"expandProperty",sortable:true,clickToSelect:true,editorType:'Text',type:'text'},
								        {title:"属性名称",field:"propertyName",sortable:true,clickToSelect:true,editorType:'Text',type:'text'},
								        {title:"属性类型",field:"propertyType",sortable:true,clickToSelect:true,editorType:'Text',type:'text'},
								        {title:"属性值",field:"propertyValue",sortable:true,clickToSelect:true,editorType:'Text',type:'text'}
								    ],
								    onClickRow:function(row, $element){   //单击行事件
								    	singleClickSelect(row, $element);
									},
								    onDblClickRow:function(row){   //双击行事件
								    	doubleClickSelect(row);
									},
								});
						     });											
							</script>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
 </form>
</div>
</body>
</html>