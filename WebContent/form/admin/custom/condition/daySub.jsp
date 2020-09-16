<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
		height: calc(100% - 54px);
		text-align: center;
		position: absolute;
		padding: 10px;
		overflow: auto;
	}
</style>
</head>
<body>
	<div id="main">
		<div style="height:34px;margin-bottom: 10px">
			<div style="float: left;width:60px;">
				<label style="line-height:34px;margin-bottom: 0px;font-weight: 700;">表单域：</label>
			</div>
			<div style="float: left;width:calc(100% - 60px);">
				<select name="formit1" id="formit1" class="form-control" style="width: 100%;">
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
		<div style="height:34px;margin-bottom: 10px">
			<div style="float: left;width:60px;">
				<label style="line-height:34px;margin-bottom: 0px;font-weight: 700;">操作符：</label>
			</div>
			<div style="float: left;width:calc(100% - 60px);">
				<input type="text" name="operators" id="operators" value="-" class="form-control" style="width: 100%;" readonly="readonly"/>
			</div>		
		</div>
		<div style="height:34px;margin-bottom: 10px">
			<div style="float: left;width:60px;">
				<label style="line-height:34px;margin-bottom: 0px;font-weight: 700;">表单域：</label>
			</div>
			<div style="float: left;width:calc(100% - 60px);">
				<select name="formit2" id="formit2" class="form-control" style="width: 100%;">
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
		<div>
			<label>
				<input name="dayType" type="radio" class="box" value="0" checked/>
				默认日期差
			</label>
			<label>
				<input name="dayType" type="radio" class="box" value="1"/>
				工作日日期差
			</label>
		</div>	
	</div>
	<div class="cmdLayout">
		<input type="button" class="x-btn ok-btn" name="确定" value="确定" id="submit" >				
		<input type="button" class="x-btn cancel-btn" name="取消" value="取消" id="btn" >			
		<script type="text/javascript">
	        $(".ok-btn").on("click",function(){
	        	var data = {};
	    		var selects_start = document.getElementById("formit1");
	    		var selects_end = document.getElementById("formit2");
	    		var radios = document.getElementsByName("dayType");
	    		var str = "differDate(";
	    		if(radios[1].checked==true){
	    			str = "differDateBiz(";
	    		}
	    		var index_start = selects_start.selectedIndex;
	    		if(selects_start.options[index_start].text.indexOf("[日期变量]") == 0){
	    			str += "["+selects_start.options[index_start].value+"]";
	    		}else{
	    			str += "{"+selects_start.options[index_start].value+"}";
	    		}
	    		str += ",";
	    		var selects_end = selects_end.selectedIndex;
	    		if(selects_start.options[selects_end].text.indexOf("[日期变量]") == 0){
	    			str += "["+selects_start.options[selects_end].value+"]";
	    		}else{
	    			str += "{"+selects_start.options[selects_end].value+"}";
	    		}
	    		str += ")";
	    		data.value = str ;
	    		Matrix.closeWindow(data);
	        });
	        
	        $(".cancel-btn").on("click",function(){
	        	Matrix.closeWindow();
	        })
	   </script>
	</div>
</body>
</html>