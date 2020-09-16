<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <script>var webContextPath="<%=path%>";</script>
    <title>查询列表设置</title>
	<meta charset="utf-8">
	 <link href="<%=path %>/resource/html5/css/font-awesome.min.css" rel="stylesheet">
    </head>
      <!-- Bootstrap -->
     <link href="<%=path %>/css/bootstrap.min.css" rel="stylesheet">
     <link rel="stylesheet" href="<%=path %>/css/themes/default/style.min.css" />
	

 <body style="background:#FAFAFA;color:#000000;font-size:12px; overflow: hidden; ">
 
   <script src="<%=path %>/resource/html5/js/jquery.min.js"></script>
	<!-- include the minified jstree source -->
	<!-- 包含tab标签的切换bootstrap.js -->
	 <script src="<%=path %>/resource/html5/js/bootstrap.min.js"></script>
	<script src="<%=path %>/resource/html5/js/jstree.min.js"></script>
	<script src='<%=request.getContextPath() %>/resource/html5/js/layer.min.js'></script>
	<script src="<%=path %>/resource/html5/js/demo.js"></script>
	<script src='<%=request.getContextPath() %>/resource/html5/js/layer.min.js'></script>
	<% 
	String formId = (String)request.getAttribute("formId");
	
	%>
	
  	<script type="text/javascript">
  	function infoMsg(message){
		//isc.say(message);
		layer.alert(message, {icon: 1});
	}
    function sendRequest(url,param,data,callback){
        url = url+"?"+param
        //showMask();
		$.ajax({
	        type : "POST",
	        url : url,
	        data: data,
	        error : function(){
				hideMask();
				infoMsg("服务器操作异常,请与管理员联系!");
	        },
	
	        success : function(data) {
	        	callback(data);
	        	hideMask();
	        }
	    })
    }
    
    function saveInfo(){
    	
    	 var ids = "";
 	    
	     if($("#rightselect option").length==0){
	    	 infoMsg("请选择数据！");//icon1 对勾 2x
	        return false;
	     }
	    
	    var array = new Array(); //定义数组
	    $("#rightselect option").each(function(){ //遍历全部option
	        var id = $(this).val();  //获取option的内容
	        if(ids!="")
	        ids+=",";
	        ids+=id;
	    });
	    
    	var url="<%=path %>/QueryListSetttingServlet";
		var param="command=save";
		var data = {};
        data["formId"]=document.getElementById("formId").value;
        data["setedCols"]=ids;
		sendRequest(url,param,data, function(data){
			if("false" != data){
				parent.location.reload();
            	var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
				parent.layer.close(index);
			}else{
				infoMsg("保存失败!");
			}
		  }	
		);
    }
    
    function cacel(){
		parent.layer.close(index);
    }
  	
  	$(function() {
  	    //左到右全部移除
  		$("#button001").click(function(){
  			var arr = [];
  			var _select = document.getElementById("rightselect");
   
       		var length = $('#select003').find('option').length;
		    if(length==0)
		      return false;
		      var optionstring="";
		      for(var i=0;i<length;i++){
			      var obj = $('#select003').find('option')[i];
			      var name = obj.text;
			      var id = obj.value;
			      var containsid = false;
		     	  for(var j=0;j<_select.options.length;j++){
		       	 	 var oldid = _select.options[j].value;
				     if(id==oldid){
				         containsid = true;
				         break;
				     }
		       }
	       if(!containsid){
	         var objOption = new Option(name,id);
	         rightselect.options.add(objOption);
	       }
	    }
		     select003.innerHTML = "";
  		});
  		
  		
  		//右到左全部移除
  		$("#button002").click(function(){
  			var arr = [];
		    var leftselect = document.getElementById("select003");
   
       		var length = $('#rightselect').find('option').length;
		    if(length==0)
		      return false;
		      var optionstring="";
		      for(var i=0;i<length;i++){
			      var obj = $('#rightselect').find('option')[i];
			      var name = obj.text;
			      var id = obj.value;
			      var containsid = false;
		     	  for(var j=0;j<leftselect.options.length;j++){
		       	 	 var oldid = leftselect.options[j].value;
				     if(id==oldid){
				         containsid = true;
				         break;
				     }
		       }
	       if(!containsid){
	         var objOption = new Option(name,id);
	         leftselect.options.add(objOption);
	       }
	    }
		      rightselect.innerHTML = "";
  		});
  		
  		
  		//上移
		$("#button005").click(function(){
			if(null == $('#rightselect').val()){ 
				infoMsg('请选择一项'); 
				return false; 
			} 
			//选中的索引,从0开始 
			var optionIndex = $('#rightselect').get(0).selectedIndex; 
			//如果选中的不在最上面,表示可以移动 
			if(optionIndex > 0){ 
				$('#rightselect option:selected:first').insertBefore($('#rightselect option:selected:first').prev('option')); 
			} 
				
		});
  		
  		
		//下移
		$("#button006").click(function(){
			if(null == $('#rightselect').val()){ 
				infoMsg('请选择一项'); 
				return false; 
			} 
			//索引的长度,从1开始 
			var optionLength = $('#rightselect')[0].options.length; 
			//选中的索引,从0开始 
			var optionIndex = $('#rightselect').get(0).selectedIndex; 
			//如果选择的不在最下面,表示可以向下 
			if(optionIndex < (optionLength-1)){ 
				$('#rightselect option:selected:first').insertAfter($('#rightselect option:selected:first').next('option')); 
			}
	
	    });
		
		
		//选中点击按钮--移到左边
		$("#button004").click(function(){
			var arr = [];
		    var _select = document.getElementById("rightselect");
		    var leftselect = document.getElementById("select003");
		    if(null == $('#rightselect').val()){ 
		    	infoMsg('请选择一项'); 
				return false; 
			} 
		    
	        var length = $('#rightselect').find('option:selected').length;
		    if(length==0)
		      return false;
		      var optionstring="";
		      for(var i=0;i<length;i++){
		    	  if(i==0){
		    		  var obj = $('#rightselect').find('option:selected')[i];
		    	  }else{
		    		  i=i-1;
		    		  var obj = $('#rightselect').find('option:selected')[i];
		    	  }
			      var name = obj.text;
			      var id = obj.value;
			      var containsid = false;
		     	  for(var j=0;j<leftselect.options.length;j++){
		       	 	 var oldid = leftselect.options[j].value;
				     if(id==oldid){
				         containsid = true;
				         break;
				     }
		       }
		       if(!containsid){
		         var objOption = new Option(name,id);
		         leftselect.options.add(objOption);
		         _select.options.remove(_select.selectedIndex);
		       }
	    	}
		});
		
		
		//双击添加到左边
		$("#rightselect").dblclick(function(){ 
			var _select = document.getElementById("rightselect");
		    var leftselect=document.getElementById("select003");
		       
		    var id = $('#rightselect').find('option:selected').val();
		    var name = $('#rightselect').find('option:selected').text();
	    
	        var containsid = false;    //判断左边有没有
		    for(var j=0;j<leftselect.options.length;j++){
			       var oldid = leftselect.options[j].value;
			       if(id==oldid){
				       containsid = true;
				       break;
		           }
	           }
		    if(!containsid){
		        var objOption = new Option(name,id);
		        leftselect.options.add(objOption);
		        _select.options.remove(_select.selectedIndex);
		    }
        }); 
        
           
		//双击添加到右边    
        $("#select003").dblclick(function(){ 
	       var _select = document.getElementById("rightselect");
	       var leftselect=document.getElementById("select003");
	       
	       var id = $('#select003').find('option:selected').val();
	       var name = $('#select003').find('option:selected').text();
    
           var containsid = false;    //判断右边有没有
	       for(var j=0;j<_select.options.length;j++){     
		       var oldid = _select.options[j].value;
		       if(id==oldid){
			       containsid = true;
			       break;
	           }
           }
	       if(!containsid){
	          var objOption = new Option(name,id);
	          _select.options.add(objOption);
	          leftselect.options.remove(leftselect.selectedIndex);
	       }
	      });
           
       
        //选中点击按钮--移除到右边
		$("#button003").click(function(){
			var arr = [];
		    var _select = document.getElementById("rightselect");
		    var leftselect = document.getElementById("select003");
      
		    if(null == $('#select003').val()){ 
		    	infoMsg('请选择一项'); 
				return false; 
			} 
       		var length = $('#select003').find('option:selected').length;
		    if(length==0)
		      return false;
		      var optionstring="";
		      for(var i=0;i<length;i++){
		    	  if(i==0){
		    		  var obj = $('#select003').find('option:selected')[i];
		    	  }else{
		    		  i=i-1;
		    		  var obj = $('#select003').find('option:selected')[i];
		    	  }

			     
			      var name = obj.text;
			      var id = obj.value;
			      var containsid = false;
		     	  for(var j=0;j<_select.options.length;j++){
		       	 	 var oldid = _select.options[j].value;
				     if(id==oldid){
				         containsid = true;
				         break;
				     }
		       }
		       if(!containsid){
		         var objOption = new Option(name,id);
		         _select.options.add(objOption);
		         leftselect.options.remove(leftselect.selectedIndex);
		       } 
	    	}    
      });
        
        
       //点击取消关闭
	   $("#button01").click(function(){
	       Matrix.closeLayerWindow();
	   });
	   //点击确认获取选中的数据并构造id 逗号分隔
	   $("#button02").click(function(){
	 
	    
	    
	    saveInfo();
	    //window.location="<%=path %>/QueryListSetttingServlet?ids="+ids;
	  });
        
   });
  	
 </script>

<form style="overflow：hidden;">
<input type="hidden" id="formId" name="formId" value="<%=formId%>"/>
 <!-- setup a container element -->
  <table style="width:100%;height:100%;">	
  	
  	 <tr id="trheader" style="width:100%;height:30px;">
	
	
	  <td style="width:45%;height:30px;">
		
			<div><h5 style="color:blue;"> &nbsp;&nbsp;待选字段:</h2></div>
	 </td>     
    
	
	<td style="width:5%;text-align: center;">
			
	</td>
	
	<td style="vertical-align:top;">
		<div><h5 style="color:blue;"> &nbsp;&nbsp;已选字段:</h2></div>
    </td>
  	
 
	<td style="width:5%;text-align: center;">
			
	</td>

	 </tr>	
	 
	 <tr style="width:100%;height:100%;">
	  <td style="width:45%;">
		
			  <script type="text/javascript">
			 $(document).ready(function(){
			
			 var type = '<%=request.getAttribute("type")%>';
			 if(type==1){
				 var arr0 = '<%=request.getAttribute("jsonObject")%>';  //未选择的
				 if(arr0!=null&&arr0.length>0){
				 	 var arr = JSON.parse(arr0);
					 var optionstring = "";
					 var json0 = arr['returnjson'];
					 var json00 = json0['0'];
					 for (var i in json00) {  
	                     optionstring += "<option value=\"" + i + "\" >" + json00[i] + "</option>";   
	                 } 
					 
					 $("#select003").html(optionstring); 
				 }
				 
				 var arr1 = '<%=request.getAttribute("jsonObjectone")%>';   //已选择的
				 if(arr1!=null&&arr1.length>0){
				 	 var arro = JSON.parse(arr1);
					 var optionstring = "";
					 var json1 = arro['returntwojson'];
					 var json11 = json1['0'];
					 for (var i in json11) {  
	                     optionstring += "<option value=\"" + i + "\" >" + json11[i] + "</option>";   
	                 } 
					 $("#rightselect").html(optionstring);
				 }
			 }else{
				 $.ajax({  
						url: "<%=path %>/QueryListSetttingServlet",    //后台webservice里的方法名称 
		                type: "post",  
		                dataType: "json",  
		                contentType: "application/json",  
		                async:false, 
		                success: function (datass) {
		                if(datass!=null&&datass!=""){
		                    var arr = datass.returnjson;  
		                    if(arr!=null&&arr.length>0){
		                    	//有数据
		                       var optionstring = "";
			                    for (var i in arr) {  
			                        var jsonObj =arr[i];  
			                     	for(var key in jsonObj){
			                     		 optionstring += "<option value=\"" + key + "\" >" + jsonObj[key] + "</option>";  
			                     	}
			                    } 
			                       $("#select003").html(optionstring);  
		                    }else{
			                    //无数据
			                     $("#select003").html("");
			                }  
		                }
		                },  
		                error: function (msg) {  
		                    alert(msg);  
		                }  
		            }); 
			 }
		
		  })
			</script>
		<div id="leftContent" style="height:100%;">	
			<div id="li003content" style="padding-top:10px;">
				 <div style="width:100%;height:calc(100% - 11px)">
                     <select id="select003" style="border:1px solid #ccc;height:100%;" class="form-control" multiple="">
                                          
                     </select>
            	  </div>
		    </div>
          </div>
	 </td>     
    
       
	<!-- 样式 -->
	<style>
	.select_selected:hover {
	    background-position: -128px -256px;
	}
	
	.select_selected {
	    display: inline-block;
	    width: 32px;
	    height: 32px;
	    vertical-align: middle;
	    background: url("<%=path%>/resource/html5/image/icon32.png") no-repeat left top;
	    background-position: 0 -256px;
	    cursor: pointer;
	}
	.select_unselect:hover {
	    background-position: -128px -256px;
	}
	
	.select_unselect {
	    display: inline-block;
	    width: 32px;
	    height: 32px;
	    vertical-align: middle;
	    background: url("<%=path%>/resource/html5/image/icon32.png") no-repeat left top;
	    background-position: -32px -256px;
	    cursor: pointer;
	}
	
	.select_left {
	    display: inline-block;
	    width: 32px;
	    height: 32px;
	    vertical-align: middle;
	    background: url("<%=path%>/resource/html5/image/icon32.png") no-repeat left top;
	    background-position:  -32px -290px;
	    cursor: pointer;
	}
	
	.select_left:hover {
	    background-position: -96px -290px;
	}
	
	.select_right {
	    display: inline-block;
	    width: 32px;
	    height: 32px;
	    vertical-align: middle;
	    background: url("<%=path%>/resource/html5/image/icon32.png") no-repeat left top;
	    background-position:  0 -290px;
	    cursor: pointer;
	}
	
	.select_right:hover {
	    background-position: -64px -290px;
	}
	
	
	</style>
	
	
	<td style="width:5%;text-align: center;">
			<p><span id="button001" style="margin-right: 0px;" class="select_left"></span></p><br/>
	        <p><span id="button003" style="margin-right: 0px;" class="select_selected"></span></p><br/>
	        <p><span id="button004" style="margin-right: 0px;" class="select_unselect"></span></p><br/>
	        <p><span id="button002" style="margin-right: 0px;" class="select_right"></span></p>
	</td>
	
	<td style="vertical-align:top;">
		<div id="rightContent" style="height:100%;">	
			<div id="li003content" style="padding-top:10px;">
				 <div style="width:100%;height:calc(100% - 11px)">
	          <select id="rightselect" style="border:1px solid #ccc;height:100%;" class="form-control" multiple="multiple">
                                          
                     </select>
            	  </div>
		    </div>
          </div>

    </td>
  	
 
	<style>
		.sort_up:hover {
		    background-position: -192px -256px;
		}
		.sort_up {
		    display: inline-block;
		    width: 32px;
		    height: 32px;
		    vertical-align: middle;
		    background: url("<%=path%>/resource/html5/image/icon32.png") no-repeat left top;
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
		    background: url("<%=path%>/resource/html5/image/icon32.png") no-repeat left top;
		    background-position: -96px -256px;
		    cursor: pointer;
		}
		
		
	</style>
	<td style="width:5%;text-align: center;">
		 <p><span id="button005" class="sort_up " style="margin-right: 0px;" ></span></p><br/>
		 <p><span id="button006" class="sort_down " style="margin-right: 0px;"></span></p>
	</td>
  </tr>
  		
  			
  <tr style="wdith:100%;height:60px">
	 <td colspan="4" style="vertical-align:middle;border-top: 1px solid #e5e5e5;color:#fff;width:100%;position: fixed;bottom: 0px;padding: 14px 15px 15px;    margin-bottom: 0; text-align: right;">
	    <button id="button02" class="x-btn ok-btn " " type="button">确定</button>
	    <button style="margin-left:5px;" id="button01" class="x-btn cancel-btn " onclick="cancel();" type="button">取消</button>
	 </td>
 </tr>
</table>

</form>

  </body>
</html>
