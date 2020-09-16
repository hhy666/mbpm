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
<title>参数对象信息页</title>
<%@ include file="/form/html5/admin/html5Head.jsp"%>
<style type="text/css">
	#font2{
		font-size:14px;
		margin-left:10px;
		font-weight:bold;
	}
</style>
<script type="text/javascript">
	//点击选择
	function singleClickSelect(row, element){
		$('.changeColor').removeClass('changeColor');//去除之前选中的行的，选中样式
		$(element).addClass('changeColor');
	}
	//添加参数对象
	function addDeclaration(){
		var tddid = Matrix.getFormItemValue('tddid');
		layer.open({
			id:'Dialog1',
			type : 2,
			
			title : ['添加参数对象成员'],
			shadeClose: false, //开启遮罩关闭
			area : [ '45%', '75%' ],
			content : '<%=request.getContextPath()%>/editor/process_editDeclarationChild.action?iframewindowid=Dialog1&editFlag=add&tddid='+tddid	
		});  	
	}
	
	//修改参数对象
	function editDeclaration(){
		var $tr = $('#DataGrid001_table').find('tr.changeColor');   //选中行
		if($tr!=null && $tr.length==1){
			var index = $tr.data('index'); //获得选中的行的index
			var record = $("#DataGrid001_table").bootstrapTable('getData')[index];  //当前选中行
			var name = record.name;
			var tddid = Matrix.getFormItemValue('tddid');
			layer.open({
    			id:'Dialog1',
    			type : 2,
    			
    			title : ['编辑参数对象成员'],
    			shadeClose: false, //开启遮罩关闭
    			area : [ '45%', '75%' ],
    			content : '<%=request.getContextPath()%>/editor/process_editDeclarationChild.action?iframewindowid=Dialog1&editFlag=edit&name='+name+'&tddid='+tddid	
    		});  	
		}else{
			 Matrix.warn('请选择要编辑的参数对象成员！');
		}
	}
	
	//删除参数对象成员
	function deleteDeclaration(){
		var select = $('#DataGrid001_table').find('tr.changeColor');
		if(select!=null && select.length>0){
			var index = $('#DataGrid001_table').find('tr.changeColor').data('index');//获得选中的行的id
			var record = $("#DataGrid001_table").bootstrapTable('getData')[index];  //当前选中行
			var name = record.name;
			layer.confirm("确认删除"+name+"？", {
			   btn: ['确定','取消'],  //按钮
			   closeBtn:0
	        },function(windowId){
	        	var tddid = Matrix.getFormItemValue('tddid');
	        	var url = "<%=request.getContextPath()%>/editor/process_deleteDeclarationChild.action?tddid="+tddid+"&name="+name;
	        	Matrix.sendRequest(url,{'name':name},function(data){
	        		if(data!=null && data.data!=''){
	        			var result = isc.JSON.decode(data.data);
						if(result.result){
							Matrix.refreshDataGridData('DataGrid001');
						}else{
							Matrix.warn("未成功删除该参数对象成员!");
						}
					}
				});	
				layer.close(windowId);
	        })
		}else{
			Matrix.warn("请选择一条需要删除的参数对象成员!");
		}
	}
	
	//页面失焦事件
	window.onblur = function(){
		var synJson = Matrix.formToObject('form0'); 
		if(synJson!=null){
			var url = "<%=request.getContextPath()%>"+"/editor/process_saveDeclaration.action";
			Matrix.sendRequest(url,synJson,function(){
				return true;
			});
		}
	}
	
	//弹出窗口回调
	function onDialog1Close(){	
		Matrix.refreshDataGridData('DataGrid001');
	}
</script>
</head>
<body>
  <div style="width: 100%; height: 100%; position: relative;">
	 <form id="form0" name="form0" eventProxy="Mform0" method="post" action="<%=request.getContextPath()%>/editor/process_getTypeDeclarationByStructId.action?structId=${param.structId}"
		  style="margin: 0px; position: relative; width: 100%; height: 100%;" enctype="application/x-www-form-urlencoded">
		  <input type="hidden" name="editFlag" id="editFlag" />
		  <input type="hidden" name="index" id="index" value="${param.index }"/>
		  <input type="hidden" name="tddid" id="tddid" value="${structId}" />
		  		<div style="height: 30px;width: 100%;background: #F8F8F8;">
					<label style="margin-top: 5px;"><font id="font2">对象信息</font></label>
				</div>
				<div style="height: 36px;width: 100%;background: #F8F8F8;">
					<label id="label002" name="label002" id="label002" style="height: 100%;width: 20%;text-align: center;">
					        名称:
					</label>
					 <div id="input001_div" style="vertical-align: middle;display:inline-block;height: 100%;width: 30%;">
						<input id="input001" name="input001" type="text" value="${tname}" onkeyup="changeContent();" class="form-control" style="height:100%;width:100%;"/>
					</div>
				</div>
				<script>
					function changeContent(){
				         var name = Matrix.getFormItemValue('input001');//名称
				         var index = Matrix.getFormItemValue('index');
						 parent.updateName(name,index);
				    }
				</script>
				<div style="height: 30px;width: 100%;background: #F8F8F8;">
					<label><font id="font2">对象成员</font></label>
				</div>
				<div style="height: 30px;width: 100%;background: #F8F8F8;">
					<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemAdd" style="padding-left:5px;padding-right:5px;margin:0px;border:0;" onclick="addDeclaration();">
							<img src="<%=path%>/resource/images/new.png" style="padding-right: 2px;">添加
					</button>
					<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemDel" style="padding-left:5px;padding-right:5px;margin:0px;border:0;" onclick="editDeclaration();">
						<img src="<%=path%>/resource/images/edit.png" style="padding-right: 4px;">修改
					</button>	
					<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemMoveDown" style="padding-left:5px;padding-right:5px;margin:0px;border:0;" onclick="deleteDeclaration();">
						<img src="<%=path%>/resource/images/deletex.png" style="padding-right: 2px;">删除
					</button>	
				</div>
				<div style="height: calc(100% - 126px);width: 100%;overflow: auto">
					<table id="DataGrid001_table" style="width:100%;height:100%;">		
						</table>
						<script>
							$(document).ready(function() {   
								$("#DataGrid001_table").bootstrapTable({           
									classes: 'table table-hover table-no-bordered',
									method: "post", 
									contentType : "application/x-www-form-urlencoded",  //必须配置 不然queryParams传参后台获取不到
									url: "<%=request.getContextPath()%>/editor/process_getParameterObjectList.action", 
									search: false,    //是否启用搜索框
									sortable: false,  //是否启用排序
									pagination:false, //是否启用分页
									sidePagination: "server",   //指定服务器端分页
									queryParams: queryParams,   //传参
									//clickToSelect: true,    //设置true 将在点击行时,自动选择radiobox 和 checkbox
									formatLoadingMessage: function() {
							            return '请稍等，正在加载中...';
								    },
									formatNoMatches: function() {
							            return '无符合条件的记录';
							        },
								    columns: [       //列配置项		
								        {title:"名称",field:"name",sortable:true,clickToSelect:true,editorType:'Text',type:'text'},
								        {title:"描述",field:"description",sortable:true,clickToSelect:true,editorType:'Text',type:'text'}
								    ],
								    //singleSelect:true,   //设置true将禁止多选
								    onClickRow:function(row, $element){   //点击行事件 跳转
								    	singleClickSelect(row, $element);
									},
								});
						     });
							 function queryParams(params) {
							      var temp = {   
							    	  structId:$("#tddid").val()				    	
							      };
							      return temp;
							 };
						</script>	
				</div>
		</form>
	</div>
 </body>
</html>
