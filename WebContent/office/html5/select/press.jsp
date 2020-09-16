<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link href='<%=path %>/resource/html5/css/style.min.css' rel="stylesheet"></link>
<link href='<%=path %>/resource/html5/css/matrix_runtime.css' rel="stylesheet"></link>
<link href='<%=path %>/resource/html5/css/bootstrap/dist/css/bootstrap.min.css' rel="stylesheet"></link>
<link href='<%=path %>/resource/html5/assets/bootstrap-table/src/bootstrap-table.css'	rel="stylesheet"></link>
<link rel='stylesheet' href='<%=path %>/resource/html5/themes/default/style.min.css'/>
<SCRIPT SRC='<%=path %>/resource/html5/js/jquery.min.js'></SCRIPT>
<script src='<%=path %>/resource/html5/assets/bootstrap-table/src/bootstrap-table.js'></script>

<SCRIPT>var webContextPath = "<%=path %>";</SCRIPT>
<style>
footer {
  background: #F8F8F8;
  color:#c0c0c0;
  padding: 10px;
  text-align: center;
}
#DataGrid001_table th div{
  background-color:white;
}

</style>
</head>
<body>
    <header>
      <h2 style="display:none">催办</h1>
    </header>
	
	<div style="height:100%;width:100%;">
		<label style="margin-top:10px;margin-buttom:10px;"><span style="padding-left:5px;">请选择人员</span></label>
		<div style="height:50%;width:100%;overflow:auto;">
			<table id="DataGrid001_table" style="width:100%;height:100%;">				
			</table>
			<script>
				$(document).ready(function() { 
					 $("#DataGrid001_table").bootstrapTable({           
							method: "post", 
							url: "<%=path%>/mobile/flowEdit_getPress.action?piid=${param.piid}", 
							search: false, sidePagination: "server", clickToSelect: true,  
							columns: [{checkbox:true},
								  {title:"名称",field:"userName",clickToSelect:true,editorType:'Text',type:'text'}
						    ],
						    undefinedText:"-----",
						    singleSelect:false });
					 });
			</script>
		</div>	
		<div style="margin-top:10px;height:5%;padding-left:5px;">附言:</div>
		<textarea style="width:100%;height:130px;" id="postscript"></textarea>
	</div>
	
    <footer class="cmdLayout">	
		<input type="button" class="x-btn ok-btn" name="确定" value="确定" id="submit" >
		<input type="button" class="x-btn cancel-btn" name="取消" value="取消" id="btn" >		
		
		<script type="text/javascript">
        $(".ok-btn").on("click",function(){
        	 var selections = $('#DataGrid001_table').bootstrapTable('getSelections');
        	 if(selections.length>0&&selections!=null){
	        	 var taskId = selections[0].taskId;
	        	 var userId = selections[0].userId;
	        	 var userName = selections[0].userName;
	        	 var postscript = document.getElementById('postscript').value;
        	 }
        	//去催办
        	 $.ajax({ 
    			 url: '<%=path%>/mobile/flowEdit_toPress.action?taskId='+taskId+'&userName='+userName+'&userId='+userId+'&postscript='+postscript+'',   
    	         type: "post", 
    	         dataType: "json", 
    	         success: function(data){ 
    	        	 if(data==true){
    	        		 Matrix.closeLayerWindow();
    	        		 Matrix.say("催办成功");
    	        	 }else if(data==false){
    	        		 Matrix.warn('没有催办人');
    	        	 }
                 } 
             });
        });
        
        $(".cancel-btn").on("click",function(){
        	Matrix.closeLayerWindow();
        })
		</script>
    </footer>
    <SCRIPT SRC='<%=path %>/resource/html5/js/matrix_runtime.js'></SCRIPT>
	<SCRIPT SRC='<%=path %>/resource/html5/js/jquery.inputmask.bundle.min.js'></SCRIPT>
	<SCRIPT SRC='<%=path %>/resource/html5/css/bootstrap/dist/js/bootstrap.min.js'></SCRIPT>
	<SCRIPT SRC='<%=path %>/resource/html5/js/icheck.min.js'></SCRIPT>
	<SCRIPT SRC='<%=path %>/resource/html5/js/bootstrap-select.js'></SCRIPT>
	<SCRIPT SRC='<%=path %>/resource/html5/js/select2.js'></SCRIPT>
	<SCRIPT SRC='<%=path %>/resource/html5/js/content.min.js'></SCRIPT>
	<SCRIPT SRC='<%=path %>/resource/html5/js/layer.min.js'></SCRIPT>
	<SCRIPT SRC='<%=path %>/resource/html5/js/autosize.min.js'></SCRIPT>
	<SCRIPT SRC='<%=path %>/resource/html5/js/laydate/laydate.js'></SCRIPT>
	<SCRIPT SRC='<%=path %>/resource/html5/js/clockpicker.js'></SCRIPT>
	<SCRIPT SRC='<%=path %>/resource/html5/js/bootstrap-wysiwyg/js/bootstrap-wysiwyg.min.js'></SCRIPT>
	<SCRIPT SRC='<%=path %>/resource/html5/js/jquery.hotkeys/jquery.hotkeys.js'></SCRIPT>
	<SCRIPT SRC='<%=path %>/resource/html5/css/google-code-prettify/src/prettify.js'></SCRIPT>
	<SCRIPT SRC='<%=path %>/resource/html5/js/validator.js'></SCRIPT>
	<script src='<%=path %>/resource/html5/js/jstree.min.js'></script>
	<script src='<%=path %>/resource/html5/assets/bootstrap-table/src/bootstrap-table.js'></script>
</body>
</html>