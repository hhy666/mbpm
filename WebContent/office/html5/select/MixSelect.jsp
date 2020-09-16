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
<title>混合选择部门角色人员页面</title>
<link href='<%=path %>/resource/html5/css/matrix_runtime.css' rel="stylesheet"></link>
<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/validator.js'></SCRIPT>
<link href="<%=path %>/css/themes/default/style.min.css" rel="stylesheet"/>
<link href='<%=path %>/resource/html5/css/bootstrap/dist/css/bootstrap.min.css' rel="stylesheet"></link>
<link href='<%=path %>/resource/html5/css/font-awesome.min.css' rel="stylesheet"></link>
<link href='<%=path %>/resource/html5/css/custom.css' rel="stylesheet"></link>
<link href='<%=path %>/resource/html5/css/skin/mCustom_<%=session.getAttribute("skin") %>.css' rel="stylesheet"></link>
<link href='<%=path %>/resource/html5/assets/toastr-master/toastr.min.css'  rel="stylesheet"></link>
<style type="text/css">
	body, ul{
	    margin: 0;
	    padding: 0;
	    font-size: 14px;
	}
	div, ul{
		box-sizing: border-box;
	}
	.container{
		padding: 20px 20px 0 20px;
	    position: absolute;
	    height: calc(100% - 54px);
	    width: 100%;
	}
	.select-base{
		position: relative;
		height: 100%;
		width: 100%;
	}
	.select-list {
	    height: 80px;
	    border: 1px solid #e0e0e0;
	    margin-bottom: 10px;
	    overflow: auto;
	}
	.select-item {
	    display: inline-block;
	    line-height: 30px;
	    margin: 5px 0 0 5px;
	    padding: 0 10px;
	    border-radius: 1px;
	    background: #F3F6FC;
	}
	.icon-btn{
		padding-right: 5px;
	}
	.remove-btn {
	    cursor: pointer;
	    margin-left: 10px;
	    padding: 3px;
	    color: #999;
	}
	.remove-btn:hover{
	    border-radius:6px;
	    background:rgba(250,250,250,.9);
	}
   .select-pane {
	    border: 1px solid #e0e0e0;
	    border-bottom: 0px;
	    border-top: none;
	    position: absolute;
	    height: calc(100% - 130px);
	    left: 0;
	    bottom: 0;
	    right: 0;
	}
	.dept-pane,.role-pane,.person-pane{
		height: 100%;
	    overflow: hidden;
	}
	.select-tree{
		position: absolute;
	    top: 0;
	    left: 0;
	    bottom: 0;
	    right: 0;
    	/*
    	padding: 5px 0;
    	*/
    	overflow: auto;
	}
	.person-list{
		height: calc(100% - 28px);
	    padding: 5px 0;
    	overflow: auto;
	}
	.person-list .select-member li {
	    cursor: pointer;
	    padding: 0 30px 0 10px;
	    overflow: hidden;
	    text-overflow: ellipsis;
	    white-space: nowrap;
	    position: relative;
	    line-height: 24px;
	    list-style-type: none
	}
	 .form-control {
	   	 border-radius: 0;
	 }
	.jstree-default .jstree-hovered{
		 background:none;
		 border-radius:0px;
     	 color: blue;
    	 text-decoration: underline;
 		 box-shadow:none
 	}
 	.jstree-default .jstree-clicked {
	     background: #DDDDDD;
	     border-radius: 0px;
	     box-shadow: none;
	}
	.jstree-anchor {
    	 padding: 0 4px 0 0px;
	}
	.jstree-default .jstree-node-online {
    	background: url("<%=path %>/office/html5/image/openfoldericon.png") no-repeat #fff;
        background-position: 50% 50%;
    	background-size: auto;
	}
	.jstree-default .jstree-node-offline {
    	background: url("<%=path %>/office/html5/image/foldericon.png") no-repeat #fff;
       	background-position: 50% 50%;
    	background-size: auto;
	}
</style>
<script src="<%=path %>/resource/html5/js/jquery.min.js"></script>
<script src="<%=path %>/resource/html5/js/jstree.min.js"></script>
<script src="<%=path %>/resource/html5/js/matrix_runtime.js"></script>
<script src='<%=path %>/resource/html5/assets/toastr-master/toastr.min.js'></SCRIPT>
<script type="text/javascript">
	$(document).ready(function() {
		debugger;
		//初始加载保存的组织机构信息
		var authUser = parent.authUser;
		if(authUser && authUser.areaName && authUser.areaIds){
			var areaName = authUser.areaName;
			var areaIds = authUser.areaIds;
			var nameArr = areaName.split("、"); 
			var id_type = areaIds.split(";");  
			for(var i = 0;i<nameArr.length;i++){
	            var allName = nameArr[i];
                var allId = (id_type[i].split(":"))[0];
                var type= (id_type[i].split(":"))[1];
                if(type == 1){   //人员
					$(".select-list").append("<li class=\"select-item\" id="+allId+" area-text="+allName+" area-type=\"1\"><span class=\"icon-btn\" style=\"color: #0DB3A6;\"><i class=\"fa fa-user\"></i></span><span>"+allName+"</span><span class=\"remove-btn\" onclick=\"removeElement(this);\"><i class=\"fa fa-remove\"></i></span></li>");
				}else if(type == 2){  //部门 组织机构
					$(".select-list").append("<li class=\"select-item\" id="+allId+" area-text="+allName+" area-type=\"2\"><span class=\"icon-btn\" style=\"color: #f0ad4e;\"><i class=\"fa fa-sitemap\"></i></span><span>"+allName+"</span><span class=\"remove-btn\" onclick=\"removeElement(this);\"><i class=\"fa fa-remove\"></i></span></li>");	
				}else if(type == 3){   //角色
					$(".select-list").append("<li class=\"select-item\" id="+allId+" area-text="+allName+" area-type=\"3\"><span class=\"icon-btn\" style=\"color: #0DB3A6;\"><i class=\"fa fa-tree\"></i></span><span>"+allName+"</span><span class=\"remove-btn\" onclick=\"removeElement(this);\"><i class=\"fa fa-remove\"></i></span></li>");
				}
			}    
		}
		
		var deptTree=$('#dept_container').jstree({
			'core' : {
				"check_callback" : true,//默认为flase，会导致无法使用修改树结构。
				'multiple' : true,    //设置为多选
				"animation" : false,   //打开/关闭动画持续时间（以毫秒为单位） - 将此设置false为禁用动画（默认为200）
				'dblclick_toggle': false,  //禁止双击（ 默认为true）
				'data' : {
					"url" : "<%=path%>/select/SelectAction_getDepTree.action",
					"data" : function(node) {
						return {
							"root" : node.id ==="#"?"0":node.id
						};
					},
					"dataType" : "json",
					"type" : "post"
				},
				'themes' : {
					"theme" : "default",
					'dots' : true,  //是否显示连线 （设置wholerow时不显示）
					'icons' : true   //是否显示节点图标
				}
			},
			"plugins" : ["wholerow"]
			
		}).on('select_node.jstree', function(event, data) {  
			var node = data.node;
			var id = node.id;
			var text = node.text;
			
			var flag = true;
			$('.select-list').find('li').each(function() {
				if(id == $(this).attr("id") && text == $(this).attr("area-text")){
					flag = false;
					return;
				}
			});
			if(flag){
				$(".select-list").append("<li class=\"select-item\" id="+id+" area-text="+text+" area-type=\"2\"><span class=\"icon-btn\" style=\"color: #f0ad4e;\"><i class=\"fa fa-sitemap\"></i></span><span>"+text+"</span><span class=\"remove-btn\" onclick=\"removeElement(this);\"><i class=\"fa fa-remove\"></i></span></li>");
			}
        });
		
		var roleTree=$('#role_container').jstree({
			'core' : {
				"check_callback" : true,//默认为flase，会导致无法使用修改树结构。
				'multiple' : true,    //设置为多选
				"animation" : false,   //打开/关闭动画持续时间（以毫秒为单位） - 将此设置false为禁用动画（默认为200）
				'dblclick_toggle': false,  //禁止双击（ 默认为true）
				'data' : {
					"url" : "<%=path %>/select/SelectAction_getRoleTree.action",
					"data" : function(node) {
						return {
							"root" : node.id ==="#"?"0":node.id
						};
					},
					"dataType" : "json",
					"type" : "post"
				},
				'themes' : {
					"theme" : "default",
					'dots' : true,  //是否显示连线 （设置wholerow时不显示）
					'icons' : true   //是否显示节点图标
				}
			},
			"plugins" : ["wholerow"]
			
		}).on('select_node.jstree', function(event, data) {  
			var node = data.node;
			var id = node.id;
			var text = node.text;
			
			var flag = true;
			$('.select-list').find('li').each(function() {
				if(id == $(this).attr("id") && text == $(this).attr("area-text")){
					flag = false;
					return;
				}
			});
			if(flag){
				$(".select-list").append("<li class=\"select-item\" id="+id+" area-text="+text+" area-type=\"3\"><span class=\"icon-btn\" style=\"color: #0DB3A6;\"><i class=\"fa fa-tree\"></i></span><span>"+text+"</span><span class=\"remove-btn\" onclick=\"removeElement(this);\"><i class=\"fa fa-remove\"></i></span></li>");
			}
			  
        });
		
		//展开时候图标设置
		$('.select-tree').on('open_node.jstree', function(e, datas) {  
 			var nodeId = datas.node.id; 
 			$(this).jstree(true).set_icon(nodeId, "jstree-node-online");
		
		});
	    //收拢时候图标设置
	    $('.select-tree').on('close_node.jstree', function(e, datas) {  
	     	var nodeId = datas.node.id; 
	     	$(this).jstree(true).set_icon(nodeId, "jstree-node-offline")
		});
		
		$('#dept').click(function(){
			$('.dept-pane').css('display','block'); 
			$('.role-pane').css('display','none'); 
			$('.person-pane').css('display','none'); 
			$("#dept").addClass("select");
			$("#role").removeClass("select");
			$("#person").removeClass("select");
			$('.select-menu').removeAttr("style");
		});
		$('#role').click(function(){
			$('.role-pane').css('display','block'); 
			$('.dept-pane').css('display','none'); 
			$('.person-pane').css('display','none'); 
			$("#dept").removeClass("select");
			$("#role").addClass("select");
			$("#person").removeClass("select");
			$('.select-menu').removeAttr("style");
		});
		$('#person').click(function(){
			$('.person-pane').css('display','block'); 
			$('.dept-pane').css('display','none'); 
			$('.role-pane').css('display','none'); 
			$("#dept").removeClass("select");
			$("#role").removeClass("select");
			$("#person").addClass("select");
			$('.select-menu').css('border-bottom','0px'); 
		});
	});
	
	//查询用户
	function searchItems(){
		var userName;
		if($("#searchValue").val() == ''){
			Matrix.warn('请输入查询关键字！');
			return;
		}else{
			userName = $("#searchValue").val();
		}
		$.ajax({  
            url: "<%=path %>/select/SelectAction_getAllPerson.action",   
            type: "post",  
            dataType: "json",
            data: {"userName" : userName}, 
            async:false, 
            success: function (datass) {
            if(datass!=null&&datass!=""){
                var arr = datass.aaData;  
                if(arr!=null&&arr.length>0){
                //有人员数据
                   var listr = "";
                   for (var i in arr) {  
                       var jsonObj =arr[i];  
                       listr += "<li id="+jsonObj.id+" area-text="+jsonObj.name+" >" + jsonObj.name + "</li>";      
                   } 
                   $("#emptyMessage").remove();
                   $(".select-member").html(listr);  
                }else{
                   //无人员数据
                   $(".select-member").html("");  
                   $(".select-member").html("<div id=\"emptyMessage\" style=\"padding-top: 50px;font-size: 16px;color: #989898;text-align: center;\">无人员数据</div>");
                  
               }  
            }
            },  
            error: function (msg) {  
                alert("出错了！");  
            }  
        }); 
		
		$(".select-member li").hover(function(){
			$(this).addClass("changeColor").siblings().removeClass("changeColor");
		}).click(function(){
			var id = $(this).attr("id");
			var text = $(this).attr("area-text");
			
			var flag = true;
			$('.select-list').find('li').each(function() {
				if(id == $(this).attr("id") && text == $(this).attr("area-text")){
					flag = false;
					return;
				}
			});
			if(flag){
				$(".select-list").append("<li class=\"select-item\" id="+id+" area-text="+text+" area-type=\"1\"><span class=\"icon-btn\" style=\"color: #0DB3A6;\"><i class=\"fa fa-user\"></i></span><span>"+text+"</span><span class=\"remove-btn\" onclick=\"removeElement(this);\"><i class=\"fa fa-remove\"></i></span></li>");
			}	
        });
	}
	
	//删除选中的节点
	function removeElement(element){
		$(element).parent().remove();
	}
	
	//确定
	function confirm(){
		var data = {};
		var allIds = "";
		var allNames = "";
		
		var flag = false;
		var length = $('.select-list').find('li').length;
		if(length > 0){
			$('.select-list').find('li').each(function() {
				var allId = $(this).attr("id");
				var allName = $(this).attr("area-text");
				var type = $(this).attr("area-type");   //1 人员  2.部门  3.角色
				
				if(allName.indexOf("(")!=-1 && allName.endsWith(")")){
					allName = allName.substring(0,allName.indexOf("("));
       	     	}   
				
				var cont = allId+":"+type;
				if(flag){
					allIds += ";";
					allNames += "、";
				}else{
					data += ",";
				}
				allIds += cont;
				allNames += allName;
				flag = true;
				
				data="{\"allIds\":\""+allIds;
				data+="\",\"allNames\":\""+allNames;
				data+="\"}";
		
			});
		}else{
			data="{\"allIds\":\""+allIds;
			data+="\",\"allNames\":\""+allNames;
			data+="\"}";
		}
		var str = JSON.parse(data);   
		Matrix.closeWindow(str);
	}
	
	//取消
	function cancel(){
	    Matrix.closeWindow();
	}
</script>
</head>
<body>
	<div class="container">
		<div class="select-base">
			<ul class="select-list"></ul>
			<div class="select-menu">
				<div class="select-btn select" id="dept">组织机构</div>
				<div class="select-btn" id="role">角色</div>
				<div class="select-btn" id="person">人员</div>
			</div>
			<div class="select-pane">
				<div class="dept-pane" style="display: block;">
					<div id="dept_container" class="select-tree"></div>
				</div>
				<div class="role-pane" style="display: none;">
					<div id="role_container" class="select-tree"></div>
				</div>
				<div class="person-pane" style="display: none;">
					<div class="input-group">							
						<input id="searchValue" name="searchValue" type="text" placeholder="请输入用户名或工号" class="form-control" style="height:28px;">
				         <span class="input-group-addon addon-udSelect udSelect" onclick="searchItems();"><i class="fa fa-search"></i></span>
		            </div>
					<div id="person_container" class="person-list">
                        <ul class="select-member">
                        	<div id="emptyMessage" style="padding-top: 50px;font-size: 16px;color: #989898;text-align: center;">无人员数据</div>
                        </ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="cmdLayout">
		<div class="x-btn ok-btn" onclick="confirm();">
			<span>确定</span>
		</div>
		<div class="x-btn cancel-btn" onclick="cancel();">
			<span>取消</span>
		</div>
	</div>
</body>
</html>