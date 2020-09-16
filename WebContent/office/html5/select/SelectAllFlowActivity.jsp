<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
basePath = path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
 
  <SCRIPT>var webContextPath="<%=path%>";</SCRIPT>
    <base href="<%=basePath%>">
    
    <title>选择节点页面</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script src="<%=path %>/resource/html5/js/jquery.min.js"></script>
	<script src="<%=path %>/resource/html5/js/demo.js"></script>
	   <jsp:include page="../../../foundation/common/taglib.jsp"/>
     <jsp:include page="../../../foundation/common/resource.jsp"/>
   <link href="<%=path %>/css/bootstrap.min.css" rel="stylesheet">
     <link rel="stylesheet"
	href="<%=path %>/css/themes/default/style.min.css" />
  </head>
  <script type="text/javascript">
  $(function() {
  	  $("#button001").click(function(){
           Matrix.closeWindow();
        });
        $("#button002").click(function(){
              var data = {};
        	  var id = "";
        	 if($("#select001 option:selected").length==0){
		 //    layer.alert("请选择数据！",{icon: 2});//icon 1 对勾 2 x
		 Matrix.warn("请选择数据！");
		     return false;
	     }
	     id = $('#select001').find('option:selected').val();
	     data["id"]=id;
         Matrix.closeWindow(data);
        });
    });
  </script>
  <body style="   /* background: #FAFAFA;*/">
  <style>
 
 .jstree-default .jstree-hovered{
 background:none;
 border-radius:0px;
     color: blue;
    text-decoration: underline;
 box-shadow:none}
 .jstree-default .jstree-clicked {
    background: #DDDDDD;
    border-radius: 0px;
    box-shadow: none;
}
.jstree-anchor {
    padding: 0 4px 0 0px;
}
 </style>
  <table style="width:100%;height:100%;">
  <tr>
  <td style="width:100%;height:85%;">
  	<div id="container" style="width:50%;    float: left;background:#fff;  font-size: 12px;height:100%;;overflow:auto;border: 1px #ccc solid;"></div>
					<style>
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
		.jstree-default .jstree-node-flowline {
    background: url("<%=path %>/matrix/resource/isomorphic/skins/Enterprise/images/matrix/tree/flow_item.png") no-repeat #fff;
       background-position: 50% 50%;
    background-size: auto;
}

					</style>
						<!-- include the jQuery library -->
	<script src="<%=path %>/resource/html5/js/jquery.min.js"></script>
	<!-- include the minified jstree source -->
	<script src="<%=path %>/resource/html5/js/jstree.min.js"></script>

	<script type="text/javascript">
			$(document).ready(function() {
		var tree=	$('#container').jstree({
		 
				'core' : {
				'multiple' : false,
				'dblclick_toggle': true,
	    		'data' : {
						"url" : webContextPath+"/select/SelectAction_getAllFlowTree.action",
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
				
				'expand_selected_onload' : true, //选中项蓝色底显示  
                "checkbox": {
                    "keep_selected_style": true,//是否默认选中
                    "three_state": false,//父子级别级联选择
                    "tie_selection": true
                },
                "themes": { "theme": "default", "dots": false, "icons": false },  
            "plugins" : [ "themes", "json_data", "checkbox","crrm"]  ,
				'plugins' : ['contextmenu', "json_data"],
				'contextmenu' : false
			});
	$('#container').on('select_node.jstree', function(e, datas) {  
		
             r = [];  
            var i, j;  
            for (i = 0, j = datas.selected.length; i < j; i++) {  
                var node = datas.instance.get_node(datas.selected[i]);  
        //     datas.instance.get_node(datas.selected[i],true).attr('aria-selected', true).children('.jstree-anchor')[0].focus();
                var text = node.text;  
                var id = node.id;
                var depType = node.original.depType;
                var pdid = node.original.pdid;
                 document.getElementById('pdid').value = pdid;
                 if(depType==17){
                         $.ajax({  
                url: "<%=path %>/select/SelectAction_getActivityByPdid.action?pdid="+$("#pdid").val(),    //后台webservice里的方法名称  
                type: "post",  
                dataType: "json",  
                contentType: "application/json",  
                async:false, 
                success: function (datass) {
                if(datass!=null&&datass!=""){
                    var arr = datass.aaData;  
                    if(arr!=null&&arr.length>0){
                       var optionstring = "";
	                    for (var i =0;i<arr.length;i++) {  
	                        var jsonObj =arr[i];  
	                     
	                        optionstring += "<option value=\"" + jsonObj.adid + "\" >" +jsonObj.adid+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+ jsonObj.activityName + "</option>";  
	                        
	                     
	                    }  
	                       $("#select001").html(optionstring);  
                    }else{
               $("#select001").empty(); 
                }
                }
                },  
                error: function (msg) {  
                    alert("出错了！");  
                }  
            });
            }  
             }  
        
        }) ;
        //展开时候图标设置
    $('#container').on('open_node.jstree', function(e, datas) {  
     var nodeId = datas.node.id; 
     $('#container').jstree(true).set_icon(nodeId, "jstree-node-online");
    // tree.set_icon(node,"jstree-node-offline");
    });
    //收拢时候图标设置
     $('#container').on('close_node.jstree', function(e, datas) {  
     var nodeId = datas.node.id; 
     $('#container').jstree(true).set_icon(nodeId, "jstree-node-offline");
    // tree.set_icon(node,"jstree-node-offline");
    });

 
		});
	</script>
			<div style="width:50%;padding-left: 10px;    float: left;" id="leftbottomContent"> 
		
 <select style="border:1px solid #ccc" id="select001" class="form-control" size="24">
                                          
                                        </select>
                                        </div>
                                         <style>
                                    .m-l-n {
    margin-left: -15px;
}
select[multiple], select[size] {
    height: auto;
}
.form-control, .single-line {
    background-color: #FFF;
    background-image: none;
    border: 1px solid #e5e6e7;
    border-radius: 1px;
    color: inherit;
    display: block;
    padding: 6px 12px;
    -webkit-transition: border-color .15s ease-in-out 0s,box-shadow .15s ease-in-out 0s;
    transition: border-color .15s ease-in-out 0s,box-shadow .15s ease-in-out 0s;
    width: 100%;
    font-size: 12px;
}
.form-control, .form-control:focus, .has-error .form-control:focus, .has-success .form-control:focus, .has-warning .form-control:focus, .navbar-collapse, .navbar-form, .navbar-form-custom .form-control:focus, .navbar-form-custom .form-control:hover, .open .btn.dropdown-toggle, .panel, .popover, .progress, .progress-bar {
    box-shadow: none;
}

                                    </style>  
  </td>
 
  </tr>
  <tr>
  <td style="vertical-align:middle;  background-color:rgb(250, 250, 250);    border-top: 1px solid #e5e5e5;color:#fff;width:100%;position: fixed;  bottom: 0px;      padding: 7px 7px ;    margin-bottom: 0; text-align: center;">
  <button id="button002" class="x-btn ok-btn " type="button">确定</button>
    <button style="margin-left:5px;" id="button001" class="x-btn cancel-btn " type="button">取消</button>
</td>
  </tr>
  </table>
  <input type="hidden" id="pdid"  name="pdid"/>
  </body>
</html>
