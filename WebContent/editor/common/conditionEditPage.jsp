<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML >
<html>
<head>
		<meta charset="UTF-8">
		<title>终止条件</title>
		<%@ include file="/form/html5/admin/html5Head.jsp"%>
		<script type="text/javascript">
			window.onload=function(){
				//设计开发阶段隐藏部门角色按钮
				var phase = '<%= session.getAttribute("phase")%>';
				if(phase == '3'){
					document.getElementById('depbtn').style.display = 'none';
					document.getElementById('rolebtn').style.display = 'none';
				}
			
				
				//从父页面获得条件的值
				var conditionValue = parent.Matrix.getFormItemValue("conditionValue");
				var express = parent.Matrix.getFormItemValue("express");
				if(conditionValue!=null && conditionValue!='null'){
					Matrix.setFormItemValue('inputTextArea001',conditionValue);
				}
				if(express!=null && express!='null'){
					Matrix.setFormItemValue('express',express);
				}
			}
			
			//点击选择行
			function singleClickSelect(row, element){
				$('.changeColor').removeClass('changeColor');//去除之前选中的行的，选中样式
		    	$(element).addClass('changeColor');
			}
			
			var operateValueMap = {'==':'等于','<':'小于','<=':'小于等于','>':'大于','>=':'大于等于'};
			
			//点击添加按钮
			function addCondition(){
				var $tr = $('#DataGrid001_table').find('tr.changeColor');   //选中行
				
				var selectId = "";
				var selectName = "";
				if($tr!=null && $tr.length==1){
		     		var index = $tr.data('index');  //获得选中的行的index
			        var item = Matrix.getGridData('DataGrid001');   //所有数据
			        var record = item[index];  //当前选中行
			        
			        selectId = record.id;//取得数据表格选中数据的编码
					selectName = record.name;
		     	}else{
		     		Matrix.warn("请选择流程变量！");
		     		return;
		     	}
				
			
				var compareValue = Matrix.getFormItemValue('comboBox001');//操作符编号
				var operate = getCompareValue(compareValue);//操作符编码
				var operateName = operateValueMap[operate];//操作符名称
				
				var inputValue = Matrix.getFormItemValue('input001');//输入值
				var ids = Matrix.getFormItemValue('ids');//部门 or 角色 编码
				if(inputValue==null || inputValue=='' || inputValue=='undefined' || inputValue=='null'){
					Matrix.warn("请输入或者选择比较值!");
					return;
				}
				if(ids==null || ids==''){
					ids = inputValue;
				}
				var nameStr = selectId+operate+""+ids+"";//"【"+selectName+"】 【"+operateName+"】 【"+inputValue+"】";
				var idStr = selectId+operate+""+ids+"";
				
				var textAreaValue = Matrix.getFormItemValue('inputTextArea001');//生成表达式的名称
				if(textAreaValue==null||textAreaValue=='undefined'){
					textAreaValue="";
				}
				var cursorPosition = getCursorPosition('inputTextArea001');//获得当前光标的位置
				var preCursorStr = textAreaValue.substring(0,cursorPosition);
				var aftCursorStr = textAreaValue.substring(cursorPosition);
				
				var conditionExpressId = Matrix.getFormItemValue("conditionExpressId");//生成表达式的值
				
				
				if(textAreaValue==null||textAreaValue=='undefined'||textAreaValue=='null'){
					textAreaValue="";
				}
				if(conditionExpressId==null||conditionExpressId=='undefined'||conditionExpressId=='null'){
					conditionExpressId="";
				}
				
				if(textAreaValue == ""){
					preCursorStr = nameStr;
				}else if(textAreaValue.length>0){
					if(textAreaValue.indexOf(nameStr) == -1){
						preCursorStr = preCursorStr +" "+ nameStr+" " ;
					}
				}
				if(conditionExpressId == ""){
					conditionExpressId = idStr;
				}else if(conditionExpressId.length>0){
					if(conditionExpressId.indexOf(idStr) == -1){
						if( !conditionExpressId.endWith("and ") && !conditionExpressId.endWith("or ") && !conditionExpressId.endWith("not ")){
							conditionExpressId += " and ";
						}
					
						conditionExpressId += idStr;
					}
					
				}
				textAreaValue = preCursorStr + aftCursorStr;
				Matrix.setFormItemValue('inputTextArea001',textAreaValue);
				Matrix.setFormItemValue("conditionExpressId",conditionExpressId);
			}
			
			function getCompareValue(compareValue){
				if(compareValue != null && compareValue!=''){
					if(!isNaN(parseInt(compareValue))){
						switch(parseInt(compareValue)){
							case 0:
								return "==";
							case 1:
								return "<";
							case 2:
								return "<=";
							case 3:
								return ">";
							case 4:
								return ">=";
						}
					}
				}
			}
			//获得文本域中当前光标位置
			function getCursorPosition(elementId){
	            var elements = document.getElementsByName(elementId);
	            var element = null;
	            if(elements!=null && elements.length>0){
	            	element = elements[0];
	            }
		        var cursurPosition=0;
	            if(element!=null){
		            if(element.selectionStart){//非IE
		                cursurPosition= element.selectionStart;
		            }else{//IE
		                try{
			                var range = document.selection.createRange();
			                range.moveStart("character",-element.value.length);
			                cursurPosition=range.text.length;
		                }catch(e){
		                 	cursurPosition = 0;
		                }
		            }
	            }
		        return cursurPosition;
	        }
			
			
			//点击+  -  *  / and or  not 等按钮 执行的动作
			function basicOperat(value){
				var i = parseInt(value);
				var textAreaValue = Matrix.getFormItemValue('inputTextArea001');
				if(textAreaValue==null||textAreaValue=='undefined'){
					textAreaValue="";
				}
				var cursorPosition = getCursorPosition('inputTextArea001');//获得当前光标的位置
				var preCursorStr = textAreaValue.substring(0,cursorPosition);
				var aftCursorStr = textAreaValue.substring(cursorPosition);
				var textValue = "";
				switch(i){
					case 1:
						textValue = preCursorStr+" + "+aftCursorStr;
						Matrix.setFormItemValue('inputTextArea001',textValue);
						return;
					case 2:
						textValue = preCursorStr+" - "+aftCursorStr;
						Matrix.setFormItemValue('inputTextArea001',textValue);
						return;
					case 3:
						textValue = preCursorStr+" * "+aftCursorStr;
						Matrix.setFormItemValue('inputTextArea001',textValue);
						return;
					case 4:
						textValue = preCursorStr+" / "+aftCursorStr;
						Matrix.setFormItemValue('inputTextArea001',textValue);
						return;
					case 5:
						textValue = preCursorStr+" and "+aftCursorStr;
						Matrix.setFormItemValue('inputTextArea001',textValue);
						return;
					case 6:
						textValue = preCursorStr+" or "+aftCursorStr;
						Matrix.setFormItemValue('inputTextArea001',textValue);
						return;
					case 7:
						textValue = preCursorStr+" not "+aftCursorStr;
						Matrix.setFormItemValue('inputTextArea001',textValue);
						return;
					case 8:
						textValue = preCursorStr+" ( "+aftCursorStr;
						Matrix.setFormItemValue('inputTextArea001',textValue);
						return;
					case 9:
						textValue = preCursorStr+" ) "+aftCursorStr;
						Matrix.setFormItemValue('inputTextArea001',textValue);
						return;
					
				}
			}
			
			//点击确认
			function comfirmSelect(){
				var textAreaValue = Matrix.getFormItemValue('inputTextArea001');//生成表达式的名称
				
				var conditionExpressId = Matrix.getFormItemValue('conditionExpressId');
				
				var data = {};
				if(textAreaValue!=null&&textAreaValue!="undefined"&&textAreaValue!='null'){
					data.expressName = textAreaValue;
				}else{
					data.expressName = "";
				}
				if(conditionExpressId!=null&&conditionExpressId!="undefined"&&conditionExpressId!='null'){
					data.express = conditionExpressId;
				}else{
					data.express = "";
				}
				
				Matrix.closeWindow(data);//确认选择关闭窗口

			}
			//选择部门或者角色
			function selectDepOrRole(value){
				if(value!=null){
					if(value=='selectDep'){
						//部门
						layer.open({
						    id:'layer01',
							type : 2,
							
							title : ['请选择'],
							closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
							shadeClose: false, //开启遮罩关闭
							area : [ '90%', '90%' ],
							content : "<%=request.getContextPath()%>/office/html5/select/SingleSelectDep.jsp?iframewindowid=layer01"
						});
						
					}else if(value=='selectRole'){
						//角色
						layer.open({
						    id:'layer02',
							type : 2,
							
							title : ['请选择'],
							closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
							shadeClose: false, //开启遮罩关闭
							area : [ '90%', '90%' ],
							content : "<%=request.getContextPath()%>/office/html5/select/SingleSelectRole.jsp?iframewindowid=layer02"
						});
						//MDialog0.initSrc="<%=request.getContextPath()%>/office/html5/select/SingleSelectRole.jsp?iframewindowid=layer01";
					}
				}
			}
			//选择部门回调
			function onlayer01Close(data){
				if(data!=null){
					var names = data.names;
					var ids = data.ids;
					Matrix.setFormItemValue("input001",names);
					document.getElementById('ids').value=ids;
				}
			}
			//选择角色回调
			function onlayer02Close(data){
				if(data!=null){
					var names = data.names;
					var ids = data.ids;
					Matrix.setFormItemValue("input001",names);
					document.getElementById('ids').value=ids;
				}
			}
			function onlayer03Close(data){
				if(data!=null){
					var name = data.name;
        			var id = data.id;
        			var textAreaValue = Matrix.getFormItemValue('inputTextArea001');//生成表达式的值
        			if(textAreaValue==null || textAreaValue==''){
        				textAreaValue = "";
        			}
        			var cursorPosition = getCursorPosition('inputTextArea001');//获得当前光标的位置
					var preCursorStr = textAreaValue.substring(0,cursorPosition);
					var aftCursorStr = textAreaValue.substring(cursorPosition);
        			
        			//把添加的条件，插入到光标位置
					textAreaValue = preCursorStr +" "+ name +" "+ aftCursorStr;
    
        			Matrix.setFormItemValue('inputTextArea001',textAreaValue);
        			Matrix.setFormItemValue("conditionExpressId",conditionExpressId);
				}
			
			}
			
			function onlayer04Close(data){
				if(data!=null){
					var name = data.name;
        			var id = data.id;
        			var textAreaValue = Matrix.getFormItemValue('inputTextArea001');//生成表达式的值
        			if(textAreaValue==null || textAreaValue==''){
        				textAreaValue = "";
        			}
        			var cursorPosition = getCursorPosition('inputTextArea001');//获得当前光标的位置
					var preCursorStr = textAreaValue.substring(0,cursorPosition);
					var aftCursorStr = textAreaValue.substring(cursorPosition);
					
					//把添加的条件，插入到光标位置
					textAreaValue = preCursorStr +" "+ name +" "+ aftCursorStr;
        		
        			var conditionExpressId = Matrix.getFormItemValue('conditionExpressId');
        			if(conditionExpressId!="" && conditionExpressId.indexOf(id)==-1 &&  !conditionExpressId.endsWith("and ") && !conditionExpressId.endsWith("or ") && !conditionExpressId.endsWith("not ")){
        				conditionExpressId+=" and ";
        				conditionExpressId+=id;
        			}else{
        				conditionExpressId = id;
        			}
    
        			Matrix.setFormItemValue('inputTextArea001',textAreaValue);
        			Matrix.setFormItemValue("conditionExpressId",conditionExpressId);
				}
			
			}
			function onlayer05Close(data){
				if(data!=null){
					var name = data.name;
        			var id = data.id;
        			var textAreaValue = Matrix.getFormItemValue('inputTextArea001');//生成表达式的值
        			var textAreaValue = Matrix.getFormItemValue('inputTextArea001');//生成表达式的值
        			if(textAreaValue==null || textAreaValue==''){
        				//确保能分隔
        				textAreaValue = "";
        			}
        			var cursorPosition = getCursorPosition('inputTextArea001');//获得当前光标的位置
					var preCursorStr = textAreaValue.substring(0,cursorPosition);
					var aftCursorStr = textAreaValue.substring(cursorPosition);
					
					//把添加的条件，插入到光标位置
					textAreaValue = preCursorStr +" "+ name +" "+ aftCursorStr;
					
        			var conditionExpressId = Matrix.getFormItemValue('conditionExpressId');
        			if(conditionExpressId!="" && conditionExpressId.indexOf(id)==-1 && !conditionExpressId.endsWith("and ") && !conditionExpressId.endsWith("or ") && !conditionExpressId.endsWith("not ")){
        				conditionExpressId+=" and ";
        				conditionExpressId+=id;
        			}else{
        				conditionExpressId = id;
        			}       	
        			Matrix.setFormItemValue('inputTextArea001',textAreaValue);
        			Matrix.setFormItemValue("conditionExpressId",conditionExpressId);
				}
			
			}
		</script>
 </head>
<body>
<div id="j_id1" jsId="j_id1" style="position: relative; _layout: flowlayout; width: 100%; height: 100%;overflow:hidden;">
  <form id="form0" name="form0" eventProxy="Mform0" method="post" action="<%=request.getContextPath()%>/editor/editor_loadConditionEditDataGridData.action"
	 style="margin: 0px;padding:0px; height: 100%;" enctype="application/x-www-form-urlencoded">
	 <input type="hidden" name="form0" value="form0"/>
	 <input name="version" id="version" type="hidden">
	 <!-- ids 用来存放  选择部门或者选择角色回调回来的编码值 -->
	 <input type="hidden" name="ids" id="ids" />
	 <table class="query_form_content" style="height:calc(100% - 54px);width:100%;overflow:hidden;border-collapse: collapse;border-spacing:0px;table-layout:fixed;">
		<tr id="tr001" style="height:60%;">
			<td id="td011" style="border-style:none;width:100%;margin:0px;padding:0px;vertical-align: top;">
				<div style="height:100%;overflow:auto;">
					<table id="DataGrid001_table" style="width:100%;height:100%;">
					</table>
				</div>
				<script>
				$(document).ready(function() {   
					$("#DataGrid001_table").bootstrapTable({           
						classes: 'table table-hover table-no-bordered',
						method: "post", 
						url: "<%=path%>/editor/editor_loadConditionEditDataGridData.action", 
						search: false, 
						sidePagination: "server",
					    columns: [
					        {title:"编码",field:"id",sortable:true,clickToSelect:true,editorType:'Text',type:'text'},
					        {title:"名称",field:"name",sortable:true,clickToSelect:true,editorType:'Text',type:'text'},
					        {title:"类型",field:"type",sortable:true,clickToSelect:true,editorType:'Text',type:'text'}
					    ],
					    singleSelect:true,
					    onClickRow:function(row, $element){   //单击行事件
					    	singleClickSelect(row, $element);
						},
					});
			     });			
				</script>			
		   </td>
		</tr>
		<tr id="tr002">
			<td id="td022" style="width:100%;height:35px;background-color: rgb(250, 250, 250);border: 1px solid #cccccc;">
				<label id="label001" name="label001" id="label001" style="width:10%;margin-left:10px;text-align: center;display: inline-block;">
					操作符：
				</label>
				<div id="comboBox001_div" style="width:20%;height: 100%;display: inline-block;">
					<select id="comboBox001" name="comboBox001" value="${activity.priority}" class="form-control" style="width:100%;height: 100%;">
	                     <option value="0" selected>等于</option>
	                     <option value="1">小于</option>
	                     <option value="2">小于等于</option>
	                     <option value="3">大于</option>
	                     <option value="4">大于等于</option>
	                 </select>	
				</div>
			
				<label id="label002" name="label002" id="label002" style="width:10%;margin-left:10px;text-align: center;display: inline-block;">
					比较值：
				</label>
				<div id="input001_div" style="width:40%;height: 100%;display: inline-block;">
					<input id="input001" name="input001" type="text" value="${activity.id}" class="form-control" style="width:100%;height: 100%;"/>
			    </div>
			    <div style="width:10%;display: inline-block;">
			    	<button type="button" class="btn  btn-default toolBarItem" id="button001" style="vertical-align: baseline;padding-left:5px;padding-right:5px;margin:0px;border:0;" onclick="addCondition();">
						<img src="<%=path%>/resource/images/new.png" style="padding-right: 2px;">添加
			    	</button>
			    </div>
			</td>
		</tr>
		<tr id="tr003">
			<td id="td033" class="tdLayout"  style="width:100%;text-align:left;border-bottom: 0px;">
				<div class="btn-group" role="group">
					<button type="button" class="x-btn ok-btn" value="1" style="margin-right: 0px;">+</button>
					<button type="button" class="x-btn ok-btn" value="2" style="margin-right: 0px;">-</button>
					<button type="button" class="x-btn ok-btn" value="3" style="margin-right: 0px;">*</button>
					<button type="button" class="x-btn ok-btn" value="4" style="margin-right: 0px;">/</button>	
					<button type="button" class="x-btn ok-btn" value="5" style="margin-right: 0px;">and</button>
					<button type="button" class="x-btn ok-btn" value="6" style="margin-right: 0px;">or</button>	
					<button type="button" class="x-btn ok-btn" value="7" style="margin-right: 0px;">not</button>
					<button type="button" class="x-btn ok-btn" value="8" style="margin-right: 0px;">(</button>	
					<button type="button" class="x-btn ok-btn" value="9" style="margin-right: 0px;">)</button>
					<button type="button" class="x-btn ok-btn" value="10" id="depbtn" style="margin-right: 0px;">部门</button>
					<button type="button" class="x-btn ok-btn" value="11" id="rolebtn" style="margin-right: 0px;">角色</button>		
					<script>
						$(".btn-group").children("button").on("click",function(){
							debugger;
							var value = $(this).val();
							if(value == 10){
								layer.open({
							    	id:'layer03',
									type : 2,
									
									title : ['设置部门条件'],
									closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
									shadeClose: false, //开启遮罩关闭
									area : [ '90%', '90%' ],
									content : "<%=request.getContextPath()%>/editor/common/selectCondition.jsp?iframewindowid=layer03&condition=depCondition"
								});
							}else if(value == 11){
								layer.open({
							    	id:'layer04',
									type : 2,
									
									title : ['设置角色条件'],
									closeBtn : 1,//显示关闭按钮风格1 2  0不显示关闭按钮
									shadeClose: false, //开启遮罩关闭
									area : [ '90%', '90%' ],
									content : "<%=request.getContextPath()%>/editor/common/selectCondition.jsp?iframewindowid=layer04&condition=roleCondition"
								});
							}else{
								basicOperat(value);
							}
							
					     });
					</script>
				</div>
			</td>
		</tr>
		<tr id="tr004">
			<td id="td044" style="width:100%;height:120px;border:0px;">
				<div id="inputTextArea001_div" style="height:100%;">
					<textarea class="form-control" rows="3" id="inputTextArea001" name="inputTextArea001" style="height:100%;resize: none;"></textarea>
				</div>
				<input type="hidden" name="conditionExpressId" id="conditionExpressId"/>
			</td>
		</tr>
		<tr id="tr005">
			<td id="td055" class="cmdLayout" style="border-top: 0px;">
				<input type="button" class="x-btn ok-btn" id="button002" name="确认" value="确认" id="submit" >
				<input type="button" class="x-btn cancel-btn" id="button003" name="取消" value="取消" id="btn" >
				<script type="text/javascript">
					$("#button002").on("click",function(){
						comfirmSelect();			
			        });
			        
			        $("#button003").on("click",function(){	        	
						Matrix.closeWindow();
						//var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
						//parent.layer.close(index);
			        })    	
				</script>		
			</td>
		</tr>
	</table>
  </form>					
</div>
</body>
</html>