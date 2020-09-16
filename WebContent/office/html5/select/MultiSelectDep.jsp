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
    <title>多选部门页面</title>
    <link href='<%=path %>/resource/html5/css/matrix_runtime.css' rel="stylesheet"></link>
	<link href="<%=path %>/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%=path %>/css/themes/default/style.min.css" />
    <link href='<%=path %>/resource/html5/css/font-awesome.min.css' rel="stylesheet"></link>
	<link href='<%=path %>/resource/html5/css/skin/mCustom_<%=session.getAttribute("skin") %>.css' rel="stylesheet"></link>
	
    <script src="<%=path %>/resource/html5/js/jquery.min.js"></script>
	<script src="<%=path %>/resource/html5/js/bootstrap.min.js"></script>
	<script src="<%=path %>/resource/html5/js/jstree.min.js"></script>
	<script src='<%=path %>/resource/html5/js/layer.min.js'></script>
	<script src='<%=path %>/resource/html5/js/matrix_runtime.js'></script>
	<SCRIPT SRC='<%=request.getContextPath() %>/resource/html5/js/validator.js'></SCRIPT>
    <style type="text/css">
    	body, ul{
		    margin: 0;
		    padding: 0;
		    font-size: 14px;
		}
		div, ul{
			box-sizing: border-box;
		}
		.main{
			padding: 10px 10px 0px 10px;
		    position: absolute;
		    height: calc(100% - 54px);
		    width: 100%;
		}
		.footer{
			vertical-align:middle;
			background: #F8F8F8;
			border-top:1px solid #e5e5e5;
			color:#fff;width:100%;
			position: fixed;
			bottom: 0px;
			padding: 14px 15px 15px;
			margin-bottom: 0; 
			text-align: right;
		}
		.select-base{
			position: relative;
			height: 100%;
			width: 100%;
		}
		 .select-pane {		   
		    position: absolute;
		    height: 100%;
		    left: 0;
		    bottom: 0;
		    right: 0;
		}
		.dept-pane{
			height: 100%;
		    overflow: hidden;
		}
		.select-tree{
			height: calc(100% - 30px);
			background:#fff;
			font-size: 12px;
			border: 1px #ccc solid;
			border-top: 0px;
    		border-bottom: 0px;
			overflow:auto;
		}
		.pane-left{
			position: absolute;
			left: 0;
			top: 0;
			height: 100%;
		    width: calc((100% - 100px)/2);
		}
		.pane-move{
		    position: absolute;
		    left: calc((100% - 100px)/2);
		    top: 0;
		    height: 100%;
		    width: 50px;
		    display: table;
		}
		.pane-right{
			position: absolute;
		    right: 50px;
		    top: 0;
		    height: 100%;
		    width: calc((100% - 100px)/2);;
		}
		.pane-sort{
			position: absolute;		  
		    right: 0;
		    top: 0;
		    height: 100%;
		    width: 50px;  
		    display: table;
		}
		.table-cell{
			display: table-cell;
			text-align:center; 
			vertical-align: middle;
		}
		.select-member{
			height: 100%;
			width: 100%;
		}
		.select-member li {
		    cursor: pointer;
		    margin: 0 10px 0 10px;
		    white-space: nowrap;
		    line-height: 24px;
		    list-style-type: none
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
    	.jstree-default .jstree-hovered{
			 background:none;
		 	 border-radius:0px;
		     color: blue;
		   	 text-decoration: underline;
		 	box-shadow:non
		}
		.jstree-default .jstree-clicked {
		    background: #DDDDDD;
		    border-radius: 0px;
		    box-shadow: none;
		}
		.jstree-anchor {
		    padding: 0 4px 0 0px;
		}
		.select_selected:hover {
		    background-position: -130px -256px;
		}
		.select_selected {
		    display: inline-block;
		    width: 32px;
		    height: 32px;
		    vertical-align: middle;
		    background: url("<%=path%>/office/html5/image/icon32.png") no-repeat left top;
		    background-position: 0 -256px;
		    cursor: pointer;
		}
		.select_unselect:hover {
		    background-position: -160px -256px;
		}
		.select_unselect {
		    display: inline-block;
		    width: 32px;
		    height: 32px;
		    vertical-align: middle;
		    background: url("<%=path%>/office/html5/image/icon32.png") no-repeat left top;
		    background-position: -32px -256px;
		    cursor: pointer;
		}
		.sort_up:hover {
		    background-position: -192px -256px;
		}
		.sort_up {
		    display: inline-block;
		    width: 32px;
		    height: 32px;
		    vertical-align: middle;
		    background: url("<%=path%>/office/html5/image/icon32.png") no-repeat left top;
		    background-position: -64px -256px;
		    cursor: pointer;
		}
		.sort_down:hover {
		    background-position: -224px -256px;
		}
		.sort_down {
		    display: inline-block;
		    width: 32px;
		    height: 32px;
		    vertical-align: middle;
		    background: url("<%=path%>/office/html5/image/icon32.png") no-repeat left top;
		    background-position: -96px -256px;
		    cursor: pointer;
		}
		.form-control {
	   		border-radius: 0;
	 	}
		::-webkit-scrollbar {    
		    width:4px;  
		    height:4px;   
		}  
		.udSelect{
			border-radius: 0px;
		}
    </style>
    
    <script type="text/javascript">
		$(function() {		
			if(parent.document.getElementById('ids2')){
			    var ids = parent.document.getElementById('ids2').value;
	            var names = parent.document.getElementById('input002').value;
	            if(names!=""){
			         var rightoptionstring="";
			         var optionArr=names.split(",");
			         var idArr = ids.split(",");
	                 for (var i in optionArr) {  
		                  var name =optionArr[i];  
		                  var id = idArr[i];
		                  rightoptionstring += "<option value=\"" + id + "\" >" +name + "</option>";                          
		             } 
		             $("#rightselect").html(rightoptionstring); 
	           }
	        }
			
		    //监听操作按钮 
		    monitorButton();  
		    
		    //确定
        	 $("#confirm").click(function(){
        	     var data = {};
        	     var ids = "";
        	     var names = "";
        	     
        	     var length = $('#rightselect').find('li').length;
        	     if(length==0){
				     layer.alert("请选择数据！",{icon: 2});//icon1 对勾 2x
				     return false;
			     }
        	     $('#rightselect').find('li').each(function() {  				 	
   				 	   var txt = $(this).text(); //获取内容
   				       var id = $(this).attr("id");
   				       if(names!="")
   				       names+=",";
   				       names+=txt;
   				       if(ids!="")
   				       ids+=",";
   				       ids+=id;
   			     });
		        data["ids"]=ids;
		        data["names"]=names;
		        data["clientId"]="${param.clientId}";
		        data["id"]="${param.id}";
		        Matrix.closeLayerWindow(data);
            });
		    
        	 //取消
			 $("#cancel").click(function(){
                 Matrix.closeLayerWindow();
        	 });        	 
        	 
        	 var tree = $('#dept_container').jstree({
				'core' : {
					'multiple' : false,
		    		'data' : {
						"url" :"<%=path %>/select/SelectAction_getDepTree.action",
						"data" : function(node) {
							return {
							"root" : node.id ==="#"?"0":node.id
							};
						},
						"dataType" : "json",
						"type":"post"
					},
					'themes' : {
						'icons' : true
					}
				},	
				"plugins" : [ "themes", "json_data", "crrm","wholerow"],
				'contextmenu' : false
			 });
        	 
        	//双击选中添加到右边
 			$('#dept_container').on('dblclick.jstree', function(e, datas) {
       			var selecttree = $('#dept_container').jstree().get_selected(true);
		        if(selecttree!=null&&selecttree.length>0){
			       var node = $('#dept_container').jstree().get_selected(true)[0]; 
				   var name = node.text;  
			       var id = node.id;
			             
			       var containsid = false;
			       $('#rightselect').find('li').each(function() {
	 				   if(id == $(this).attr("id")){
	 					  containsid = true;
	 					  return;
	 				   }
	 			   });
			       if(!containsid){
				    	$('#rightselect').append("<li id=\"" + id + "\" >" + name + "</li>");
				    	$('.changeColor').removeClass("changeColor");
				   }
		        } 
 			});
	     
	        //展开时候图标设置
		    $('#dept_container').on('open_node.jstree', function(e, datas) {  
			     var nodeId = datas.node.id; 
			     $('#dept_container').jstree(true).set_icon(nodeId, "jstree-node-online");
			    // tree.set_icon(node,"jstree-node-offline");
		    });
		    //收拢时候图标设置
		    $('#dept_container').on('close_node.jstree', function(e, datas) {  
			     var nodeId = datas.node.id; 
			     $('#dept_container').jstree(true).set_icon(nodeId, "jstree-node-offline");
			    // tree.set_icon(node,"jstree-node-offline");
		    });		 
	    });
		
		var recordId;  //记录当前选中的区域id
		var ctrl = false;  //记录ctrl键
		//监听相关操作按钮
		function monitorButton(){
			$(document).keydown(function(event){  
				if(event.ctrlKey){  //按下了ctrl键
					ctrl=true;
				}
				if(event.ctrlKey && event.keyCode == 65){   //按下了ctrl+a组合键
					$('.changeColor').removeClass("changeColor");
					$("#"+recordId+" li").addClass("changeColor");
				} 
			}).keyup(function(){
				ctrl=false;
			});
				
			$(".select-member").on("click","li",function(){
			    if(ctrl){   //按下了ctrl键连选
	            	$(this).addClass("changeColor");
	            }else{
	            	$(this).addClass("changeColor").siblings().removeClass("changeColor");			 
	            }
			    recordId = $(this).parent().attr('id');
	 		});
			 
            //选中节点右移
			$("#button003").click(function(){	
				if(document.getElementById('dept_container').style.display == 'none'){
					var selectLi = $("#depSelect").children("li.changeColor");
	    		    if(selectLi.length>0){
	    		    	var name = selectLi.text(); 
	 	                var id = selectLi.attr('id');
		 	         
				        var containsid = false;
				        $('#rightselect').find('li').each(function() {
		 				    if(id == $(this).attr("id")){
		 					   containsid = true;
		 					   return;
		 				    }
		 			    });
				        if(!containsid){
					    	 $('#rightselect').append("<li id=\"" + id + "\" >" + name + "</li>");
					    	 $('.changeColor').removeClass("changeColor");
					    }   
	    		    }    		     
				}else{
					var selecttree = $('#dept_container').jstree().get_selected(true);
			        if(selecttree!=null&&selecttree.length>0){
				       var node = $('#dept_container').jstree().get_selected(true)[0]; 
					   var name = node.text;  
				       var id = node.id;
				             
				       var containsid = false;
				       $('#rightselect').find('li').each(function() {
		 				   if(id == $(this).attr("id")){
		 					  containsid = true;
		 					  return;
		 				   }
		 			   });
				       if(!containsid){
					    	$('#rightselect').append("<li id=\"" + id + "\" >" + name + "</li>");
					    	$('.changeColor').removeClass("changeColor");
					   }
			        }  
				}
		     });
            
			//移除右边的选中数据
			$("#button004").click(function(){
				var length = $('#rightselect').find('li.changeColor').length;
			    if(length==0){	       
					layer.msg('请选择一项'); 
					return false; 
				} 
			    $('#rightselect').find('li.changeColor').remove(); 
			});
			//双击从右边移除
			$("#rightselect").dblclick(function(){ 
    			$('#rightselect').find('li.changeColor').remove(); 
        	}); 
			 //上移
			$("#button005").click(function(){				
				var select = $('#rightselect').find('li.changeColor');
				var length = select.length;
			    if(length==0){	       
					layer.msg('请选择一项'); 
					return false; 
				} 
			    var index = $('#rightselect').find('li').index(select)
			    if(index>0){                         
			    	select.prev().before(select);
				}
				//选中的索引,从0开始 
				var index = $('#rightselect').get(0).selectedIndex; 
				//如果选中的不在最上面,表示可以上移 
				if(index != 0){ 
					$('#rightselect option:changeColor:first').insertBefore($('#rightselect option:changeColor:first').prev('option')); 
				} 	
			});
		    //下移
			$("#button006").click(function(){
				var select = $('#rightselect').find('li.changeColor');
				var length = select.length;
			    if(length==0){	       
					layer.msg('请选择一项'); 
					return false; 
				} 
			    //选中的索引,从0开始 
			    var index = $('#rightselect').find('li').index(select)
			    var num = $('#rightselect').find('li').length;
			    //如果选中的不在最下面,表示可以下移
			    if(index!=num-1){  
			    	select.next().after(select);
			    } 
			}); 
		}
		
		//根据部门名称搜索
		function searchDept(){ 	
			Matrix.showMask2();
			var depName = $('#depKeyWord').val();
			if(depName == ''){
				Matrix.hideMask2();
				$('#dept_container').css('display','block');
				$('#depResult').css('display','none');
				return;
			}
			$('#dept_container').css('display','none');
			$('#depResult').css('display','block');
			
			$.ajax({  
	            url: "<%=path %>/select/SelectAction_getAllDept.action",  
	            type: "post",  
	            dataType: "json",  
	            data: {"depName" : depName}, 
	            async:false, 
	            success: function (datass) {
	            if(datass!=null&&datass!=""){
	                var arr = datass.depData;  
	                if(arr!=null&&arr.length>0){
	                     //有部门数据
	                    var listring = "";
	                    for (var i in arr) {  
	                        var jsonObj =arr[i];  	                     
	                        listring += "<li id=\"" + jsonObj.depId + "\" >" + jsonObj.depName + "</li>";                      
	                    }                    
	                    $("#depSelect").html(listring);  
	                    
	                    $("#depSelect").on("click","li",function(){         			   
	         	            $(this).addClass("changeColor").siblings().removeClass("changeColor");	         	                	            
	                    });
	                    
	                    $("#depSelect").on("dblclick","li",function(){    
	                    	var selectLi = $("#depSelect").children("li.changeColor");
	    	    		    if(selectLi.length>0){        			      
	        			       var name = selectLi.text(); 
	   	 	                   var id = selectLi.attr('id');
	   	 	                   
	        			       var containsid = false;
	        			       $('#rightselect').find('li').each(function() {
	        	 				   if(id == $(this).attr("id")){
	        	 					  containsid = true;
	        	 					  return;
	        	 				   }
	        	 			   });
	        			       if(!containsid){
	        				    	$('#rightselect').append("<li id=\"" + id + "\" >" + name + "</li>");
	        				    	$('.changeColor').removeClass("changeColor");
	        				   }
	        		        }      	
	                    });
	           
	                }else{
	                    //无部门数据
	                     $("#depSelect").html("");
	                } 
	                Matrix.hideMask2();
	            }
	            },  
	            error: function (msg) {  
	            	Matrix.hideMask2();
	                layer.msg("出错了！");  
	            }  
      		}); 
		}
	</script>
</head>  
<body style="background:#FAFAFA;color:#000000;font-size:12px;">
	<div id="matrixMask" name="matrixMask" class="matrixMask" style="width: 100%; height: 100%; position: absolute;top: 1;left: 1;z-index: 9999999999999;display: none;"> </div>
	<div class="main">
		<div class="select-base">
			<div class="select-pane">
				<div class="pane-left">
					<!-- 部门区域 -->
					<div class="dept-pane" style="display: block;">
						<div id="depSearch" class="input-group">							
							<input id="depKeyWord" name="depKeyWord" type="text" class="form-control" style="height:30px;" onkeydown="if(event.keyCode == 13)searchDept()" placeholder="请输入部门名称">
				       		 <span class="input-group-addon addon-udSelect udSelect" onclick="searchDept();"><i class="fa fa-search"></i></span>
				         </div>
						<div id="dept_container" class="select-tree"></div>
						<div id="depResult" class="select-tree" style="display: none">
							<ul class="select-member" id="depSelect"></ul>        
						</div>
					</div>						
				</div>		
				<!-- 左移右移 -->
				<div class="pane-move">
					<div class="table-cell">
						<p><span id="button003" class="select_selected" style="margin-right: 0px;"></span></p><br/>
				       	<p><span id="button004" class="select_unselect" style="margin-right: 0px;"></span></p>	
			       	</div>			
				</div>
				<!-- 选择部门结果 -->
				<div class="pane-right">
					<div id="personList" style="display: block; height: 100%;border: 1px #ccc solid;border-bottom: 0px;overflow:auto;">
						 <ul class="select-member" id="rightselect"></ul>         
					</div>
				</div>	
				<!-- 上移下移 -->
				<div class="pane-sort">	
					<div class="table-cell">      
	                 	<p><span id="button005" class="sort_up" style="margin-right: 0px;"></span></p><br/>
					    <p><span id="button006" class="sort_down" style="margin-right: 0px;"></span></p>
					</div>	
                </div>	
			</div>
		</div>
	</div>
	<div class="cmdLayout">
		<button id="confirm" class="x-btn ok-btn" type="button">确定</button>
		<button id="cancel" class="x-btn cancel-btn" type="button" style="margin-left:5px;">取消</button>
	</div>
</body>
</html>
