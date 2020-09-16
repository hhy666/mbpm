<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="commonj.sdo.DataObject"%>
<%@ page import="com.matrix.commonservice.data.DataService"%>
<%@ page
	import="com.matrix.client.foundation.common.helper.CommonServiceHelper"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="com.matrix.form.api.MFormContext"%>
<%@ page import="com.matrix.form.engine.foundation.FormStore"%>
<%@ page import="com.matrix.form.model.PropertyBasicInfo"%>
<%@ page import="com.matrix.form.model.form.FormVariable"%>
<%@ page import="com.matrix.form.model.config.FormContentHelper"%>
<%@ page import="com.matrix.form.model.FormContainer"%>
<%@ page import="com.matrix.form.model.form.FormModel"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>选择取年  取月 取日 取星期几 取季</title>
<%@ include file="/form/html5/admin/html5Head.jsp"%>
<style type="text/css">
	#main {
		width: 100%;
		height: 45%;
		text-align: center;
		position: absolute;
		padding: 10px;
	}
</style>		
</head>
<body>
	<div id="main">
		<div>
			<label style="float:left;line-height:34px;width:100px;margin-bottom: 0px;font-weight: 700;">表单域：</label>
			<select id="formit1" class="form-control" style="width:calc(100% - 100px)">
				<c:forEach var="field" items="${entVal}">
					<option value="${field}">${field}</option>
				</c:forEach>
				<c:forEach var="dateVar" items="${dateVars}">
					<c:if test="${dateVar!='本年' && dateVar!='本季' && dateVar!='本月' && dateVar!='本日'}">
						<option value="${dateVar}">[日期变量]${dateVar}</option>
					</c:if>
				</c:forEach>
				<c:forEach var="sysData" items="${sysDataVars}">
					<option value="${sysData}">[系统数据域]${sysData}</option>
				</c:forEach>
			</select>
		</div>
	</div>
	<div class="cmdLayout">
		<input type="button" class="x-btn ok-btn" name="确定" value="确定" id="submit" >				
		<input type="button" class="x-btn cancel-btn" name="取消" value="取消" id="btn" >			
		<script type="text/javascript">
	        $(".ok-btn").on("click",function(){
	        	var selects = document.getElementById("formit1");
	    		var index = selects.selectedIndex;
	    		if(selects.options[index].text.indexOf("[日期变量]") == 0){
	    			var str = "([" +　selects.options[index].value + "])";
	    		}else{
	    			var str = "({" +　selects.options[index].value + "})";
	    		}	
	    		var data = {};
	    		data.value = str;
	    		Matrix.closeWindow(data);		
	        });
	        
	        $(".cancel-btn").on("click",function(){
	        	Matrix.closeWindow();
	        })
	   </script>
	</div>
</body>
</html>
</script>