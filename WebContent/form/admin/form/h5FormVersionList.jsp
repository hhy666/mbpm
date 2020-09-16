<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
<meta charset="UTF-8">
<title>H5表单版本列表</title>
<jsp:include page="/form/html5/admin/html5Head.jsp"/>
<script type="text/javascript">
	//点击选择
	function singleClickSelect(row, element){
		$('.changeColor').removeClass('changeColor');//去除之前选中的行的，选中样式
		$(element).addClass('changeColor');
	}
	
	//双击编辑表单
	function doubleClickSelect(record){
		if(record!=null){
			var url = "<%=request.getContextPath()%>/form/formInfo_updateH5FormVersion.action?state="+record.state;
			var formUuid = record.uuid;
			var synJson = {'formUuid':formUuid};
			Matrix.sendRequest(url,synJson,function(data){
				if(data != null && data.data != null){
					var json = isc.JSON.decode(data.data);
					if(json.result){
						//编辑成功后跳转到设计页面
						parent.$('#content').attr('src','<%=path%>/form/admin/designer/designer.jsp');
						var data = {};
						data.opType = 'update';
						var version = record.version;  //当前要编辑的版本的版本号
						data.version = version;
						Matrix.closeWindow(data);
					}else{
						Matrix.warn("编辑失败！");
					}
				}
			});
		}else{
			Matrix.warn("请选择表单版本！");
		}
	}	
	
    //编辑表单版本
    function updateFormVersion(){
    	var $tr = $('#DataGrid001_table').find('tr.changeColor');   //选中行
		if($tr!=null && $tr.length==1){
			var index = $tr.data('index');  //获得选中的行的index
       		var item = Matrix.getGridData('DataGrid001');   //所有数据
       		var record = item[index];  //当前选中行
       		doubleClickSelect(record);
		 }else{
			Matrix.warn("请先选择表单版本！");
		 }			 
    }
	
    //删除表单版本
    function deleteFormVersion(){
    	debugger;
    	var $tr = $('#DataGrid001_table').find('tr.changeColor');   //选中行
		if($tr!=null && $tr.length==1){
			var index = $tr.data('index');  //获得选中的行的index
       		var item = Matrix.getGridData('DataGrid001');   //所有数据
       		var record = item[index];  //当前选中行
       		var formType = $('#formType').val();   //表单类型  pc电脑   mo移动
       		if(item.length==1 && formType=='pc'){      //移动表单最后一个版本可以删除
       			Matrix.warn("只有一个表单版本不可删除！");
     			return false;
       		}
       		if(record.version==0){
     			Matrix.warn("该版本不支持此操作！");
     			return false;
     		}
       		var state = record.state;
    		//是否发布
    		if(state==1){
    			Matrix.warn("表单已发布，不能执行删除操作！");
    			return false;
    		}
    
    		layer.confirm("您确定要删除该表单版本？", {
 			   btn: ['确定','取消'],  //按钮
 			   closeBtn:0
 	        },function(index){
 	        	var uuid = record.uuid;
 	        	var synJson = {'uuid':uuid};
 				var url = "<%=request.getContextPath()%>/form/formInfo_deleteH5FormVersion.action";
 				Matrix.sendRequest(url,synJson,function(data){
 					if(data.data!=null){
 						var result = isc.JSON.decode(data.data);
 						if(result.result){
 							Matrix.refreshDataGridData('DataGrid001');
 							if(formType=='pc'){  //电脑表单
 								parent.changePC();
 							}else if(formType=='mo'){  //移动表单
 								//还要删除Catalog目录
								if(item.length==1 && formType=='mo'){      //移动表单最后一个版本要删除目录 并且关闭窗口
									parent.deleteMobileForm();
									var data = {};
			    					data.opType = 'delete';
									Matrix.closeWindow(data);
								}else{
									parent.changeMobile();
									Matrix.warn('删除成功！');
								}
 							}
 						}else{
 							Matrix.warn("删除失败！");
 						}
 					}
 				});	
 				layer.close(index);
 	        })
 	        
		}else{
			Matrix.warn("请先选择表单版本！");
		}			 
	}
    
    //复制一个新的表单版本
	function copyFormVersion(){
		var $tr = $('#DataGrid001_table').find('tr.changeColor');   //选中行
		if($tr!=null && $tr.length==1){
			var index = $tr.data('index');  //获得选中的行的index
       		var item = Matrix.getGridData('DataGrid001');   //所有数据
       		var record = item[index];  //当前选中行
       		var formUuid = record.uuid;
       		
       		var synJson = Matrix.formToObject("form0");
       		synJson.formUuid = formUuid;
       		var url = "<%=request.getContextPath()%>/form/formInfo_copyH5FormVersion.action";
       		Matrix.sendRequest(url,synJson,function(data){
    			if(data != null && data.data != null){
    				var json = isc.JSON.decode(data.data);
    				if(json.result){
    					//复制成功后跳转到设计页面
    					parent.$('#content').attr('src','<%=path%>/form/admin/designer/designer.jsp');
    					var data = {};
    					data.opType = 'copy';
    					var version = json.version;   //复制成功后的复制版本的版本号
						data.version = version;
    					Matrix.closeWindow(data);
    				}else{
    					Matrix.warn("复制失败！");
    				}
    			}
    		});
		}else{
			Matrix.warn("请先选择表单版本！");
		}			 
	}
  
	//放到body标签的onload方法中
	function format(){
	 	var createdUser = Matrix.getFormItemValue('createdUser');
	 	if(createdUser=='null'){
	 		Matrix.setFormItemValue('createdUser'," ");
	 	}
	}
  </script>
</head>
<body onload="format()">
	<form id="form0" name="form0" eventProxy="Mform0" method="post" style="margin: 0px; position: relative; overflow: auto; width: 100%; height: 100%;padding-left:6px;padding-right:6px;">
		<input type="hidden" name="form0" value="form0" />
		<!-- 表单类型  pc电脑   mo移动 -->
		<input type="hidden" id="formType" name="formType" value="${param.formType}">
		<!-- commom cols -->
		<input type="hidden" id="nodeUuid" name="nodeUuid" value="${formInfo.nodeUuid}">

		<!-- 实体类型 entity[1] or query Obj [2]  -->
		<input type="hidden" id="type" name="type" value="${formInfo.type}">
		<input type="hidden" id="version" name="version"/><!-- 添加时动态写入值 -->
		
		<input type="hidden" id="mid" name="mid" value="${formInfo.mid}">
		<input type="hidden" id="name" name="name" value="${formInfo.name}">
		<input type="hidden" id="desc" name="desc" value="${formInfo.desc}">
		<input type="hidden" id="createdUser" name="createdUser" value="${formInfo.createdUser }"/>  
		<!-- <input type="hidden" id="createdDate" name="createdDate" value="${formInfo.createdDate }"/>-->
		<input type="hidden" id="operatorName" name="operatorName" value="${formInfo.operatorName }"/>
		
		<div style="display: block;padding-top:1px;">
			<table id="DataGrid001_table" style="width:100%;">
			</table>
			
			<script type="text/javascript">
				$(document).ready(function() { 
					var nodeUuid = $("#nodeUuid").val();
					$("#DataGrid001_table").bootstrapTable({           
						classes: 'table table-hover table-no-bordered',
						method: "post", 
						contentType : "application/x-www-form-urlencoded",  //必须配置 不然queryParams传参后台获取不到
						url: "<%=request.getContextPath() %>/form/formInfo_getFormVersionList.action?nodeUuid="+nodeUuid, 
						search: false,    //是否启用搜索框
						sortable: false,  //是否启用排序
						pagination:false, //是否启用分页
						sidePagination: "server",   //指定服务器端分页
						formatLoadingMessage: function() {
				            return '请稍等，正在加载中...';
					    },
						formatNoMatches: function() {
				            return '无符合条件的记录';
				        },
					    columns: [
					        {
					         title : '序号',
					         align: "center",
					         width: 50,
					         formatter: function (value, row, index) {
					        	  //获取每页显示的数量
					        	  var pageSize=$('#DataGrid001_table').bootstrapTable('getOptions').pageSize;  
					        	  //获取当前是第几页  
					        	  var pageNumber=$('#DataGrid001_table').bootstrapTable('getOptions').pageNumber;
					        	  //返回序号，注意index是从0开始的，所以要加上1
					        	  return pageSize * (pageNumber - 1) + index + 1;
					          }				 
						    },          
						    {title:"主键编码",field:"uuid",sortable:true,clickToSelect:true,editorType:'Text',type:'text',visible:false},
					        {title:"版本号",field:"version",sortable:true,clickToSelect:true,editorType:'Text',type:'text'},
					    	{title:"创建人",field:"createdUser",sortable:true,clickToSelect:true,editorType:'Text',type:'text'},
					    	{title:"创建时间",field:"createdDate",sortable:true,clickToSelect:true,editorType:'Text',type:'text'},
					    	{title:"发布人",field:"publishedUser",sortable:true,clickToSelect:true,editorType:'Text',type:'text'},
					    	{title:"发布时间",field:"publishedDate",sortable:true,clickToSelect:true,editorType:'Text',type:'text'},
					    	{title:"当前操作人",field:"operatorName",sortable:true,clickToSelect:true,editorType:'Text',type:'text'},
					    	{title:"状态",field:"state",sortable:true,clickToSelect:true,editorType:'Text',type:'text',
					    		formatter: function (value, row, index) {
					               if(value == '0') {
					                  return "未发布";
					               }else if(value == '1'){
					                  return "发布";
					               }
						        }
					    	}
					    ],
					    singleSelect:true,  //设置true将禁止多选
					    onClickRow:function(row, $element){   //单击行事件
					    	singleClickSelect(row, $element);
						},
					    onDblClickRow:function(row){   //双击行事件
					    	doubleClickSelect(row);
						},
				  });
			    });
			</script>
		</div>
		<div class="cmdLayout">
			<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemCopy" style="padding-left:5px;padding-right:5px;margin:0px;border:0;" onclick="copyFormVersion();">
				<img src="<%=path%>/resource/images/relatarc.png" style="padding-right: 2px;">复制
			</button>
			<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemEdit" style="padding-left:5px;padding-right:5px;margin:0px;border:0;" onclick="updateFormVersion();">
				<img src="<%=path%>/resource/images/edit.png" style="padding-right: 2px;">编辑
			</button>
			<button type="button" class="btn  btn-default toolBarItem" id="MtoolBarItemDel" style="padding-left:5px;padding-right:5px;margin:0px;border:0;" onclick="deleteFormVersion();">
				<img src="<%=path%>/resource/images/deletex.png" style="padding-right: 4px;">删除
			</button>	
		</div>
	</form>
</body>
</html>