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
	<title>输出数据映射</title>
	<%@ include file="/form/html5/admin/html5Head.jsp"%>
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
			parent.parent.data = record;     //editFlowProMainPage.jsp记录data
			Matrix.setFormItemValue('structId',record.structId);
			Matrix.setFormItemValue('ysValue',record.value);
			Matrix.setFormItemValue('ysType',record.type);
			var newData = {};
			newData['structId'] = record.structId;
		    if(record.type == 1){       //流程变量
			    var flowType = $('#flowType').val();     //0为外部子流程活动   空为编辑流程
				var url;
				if(flowType == 0){
					var activityId = $('#activityId').val(); 
					url = "<%=request.getContextPath()%>/editor/editor_getValueByStructId.action?activityId='+activityId+'&type=2";
				}else{
					url = "<%=request.getContextPath()%>/editor/process_getValueByStructId.action?type=2";
				}
			    Matrix.sendRequest(url,newData,function(data){
					var result = isc.JSON.decode(data.data);
					var oldValue = result.ysOldValue;
					Matrix.setFormItemValue("oldValue",oldValue); 
					
					var structId = Matrix.getFormItemValue('structId');
					var ysValue = Matrix.getFormItemValue('ysValue');
					var ysType = Matrix.getFormItemValue('ysType');
					var oldValue = Matrix.getFormItemValue("oldValue");
					var params='&';
					var value=null;
					if(structId!=null && structId.length>0){
						value="structId="+structId;
						params+=value;
					}
					if(ysValue!=null && ysValue.length>0){
						value="&ysValue="+ysValue;
						params+=value;
					}
					if(ysType!=null && ysType.length>0){
						value="&ysType="+ysType;
						params+=value;
					}
					if(oldValue!=null && oldValue.length>0){
						value="&oldValue="+oldValue;
						params+=value;
					}
					parent.parent.openParameterMapping(this,params);
					
				});
		    }else{     //静态值
		    	var structId = Matrix.getFormItemValue('structId');
				var ysValue = Matrix.getFormItemValue('ysValue');
				var ysType = Matrix.getFormItemValue('ysType');
				var params='&';
				var value=null;
				if(structId!=null && structId.length>0){
					value="structId="+structId;
					params+=value;
				}
				if(ysValue!=null && ysValue.length>0){
					value="&ysValue="+ysValue;
					params+=value;
				}
				if(ysType!=null && ysType.length>0){
					value="&ysType="+ysType;
					params+=value;
				}
				parent.parent.openParameterMapping(this,params);
		    }
		}	
	}	
	
	
    //选中单击编辑
	function editParamMap(){
		var $tr = $('#DataGrid001_table').find('tr.changeColor');   //选中行
		var index = $tr.data('index'); //获得选中的行的index
		if($tr!=null && $tr.length==1){
			var record = $("#DataGrid001_table").bootstrapTable('getData')[index];  //当前选中行
			selectionData = record;
			parent.parent.data = record;     //editFlowProMainPage.jsp记录data
			Matrix.setFormItemValue('structId',record.structId);
			Matrix.setFormItemValue('ysValue',record.value);
			Matrix.setFormItemValue('ysType',record.type);
			var newData = {};
			newData['structId'] = record.structId;
		    if(record.type == 1){       //流程变量
		        var flowType = $('#flowType').val();     //0为外部子流程活动   空为编辑流程
				var url;
				if(flowType == 0){
					var activityId = $('#activityId').val(); 
					url = "<%=request.getContextPath()%>/editor/editor_getValueByStructId.action?activityId='+activityId+'&type=2";
				}else{
					url = "<%=request.getContextPath()%>/editor/process_getValueByStructId.action?type=2";
				}
			    Matrix.sendRequest(url,newData,function(data){
					var result = isc.JSON.decode(data.data);
					var oldValue = result.ysOldValue;
					Matrix.setFormItemValue("oldValue",oldValue); 
					
					var structId = Matrix.getFormItemValue('structId');
					var ysValue = Matrix.getFormItemValue('ysValue');
					var ysType = Matrix.getFormItemValue('ysType');
					var oldValue = Matrix.getFormItemValue("oldValue");
					var params='&';
					var value=null;
					if(structId!=null && structId.length>0){
						value="structId="+structId;
						params+=value;
					}
					if(ysValue!=null && ysValue.length>0){
						value="&ysValue="+ysValue;
						params+=value;
					}
					if(ysType!=null && ysType.length>0){
						value="&ysType="+ysType;
						params+=value;
					}
					if(oldValue!=null && oldValue.length>0){
						value="&oldValue="+oldValue;
						params+=value;
					}
					parent.parent.openParameterMapping(this,params);
					
				});
		    }else{     //静态值
		    	var structId = Matrix.getFormItemValue('structId');
				var ysValue = Matrix.getFormItemValue('ysValue');
				var ysType = Matrix.getFormItemValue('ysType');
				var params='&';
				var value=null;
				if(structId!=null && structId.length>0){
					value="structId="+structId;
					params+=value;
				}
				if(ysValue!=null && ysValue.length>0){
					value="&ysValue="+ysValue;
					params+=value;
				}
				if(ysType!=null && ysType.length>0){
					value="&ysType="+ysType;
					params+=value;
				}
				parent.parent.openParameterMapping(this,params);
		    }
		}else{
			Matrix.warn("请选择要编辑的参数对象！");
		}
	}
	
	//保存
	function saveParamMap(){
		var flowType = Matrix.getFormItemValue("flowType");
		var structId = Matrix.getFormItemValue("structId");
		var newValue = Matrix.getFormItemValue("newValue");
		var ysValue = Matrix.getFormItemValue("ysValue");
		var ysType = Matrix.getFormItemValue("ysType");
		var type = 2;   //输出参数
		var str = "{'structId':'"+structId+"',";
		str +="'ysType':'"+ysType+"',"; //1-流程变量2-静态值
		str +="'type':'"+type+"',";  //1-输入2-输出
		str +="'newValue':'"+newValue+"',"; 
		str +="'ysValue':'"+ysValue+"'}";
			
		var synJson = isc.JSON.decode(str);
		if(flowType==0&&flowType!=""&&flowType!=null){
			synJson["activityId"]=Matrix.getFormItemValue("activityId");
			var url = "<%=request.getContextPath()%>/editor/editor_saveParamMap.action";
			Matrix.sendRequest(url,synJson,function(){
				
			});
		}else{
	    	var url = "<%=request.getContextPath()%>/editor/process_saveParamMap.action";
	    	Matrix.sendRequest(url,synJson,function(){
				
			});
    	}	
	}
	</script>
</head>
<body>
<div id="j_id1" jsId="j_id1" style="position: relative; _layout: flowlayout; width: 100%; height: 100%">
 <form id="Form0" name="Form0" eventProxy="MForm0" method="post" action="<%=request.getContextPath()%>/editor/process_getCurProcessVarible.action"
	style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
	<input type="hidden" id="structId" name="structId"/>
	<input type="hidden" id="ysValue" name="ysValue"/>
	<input type="hidden" id="ysType" name="ysType"/>
	<input type="hidden" id="oldValue" name="oldValue"/>
	<input type="hidden" id="newValue" name="newValue"/>
	<input type="hidden" name="activityId" id="activityId" value="${param.activityId}" />
	<input type="hidden" name="flowType" id="flowType" value="${param.flowType}" />
	
	<table id="table001" class="tableLayout" style="width: 100%; height: 100%;">
		<tr id="tr002">
			<td id="td002" class="tdLabelCls" style="width: 100%; height: 93%; text-align:left;">
				<table class="query_form_content" style="height: 100%; width: 100%; overflow: hidden; border-collapse: collapse; border-spacing: 0px; table-layout: fixed;">
					<tr>
						<td style="height: 30px;" colspan="2">
							<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemAdd" style="padding-left:5px;padding-right:5px;margin:0px;border:0;" onclick="editParamMap();">
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
								var flowType = $('#flowType').val();     //0为外部子流程活动   空为编辑流程
								var url;
								if(flowType == 0){  
									var activityId = $('#activityId').val(); 
									url = "<%=path%>/editor/editor_getOutputParameter.action?activityId='+activityId+'";
								}else{
									url = "<%=path%>/editor/process_getOutputParameter.action";
								}
								$("#DataGrid001_table").bootstrapTable({           
									classes: 'table table-hover table-no-bordered',
									method: "post", 
									contentType : "application/x-www-form-urlencoded",  //必须配置 不然queryParams传参后台获取不到
									url: url, 
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
								        {title:"映射类型隐藏域",field:"type",sortable:true,clickToSelect:true,editorType:'Text',type:'text',visible:false},
								        {title:"参数对象成员",field:"structId",sortable:true,clickToSelect:true,editorType:'Text',type:'text'},
								        {title:"映射类型",field:"typeName",sortable:true,clickToSelect:true,editorType:'Text',type:'text'},
								        {title:"映射值",field:"value",sortable:true,clickToSelect:true,editorType:'Text',type:'text'}
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