<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" deferredSyntaxAllowedAsLiteral="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>表单设计属性页面</title>
<%@ include file="/form/html5/admin/html5Head.jsp"%>
<link href='<%=request.getContextPath() %>/resource/html5/css/jquery-editable-select.min.css' rel="stylesheet"></link>
<script src='<%=request.getContextPath() %>/resource/html5/js/jquery-editable-select.min.js'></script>
<link href='<%=request.getContextPath() %>/resource/html5/css/bootstrap-switch.min.css' rel="stylesheet"></link>
<script src='<%=request.getContextPath() %>/resource/html5/js/bootstrap-switch.min.js'></script>
<style type="text/css">
	body{
	    margin: 0;
	    padding: 0;
	    font-size: 14px;
	}
	div{
		box-sizing: border-box;
		-webkit-user-select: none;
	    -khtml-user-select: none;
	    -moz-user-select: none;
	    -ms-user-select: none;
	    -o-user-select: none;
	    user-select: none;
	}
	label{
		height: 30px;
		line-height: 30px;
		font-weight: 700;
	}
	.container{
	    position: absolute;
	    height: 100%;
	    width: 100%;
	}
	.control-pane,.form-pane{
		height: calc(100% - 40px);
		padding: 5px 5px 0px 5px;
	    overflow: auto;
	}
	.empty-message{
		padding-top: 150px;
		font-size: 18px;
		color: #989898;
		text-align: center;
	}
	.x-btn {
		text-decoration: none;
	    -webkit-border-radius: 2px;
	    -moz-border-radius: 2px;
	    border-radius: 2px;
	    cursor: pointer;
	    height: 30px;
	    line-height: 28px;
	    text-align: center;
	    border: 1px solid transparent;
	    overflow: hidden;
	    text-overflow: ellipsis;
	    white-space: nowrap;
	    -webkit-transition: background;
	    -moz-transition: background;
	    -o-transition: background;
	    transition: background;
	    -webkit-transition-duration: .3s;
	    -moz-transition-duration: .3s;
	    -o-transition-duration: .3s;
	    transition-duration: .3s;
	}
	.x-btn:hover{
		background-color: #ebebeb;
	}
	.form-control {
	    border-radius: 0;
	}
</style>
<script type="text/javascript">
	$(function(){
		//默认显示表单属性
		$("#emptyMessage").hide();
		$("#controlProperties").hide();
		//页面初始化表单属性信息
		$.ajax({
 			 url: '<%=request.getContextPath() %>/designer/designProperties_getPropertiesByType.action?type=form',   
 	         type: "post", 
 	         dataType: "json", 
 	         success: function(data){ 
 	        	if(data!=null){
 					var formCode = data.formCode;   //表单编码
 					var formName = data.formName;   //表单名称
 					var jointValidation = data.jointValidation;   //联合校验
 					var failureTips = data.failureTips;   //校验失败提示
 					var dataUnique = data.dataUnique;   //数据唯一
 					
 					$("#formCode").val(formCode);
 					$("#formName").val(formName);	
 					$("#jointValidation").val(jointValidation);
 					$("#failureTips").val(failureTips);				
 					$("#dataUnique").val(dataUnique);		
 					
 					if(!(formCode.endsWith('_mobile'))){   //电脑端才配置数据权限
 						$("#dataPower").css('display','block'); 
 					}
 	        	}
             } 
        });
		
		//监听标签页DIV点击切换事件
		$('#control').click(function(){
			$('.control-pane').css('display','block'); 
			$('.form-pane').css('display','none'); 
			$("#control").addClass("select");
			$("#form").removeClass("select");
			if($('#controlProperties').is(':visible')){
				$("#emptyMessage").hide();
			}else{
				$("#emptyMessage").show();
			}
		});
		$('#form').click(function(){
			$('.form-pane').css('display','block'); 
			$('.control-pane').css('display','none'); 
			$("#form").addClass("select");
			$("#control").removeClass("select");
		});
		
		//监听预扣除下拉框改变事件
		$("#preDeduction").change(function(){ 
			var value = $(this).val();           
      	    if(value == 'true'){
	 			$("#dependencyPro").show();
                $("#dependencyPro_div").show();
                $("#dependencyPro_div").prev().show();
            }else{
				$("#dependencyPro").hide();
				$("#dependencyPro").val('');  //置空关联属性默认无
				$("#dependencyPro_div").hide();
                $("#dependencyPro_div").prev().hide();
            }
         });
		
		$("#defaultValue").editableSelect({
	 	     filter: false,
	 	     effects: 'fade',
	 	     duration: 200
	 	}).on('select.editable-select',function(e, li) {    
	 		debugger;
	 		$('#recordDefault').val($('li.selected').attr('value'));  //记录默认值
	 		updatePropertiesByType($(this)[0]);
	 	})
	 	$("#defaultValue").on('input propertychange',function(e) {
	 		debugger;
	 		$('#recordDefault').val($(this).val());  //记录默认值
	 		updatePropertiesByType($(this)[0]);
	 	});

	})
	
	//点击控件加载控件属性
	function initProperties(id){
		//记录当前点击的控件编码
		$("#componentId").val(id);
		//显示控件属性页面
		$('.control-pane').css('display','block'); 
		$('.form-pane').css('display','none'); 
		$("#control").addClass("select");
		$("#form").removeClass("select");
		$("#emptyMessage").hide();
		$("#controlProperties").show();
		//默认隐藏关联属性下拉框(预扣除时才显示)
		$("#dependencyPro").hide();
		//页面初始化表单属性信息
		$.ajax({
 			 url: '<%=request.getContextPath() %>/designer/designProperties_getPropertiesByType.action?type=control&id='+id,   
 	         type: "post", 
 	         dataType: "json", 
 	         success: function(data){ 
 	        	if(data!=null){
 	        		var componentTypeId = data.componentTypeId;
 	        		//记录当前点击的控件类型编码
 	        		$("#componentTypeId").val(componentTypeId);
 	        		if(componentTypeId == 'TabContainer' || componentTypeId == 'comboBox' || componentTypeId == 'EditList'){   //标签容器  下拉框  重复表才有更多属性
 	        			$('#moreAttribute').show();
 	        		}else{
 	        			$('#moreAttribute').hide();
 	        		}
 	        		var isMuiInput = data.isMuiInput;
 	        		if(isMuiInput && isMuiInput == 'true'){  
 	        			$('#dataValidator').show();
 	        		}else{
 	        			$('#dataValidator').hide();
 	        		}
 	        		
 	        		//如果是自定义组件记录自定义组件类别编码
 	        		if(componentTypeId == 'CustomComponent'){   
 	        			$("#customTypeId").val(data.customTypeId);
 	        		}
 	        		//数字框才显示计算公式按钮
 	        		$("#formula_div").hide();
 	        		if(componentTypeId == 'numberSpinner'){
 	        			$("#formula_div").show();
 	        		}
 	        		var id = data.id;   //控件编码
 					var name = data.name;   //控件名称
 					var componentTypeName = data.componentTypeName; //控件类型名称
 					var defaultValue = data.defaultValue;  //默认值
 					var defaultValueStr = data.defaultValueStr;  //复选框默认值
 					var src = data.src;  //图片地址(图片)
 					var imageType = data.imageType;  //显示方式(图片)
 					var value = data.value; //显示内容 -- 显示值
 					var contents = data.contents;  //HTML片段显示内容
 					var labelValue = data.labelValue;  //显示标签
 					var title = data.title;    //标题(标签页)
 					var href = data.href; //链接地址（链接）
 					var required = data.required; //是否必填
 					var hint = data.hint;   //提示语(文本框)
 					var textPattern = data.textPattern; //文本格式(数字框)
 					var formatPattern = data.formatPattern; //数字格式(数字框)
 					var isCurrency = data.isCurrency; //是否为货币组件(数字框)
 					var datePattern = data.datePattern; //日期样式(日期框)
 					var mask = data.mask;//输入格式(文本框)
 					var style = data.style;  //样式
 					var styleClass = data.styleClass;  //样式类(标签    表格  单元格)
 					var columns = data.columns;  //列数(单选框组,复选框组)
 					var propertyE = data.propertyE;  //自定义属性E(自定义组件)
 					var propertyB = data.propertyB;  //自定义属性B(日期格式下拉选择  流程意见 )
 					var propertyD = data.propertyD;  //自定义属性D(是否显示部门  流程意见)
 					var propertyC = data.propertyC;  //自定义属性C(上传文件类型  文件上传)
 					var maxFileCount = data.maxFileCount;  //多文件上传最大文件个数
 					var preDeduction = data.preDeduction;   //是否预扣除
 					var dependencyPro = data.dependencyPro;   //关联属性
 					var showMinimizeButton = data.showMinimizeButton;   //展开合上
 					var showCloseButton = data.showCloseButton;   //关闭按钮
 					
 					//清空关联属性下拉框选项
 					$("#dependencyPro").find("option").remove();
 					//填充关联属性下拉框选项
 					var optionStr = data.optionStr;
 					if(optionStr){
 						for(var key in optionStr){
 							var obj = optionStr[key];
 							var dependencyProId = obj.id;
 							var dependencyProname = obj.name;
 							$("#dependencyPro").append("<option value='"+dependencyProId+"'>"+dependencyProname+"</option>"); 
 						}
 					}
 					
 					controlDisplay(id,"id",componentTypeId);
 					controlDisplay(name,"name",componentTypeId);
 					controlDisplay(componentTypeName,"componentTypeName",componentTypeId);
 					controlDisplay(defaultValue,"defaultValue",componentTypeId);
 					controlDisplay(defaultValueStr,"defaultValueStr",componentTypeId);
 					controlDisplay(src,"src",componentTypeId);
 					controlDisplay(imageType,"imageType",componentTypeId);
 					controlDisplay(value,"value",componentTypeId);
 					controlDisplay(contents,"contents",componentTypeId);
 					controlDisplay(labelValue,"labelValue",componentTypeId);
 					controlDisplay(title,"title",componentTypeId);
 					controlDisplay(href,"href",componentTypeId);
 					controlDisplay(required,"required",componentTypeId);
 					controlDisplay(hint,"hint",componentTypeId);
 					controlDisplay(textPattern,"textPattern",componentTypeId);
 					controlDisplay(formatPattern,"formatPattern",componentTypeId);
 					controlDisplay(isCurrency,"isCurrency",componentTypeId);
 					controlDisplay(datePattern,"datePattern",componentTypeId);
 					controlDisplay(mask,"mask",componentTypeId);
 					controlDisplay(style,"style",componentTypeId);
 					controlDisplay(styleClass,"styleClass",componentTypeId);
 					controlDisplay(columns,"columns",componentTypeId);
 					controlDisplay(propertyE,"propertyE",componentTypeId);	
 					controlDisplay(propertyB,"propertyB",componentTypeId);
 					controlDisplay(propertyD,"propertyD",componentTypeId);	
 					controlDisplay(propertyC,"propertyC",componentTypeId);	
 					controlDisplay(maxFileCount,"maxFileCount",componentTypeId);					
 					controlDisplay(preDeduction,"preDeduction",componentTypeId);	
 					controlDisplay(dependencyPro,"dependencyPro",componentTypeId);	
 					controlDisplay(showMinimizeButton,"showMinimizeButton",componentTypeId);	
 					controlDisplay(showCloseButton,"showCloseButton",componentTypeId);	
 					
 					var customTypeId = $("#customTypeId").val();
 					if("multiFile" == customTypeId){   //多文件上传
 						if(propertyE == 'true'){
 							$("#propertyC_div").hide();
 							$("#propertyC_div").prev().hide();
 							$("#maxFileCount_div").hide();
 							$("#maxFileCount_div").prev().hide();		
 						} 						
 					}
 	        	}
             } 
        });
	}
	
	//不同控件返回不同的json数据显示不同的属性并赋值
	function controlDisplay(value,elementId,componentTypeId){
		if(typeof(value) != "undefined"){
			if(elementId == 'name' && componentTypeId == 'label'){   //标签不用显示名称
				$("#"+elementId+"_div").prev().hide();
				$("#"+elementId+"_div").hide();
				return;
			}
			if(elementId != 'propertyE' && elementId != 'propertyD'){   //扩展属性E和D
				$("#"+elementId+"_div").prev().show();
			}
			$("#"+elementId+"_div").show();
			
			if(elementId == 'name'){  //名称
				$("#name").attr("readonly",false);
				if(componentTypeId == 'EditList' || componentTypeId == 'DataList'){  //重复表    重复节 
	        		$("#name").attr("readonly",true);
	        	}
			}else if(elementId == 'required'){   //是否必填(已废弃 权限配置即可)
				$("#required option[value='"+value+"']").attr("selected", true);
			}else if(elementId == 'defaultValue'){   //默认值 （可编辑的下拉框）
				debugger;
				if(componentTypeId == 'CustomComponent'){   //自定义组件
					var customTypeId = $("#customTypeId").val();
					//自定义组件只有选人选部门才有默认值
					if(customTypeId == 'userSelect' || customTypeId == 'usersSelect'){   //单选多选用户
						$("#defaultValue").siblings("ul").children().eq(0).show();
						$("#defaultValue").siblings("ul").children().eq(1).hide();
						$("#defaultValue").siblings("ul").children().eq(2).hide();
						$("#defaultValue").siblings("ul").children().eq(3).hide();
						$("#defaultValue").siblings("ul").children().eq(4).hide();
						$("#defaultValue").siblings("ul").children().eq(5).hide();
						$("#defaultValue").siblings("ul").children().eq(6).hide();
						$("#defaultValue").siblings("ul").children().eq(7).hide();
						
					}else if(customTypeId == 'depSelect' || customTypeId == 'depsSelect'){   //单选多选部门
						$("#defaultValue").siblings("ul").children().eq(0).hide();
						$("#defaultValue").siblings("ul").children().eq(1).show();
						$("#defaultValue").siblings("ul").children().eq(2).show();
						$("#defaultValue").siblings("ul").children().eq(3).show();
						$("#defaultValue").siblings("ul").children().eq(4).show();
						$("#defaultValue").siblings("ul").children().eq(5).hide();
						$("#defaultValue").siblings("ul").children().eq(6).hide();
						$("#defaultValue").siblings("ul").children().eq(7).hide();
					}else{
						$("#defaultValue").siblings("ul").children().eq(0).hide();
						$("#defaultValue").siblings("ul").children().eq(1).hide();
						$("#defaultValue").siblings("ul").children().eq(2).hide();
						$("#defaultValue").siblings("ul").children().eq(3).hide();
						$("#defaultValue").siblings("ul").children().eq(4).hide();
						$("#defaultValue").siblings("ul").children().eq(5).hide();
						$("#defaultValue").siblings("ul").children().eq(6).hide();
						$("#defaultValue").siblings("ul").children().eq(7).hide();
					}
				}else if(componentTypeId == 'inputDate'){  //日期框
					$("#defaultValue").siblings("ul").children().eq(0).hide();
					$("#defaultValue").siblings("ul").children().eq(1).hide();
					$("#defaultValue").siblings("ul").children().eq(2).hide();
					$("#defaultValue").siblings("ul").children().eq(3).hide();
					$("#defaultValue").siblings("ul").children().eq(4).hide();
					$("#defaultValue").siblings("ul").children().eq(5).show();
					$("#defaultValue").siblings("ul").children().eq(6).hide();
					$("#defaultValue").siblings("ul").children().eq(7).show();
				}else if(componentTypeId == 'inputTime'){   //时间框
					$("#defaultValue").siblings("ul").children().eq(0).hide();
					$("#defaultValue").siblings("ul").children().eq(1).hide();
					$("#defaultValue").siblings("ul").children().eq(2).hide();
					$("#defaultValue").siblings("ul").children().eq(3).hide();
					$("#defaultValue").siblings("ul").children().eq(4).hide();
					$("#defaultValue").siblings("ul").children().eq(5).hide();
					$("#defaultValue").siblings("ul").children().eq(6).show();
					$("#defaultValue").siblings("ul").children().eq(7).hide();
				}else{
					$("#defaultValue").siblings("ul").children().eq(0).hide();
					$("#defaultValue").siblings("ul").children().eq(1).hide();
					$("#defaultValue").siblings("ul").children().eq(2).hide();
					$("#defaultValue").siblings("ul").children().eq(3).hide();
					$("#defaultValue").siblings("ul").children().eq(4).hide();
					$("#defaultValue").siblings("ul").children().eq(5).hide();
					$("#defaultValue").siblings("ul").children().eq(6).hide();
					$("#defaultValue").siblings("ul").children().eq(7).hide();
				}
				
				//初始默认值
				$('#recordDefault').val(value);
				$("li.es-visible").each(function(){
					if(value == $(this).attr('value')){  //存在该下拉框选项
						value = $(this).text();
						return false;
					}
				});
			}else if(elementId == 'imageType'){   //显示方式
				$("#imageType option[value='"+value+"']").attr("selected", true);
			}else if(elementId == 'formatPattern'){  //显示格式
				$("#formatPattern option[value='"+value+"']").attr("selected", true);
			}else if(elementId == 'datePattern'){   //日期样式
				$("#datePattern option[value='"+value+"']").attr("selected", true);
			}else if(elementId == 'value'){   //显示内容(label) -- 显示值
				if(componentTypeId == 'label'){
					$("#"+elementId+"_div").prev().children("span:first-child").text = '显示值';
				}else{
					$("#"+elementId+"_div").prev().children("span:first-child").text = '显示内容';
				}  
			}else if(elementId == 'isCurrency'){  //是否为货币组件
				//基本初始化
		        $('#isCurrency_div input').bootstrapSwitch({
		        	onText : "是",      // 设置ON文本  
		        	offText : "否",    // 设置OFF文本  
		        	onColor : "primary",// 设置ON文本颜色     (info/success/warning/danger/primary)  
		        	offColor : "default",  // 设置OFF文本颜色        (info/success/warning/danger/primary) 
		        	inverse : true,    //颠倒开关顺序 
		        	handleWidth : "30", //设置控件宽度
		        	// 当开关状态改变时触发  
		        	onSwitchChange : function(event, state) {  
		        		var element = {};
		        		element.name = "isCurrency";
		                if(state == true){				
						    element.value = "true";
		                }else{
		                    element.value = "false";
		                }  
						updatePropertiesByType(element);
		            }  
		        });
		        $('#isCurrency_div input').bootstrapSwitch('size',"mini");   //从小到大  (mini/small/normal/large)  
		        if(value == 'true'){			
					$('#isCurrency_div input').bootstrapSwitch('state',true);  //选中
				}else{
					$('#isCurrency_div input').bootstrapSwitch('state',false);  //不选中
				}
			}else if(elementId == 'styleClass'){   //样式类
				//先隐藏再根据组件类型控件显示
				$("#styleClass option[value='label']").hide();   //普通标签
				$("#styleClass option[value='tableTitle']").hide();  //表头标签
				$("#styleClass option[value='seqNumStyle']").hide();  //编码标签
				$("#styleClass option[value='tableLayout']").hide();   //表格默认样式
				$("#styleClass option[value='tdLabelCls']").hide();   //单元格默认样式
				$("#styleClass option[value='tdLayout']").hide();  //单元格标签样式
				$("#styleClass option[value='tdValueCls']").hide();  //单元格值样式
				//只显示与组件相关的下拉框选项	 
				if(componentTypeId == 'label'){
					$("#styleClass option[value='label']").show();   //普通标签
					$("#styleClass option[value='tableTitle']").show();  //表头标签
					$("#styleClass option[value='seqNumStyle']").show();  //编码标签
					$("#styleClass option[value='"+value+"']").attr("selected", true);
				}else if(componentTypeId == 'table'){
					$("#styleClass option[value='tableLayout']").show();   //表格默认样式
					$("#styleClass option[value='"+value+"']").attr("selected", true);
					
				}else if(componentTypeId == 'td'){
					$("#styleClass option[value='tdLabelCls']").show();   //单元格默认样式
					$("#styleClass option[value='tdLayout']").show();  //单元格标签样式
					$("#styleClass option[value='tdValueCls']").show();  //单元格值样式
					$("#styleClass option[value='"+value+"']").attr("selected", true);
					
				}
			}else if(elementId == 'preDeduction'){   //预扣除
				$("#preDeduction option[value='"+value+"']").attr("selected", true);
				if(value == 'true'){    //选中时显示关联属性下拉框
					$("#dependencyPro").show();
				}
				
			}else if(elementId == 'dependencyPro'){   //关联属性
				$("#dependencyPro option[value='"+value+"']").attr("selected", true);
			
			}else if(elementId == 'propertyE'){   //扩展属性E
				var customTypeId = $("#customTypeId").val();
				if("multiFile" == customTypeId){   //多文件上传
					document.getElementById("propertyE_Label").innerText = '支持图片上传预览：';
				}else if("flowComment" == customTypeId){   //流程意见
					document.getElementById("propertyE_Label").innerText = '显示多人意见：';
				}
				//基本初始化
		        $('#propertyE_div input').bootstrapSwitch({
		        	onText : "是",      // 设置ON文本  
		        	offText : "否",    // 设置OFF文本  
		        	onColor : "primary",// 设置ON文本颜色     (info/success/warning/danger/primary)  
		        	offColor : "default",  // 设置OFF文本颜色        (info/success/warning/danger/primary) 
		        	inverse : true,    //颠倒开关顺序 
		        	handleWidth : "30", //设置控件宽度
		        	// 当开关状态改变时触发  
		        	onSwitchChange : function(event, state) {  
		        		var element = {};
		        		element.name = "propertyE";
		                if(state == true){				
						    element.value = "true";
						    $("#propertyC_div").hide();
							$("#propertyC_div").prev().hide();
							$("#maxFileCount_div").hide();
							$("#maxFileCount_div").prev().hide();		
		                }else{			
		                    element.value = "";
							$("#propertyC_div").show();
							$("#propertyC_div").prev().show();
							$("#maxFileCount_div").show();
							$("#maxFileCount_div").prev().show();	
		                }  
						updatePropertiesByType(element);
		            }  
		        });
				$('#propertyE_div input').bootstrapSwitch('size',"mini");   //从小到大  (mini/small/normal/large)  
				if(value == 'true'){		
					$('#propertyE_div input').bootstrapSwitch('state',true);  //选中												
				}else{
					$('#propertyE_div input').bootstrapSwitch('state',false);  //不选中					
				}
			}else if(elementId == 'propertyB'){   //日期格式(流程意见)
				$("#propertyB option[value='"+value+"']").attr("selected", true);
			}else if(elementId == 'propertyD'){   //是否显示部门(流程意见)
				//基本初始化
		        $('#propertyD_div input').bootstrapSwitch({
		        	onText : "是",      // 设置ON文本  
		        	offText : "否",    // 设置OFF文本  
		        	onColor : "primary",// 设置ON文本颜色     (info/success/warning/danger/primary)  
		        	offColor : "default",  // 设置OFF文本颜色        (info/success/warning/danger/primary) 
		        	inverse : true,    //颠倒开关顺序 
		        	handleWidth : "30", //设置控件宽度
		        	// 当开关状态改变时触发  
		        	onSwitchChange : function(event, state) {  
		        		var element = {};
		        		element.name = "propertyD";
		                if(state == true){				
						    element.value = "true";
		                }else{
		                    element.value = "false";
		                }  
						updatePropertiesByType(element);
		            }  
		        });
				$('#propertyD_div input').bootstrapSwitch('size',"mini");   //从小到大  (mini/small/normal/large)  
				if(value == 'true' || value == ''){			
					$('#propertyD_div input').bootstrapSwitch('state',true);  //选中
				}else{
					$('#propertyD_div input').bootstrapSwitch('state',false);  //不选中
				}
			}else if(elementId == 'showMinimizeButton'){   //展开合上
				//基本初始化
		        $('#showMinimizeButton_div input').bootstrapSwitch({
		        	onText : "是",      // 设置ON文本  
		        	offText : "否",    // 设置OFF文本  
		        	onColor : "primary",// 设置ON文本颜色     (info/success/warning/danger/primary)  
		        	offColor : "default",  // 设置OFF文本颜色        (info/success/warning/danger/primary) 
		        	inverse : true,    //颠倒开关顺序 
		        	handleWidth : "30", //设置控件宽度
		        	// 当开关状态改变时触发  
		        	onSwitchChange : function(event, state) {  
		        		var element = {};
		        		element.name = "showMinimizeButton";
		                if(state == true){				
						    element.value = "true";
		                }else{
		                    element.value = "false";
		                }  
						updatePropertiesByType(element);
		            }  
		        });
				$('#showMinimizeButton_div input').bootstrapSwitch('size',"mini");   //从小到大  (mini/small/normal/large)  
				if(value == 'true'){			
					$('#showMinimizeButton_div input').bootstrapSwitch('state',true);  //选中
				}else{
					$('#showMinimizeButton_div input').bootstrapSwitch('state',false);  //不选中
				}
			}else if(elementId == 'showCloseButton'){   //关闭按钮
				//基本初始化
		        $('#showCloseButton_div input').bootstrapSwitch({
		        	onText : "是",      // 设置ON文本  
		        	offText : "否",    // 设置OFF文本  
		        	onColor : "primary",// 设置ON文本颜色     (info/success/warning/danger/primary)  
		        	offColor : "default",  // 设置OFF文本颜色        (info/success/warning/danger/primary) 
		        	inverse : true,    //颠倒开关顺序 
		        	handleWidth : "30", //设置控件宽度
		        	// 当开关状态改变时触发  
		        	onSwitchChange : function(event, state) {  
		        		var element = {};
		        		element.name = "showCloseButton";
		                if(state == true){				
						    element.value = "true";
		                }else{
		                    element.value = "false";
		                }  
						updatePropertiesByType(element);
		            }  
		        });
				$('#showCloseButton_div input').bootstrapSwitch('size',"mini");   //从小到大  (mini/small/normal/large)  
				if(value == 'true'){			
					$('#showCloseButton_div input').bootstrapSwitch('state',true);  //选中
				}else{
					$('#showCloseButton_div input').bootstrapSwitch('state',false);  //不选中
				}
			}
			$("#"+elementId).val(value);
			
		}else{
			if(elementId != 'propertyE' && elementId != 'propertyD'){   //扩展属性E
				$("#"+elementId+"_div").prev().hide();
			}	
			$("#"+elementId+"_div").hide();
		}
	}
	
	
	//保存控件和表单属性
	function updatePropertiesByType(element){
		debugger;
		var type = $('.select')[0].id;    //类型  控件还是表单
		var id = $("#componentId").val();  //记录的组件编码
		var componentTypeId =  $("#componentTypeId").val();    //要保存的组件类型编码
		var customTypeId = $("#customTypeId").val();     //自定义组件类别编码
		var attrName = element.name;    //要保存的组件名称
		var attrValue = element.value;  //要保存的组件值
		
		if(attrName == 'name'){  //保存名称时校验
			if(!validation(attrValue)){
				return;
			}
			if(id.endWith('_list')){
		    	id = id.substring(0, id.indexOf("_list"));
		    }
		}else if(attrName == 'defaultValue'){  //默认值（可编辑下拉框）
			attrValue = $("#recordDefault").val();   //取记录的默认值
			if(componentTypeId == 'CustomComponent' && customTypeId.endsWith('Select')){   //单选多选用户和部门才有默认值
				attrName = "propertyB";
			}else if(componentTypeId == 'checkBox'){   //复选框
				attrName = "defaultValueStr";
			}
		}else if(attrName == 'hint'){  //提示语（可编辑下拉框）
			if(componentTypeId == 'CustomComponent' && customTypeId.endsWith('Select')){   //单选多选用户和部门有提示1
				attrName = "propertyE";
			}
		}else if(attrName == 'maxFileCount'){  //上传最大文件个数(多文件上传)
			if(componentTypeId == 'CustomComponent' && customTypeId.endsWith('multiFile')){   //多文件上传 才有上传最大文件个数
				attrName = "propertyB";
			}
		}
		
		var param = "type="+type+"";
		param += "&id="+id+"";
		
		var data = {};
		data["componentTypeId"] = componentTypeId;  
        data["attrName"] = attrName;  
        data["attrValue"] = attrValue;  
        
		$.ajax({
			 url: '<%=request.getContextPath() %>/designer/designProperties_updatePropertiesByType.action?'+param,   
	         type: "post", 
	         dataType: "json", 
	         data: data, 
	         success: function(data){ 
	        	//var attrName = data.attrName;
	        	//var value = data.value;	
	        	debugger;
	        	if(!id.endWith('EditList')){  //非重复表    重复节 RAllListVar
	        		parent.isc.MFH.redrawComponent(id);
	        	}
	        	var formVarId = data.formVarId;  //表单变量编码
	        	var formId = data.formId;  //表单编码
	        	if(formVarId){   
	        		//刷新数据源
	        		parent.Matrix.forceFreshTreeNode("Tree0", formVarId);	
	        	}
             } 
       });
	}
	
	//点击空白页面加载控件标签页  先无控件选中
	function clickBlank(){
		$(".select").removeClass("select");
		$("#emptyMessage").show();
		$("#controlProperties").hide();
		
		$('.control-pane').css('display','block'); 
		$('.form-pane').css('display','none'); 
		$("#control").addClass("select");
		$("#form").removeClass("select");
	}
	
	//打开选择样式窗口
	function openStyle(){
		//当前点击的控件类型编码
 		var componentTypeId = $("#componentTypeId").val();
		if(componentTypeId == 'td'){   //单元格类型
			parent.layer.open({
		    	id:'m_style',
				type : 2,
				
				title : ['样式设置'],
				shade: [0.1, '#000'],
				shadeClose: false, //开启遮罩关闭
				area : [ '45%', '70%' ],
				content : "<%=request.getContextPath() %>/form/admin/designer/style/td/h5tdstyle.jsp?iframewindowid=m_style&operation=td"
			});			
		}else{
			parent.layer.open({
		    	id:'m_style',
				type : 2,
				
				title : ['样式设置'],
				shade: [0.1, '#000'],
				shadeClose: false, //开启遮罩关闭
				area : [ '45%', '55%' ],
				content : "<%=request.getContextPath() %>/form/admin/designer/style/td/h5tdstyle.jsp?iframewindowid=m_style&operation=other"
			});			
		}
	}
	
	//打开更多属性窗口
	function openMoreAttribute(){
		debugger;
		var selectItem = parent.isc.MH.selectedItems[0]
		parent.isc.MFH.editComProp(selectItem);
	}
	
	//打开表单联合校验条件窗口
	function openJointValidation(){
		var jointValidation = $("#jointValidation").val();
		parent.layer.open({
	    	id:'m_validation',
			type : 2,
			
			title : ['设置条件'],
			shade: [0.1, '#000'],
			shadeClose: false, //开启遮罩关闭
			area : [ '65%', '80%' ],
			content : "<%=request.getContextPath() %>/condition/condition_loadConditionSet.action?iframewindowid=m_validation&entrance=FormJointValidation&firstCondition="+encodeURI(jointValidation)+""
		});			
	}
	
	//打开表单联合校验条件窗口
	function openJointValidation2(){
		var jointValidation = $("#jointValidation").val();
		parent.layer.open({
	    	id:'m_validation2',
			type : 2,
			
			title : ['联合校验'],
			shade: [0.1, '#000'],
			shadeClose: false, //开启遮罩关闭
			area : [ '65%', '80%' ],
			content : "<%=request.getContextPath() %>/valid/valid_getValidationList.action?iframewindowid=m_validation2"
		});			
	}
	
	//打开数据唯一选择窗口
	function openDataUnique(){
		var dataUnique = $("#dataUnique").val();
		parent.layer.open({
	    	id:'m_dataUnique',
			type : 2,
			
			title : ['数据唯一'],
			shade: [0.1, '#000'],
			shadeClose: false, //开启遮罩关闭
			area : [ '45%', '75%' ],
			content : "<%=request.getContextPath() %>/form/admin/custom/unionpk/h5Unionpk.jsp?iframewindowid=m_dataUnique&unionPKText="+encodeURI(dataUnique)
		});			
	}
	
	//打开数据计算列表窗口
	function openDataFormula(){
		parent.layer.open({
	    	id:'m_dataFormula',
			type : 2,
			
			title : ['计算公式'],
			shade: [0.1, '#000'],
			shadeClose: false, //开启遮罩关闭
			area : [ '65%', '80%' ],
			content : "<%=request.getContextPath() %>/form/admin/custom/formula/h5FormulaList.jsp?iframewindowid=m_dataFormula"
		});			
	}
	
	//打开数据权限窗口
	function openDataPower(){
		parent.layer.open({
	    	id:'m_dataPower',
			type : 2,
			
			title : ['数据权限'],
			shade: [0.1, '#000'],
			shadeClose: false, //开启遮罩关闭
			area : [ '65%', '80%' ],
			content : "<%=request.getContextPath() %>/security/formSecurity_loadSecurityIndex.action?iframewindowid=m_dataPower"
		});			
		/*
		var url = "<%=request.getContextPath()%>/security/formSecScope_initFormAuthItems.action";
   		Matrix.sendRequest(url,null,function(data){
			if(data != null && data.data != null){
				var json = isc.JSON.decode(data.data);
				if(json.result){
					parent.layer.open({
				    	id:'m_dataPower',
						type : 2,
						
						title : ['数据权限'],
						shade: [0.1, '#000'],
						shadeClose: false, //开启遮罩关闭
						area : [ '65%', '80%' ],
						content : "<%=request.getContextPath() %>/security/formSecurity_loadSecurityIndex.action?iframewindowid=m_dataPower"
					});			
				}else{
					Matrix.warn("打开数据权限窗口失败！");
				}
			}
		});
   		*/
	}
	
	//打开数据带入窗口
	function openDataEntry(){
		parent.layer.open({
	    	id:'m_dataEntry',
			type : 2,
			
			title : ['数据带入'],
			shade: [0.1, '#000'],
			shadeClose: false, //开启遮罩关闭
			area : [ '65%', '80%' ],
			content : "<%=request.getContextPath() %>/form/admin/custom/dataInMapping/h5DataInMappingList.jsp?iframewindowid=m_dataEntry"
		});			
	}
	
	//打开触发事件窗口
	function openTriggerAction(){
		parent.layer.open({
	    	id:'m_triggerAction',
			type : 2,
			
			title : ['触发事件'],
			shade: [0.1, '#000'],
			shadeClose: false, //开启遮罩关闭
			area : [ '70%', '80%' ],
			content : "<%=request.getContextPath() %>/form/admin/custom/trigger/h5TriggerList.jsp?iframewindowid=m_triggerAction"
		});			
	}
	
	//打开控件数据校验窗口
	function openDataValidator(){
		var componentId = $('#componentId').val();
		parent.layer.open({
	    	id:'m_dataValidator',
			type : 2,
			
			title : ['数据校验'],
			shade: [0.1, '#000'],
			shadeClose: false, //开启遮罩关闭
			area : [ '65%', '80%' ],
			content : "<%=request.getContextPath() %>/form/admin/designer/h5DataValidatorList.jsp?iframewindowid=m_dataValidator&componentId="+componentId
		});		
	}
	
	//校验
	function validation(value){
		var pattern = new RegExp("[`~!@#$^&*=|{}':'\\[\\]<>/~！@#￥……&*（）——|{}【】‘：”“？]");
		if(pattern.test(value)){
			Matrix.warn("名称不能输入非法字符！");
			return false;
		}else if(value.length>100){
			Matrix.warn("名称长度不能大于100！");
			return false;
		}else{
			return true;
		}
	}
</script>
</head>
<body>
	<!-- 当前显示组件编码 -->
	<input type="hidden" id="componentId" name="componentId"/>
	<!-- 当前显示组件类型编码 -->
	<input type="hidden" id="componentTypeId" name="componentTypeId"/>
	<!-- 自定义组件类别编码 -->
	<input type="hidden" id="customTypeId" name="customTypeId"/>
	<!-- 存放默认值  即可下拉选择 也可手动输入-->
	<input type="hidden" id="recordDefault" name="recordDefault"/>
	
  	<div class="container">
		<div class="select-menu">
			<div class="select-btn select" id="form">表单属性</div>
			<div class="select-btn" id="control">控件属性</div>
		</div>
		<!-- 表单属性信息 -->
		<div class="form-pane">
			<div>
				<label>编码：</label>
			</div>
			<div id="formCode_div">
				<input id="formCode" name="formCode" type="text" value="" class="form-control" style="height:100%;width:100%;" readonly="readonly"/>
			</div>
			<div>
				<label>名称：</label>
			</div>
			<div id="formName_div">
				<input id="formName" name="formName" type="text" value="" class="form-control" style="height:100%;width:100%;" readonly="readonly"/>
			</div>
			<!--  
			<div id="jointValidation_div" style="margin-top: 10px;">
				<textarea class="form-control" rows="3" id="jointValidation" name="jointValidation" style="resize: none;" readonly="readonly"></textarea>
			</div>
			<div class="x-btn" style="font-size: 14px;color: #333;border-color: #ccc;border-top: 0px;margin-bottom: 10px;" onclick="openJointValidation();">
			     <span>联合校验</span>
			</div>  
			<div>
				<label>校验失败提示：</label>
			</div>
			<div id="failureTips_div">
				<textarea class="form-control" rows="3" id="failureTips" name="failureTips" style="resize: none;margin-bottom: 10px;" oninput="updatePropertiesByType(this);"></textarea>
			</div>
			-->
			<div>
				<label>数据唯一：</label>
			</div>
			<div id="dataUnique_div">
				<textarea class="form-control" rows="3" id="dataUnique" name="dataUnique" style="resize: none;" readonly="readonly"></textarea>
			</div>
			<div class="x-btn" style="font-size: 14px;color: #333;border-color: #ccc;border-top:0px;margin-bottom: 10px;" onclick="openDataUnique();">
			     <span>设置唯一</span>
			</div> 
			<div class="x-btn" style="font-size: 14px;color: #333;border-color: #ccc;" onclick="openJointValidation2();">
			     <span>联合校验</span>
			</div> 
			<div class="x-btn" style="font-size: 14px;color: #333;border-color: #ccc;margin-top: 10px;" onclick="openDataFormula();">
			     <span>数据计算</span>
			</div> 
		    <div class="x-btn" style="font-size: 14px;color: #333;border-color: #ccc;margin-top: 10px;display: none;" onclick="openDataPower();" id="dataPower">
			     <span>数据权限</span>
			</div> 
		    <div class="x-btn" style="font-size: 14px;color: #333;border-color: #ccc;margin-top: 10px;" onclick="openDataEntry();">
			     <span>数据带入</span>
			</div> 
		    <div class="x-btn" style="font-size: 14px;color: #333;border-color: #ccc;margin-top: 10px;" onclick="openTriggerAction();">
			     <span>触发事件</span>
			</div> 
		</div>

		<!-- 控件属性信息 -->
		<div class="control-pane" style="display: none;">
			<div id="emptyMessage" class="empty-message">请选择控件</div>
			<div id="controlProperties" style="height: 100%;">
				<div>
					<label>编码：</label>
				</div>
				<div id="id_div">
					<input id="id" name="id" type="text" value="" class="form-control" style="height:100%;width:100%;" readonly="readonly"/>
				</div>
				<div>
					<label>名称：</label>
				</div>
				<div id="name_div">
					<input id="name" name="name" type="text" value="" class="form-control" style="height:100%;width:100%;" autocomplete="off" oninput="updatePropertiesByType(this);"/>
				</div>
				<div>
					<label>类型：</label>
				</div>
				<div id="componentTypeName_div">
					<input id="componentTypeName" name="componentTypeName" type="text" value="" class="form-control" style="height:100%;width:100%;" readonly="readonly"/>
				</div>
				<div>
					<label>默认值：</label>
				</div>
				<div id="defaultValue_div">
					<select id="defaultValue" name="defaultValue" value="" class="form-control" style="height:100%;width:100%;">
	                     <option value="#{FormValue.userName}">当前用户名称</option>
	                     <option value="#{FormValue.depName}">当前用户部门名称</option>
	                     <option value="#{FormValue.parentDepName}">当前用户上级部门名称</option>
	                     <option value="#{FormValue.topDepName}">当前用户一级部门名称</option>
	                     <option value="#{FormValue.orgName}">当前用户机构名称</option>
	                     <option value="#{FormValue.date}">当前日期</option>
	                     <option value="#{FormValue.time}">当前时间</option>
	                     <option value="#{FormValue.dateTime}">当前日期时间</option>	              
	                </select>
				</div>
				<div>
					<label>默认值：</label>
				</div>
				<div id="defaultValueStr_div">
					<select id="defaultValueStr" name="defaultValueStr" value="" class="form-control" style="height:100%;width:100%;" onchange="updatePropertiesByType(this);">
	                     <option value=""></option>
	                     <option value="true">是</option>     
	                     <option value="false">否</option>       
	                </select>
				</div>
				<div>
					<label>必填：</label>
				</div>
				<div id="required_div">				
					<select id="required" name="required" value="" class="form-control" style="height:100%;width:100%;" onchange="updatePropertiesByType(this);">
	                     <option value="true">是</option>
	                     <option value="false">否</option>
	                </select>	
				</div>
				<div>
					<label>图片地址：</label>
				</div>
				<div id="src_div">
					<input id="src" name="src" type="text" value="" class="form-control" style="height:100%;width:100%;" autocomplete="off" oninput="updatePropertiesByType(this);"/>
				</div>
				<div>
					<label>显示方式：</label>
				</div>
				<div id="imageType_div">				
					<select id="imageType" name="imageType" value="" class="form-control" style="height:100%;width:100%;" onchange="updatePropertiesByType(this);">
	                     <option value="nomal">正常</option>
	                     <option value="center">中心显示</option>
	                     <option value="stretch">拉伸平铺</option>
	                     <option value="tile">重复显示</option>
	                </select>	
				</div>
				<div>
					<label>显示内容：</label>
					<!-- <label>显示值：</label> -->
				</div>
				<div id="value_div">
					<input id="value" name="value" type="text" value="" class="form-control" style="height:100%;width:100%;" autocomplete="off" oninput="updatePropertiesByType(this);"/>
				</div>
				<div>
					<label>显示内容：</label>
				</div>
				<div id="contents_div">
					<textarea id="contents" name="contents" class="form-control" rows="3"  style="resize: none;" autocomplete="off" oninput="updatePropertiesByType(this);"></textarea>
				</div>
				<div>
					<label>显示标签：</label>
				</div>
				<div id="labelValue_div">
					<input id="labelValue" name="labelValue" type="text" value="" class="form-control" style="height:100%;width:100%;" autocomplete="off" oninput="updatePropertiesByType(this);"/>
				</div>
				<div>
					<label>标题：</label>
				</div>
				<div id="title_div">
					<input id="title" name="title" type="text" value="" class="form-control" style="height:100%;width:100%;" autocomplete="off" oninput="updatePropertiesByType(this);"/>
				</div>				
				<div>
					<label>文本格式：</label>
				</div>
				<div id="textPattern_div">				
					<select id="textPattern" name="textPattern" value="" class="form-control" style="height:100%;width:100%;" onchange="updatePropertiesByType(this);">
	                     <option value=""></option>
	                     <option value="#.##%">百分号</option>
	                     <option value="#,##0.00">千分位</option>
	                     <option value="DHM">*天*时*分</option>
	                     <option value="DAY">*天</option>
	                </select>	
				</div>
				<div>
					<label>数字格式：</label>
				</div>
				<div id="formatPattern_div">
					<input id="formatPattern" name="formatPattern" type="text" value="" class="form-control" style="height:100%;width:100%;" autocomplete="off" oninput="updatePropertiesByType(this);"/>
				</div>
				<div>
					<label>显示格式：</label>
				</div>
				<div id="datePattern_div">				
					<select id="datePattern" name="datePattern" value="" class="form-control" style="height:100%;width:100%;" onchange="updatePropertiesByType(this);">
	                     <option value=""></option>
	                     <option value="yyyy-MM-dd">yyyy-MM-dd</option>
	                     <option value="yyyy年MM月dd日">yyyy年MM月dd日</option>
	                     <option value="yyyy-MM-dd HH:mm">yyyy-MM-dd HH:mm</option>
	                     <option value="yyyy年MM月dd日 HH:mm">yyyy年MM月dd日 HH:mm</option>
	                </select>	
				</div>
				<div>
					<label>输入格式：</label>
				</div>
				<div id="mask_div">				
					<input id="mask" name="mask" type="text" value="" class="form-control" style="height:100%;width:100%;" autocomplete="off" oninput="updatePropertiesByType(this);"/>
				</div>
				<div id="isCurrency_div" style="padding-top: 10px;">
					<label id="isCurrency_Label">是否为货币组件：</label>
					<input id="isCurrency" name="isCurrency" type="checkbox">
				</div>
				<div>
					<label>提示语：</label>
				</div>
				<div id="hint_div">
					<input id="hint" name="hint" type="text" value="" class="form-control" style="height:100%;width:100%;" autocomplete="off" oninput="updatePropertiesByType(this);"/>
				</div>
				<div>
					<label>链接地址：</label>
				</div>
				<div id="href_div">
					<input id="href" name="href" type="text" value="" class="form-control" style="height:100%;width:100%;" autocomplete="off" oninput="updatePropertiesByType(this);"/>
				</div>
				<div>
					<label>样式：</label>
				</div>
				<div id="style_div" class="input-group">
					<input id="style" name="style" type="text" value="" class="form-control" style="height:100%;width:100%;" autocomplete="off" oninput="updatePropertiesByType(this);"/>
					<span class="input-group-addon addon-udSelect udSelect" onclick="openStyle()"><i class="fa fa-search"></i></span>
				</div>
				<div>
					<label>样式类：</label>
				</div>
				<div id="styleClass_div">
					<select id="styleClass" name="styleClass" value="" class="form-control" style="height:100%;width:100%;" onchange="updatePropertiesByType(this);">
						<option value=""></option>
	                     <option value="label">普通标签</option>
	                     <option value="tableTitle">表头标签</option>
	                     <option value="seqNumStyle">编码标签</option>
	                     <option value="tableLayout">表格默认样式</option>
	                     <option value="tdLayout">单元格默认样式</option>
	                     <option value="tdLabelCls">单元格标签样式</option>		                      
	                     <option value="tdValueCls">单元格值样式</option>
	                </select>	
				</div>
				<div>
					<label>日期格式：</label>
				</div>
				<div id="propertyB_div">				
					<select id="propertyB" name="propertyB" value="" class="form-control" style="height:100%;width:100%;" onchange="updatePropertiesByType(this);">
	                     <option value=""></option>
	                     <option value="yyyy年MM月dd日">yyyy年MM月dd日</option>
	                     <option value="yyyy年MM月dd日 hh:mm">yyyy年MM月dd日 HH:mm</option>
	                </select>	
				</div>
				<div>
					<label>列数：</label>
				</div>
				<div id="columns_div">
					<input id="columns" name="columns" type="text" value="" class="form-control" style="height:100%;width:100%;" autocomplete="off" oninput="updatePropertiesByType(this);"/>
				</div>
				<div id="propertyE_div" style="padding-top: 10px;">
					<label id="propertyE_Label">支持图片上传预览：</label>
					<input id="propertyE" name="propertyE" type="checkbox">
				</div>
				<div id="propertyD_div" style="padding-top: 10px;">
					<label id="propertyD_Label">是否显示部门：</label>
					<input id="propertyD" name="propertyD" type="checkbox">
				</div>
				<div>
					<label>上传文件类型：</label>
				</div>
				<div id="propertyC_div">
					<input id="propertyC" name="propertyC" type="text" value="" class="form-control" style="height:100%;width:100%;" autocomplete="off" oninput="updatePropertiesByType(this);"/>
				</div>
				<div>
					<label>上传最大文件个数：</label>
				</div>
				<div id="maxFileCount_div">
					<input id="maxFileCount" name="maxFileCount" type="number" value="" class="form-control" style="height:100%;width:100%;" autocomplete="off" oninput="updatePropertiesByType(this);"/>
				</div>
				<div>
					<label>预扣除：</label>
				</div>
				<div id="preDeduction_div">				
					<select id="preDeduction" name="preDeduction" value="" class="form-control" style="height:100%;width:100%;" onchange="updatePropertiesByType(this);">
	                     <option value="true">是</option>
	                     <option value="false">否</option>
	                </select>	
				</div>
				<div>
					<label>关联属性：</label>
				</div>
				<div id="dependencyPro_div">
					<select id="dependencyPro" name="dependencyPro" value="" class="form-control" style="height:100%;width:100%;" onchange="updatePropertiesByType(this);">        
	                </select>	
				</div>
				<div id="showMinimizeButton_div" style="padding-top: 10px;">
					<label id="showMinimizeButton_Label">展开合上：</label>
					<input id="showMinimizeButton" name="showMinimizeButton" type="checkbox">
				</div>
				<div id="showCloseButton_div" style="padding-top: 10px;">
					<label id="showCloseButton_Label">关闭按钮：</label>
					<input id="showCloseButton" name="showCloseButton" type="checkbox">
				</div>
			    <div class="x-btn" style="font-size: 14px;color: #333;border-color: #ccc;margin-top:10px;display: none;" id="moreAttribute" onclick="openMoreAttribute();">
			     	<span>更多属性</span>
			    </div> 
			     <div class="x-btn" style="font-size: 14px;color: #333;border-color: #ccc;margin-top:10px;display: none;" id="dataValidator" onclick="openDataValidator();">
			     	<span>数据校验</span>
			    </div>   
			</div>
		</div>
	</div>
</body>
</html>