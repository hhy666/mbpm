<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html style="height:100%;">
<head>
<meta charset="UTF-8"/>
<title>选择条件</title>
<%@ include file="/form/html5/admin/html5Head.jsp"%>
<style type="text/css">
.content-td{
	 width:75%;
}
.label-td{
	 width:25%;
	 text-align:center;
	 background-color:#efefef;
}
.form-control-feedback{
  pointer-events: auto;
  cursor: pointer;
}
.form-control-feedback:hover{
		color:black;
}
</style>
<script type="text/javascript">

 $(document).ready(function(){
	 $("#text").val(parent.checkvalue());
	 var editorType=$("#editorType").val();
	 
	 var optionJsonObj=eval("("+parent.getOptionJsonStr()+")")
	 
	 
	 if(editorType=='23' || editorType=='24' || editorType=='25' || editorType=='26'){
		 $("#serch")[0].style.display="";
		 $("#query").on("click",function(){
		     if(editorType=='25'){    //单选部门
		    	 layer.open({
					    id:'layer01',
						type : 2,
						
						title : ['请选择'],
						//closeBtn : 2,//显示关闭按钮风格1 2  0不显示关闭按钮
						shadeClose: false, //开启遮罩关闭
						area : [ '95%', '95%' ],
						content : "<%=request.getContextPath()%>/office/html5/select/SingleSelectDep.jsp?iframewindowid=layer01"
				 });
		     }
		     if(editorType=='23'){    //单选用户
		    	 layer.open({
					    id:'layer02',
						type : 2,
						
						title : ['请选择'],
						//closeBtn : 2,//显示关闭按钮风格1 2  0不显示关闭按钮
						shadeClose: false, //开启遮罩关闭
						area : [ '95%', '95%' ],
						content : "<%=request.getContextPath()%>/office/html5/select/SingleSelectPerson.jsp?iframewindowid=layer02"
				 }); 
		     }
		     if(editorType=='26'){   //多选部门
		    	 layer.open({
					    id:'layer03',
						type : 2,
						
						title : ['请选择'],
						//closeBtn : 2,//显示关闭按钮风格1 2  0不显示关闭按钮
						shadeClose: false, //开启遮罩关闭
						area : [ '95%', '95%' ],
						content : "<%=request.getContextPath()%>/office/html5/select/MultiSelectDep.jsp?iframewindowid=layer03"
				 }); 
		     }
		     if(editorType=='24'){  //多选用户
		    	 layer.open({
					    id:'layer04',
						type : 2,
						
						title : ['请选择'],
						//closeBtn : 2,//显示关闭按钮风格1 2  0不显示关闭按钮
						shadeClose: false, //开启遮罩关闭
						area : [ '95%', '95%' ],
						content : "<%=request.getContextPath()%>/office/html5/select/MultiSelectPerson.jsp?iframewindowid=layer04"
				 });
		     }
		 })
	 }else if(editorType=='5' || editorType=='8'){
		 $("#opdemo")[0].style.display="";
		 var optionvalue=optionJsonObj[parent.checkvalue()];
		 $.ajax({
			 url:"<%=path %>/select/SelectAction_getMCode.action?option='"+optionvalue+"'",
			 type:"post",
			 dataType:"json",
			 success:function(data){
				 if(data!=null && data!=""){
					var optionString=""
					var arr=data.returnjson;
					for(var i in arr){
						$("#opselect").append("<option value=\"" + arr[i].id + "\" >" + arr[i].name + "</option>");
					}
					$('.selectpicker').selectpicker('val', '');  
	                $('.selectpicker').selectpicker('refresh'); 
	                
	                $("#mname").val(data.mname);
				  } 
				
			 }
		 }) 
	 }else if(editorType=='9' || editorType=='22'){
		 $("#multipleselect")[0].style.display="";  
		 var optionvalue=optionJsonObj[parent.checkvalue()];
			
		 $.ajax({
			 url:"<%=path %>/select/SelectAction_getMCode.action?option='"+optionvalue+"'",
			 type:"post",
			 dataType:"json",
			 success:function(data){
				 if(data!=null && data!=""){
					var optionString=""
					var arr=data.returnjson;
					for(var i in arr){
						$("#muselect").append("<option value=\"" + arr[i].id + "\" >" + arr[i].name + "</option>");
					}
					$('.selectpicker').selectpicker('val', '');  
	                $('.selectpicker').selectpicker('refresh'); 
	                
	                $("#mname").val(data.mname);
				  } 
			 }
		 }) 
	 }else{
		 $("#txt")[0].style.display="";
	 } 
	 
	 
	 //点击确定保存回调
	  $(".ok-btn").on("click",function(){
		var text=$("#text").val(); //选中表单域的值
      	var operation=$("#operation").find("option:selected").text();   //操作符
   		
      	var prefixName="";
      	if($("#serch")[0].style.display==""){
      		var value=$("#setxt").val();
      		if(value==null || value==""){ 
      			layer.msg("请选择值!");
      			return;
      		}
      		var prefix=$("#selectType").val();
      		
      		prefixName+="{"         //选中后的前缀表示                       
          	prefixName+=text;
          	prefixName+="}"
          	prefixName+=operation;
          	prefixName=prefixName+"'{"+prefix+"(";
          	prefixName=prefixName+""+value+")}'";     //最终条件 ===》   {[主表]部门}='{部门(互联网业务部)}'
      		
      	}else if($("#opdemo")[0].style.display==""){                   //单选下拉框
      		var value=$("#opselect").find("option:selected").text();
      		if(value==null || value==""){
      			layer.msg("请选择值!");
      			return;
      		}
      		var prefix="代码";
      		var mname=$("#mname").val();
      		
      		prefixName+="{"         //选中后的前缀表示                       
      	    prefixName+=text;
      	    prefixName+="}"
          	prefixName+=operation;
          	prefixName=prefixName+"'{"+prefix+"(";
          	prefixName=prefixName+""+mname+":";
          	prefixName=prefixName+""+value+")}'";     //最终条件
          
      	}else if($("#multipleselect")[0].style.display==""){             //多选下拉框
      		var muselect = document.getElementById("muselect");
      		if(muselect==null || muselect==""){
      			layer.msg("请选择值!");
      			return;
      		}
      	    var value = [];
      	    for(i=0;i<muselect.length;i++){
      	        if(muselect.options[i].selected){
      	            value.push(muselect[i].text);
      	        }
      	    }
      	  	var prefix="代码";
    		var mname=$("#mname").val();
    		
    		prefixName+="{"         //选中后的前缀表示                       
          	prefixName+=text;
          	prefixName+="}"
        	prefixName+=operation;
        	prefixName=prefixName+"'{"+prefix+"(";
        	prefixName=prefixName+""+mname+":";
        	prefixName=prefixName+""+value+")}'";     //最终条件

      	    
      	}else if($("#txt")[0].style.display==""){               //普通文本框
      		var value=$("#tdemo").val();
      		if(value==null || value==""){
      			layer.msg("请选择值!");
      			return;
      		}
      		prefixName+="{"
      		prefixName+=text;
      		prefixName+="}"
      		prefixName+=operation;
      		prefixName=prefixName+value;
      	}
      	var data ={};
      	data.name=prefixName;
  		Matrix.closeLayerWindow(data);
      	
     });
	//取消关闭窗口
	   $(".cancel-btn").on("click",function(){
		  Matrix.closeLayerWindow();
	  })
  })
  
  
  
  
  //单选部门回调
  function onlayer01Close(data){
	 if(data!=null){
		 var name=data.names;
		 var obj=document.getElementById("setxt");
		 if(obj==null || obj==''){
			 obj=='';
		 }
		 obj.value=name;
		 $("#selectType").val("部门");
		 obj.focus();
	 }
  }
  //单选用户回调
  function onlayer02Close(data){
	  if(data!=null){
		 var name=data.names;
		 var obj=document.getElementById("setxt");
		 if(obj!=null || obj==''){
			 obj=='';
		 }
		 obj.value=name;
		 $("#selectType").val("人员");
		 obj.focus();
	  }
  }
  //多选部门回调
  function onlayer03Close(data){
	  if(data!=null){
		  var name=data.names;
		  var obj=document.getElementById("setxt");
		  if(obj!=null || obj==''){
			  obj=='';
		  }
		  obj.value+=name;
		  $("#selectType").val("部门");
		  obj.focus();
	  }
  }
  //多选用户回调
  function onlayer04Close(data){
	  if(data!=null){
		  var name=data.names;
		  var obj=document.getElementById("setxt");
		  if(obj!=null || obj==''){
			  obj=='';
		  }
		  obj.value+=name;
		  $("#selectType").val("人员");
		  obj.focus();
	  }
  }
 

 
	
</script>
</head>
<body style="overflow:hidden;height:100%;">
	<form action="" style="overflow:hidden;height:100%;">
	<input type="hidden" name="editorType" id="editorType" value="${param.editorType }"/>
	<input type="hidden" name="mname" id="mname"/>
	<input type="hidden" name="selectType" id="selectType">
	  <div style="position: absolute;height: 100%;width: 100%;">
		<div style="height:calc(100% - 54px);overflow: auto;">
			<table class="table table-bordered" >
				<tr>
					<td class="label-td" style="padding-top:15px;">
						<label>表单域：</label>
					</td>
					<td class="content-td">
						<input type="text" class="form-control" id="text" style="width:80%;" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td class="label-td" style="padding-top:15px;">
						<label>操作符：</label>
					</td>
					<td class="content-td">
						<div class="" style="width:80%;">
							<select id="operation" class="selectpicker show-tick form-control">
		                       <option value="1">==</option>
		                       <option value="2">></option>
		                       <option value="3"><</option>
		                       <option value="4">>=</option>
		                       <option value="5"><=</option>
		                       <option value="5"><></option>
		                    </select>
		                 </div>
					</td>
				</tr>
				<tr>
					<td class="label-td" style="padding-top:15px;">
						<label class="control-label">值：</label>
					</td>
					<td class="content-td" id="t1"> 
						<div class="input-group" style="display:none;width:80%;" id="serch">
						    <input type="text" class="form-control" id="setxt" readonly="readonly"/>
						    <span class="input-group-addon addon-udSelect udSelect" id="query"><i class="fa fa-search"></i></span>
						</div>
		                            							                       				
						<div style="display:none;width:80%;" id="opdemo">
						 	<select id="opselect" class="selectpicker show-tick form-control" title="请选择">
		                     	
		                    </select>
		                </div>
		                
		                <div style="display:none;width:80%;" id="multipleselect">
						 	<select id="muselect" class="selectpicker show-tick form-control" multiple data-live-search="false" title="请选择">
		                         
		                     </select>
		                </div>
		                
		                <div style="display:none;" id="txt">
		                 	<input type="text" class="form-control" id="tdemo" style="width:80%;"/>
		                </div>
					</td>
				</tr>
			</table>
		</div>
		<div class="cmdLayout">
			<input type="button" class="x-btn ok-btn" name="确定" value="确定" id="submit" >
			<input type="button" class="x-btn cancel-btn" name="取消" value="取消" id="btn" >
		</div>
	  </div>
	</form>
</body>
</html>