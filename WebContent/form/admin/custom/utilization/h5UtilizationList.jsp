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
<title>应用设置显示页面</title>
<link href='<%=request.getContextPath() %>/resource/html5/css/matrix_runtime.css' rel="stylesheet"></link>
<link href='<%=request.getContextPath() %>/resource/html5/css/bootstrap/dist/css/bootstrap.min.css' rel="stylesheet"></link>
<link href='<%=request.getContextPath() %>/resource/html5/css/font-awesome.min.css' rel="stylesheet"></link>
<link href='<%=request.getContextPath() %>/resource/html5/css/square/blue.css' rel="stylesheet"></link>
<link href='<%=request.getContextPath() %>/resource/html5/css/bootstrap-select.css' rel="stylesheet"></link> 
<link href='<%=request.getContextPath() %>/resource/html5/css/custom.css' rel="stylesheet"></link>
<link href='<%=request.getContextPath() %>/resource/html5/css/skin/mCustom_<%=session.getAttribute("skin") %>.css' rel="stylesheet"></link>
<link href='<%=request.getContextPath() %>/resource/html5/assets/toastr-master/toastr.min.css'  rel="stylesheet"></link>
<!-- bootstrap select和layer资源 -->
<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/jquery.min.js'></SCRIPT>
<script src='<%=request.getContextPath() %>/resource/html5/js/layer.min.js'></script>
<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/css/bootstrap/dist/js/bootstrap.min.js'></SCRIPT>
<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/bootstrap-select.js'></SCRIPT>
<!-- iCheck资源 -->
<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/icheck.min.js'></SCRIPT>
<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/autosize.min.js'></SCRIPT>
<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/matrix_runtime.js'></SCRIPT>
<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/validator.js'></SCRIPT>
<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/assets/toastr-master/toastr.min.js'></SCRIPT>
<style type="text/css">
	*{
		-webkit-user-select: none;
	    -khtml-user-select: none;
	    -moz-user-select: none;
	    -ms-user-select: none;
	    -o-user-select: none;
	    user-select: none;
	}
	body, ul{
	    margin: 0;
	    padding: 0;
	    font-size: 14px;
	}
	div, ul{
		box-sizing: border-box;
	}
	.dropdown-menu {
	    position: absolute;
	    top: 100%;
	    left: 0;
	    z-index: 1000;
	    display: none;
	    float: left;
	    min-width: 100px;
	    padding: 5px 0;
	    margin: 2px 0 0;
	    font-size: 14px;
	    text-align: left;
	    list-style: none;
	    background-color: #fff;
	    -webkit-background-clip: padding-box;
	    background-clip: padding-box;
	    border: 1px solid #ccc;
	    border: 1px solid rgba(0, 0, 0, .15);
	    border-radius: 4px;
	    -webkit-box-shadow: 0 6px 12px rgba(0, 0, 0, .175);
	    box-shadow: 0 6px 12px rgba(0, 0, 0, .175);
	}
	.dropdown-menu.operation> li > a:hover, .dropdown-menu.operation > li > a:focus {
	    color: #262626;
	    text-decoration: none;
	    background-color: rgba(13,179,166,.1);
	}
</style>
<script type="text/javascript">
	var showListName = [];   //电脑端输出数据项
	var showMobileListName = [];   //移动端输出数据项
	var sortName = [];   //排序设置
	var hignCondition = [];  //高级查询条件
	
	window.onload = function(){
		//parent.$('#loading').css('display','none');
		parent.Matrix.hideMask2();
		parent.layer.close(parent.layer.load());//关闭加载层
	}
	
	$(function(){
		getData('selectOne','init');
	})
	
	//下拉框改变事件
	function changeModule(){
		//获取编辑下拉框应用设置
		editUtilization();
	}
	
	//判断有无应用设置  有则加载初始化下拉框  无则显示添加界面
	function getData(optionId,operation){
		debugger;
		var catalogId = $('#catalogId').val();
		var json = {};
		json.catalogId = catalogId;
		$.ajax({
			type:'post',
			url:'<%=path %>/utilization/utili_getUtilizationList.action',
			data:json,
			dataType:'json',
			success:function(data){
				if(data.length == 0){
					$('#web1').css('display','');
					$('#web2').css('display','none');
					var html = "";
					html += '<div id="module_div" style="height: 50px;line-height: 50px;float:left;">';
					html += '</div>';
					$('#top').prepend(html);
				}else{
					$('#web1').css('display','none');
					$('#web2').css('display','');
					$('#toolbar').css('display','');  //显示操作下拉菜单
					var html = "";
					html += '<div id="module_div" style="height: 50px;line-height: 50px;float:left;">';
					html += '<div style="height: 50px;line-height: 50px;float:left;padding-left: 20px;">';
					html += '<label style="font-weight: bold;font-size: 14px;color:rgb(22, 105, 171);">管理名称：</label>';
					html += '</div>';
					html += '<div style="height: 50px;float:left;">';
					html += '<select id="module" name="module" onchange="changeModule();">';
					html += '</div>';
					html += '</div>';
					
					var recordId;
					for(var i=0;i<data.length;i++){
						var uuid = data[i].uuid;
						var name = data[i].name;
						html += '<option value=\''+uuid +'\'';
						if(optionId == 'selectOne'){    //初始加载时默认选中第一个选项
							if(i==0){
								html += ' selected = selected';
								recordId = uuid;
							}
						}else if(optionId == uuid){  
							html += ' selected = selected';
							recordId = uuid;
						}	
						html += '>'+ name +'</option>';				
					}
					html += '</select>';
					$('#top').prepend(html);
					
					$('#module').selectpicker({
						 isOpen:true,
						 noneSelectedText:'请选择',
						 noneResultsText:'没有找到该选项',
						 width:300,
						 maxheight:150,
						 liveSearch:true,
						 liveSearchPlaceholder:'输入关键字进行搜索',
						 actionsBox:true,
						 minheight:80,
					});
					$('.selectpicker').selectpicker('refresh');//动态刷新
					//加载详细信息页面
					if(operation == 'init'){
						getUtilizationDetail(recordId);
					}
					if(operation == "add"){     //添加  
						getUtilizationDetail(recordId);
						Matrix.say('保存成功');				
					}else if(operation == "copy"){  //复制
						getUtilizationDetail(recordId);
						Matrix.say('复制成功！');
					}else if(operation == "update"){   //修改
						Matrix.say("更新成功");
					}
				}
				
			}
		});
	}
	
	//根据应用设置主键加载应用设置详细信息页面
	function getUtilizationDetail(uuid){
		var catalogId = $('#catalogId').val();
		var formId = $('#formId').val();
		var formFlag = formId + "EntityVar";
		if(uuid!=null && uuid!=''){
			var src = "<%=path %>/form/admin/custom/utilization/h5UtilizationTabPage.jsp?formFlag="+formFlag+"&catalogId="+catalogId+"&oType=update&formId="+formId+"&uuid="+uuid;
			document.getElementById('iframeContent').src = src;	
		}else{
			Matrix.warn('该应用设置不存在！');
		}
	}
	
	//没有应用设置时新增
	function createNew(){
		$('#web1').css('display','none');
		$('#web2').css('display','');
		addUtilization();
	}
	
	//添加应用设置
	function addUtilization(){
		debugger;
		var catalogId = $('#catalogId').val();
		var formId = $('#formId').val();
		var formFlag = formId + "EntityVar";
		var url = "<%=request.getContextPath()%>/query/query_getUUID.action";
		Matrix.sendRequest(url,null,function(data){	  
			var callbackJson = isc.JSON.decode(data.data);
			if(callbackJson!=null){  
			   $('#toolbar').css('display','none');  //隐藏操作下拉菜单
			   var content = "";
			   content += '<div style="height: 50px;line-height: 50px;float:left;padding-left: 20px;">';
			   content += '<label style="font-weight: bold;font-size: 14px;color:rgb(22, 105, 171);">添加应用设置</label>';
			   content += '</div>';
			   $("#module_div").html(content);
				
			   var uuid = callbackJson.uuid;
			   var src = "<%=path %>/form/admin/custom/utilization/h5UtilizationTabPage.jsp?formFlag="+formFlag+"&catalogId="+catalogId+"&oType=add&formId="+formId+"&uuid="+uuid;
			   document.getElementById('iframeContent').src = src;	
			}else{
			   Matrix.warn('添加失败');
			}    
		});	
	}
	
	//编辑应用设置
	function editUtilization(){
		var uuid = $("#module").val();
		var catalogId = $('#catalogId').val();
		var formId = $('#formId').val();
		var formFlag = formId + "EntityVar";
		
		if(uuid!=null && uuid!=''){
			var src = "<%=path %>/form/admin/custom/utilization/h5UtilizationTabPage.jsp?formFlag="+formFlag+"&catalogId="+catalogId+"&oType=update&formId="+formId+"&uuid="+uuid;
			document.getElementById('iframeContent').src = src;	
		}else{
			Matrix.warn('该应用设置不存在！');
		}
		
	}
	
	//复制应用设置
	function copyUtilization(){
		if($("#module").val()!=null){
			var uuid = $("#module").val();
			var formId = $("#formId").val();
			var catalogId = $("#catalogId").val()
			
			var url = "<%=request.getContextPath()%>/utilization/utili_copyUtilization.action?formId="+formId;
			var synJson = {'data':'{"uuid":"'+uuid+'","catalogId":"'+catalogId+'"}'};
			Matrix.sendRequest(url,synJson,function(data){
				var callbackJson = isc.JSON.decode(data.data);
				if(callbackJson!=null){   	
				    if(callbackJson!=null&&callbackJson.result==true){
						//刷新下拉框 并设置选中
						$("#module_div").remove();
						var copyUuid = callbackJson.uuid;
						getData(copyUuid,'copy');
					}
				}else{
					Matrix.say('复制失败！');
				}
			});	
		}else{
			Matrix.warn('应用设置为空不能复制！');
		}
	}
	
	//删除应用设置
	function deleteUtilization(){
		var uuid = $("#module").val();
		if(uuid!=null && uuid!=''){
			layer.confirm("确认删除？", {
			   btn: ['确定','取消'],  //按钮
			   closeBtn:0
	        },function(index){
	        	var synJson = {'uuid':uuid};
				var url = "<%=request.getContextPath()%>/utilization/utili_deleteUtilization.action";
				Matrix.sendRequest(url,synJson,function(data){
					var callbackJson = isc.JSON.decode(data.data);
					if(callbackJson!=null){   	
					    if(callbackJson!=null&&callbackJson.result==true){
							Matrix.say('删除成功！');
							//刷新下拉框 并设置选中
							$("#module_div").remove();
							getData('selectOne','init');
						}
					}else{
						Matrix.say('删除失败！');
					}
				});	
				layer.close(index);
	        })
		}else{
			Matrix.warn('该应用设置不存在！');
		}
	}
	
	//上移应用设置
	function moveUpUtilization(){
		var checkIndex=$("#module ").get(0).selectedIndex; //获取Select选择的索引值
		if(checkIndex>0){
			var uuid = $("#module").val();   //当前主键编码
			var beforeSelected =  $("#module").find("option:selected").prev().val();  //上一条主键编码   
			var catalogId = $('#catalogId').val();
			var url = "<%=request.getContextPath()%>/utilization/utili_moveUpUtilization.action";
			
			var synJson = {};
			synJson.beforeSelected = beforeSelected;
			synJson.uuid = uuid;
			synJson.catalogId = catalogId;
			Matrix.sendRequest(url,synJson,function(data){
				if(data.data){
					var json = isc.JSON.decode(data.data);
					if(json.result==true){
						//刷新下拉框 并设置选中
						$("#module_div").remove();
						getData(uuid,'moveUp');
					}
				}
			});
		}else{
			Matrix.warn("首行数据不可上移！");
		}
	}
	
	//下移应用设置
	function moveDownUtilization(){
		var checkIndex=$("#module ").get(0).selectedIndex; //获取Select选择的索引值
		var optionSize = $("#module option").length;
		if(checkIndex<optionSize-1){
			var uuid = $("#module").val();   //当前主键编码
			var nextSelected =  $("#module").find("option:selected").next().val();  //上一条主键编码   
			var catalogId = $('#catalogId').val();
			var url = "<%=request.getContextPath()%>/utilization/utili_moveDownUtilization.action";
			
			var synJson = {};
			synJson.nextSelected = nextSelected;
			synJson.uuid = uuid;
			synJson.catalogId = catalogId;
			Matrix.sendRequest(url,synJson,function(data){
				if(data.data){
					var json = isc.JSON.decode(data.data);
					if(json.result==true){
						//刷新下拉框 并设置选中
						$("#module_div").remove();
						getData(uuid,'moveDown');
					}
				}
			});
		}else{
			Matrix.warn("末行数据不可下移！");
		}
	}
</script>
</head>
<body>
	<!-- 表单模板主键mo_doc_template表  根据此关联外键查询应用设置列表-->
	<input type="hidden" id="catalogId" name="catalogId" value="${param.catalogId}">
	<!-- 表单编码 -->
	<input type="hidden" id="formId" name="formId" value="${param.formId}">
	
	<div id="web1" style="width: 100%;height: 100%;text-align: center;display:none;">
		<img src="<%=path %>/resource/images/list.jpg" style="width: 400px;height: 250px;margin: 70px auto 0;"/>
		<div style="padding:38px 0 12px">当前尚无应用配置，如需添加请点击新建添加，然后进行设计</div>
		<input type="button" class="x-btn ok-btn " value="新建" style="width:110px;height: 36px" onclick="createNew()">
	</div>
	<div id="web2" style="position: absolute;width: 100%;height: 100%;display: none;">
		<div id="top" style="height: 50px;width:85%;margin:10px auto;border: 1px solid rgb(231, 234, 236);background: white;box-shadow: 0 2px 4px 0 rgba(0,0,0,.08);">
			<div id="toolbar" style="float:right;padding-top: 10px;display: none;">
			    <ul class="nav">
					<li class="dropdown">					  
		               <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" style="color:black;">
		               		<label style="vertical-align: middle;cursor: pointer;color:rgb(22, 105, 171);">操作&nbsp;</label><span><img class="imgButton" tabindex="0" src="<%=path %>/image/test1.jpg" style="height: 15px; width: 15px;"></span>
		               </a>
		               <ul class="dropdown-menu operation">
		                <li><a href="#" onclick="addUtilization()">添加</a></li>
		                <li><a href="#" onclick="copyUtilization()">复制</a></li>          
		                <li><a href="#" onclick="deleteUtilization()">删除</a></li>	           
		                <li><a href="#" onclick="moveUpUtilization()">上移</a></li>
		                <li><a href="#" onclick="moveDownUtilization()">下移</a></li>
		               </ul>
		            </li>
	            </ul>
			</div>
		</div>
		<div id="bottom" style="height: calc(100% - 80px);width:85%;overflow::auto;margin:0px auto 0px auto;background:white;box-shadow: 0 2px 4px 0 rgba(0,0,0,.08);">
			<iframe id="iframeContent" style="border:1px solid rgb(231, 234, 236);width:100%;height:100%;" frameborder="0" src="">
			</iframe>
		</div>
	</div>
</body>
</html>