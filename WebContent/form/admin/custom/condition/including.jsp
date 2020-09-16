<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>包含不包含选择页面</title>
<%@ include file="/form/html5/admin/html5Head.jsp"%>
<style type="text/css">
	#main {
		width: 100%;
		height: calc(100% - 54px);
		text-align: center;
		position: absolute;
		padding: 10px;
		overflow: auto;
	}
</style>	
</head>
<body>
	<%String text=com.matrix.office.chinese.util.ChineseUtill.toChinese(request.getParameter("text"));
	  String type = request.getParameter("type");  //是包含还是不包含
	  String content = "{"+text+"}";	
	 %>
	<div id="main">
		<div style="padding-bottom: 5px;">
			<label style="float:left;line-height:34px;width:70px;margin-bottom: 0px;font-weight: 700;">表单域：</label>
			<input type="text" name="content" id="content" value="<%=content %>" class="form-control" style="width: calc(100% - 70px)"/>
		</div>
		<div style="padding-bottom: 5px;">
			<label style="float:left;line-height:34px;width:70px;margin-bottom: 0px;font-weight: 700;">操作符：</label>
			<input type="text" name="operators" id="operators" value="<%=type %>" class="form-control" style="width: calc(100% - 70px);"/>
		</div>
		<div>
			<label style="float:left;line-height:34px;width:70px;margin-bottom: 0px;font-weight: 700;">值：</label>
			<input type="text" name="value" id="value" class="form-control" style="width: calc(100% - 70px)"/>
		</div>
	</div>
	<div class="cmdLayout">
		<input type="button" class="x-btn ok-btn" name="确定" value="确定" id="submit" >				
		<input type="button" class="x-btn cancel-btn" name="取消" value="取消" id="btn" >			
		<script type="text/javascript">
	        $(".ok-btn").on("click",function(){
	        	var data = {};
	    		var content=document.getElementById('content').value;
	    		var operators=document.getElementById('operators').value;
	    		var val=document.getElementById('value').value;
	    		if(val==null||val==''||val=='undefined'||val==""){
	    			Matrix.warn("请输入值!");
	    		}else{
	    			data.value=content+" ";
	    			data.value+=operators+" ";
	    			data.value+="'%";
	    			data.value+=val;
	    			data.value+="%'";
	    		  	Matrix.closeWindow(data);
	    	    }
	        });
	        
	        $(".cancel-btn").on("click",function(){
	        	Matrix.closeWindow();
	        })
	   </script>
	</div>
</body>
</html>
