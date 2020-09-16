<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java" import="com.matrix.engine.foundation.config.MFSystemProperties" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>任务分派下的执行人员信息</title>
	<%@ include file="/form/html5/admin/html5Head.jsp"%>
	<style>
		#font2,#font3{
			font-size: 14px;
			margin-left: 10px;
			font-weight: bold;
		}
		
		#td107,#td041{
			width: 100%;
			height: 30px;
		}
	</style>
	<script type="text/javascript">
		windowId = this;
		
		//页面失焦事件
		window.onblur=function(){
			saveExecutor();
		}
		//保存
		function saveExecutor(){
			debugger;
			var editFlag = Matrix.getFormItemValue('editFlag');
			var data = Matrix.formToObject('form0');
			var index = Matrix.getFormItemValue('index');
			var isContain = Matrix.getFormItemValue('include');
			var activityId = Matrix.getFormItemValue('activityId');
			var url = "<%=request.getContextPath()%>/editor/editor_updateExecutorInfo.action?isContain="+isContain+"&index="+index;
			if(editFlag!='edit'){//处于非编辑状态
				if(data!=null){
					Matrix.sendRequest(url,data,function(){});
				}
			}
		}
		//页面获得焦点，就处在编辑状态
		window.onfocus = function(){
			Matrix.setFormItemValue('editFlag','');
		}
		
		function setFocus(){
			var input = document.getElementsByName('input001')[0];	
			input.focus();
		}	
		
		//页面初始事件
		window.onload=function(){
			debugger;
			<%
			int phaseStatus = (Integer)session.getAttribute("phase");										
			if(phaseStatus == 4){ //实施阶段	
			%>						
			//条件
		    //document.getElementById("tr002").style.display='none';     
		    //源自变量的角色
		    document.getElementById("td204").style.display='none';     
		    document.getElementById("td206").style.display='none'; 
		    //设置人员辅助类
		    document.getElementById("tr016").style.display='none';     
		    
		    <%}%>	
			setFocus();
			
			var executor = "${assign.assignWorkerType}";
			var SelectRole = "${assign.selectRole}";
			var SelectDep = "${assign.selectDep}";
			var DepFromType = "${assign.depFromType}";
			var RoleFromType = "${assign.roleFromType}";
			if(executor=='PROCESSSTARTER'){//流程启动人员
				$('#popupSelectDialog002_button').addClass('notclickn');
				$('#popupSelectDialog003_button').addClass('notclickn');
				$('#popupSelectDialog004_button').addClass('notclickn');
				
				$('#checkBox001').iCheck('disable');  //角色
				$('#role_0').iCheck('disable');     //选定角色
				$('#popupSelectDialog005_button').addClass('notclickn');
				$('#role_1').iCheck('disable');     //源自变量的角色
				$('#popupSelectDialog006_button').addClass('notclickn');
				
				$('#checkBox002').iCheck('disable');  //部门
				$('#dept_0').iCheck('disable');  //选定部门
				$('#popupSelectDialog007_button').addClass('notclickn');
				$('#dept_1').iCheck('disable'); //源自变量的部门
				$('#popupSelectDialog008_button').addClass('notclickn');
				$('#dept_2').iCheck('disable'); //源自关联部门
				
				$('#includeSubDep').iCheck('disable');       //设置包含子部门不可用
				$('#comboBox001').attr('disabled',true);       //源自关联部门下拉框不可用
				$('#popupSelectDialog009_button').addClass('notclickn');
				$('#popupSelectDialog004').val('');
				$('#popupSelectDialog002').val('');
				$('#popupSelectDialog003').val('');
				$('#popupSelectDialog005').val('');
				$('#popupSelectDialog006').val('');
				$('#popupSelectDialog007').val('');
				$('#popupSelectDialog008').val('');
				$('#popupSelectDialog009').val('');
			
			}else if(executor=='ACTEXECUTOR'){//选定活动执行人员
				$('#popupSelectDialog002_button').removeClass('notclickn');
				$('#popupSelectDialog003_button').addClass('notclickn');
				$('#popupSelectDialog004_button').addClass('notclickn');
				
				$('#checkBox001').iCheck('disable');  //角色
				$('#role_0').iCheck('disable');     //选定角色
				$('#popupSelectDialog005_button').addClass('notclickn');
				$('#role_1').iCheck('disable');     //源自变量的角色
				$('#popupSelectDialog006_button').addClass('notclickn');
				
				$('#checkBox002').iCheck('disable');  //部门
				$('#dept_0').iCheck('disable');  //选定部门
				$('#popupSelectDialog007_button').addClass('notclickn');
				$('#dept_1').iCheck('disable'); //源自变量的部门
				$('#popupSelectDialog008_button').addClass('notclickn');
				$('#dept_2').iCheck('disable'); //源自关联部门
				
				$('#includeSubDep').iCheck('disable');       //设置包含子部门不可用
				$('#comboBox001').attr('disabled',true);       //源自关联部门下拉框不可用
				$('#popupSelectDialog009_button').addClass('notclickn');
				$('#popupSelectDialog004').val('');
				$('#popupSelectDialog003').val('');
				$('#popupSelectDialog005').val('');
				$('#popupSelectDialog006').val('');
				$('#popupSelectDialog007').val('');
				$('#popupSelectDialog008').val('');
				$('#popupSelectDialog009').val('');
				
			}else if(executor=='STATICUSER'){//选定人员
				$('#popupSelectDialog002_button').addClass('notclickn');
				$('#popupSelectDialog003_button').addClass('notclickn');
				$('#popupSelectDialog004_button').removeClass('notclickn');
				
				$('#checkBox001').iCheck('disable');  //角色
				$('#role_0').iCheck('disable');     //选定角色
				$('#popupSelectDialog005_button').addClass('notclickn');
				$('#role_1').iCheck('disable');     //源自变量的角色
				$('#popupSelectDialog006_button').addClass('notclickn');
				
				$('#checkBox002').iCheck('disable');  //部门
				$('#dept_0').iCheck('disable');  //选定部门
				$('#popupSelectDialog007_button').addClass('notclickn');
				$('#dept_1').iCheck('disable'); //源自变量的部门
				$('#popupSelectDialog008_button').addClass('notclickn');
				$('#dept_2').iCheck('disable'); //源自关联部门
			
				$('#includeSubDep').iCheck('disable');       //设置包含子部门不可用
				$('#comboBox001').attr('disabled',true);       //源自关联部门下拉框不可用
				$('#popupSelectDialog009_button').addClass('notclickn');
				$('#popupSelectDialog002').val('');
				$('#popupSelectDialog003').val('');
				$('#popupSelectDialog005').val('');
				$('#popupSelectDialog006').val('');
				$('#popupSelectDialog007').val('');
				$('#popupSelectDialog008').val('');
				$('#popupSelectDialog009').val('');
				
			}else if(executor=='DYNAMICUSER'){//源自变量的人员
				$('#popupSelectDialog002_button').addClass('notclickn');
				$('#popupSelectDialog003_button').removeClass('notclickn');
				$('#popupSelectDialog004_button').addClass('notclickn');
			
				$('#checkBox001').iCheck('disable');  //角色
				$('#role_0').iCheck('disable');     //选定角色
				$('#popupSelectDialog005_button').addClass('notclickn');
				$('#role_1').iCheck('disable');     //源自变量的角色
				$('#popupSelectDialog006_button').addClass('notclickn');
				
				$('#checkBox002').iCheck('disable');  //部门
				$('#dept_0').iCheck('disable');  //选定部门
				$('#popupSelectDialog007_button').addClass('notclickn');
				$('#dept_1').iCheck('disable'); //源自变量的部门
				$('#popupSelectDialog008_button').addClass('notclickn');
				$('#dept_2').iCheck('disable'); //源自关联部门
				
				$('#includeSubDep').iCheck('disable');       //设置包含子部门不可用
				$('#comboBox001').attr('disabled',true);       //源自关联部门下拉框不可用
				$('#popupSelectDialog009_button').addClass('notclickn');
				$('#popupSelectDialog002').val('');
				$('#popupSelectDialog004').val('');
				$('#popupSelectDialog005').val('');
				$('#popupSelectDialog006').val('');
				$('#popupSelectDialog007').val('');
				$('#popupSelectDialog008').val('');
				$('#popupSelectDialog009').val('');
				
			}else if(executor=='COMPLEXSETTING'){//通过部门、角色进行分派
				$('#popupSelectDialog002_button').addClass('notclickn');
				$('#popupSelectDialog003_button').addClass('notclickn');
				$('#popupSelectDialog004_button').addClass('notclickn');
				
				$('#popupSelectDialog002').val('');
				$('#popupSelectDialog003').val('');
				$('#popupSelectDialog004').val('');
				$('#popupSelectDialog009').val('');
				$('#checkBox001').iCheck('enable');  //角色
				var isSelectRole = SelectRole;
				if(isSelectRole=='true'){
					$('#role_0').iCheck('enable');     //选定角色
					$('#role_1').iCheck('enable');     //源自变量的角色
					var roleDetailType = RoleFromType;
					if(roleDetailType=='STATIC'){
						$('#popupSelectDialog005_button').removeClass('notclickn');
						$('#popupSelectDialog006_button').addClass('notclickn');
						$('#popupSelectDialog006').val('');
					}else if(roleDetailType=='DYNAMIC'){
						$('#popupSelectDialog005_button').addClass('notclickn');
						$('#popupSelectDialog006_button').removeClass('notclickn');
						$('#popupSelectDialog005').val('');
					}
					
				}else{
					$('#role_0').iCheck('disable');     //选定角色
					$('#popupSelectDialog005_button').addClass('notclickn');
					$('#role_1').iCheck('disable');     //源自变量的角色
					$('#popupSelectDialog006_button').addClass('notclickn');
					$('#popupSelectDialog005').val('');
					$('#popupSelectDialog006').val('');
				}
				$('#checkBox002').iCheck('enable');  //部门
				var isSelectDep = SelectDep;
				if(isSelectDep=='true' ){
					$('#dept_0').iCheck('enable');  //选定部门
					$('#dept_1').iCheck('enable'); //源自变量的部门
					$('#dept_2').iCheck('enable'); //源自关联部门
					var deptDetailType = DepFromType;
					if(deptDetailType=='STATIC'){
						$('#popupSelectDialog007_button').removeClass('notclickn');
						$('#popupSelectDialog008_button').addClass('notclickn');
						$('#popupSelectDialog008').val('');
						$('#comboBox001').attr('disabled',true);       //源自关联部门下拉框不可用
					}else if(deptDetailType=='DYNAMIC'){
						$('#popupSelectDialog007_button').addClass('notclickn');
						$('#popupSelectDialog008_button').removeClass('notclickn');
						$('#popupSelectDialog007').val('');
						$('#comboBox001').attr('disabled',true);       //源自关联部门下拉框不可用
					}else if(deptDetailType=='RELATION'){
						$('#popupSelectDialog007_button').addClass('notclickn');
						$('#popupSelectDialog008_button').addClass('notclickn');
						$('#popupSelectDialog007').val('');
						$('#popupSelectDialog008').val('');
						$('#comboBox001').attr('disabled',false);       //源自关联部门下拉框可用
					}
				}else{
					$('#includeSubDep').iCheck('disable');       //设置包含子部门不可用
					$('#dept_0').iCheck('disable');  //选定部门
					$('#dept_1').iCheck('disable'); //源自变量的部门
					$('#dept_2').iCheck('disable'); //源自关联部门
					$('#popupSelectDialog007_button').addClass('notclickn');
					$('#popupSelectDialog008_button').addClass('notclickn');
					$('#popupSelectDialog007').val('');
					$('#popupSelectDialog008').val('');
					$('#comboBox001').attr('disabled',true);       //源自关联部门下拉框不可用
				} 
				
			}else if(executor=='COMPONENT'){//设置人员辅助类
				$('#popupSelectDialog002_button').addClass('notclickn');
				$('#popupSelectDialog003_button').addClass('notclickn');
				$('#popupSelectDialog004_button').addClass('notclickn');
				$('#popupSelectDialog002').val('');
				$('#popupSelectDialog003').val('');
				$('#popupSelectDialog004').val('');
				$('#checkBox001').iCheck('disable');  //角色
				$('#role_0').iCheck('disable');     //选定角色
				$('#popupSelectDialog005_button').addClass('notclickn');
				$('#role_1').iCheck('disable');     //源自变量的角色
				$('#popupSelectDialog006_button').addClass('notclickn');
				$('#checkBox002').iCheck('disable');  //部门
				$('#dept_0').iCheck('disable');  //选定部门
				$('#popupSelectDialog007_button').addClass('notclickn');
				$('#dept_1').iCheck('disable'); //源自变量的部门
				$('#popupSelectDialog008_button').addClass('notclickn');
				$('#dept_2').iCheck('disable'); //源自关联部门
				$('#comboBox001').attr('disabled',true);       //源自关联部门下拉框不可用
				$('#includeSubDep').iCheck('disable');       //设置包含子部门不可用
				
				$('#popupSelectDialog009_button').removeClass('notclickn');
				$('#popupSelectDialog002').val('');
				$('#popupSelectDialog003').val('');
				$('#popupSelectDialog004').val('');
				$('#popupSelectDialog005').val('');
				$('#popupSelectDialog006').val('');
				$('#popupSelectDialog007').val('');
				$('#popupSelectDialog008').val('');
			}
			
			changeStatus();     //监听改变执行人员时，各个组件相应的变化	
			
			//角色复选框选中
			$("input:checkbox[name='checkBox001']").on('ifChecked', function(event){	
				$('#role_0').iCheck('enable');     //选定角色
				$('#role_1').iCheck('enable');     //源自变量的角色
				var roleDetailType =  document.getElementsByName("role");//角色的详细信息是否选中 
				if(roleDetailType[0].checked){
					$('#popupSelectDialog005_button').removeClass('notclickn');
					$('#popupSelectDialog006_button').addClass('notclickn');
					$('#popupSelectDialog006').val('');	
				}else if(roleDetailType[1].checked){
					$('#popupSelectDialog005_button').addClass('notclickn');
					$('#popupSelectDialog006_button').removeClass('notclickn');
					$('#popupSelectDialog005').val('');
				}
				$('#checkBox001').val(1);
				window.focus();
				
			});
			
			//角色复选框取消选中
			$("input:checkbox[name='checkBox001']").on('ifUnchecked', function(event){
				$('#role_0').iCheck('disable');     //选定角色
				$('#popupSelectDialog005_button').addClass('notclickn');
				$('#role_1').iCheck('disable');     //源自变量的角色
				$('#popupSelectDialog006_button').addClass('notclickn');
				$('#popupSelectDialog005').val('');
				$('#popupSelectDialog006').val('');	
				$('#checkBox001').val('');
				window.focus();
			});
			
			//部门复选框选中
			$("input:checkbox[name='checkBox002']").on('ifChecked', function(event){		
				$('#dept_0').iCheck('enable');  //选定部门
				$('#dept_1').iCheck('enable'); //源自变量的部门
				$('#dept_2').iCheck('enable'); //源自关联部门
				$('#includeSubDep').iCheck('enable');       //设置包含子部门可用
				var deptDetailType = document.getElementsByName("dept");
				if(deptDetailType[0].checked){
					$('#popupSelectDialog007_button').removeClass('notclickn');
					$('#popupSelectDialog008_button').addClass('notclickn');
					$('#popupSelectDialog008').val()
					$('#comboBox001').attr('disabled',true);       //源自关联部门下拉框不可用
				}else if(deptDetailType[1].checked){
					$('#popupSelectDialog007_button').addClass('notclickn');
					$('#popupSelectDialog008_button').removeClass('notclickn');
					$('#popupSelectDialog007').val('');
					$('#comboBox001').attr('disabled',true);       //源自关联部门下拉框不可用
				}else if(deptDetailType[2].checked){
					$('#popupSelectDialog007_button').addClass('notclickn');
					$('#popupSelectDialog008_button').addClass('notclickn');
					$('#popupSelectDialog007').val('');
					$('#popupSelectDialog008').val('');
					$('#comboBox001').attr('disabled',false);       //源自关联部门下拉框可用
				}
				$('#checkBox002').val(1);
				window.focus();
			});
			
			//部门复选框取消选中
			$("input:checkbox[name='checkBox002']").on('ifUnchecked', function(event){
				$('#dept_0').iCheck('disable');  //选定部门
				$('#dept_1').iCheck('disable'); //源自变量的部门
				$('#dept_2').iCheck('disable'); //源自关联部门
				$('#includeSubDep').iCheck('disable');       //设置包含子部门不可用
				$('#popupSelectDialog007_button').addClass('notclickn');
				$('#popupSelectDialog008_button').addClass('notclickn');
				$('#popupSelectDialog007').val('');
				$('#popupSelectDialog008').val('');	
				$('#comboBox001').attr('disabled',true);       //源自关联部门下拉框不可用
				$('#checkBox002').val('');
				window.focus();
				
			});
			
			
			//选定角色  源自变量的角色单选按钮组改变事件
			$("input:radio[name='role']").on('ifChecked', function(event){
			      var value = $(this).val();  //1.选定角色。2.源自变量的角色。
			      if(value == 1){
			    	  $('#popupSelectDialog005_button').removeClass('notclickn');
					  $('#popupSelectDialog006_button').addClass('notclickn');
					  $('#popupSelectDialog006').val('');
				  }else if(value == 2){
					  $('#popupSelectDialog005_button').addClass('notclickn');
					  $('#popupSelectDialog006_button').removeClass('notclickn');
					  $('#popupSelectDialog005').val('');
			      }	     
			      window.focus();
			});
			
			//选定部门   源自变量的部门  源自关联部门单选按钮组改变事件
			$("input:radio[name='dept']").on('ifChecked', function(event){
			      var value = $(this).val();  //1.选定部门 。2. 源自变量的部门。 3.源自关联部门
			      if(value == 1){
			    	  $('#popupSelectDialog007_button').removeClass('notclickn');
					  $('#popupSelectDialog008_button').addClass('notclickn');
					  $('#popupSelectDialog008').val('');
					  $('#comboBox001').attr('disabled',true);       //源自关联部门下拉框不可用
				  }else if(value == 2){
					  $('#popupSelectDialog007_button').addClass('notclickn');
					  $('#popupSelectDialog008_button').removeClass('notclickn');
					  $('#popupSelectDialog007').val('');
					  $('#comboBox001').attr('disabled',true);       //源自关联部门下拉框不可用
			      }else if(value == 3){
			    	  $('#popupSelectDialog007_button').addClass('notclickn');
					  $('#popupSelectDialog008_button').addClass('notclickn');
					  $('#popupSelectDialog007').val('');
					  $('#popupSelectDialog008').val('');
					  $('#comboBox001').attr('disabled',false);       //源自关联部门下拉框可用
			      }   
			      window.focus();
			});
			
			//包含子部门复选框选中
			$("input:checkbox[name='includeSubDep']").on('ifChecked', function(event){	
				$('#includeSubDep').val(1);
				window.focus();
				
			});
			
			//包含子部门复选框取消选中
			$("input:checkbox[name='includeSubDep']").on('ifUnchecked', function(event){
				$('#includeSubDep').val('');
				window.focus();
			});
		}
		
		function changeStatus(){
			$("input:radio[name='executor']").on('ifChecked', function(event){
				  debugger;
				  $('#includeSubDep').iCheck('enable');       //设置包含子部门可用
			      var value = $(this).val();  //静态。动态。
			      if(value == 1){      //流程启动人员
			    	    $('#popupSelectDialog002_button').addClass('notclickn');
						$('#popupSelectDialog003_button').addClass('notclickn');
						$('#popupSelectDialog004_button').addClass('notclickn');
						$('#checkBox001').iCheck('disable');  //角色
						$('#role_0').iCheck('disable');     //选定角色
						$('#popupSelectDialog005_button').addClass('notclickn');
						$('#role_1').iCheck('disable');     //源自变量的角色
						$('#popupSelectDialog006_button').addClass('notclickn');
						$('#checkBox002').iCheck('disable');  //部门
						$('#dept_0').iCheck('disable');  //选定部门
						$('#popupSelectDialog007_button').addClass('notclickn');
						$('#dept_1').iCheck('disable'); //源自变量的部门
						$('#popupSelectDialog008_button').addClass('notclickn');
						$('#dept_2').iCheck('disable'); //源自关联部门
						$('#comboBox001').attr('disabled',true);       //源自关联部门下拉框不可用
						$('#includeSubDep').iCheck('disable');       //设置包含子部门不可用
						$('#popupSelectDialog009_button').addClass('notclickn');
						$('#popupSelectDialog004').val('');
						$('#popupSelectDialog002').val('');
						$('#popupSelectDialog003').val('');
						$('#popupSelectDialog005').val('');
						$('#popupSelectDialog006').val('');
						$('#popupSelectDialog007').val('');
						$('#popupSelectDialog008').val('');
						$('#popupSelectDialog009').val('');
				  }else if(value == 3){      //选定活动的执行人员
					  	$('#popupSelectDialog002_button').removeClass('notclickn');
						$('#popupSelectDialog003_button').addClass('notclickn');
						$('#popupSelectDialog004_button').addClass('notclickn');					
						$('#checkBox001').iCheck('disable');  //角色
						$('#role_0').iCheck('disable');     //选定角色
						$('#popupSelectDialog005_button').addClass('notclickn');
						$('#role_1').iCheck('disable');     //源自变量的角色
						$('#popupSelectDialog006_button').addClass('notclickn');
						$('#checkBox002').iCheck('disable');  //部门
						$('#dept_0').iCheck('disable');  //选定部门
						$('#popupSelectDialog007_button').addClass('notclickn');
						$('#dept_1').iCheck('disable'); //源自变量的部门
						$('#popupSelectDialog008_button').addClass('notclickn');
						$('#dept_2').iCheck('disable'); //源自关联部门
						$('#comboBox001').attr('disabled',true);       //源自关联部门下拉框不可用
						$('#includeSubDep').iCheck('disable');       //设置包含子部门不可用
						$('#popupSelectDialog009_button').addClass('notclickn');
						$('#popupSelectDialog004').val('');
						$('#popupSelectDialog003').val('');
						$('#popupSelectDialog005').val('');
						$('#popupSelectDialog006').val('');
						$('#popupSelectDialog007').val('');
						$('#popupSelectDialog008').val('');
						$('#popupSelectDialog009').val('');
			      }else if(value == 4){    //选定人员
			    	 	$('#popupSelectDialog002_button').addClass('notclickn');
						$('#popupSelectDialog003_button').addClass('notclickn');
						$('#popupSelectDialog004_button').removeClass('notclickn');
						$('#checkBox001').iCheck('disable');  //角色
						$('#role_0').iCheck('disable');     //选定角色
						$('#popupSelectDialog005_button').addClass('notclickn');
						$('#role_1').iCheck('disable');     //源自变量的角色
						$('#popupSelectDialog006_button').addClass('notclickn');
						$('#checkBox002').iCheck('disable');  //部门
						$('#dept_0').iCheck('disable');  //选定部门
						$('#popupSelectDialog007_button').addClass('notclickn');
						$('#dept_1').iCheck('disable'); //源自变量的部门
						$('#popupSelectDialog008_button').addClass('notclickn');
						$('#dept_2').iCheck('disable'); //源自关联部门
						$('#comboBox001').attr('disabled',true);       //源自关联部门下拉框不可用
						$('#includeSubDep').iCheck('disable');       //设置包含子部门不可用
						$('#popupSelectDialog009_button').addClass('notclickn');
						$('#popupSelectDialog002').val('');
						$('#popupSelectDialog003').val('');
						$('#popupSelectDialog005').val('');
						$('#popupSelectDialog006').val('');
						$('#popupSelectDialog007').val('');
						$('#popupSelectDialog008').val('');
						$('#popupSelectDialog009').val('');	
			      }else if(value == 5){   //源自变量人员
			    	  	$('#popupSelectDialog002_button').addClass('notclickn');
						$('#popupSelectDialog003_button').removeClass('notclickn');
						$('#popupSelectDialog004_button').addClass('notclickn');	
						$('#checkBox001').iCheck('disable');  //角色
						$('#role_0').iCheck('disable');     //选定角色
						$('#popupSelectDialog005_button').addClass('notclickn');
						$('#role_1').iCheck('disable');     //源自变量的角色
						$('#popupSelectDialog006_button').addClass('notclickn');		
						$('#checkBox002').iCheck('disable');  //部门
						$('#dept_0').iCheck('disable');  //选定部门
						$('#popupSelectDialog007_button').addClass('notclickn');
						$('#dept_1').iCheck('disable'); //源自变量的部门
						$('#popupSelectDialog008_button').addClass('notclickn');
						$('#dept_2').iCheck('disable'); //源自关联部门	
						$('#comboBox001').attr('disabled',true);       //源自关联部门下拉框不可用
						$('#includeSubDep').iCheck('disable');       //设置包含子部门不可用
						$('#popupSelectDialog009_button').addClass('notclickn');
						$('#popupSelectDialog002').val('');
						$('#popupSelectDialog004').val('');
						$('#popupSelectDialog005').val('');
						$('#popupSelectDialog006').val('');
						$('#popupSelectDialog007').val('');
						$('#popupSelectDialog008').val('');
						$('#popupSelectDialog009').val('');
			      }else if(value == 9){   //通过部门、角色进行分派
			    	 	$('#popupSelectDialog002_button').addClass('notclickn');
						$('#popupSelectDialog003_button').addClass('notclickn');
						$('#popupSelectDialog004_button').addClass('notclickn');
						$('#popupSelectDialog002').val('');
						$('#popupSelectDialog003').val('');
						$('#popupSelectDialog004').val('');
						$('#popupSelectDialog009').val('');
						$('#includeSubDep').iCheck('disable');       //设置包含子部门不可用
						
						$('#checkBox001').iCheck('enable');  //角色
						var isSelectRole = $('#checkBox001').val();
						if(isSelectRole=='true' || isSelectRole=='1'){
							$('#role_0').iCheck('enable');     //选定角色
							$('#role_1').iCheck('enable');     //源自变量的角色
							var roleDetailType =  document.getElementsByName("role");//角色的详细信息是否选中 
							if(roleDetailType[0].checked){
								$('#popupSelectDialog005_button').removeClass('notclickn');
								$('#popupSelectDialog006_button').addClass('notclickn');
								$('#popupSelectDialog006').val('');
							}else if(roleDetailType[1].checked){
								$('#popupSelectDialog005_button').addClass('notclickn');
								$('#popupSelectDialog006_button').removeClass('notclickn');
								$('#popupSelectDialog005').val('');
							}
							
						}else{
							$('#role_0').iCheck('disable');     //选定角色
							$('#popupSelectDialog005_button').addClass('notclickn');
							$('#role_1').iCheck('disable');     //源自变量的角色
							$('#popupSelectDialog006_button').addClass('notclickn');
						}
						$('#checkBox002').iCheck('enable');  //部门
						var isSelectDep = $('#checkBox002').val();
						if(isSelectDep=='true' || isSelectDep=='1'){
							$('#dept_0').iCheck('enable');  //选定部门
							$('#dept_1').iCheck('enable'); //源自变量的部门
							$('#dept_2').iCheck('enable'); //源自关联部门
							$('#includeSubDep').iCheck('enable');       //设置包含子部门可用
							var deptDetailType = document.getElementsByName("dept");
							if(deptDetailType[0].checked){
								$('#popupSelectDialog007_button').removeClass('notclickn');
								$('#popupSelectDialog008_button').addClass('notclickn');
								$('#popupSelectDialog008').val('');							   
								$('#comboBox001').attr('disabled',true);       //源自关联部门下拉框不可用
							}else if(deptDetailType[1].checked){
								$('#popupSelectDialog007_button').addClass('notclickn');
								$('#popupSelectDialog008_button').removeClass('notclickn');
								$('#popupSelectDialog007').val('');
								$('#comboBox001').attr('disabled',true);       //源自关联部门下拉框不可用
							}else if(deptDetailType[2].checked){
								$('#popupSelectDialog007_button').addClass('notclickn');
								$('#popupSelectDialog008_button').addClass('notclickn');
								$('#popupSelectDialog007').val('');
								$('#popupSelectDialog008').val('');
								$('#comboBox001').iCheck('enable');       //源自关联部门下拉框
							}
							$('#popupSelectDialog007_button').addClass('notclickn');
							$('#popupSelectDialog008_button').addClass('notclickn');
							$('#comboBox001').attr('disabled',true);       //源自关联部门下拉框不可用
						}else{
							$('#dept_0').iCheck('disable');  //选定部门
							$('#dept_1').iCheck('disable'); //源自变量的部门
							$('#dept_2').iCheck('disable'); //源自关联部门
							$('#popupSelectDialog007_button').addClass('notclickn');
							$('#popupSelectDialog008_button').addClass('notclickn');
							$('#popupSelectDialog007').val('');
							$('#popupSelectDialog008').val('');
							$('#comboBox001').attr('disabled',true);       //源自关联部门下拉框不可用
						} 
						$('#popupSelectDialog007_button').addClass('notclickn');
						$('#popupSelectDialog008_button').addClass('notclickn');
						$('#comboBox001').attr('disabled',true);       //源自关联部门下拉框不可用
						$('#popupSelectDialog009_button').addClass('notclickn');
						InitIsSelectRole();
						InitIsSelectDept();
	
			      }else if(value == 10){   //设置人员辅助类
			    	  	$('#popupSelectDialog002_button').addClass('notclickn');
						$('#popupSelectDialog003_button').addClass('notclickn');
						$('#popupSelectDialog004_button').addClass('notclickn');
						$('#popupSelectDialog002').val('');
						$('#popupSelectDialog003').val('');
						$('#popupSelectDialog004').val('');
						$('#checkBox001').iCheck('disable');  //角色
						$('#role_0').iCheck('disable');     //选定角色
						$('#popupSelectDialog005_button').addClass('notclickn');
						$('#role_1').iCheck('disable');     //源自变量的角色
						$('#popupSelectDialog006_button').addClass('notclickn');
						$('#checkBox002').iCheck('disable');  //部门
						$('#dept_0').iCheck('disable');  //选定部门
						$('#popupSelectDialog007_button').addClass('notclickn');
						$('#dept_1').iCheck('disable'); //源自变量的部门
						$('#popupSelectDialog008_button').addClass('notclickn');
						$('#dept_2').iCheck('disable'); //源自关联部门
						$('#comboBox001').attr('disabled',true);       //源自关联部门下拉框不可用
						$('#includeSubDep').iCheck('disable');       //设置包含子部门不可用
						$('#popupSelectDialog009_button').removeClass('notclickn');
						$('#popupSelectDialog002').val('');
						$('#popupSelectDialog003').val('');
						$('#popupSelectDialog004').val('');
						$('#popupSelectDialog005').val('');
						$('#popupSelectDialog006').val('');
						$('#popupSelectDialog007').val('');
						$('#popupSelectDialog008').val('');
					}     
			        window.focus();
			});
		}
		
		function InitIsSelectRole(){
			var role = $('#checkBox001').val();
			if(role=='true' || role=='1'){
				$('#role_0').iCheck('enable');     //选定角色
				$('#role_1').iCheck('enable');     //源自变量的角色
				var roleDetailType =  document.getElementsByName("role");//角色的详细信息是否选中 
				if(roleDetailType[0].checked){
					$('#popupSelectDialog005_button').removeClass('notclickn');
					$('#popupSelectDialog006_button').addClass('notclickn');
				}else if(roleDetailType[1].checked){
					$('#popupSelectDialog005_button').addClass('notclickn');
					$('#popupSelectDialog006_button').removeClass('notclickn');
				}
			}else if(role==''||role=='undefined'){
				$('#role_0').iCheck('disable');     //选定角色
				$('#popupSelectDialog005_button').addClass('notclickn');
				$('#role_1').iCheck('disable');     //源自变量的角色
				$('#popupSelectDialog006_button').addClass('notclickn');
			}
		}
		
		function InitIsSelectDept(){
			var isSelectDep = $('#checkBox002').val();
				if(isSelectDep=='true' || isSelectDep=='1'){
					$('#dept_0').iCheck('enable');  //选定部门
					$('#dept_1').iCheck('enable'); //源自变量的部门
					$('#dept_2').iCheck('enable'); //源自关联部门
					var deptDetailType = document.getElementsByName("dept");
					if(deptDetailType[0].checked){
						$('#popupSelectDialog007_button').removeClass('notclickn');
						$('#popupSelectDialog008_button').addClass('notclickn');
						$('#comboBox001').attr('disabled',true);       //源自关联部门下拉框不可用
					}else if(deptDetailType[1].checked){
						$('#popupSelectDialog007_button').addClass('notclickn');
						$('#popupSelectDialog008_button').removeClass('notclickn');
						$('#comboBox001').attr('disabled',true);       //源自关联部门下拉框不可用
					}else if(deptDetailType[2].checked){
						$('#popupSelectDialog007_button').addClass('notclickn');
						$('#popupSelectDialog008_button').addClass('notclickn');
						$('#comboBox001').attr('disabled',false);       //源自关联部门下拉框可用
					}
				}else if(isSelectDep == ''|| isSelectDep=='undefined'){
					$('#dept_0').iCheck('disable');  //选定部门
					$('#dept_1').iCheck('disable'); //源自变量的部门
					$('#dept_2').iCheck('disable'); //源自关联部门
					$('#popupSelectDialog007_button').addClass('notclickn');
					$('#popupSelectDialog008_button').addClass('notclickn');
					$('#comboBox001').attr('disabled',true);       //源自关联部门下拉框不可用
				} 
		}
		
		
		//打开条件编辑窗口 (设计开发和实施阶段弹出的不一样)
		function openpopupSelectDialog001(){
			var conditionValue = Matrix.getFormItemValue('popupSelectDialog001');
			if(conditionValue!=null && conditionValue!='null'){
				parent.parent.Matrix.setFormItemValue('conditionValue',conditionValue);
			}
			Matrix.setFormItemValue('editFlag','edit');
			<%
			int phaseStatus4 = (Integer)session.getAttribute("phase");										
			if(phaseStatus4 == 4){ //实施阶段	
			%>		
			  parent.parent.openConditionByAdmin(this,conditionValue);  //loadBasicActivityTreeNodePage.jsp弹出
			<%
			}else{  //设计开发
			%>
			  parent.parent.openConditionByDesigner(this);     //loadBasicActivityTreeNodePage.jsp弹出
			<%
			}
			%>
		}
		
		//打开选定活动执行人员窗口
		function openpopupSelectDialog002(){
			Matrix.setFormItemValue('editFlag','edit');
			parent.parent.openExecutor(this);     //loadBasicActivityTreeNodePage.jsp弹出
		}
		
		//打开选择人员窗口
		function openpopupSelectDialog004(){
			Matrix.setFormItemValue('editFlag','edit');
			parent.parent.selectUser(this);     //loadBasicActivityTreeNodePage.jsp弹出
		}
		
		//打开源自变量人员窗口
		function openpopupSelectDialog003(){
			<%
			int phaseStatus2 = (Integer)session.getAttribute("phase");										
			if(phaseStatus2 == 4){ //实施阶段	
			%>	
			Matrix.setFormItemValue('editFlag','edit');
			parent.parent.openUserLayer(this);
			<%
			}else{
			%>
			Matrix.setFormItemValue('editFlag','edit');
			parent.parent.openVariables5(this);     //loadBasicActivityTreeNodePage.jsp弹出
			<%
			}
			%>
		}
		
		//打开选定角色窗口
		function openpopupSelectDialog005(){
			Matrix.setFormItemValue('editFlag','edit');
			<%
				boolean roleIsTreeFlag = MFSystemProperties.getInstance().getOrganizationTable().getRoleIsTreeFlag();
				if(roleIsTreeFlag==true){
			%>
					parent.parent.openRoleTree(this);     //loadBasicActivityTreeNodePage.jsp弹出
			<%
				}else{
			%>
					parent.parent.openRoleList(this);     //loadBasicActivityTreeNodePage.jsp弹出
			<%
				}
			%>
		}
		
		//打开源自变量角色窗口
		function openpopupSelectDialog006(){
			<%
			 int phaseStatus3 = (Integer)session.getAttribute("phase");
		     if(phaseStatus3 == 4){ //实施阶段	
			%>
				Matrix.setFormItemValue('editFlag','edit');
				parent.parent.openRoleLayer(this);   //loadBasicActivityTreeNodePage.jsp弹出
			<%
			 }else{
			%>
				Matrix.setFormItemValue('editFlag','edit');
				parent.parent.openVariables6(this);     //loadBasicActivityTreeNodePage.jsp弹出
			<%
			 }
			%>
		}
		
		//打开选择部门窗口
		function openpopupSelectDialog007(){
			Matrix.setFormItemValue('editFlag','edit');
			parent.parent.selectDept(this);     //loadBasicActivityTreeNodePage.jsp弹出
		}
		
		//打开源自变量部门窗口
		function openpopupSelectDialog008(){
			<%
			 int phase4 = (Integer)session.getAttribute("phase");
			 if(phase4 == 4){ //实施阶段	
			%>
				Matrix.setFormItemValue('editFlag','edit');
				parent.parent.openDeptLayer(this);   //loadBasicActivityTreeNodePage.jsp弹出
			<%
			 }else{
			%>
				Matrix.setFormItemValue('editFlag','edit');
				parent.parent.openVariables7(this);     //loadBasicActivityTreeNodePage.jsp弹出
			<%
			 }
			%>
		}
		
		//打开人员辅助类窗口(集成组件)
		function openpopupSelectDialog009(){
			Matrix.setFormItemValue('editFlag','edit');
			parent.parent.openAssistance(this);   //loadBasicActivityTreeNodePage.jsp弹出
		}
		
	</script>
</head>
<body>
<div id="j_id1" jsId="j_id1" style="position: relative; _layout: flowlayout; width: 100%; height: 100%;overflow:auto">
  <form id="form0" name="form0" eventProxy="Mform0" method="post" action="<%=request.getContextPath()%>/mobile/showUser_loadDataGridData.action"
	style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="initData" id="initData" value="" /> 
	<input type="hidden" name="editFlag" id="editFlag" />
	<input type="hidden" name="include" id="include" value="${param.include }" />
	<input type="hidden" name="index" id="index" value="${param.index }"/>
	<!-- 活动编码 adid -->
	<input name="activityId" id="activityId" type="hidden" value="${param.activityId}"/>
	<input name="type" id="type" type="hidden" value="${param.type}"/>
	<input name="processdid" id="processdid" type="hidden" value="${param.processdid}"/>
	<input name="containerType" id="containerType" type="hidden" value="${param.containerType}"/>
	<input name="containerId" id="containerId" type="hidden" value="${param.containerId }"/>
	<!-- 执行人员编码 -->
	<input name="componentId" id="componentId" type="hidden" value="${assign.componentId }"/>
	<!-- 选定人员编码 -->
	<input name="selectedUserId" id="selectedUserId" type="hidden" value="${assign.actAssignId }"/>
	<!-- 选定活动执行人员编码 -->
	<input name="actExecutorId" id="actExecutorId" type="hidden" value="${assign.actAssignId }"/>
	<!-- 源自变量的人员编码 -->
	<input name="formVarUserId" id="formVarUserId" type="hidden" value="${assign.actAssignId }"/>
	<!-- 角色编码 -->
	<input name="roleId" id="roleId" type="hidden" value="${assign.roleValue }"/>
	<!-- 部门编码 -->
	<input name="depId" id="depId" type="hidden" value="${assign.depValue }"/>
	
	<table id="table001" class="tableLayout" style="width: 100%; border: 0px; overflow: auto;">
		<tr id="tr107" name="tr107">
			<td id="td107" name="td107" colspan="20" rowspan="1"
				style="width: 100%;"><font id="font2">任务分派</font>
			</td>
		</tr>
		<tr id="tr001">
			<td id="td001" class="tdValueCls" colspan="3" rowspan="1" style="width: 15%;border: 0px;text-align:center;">
			   <label id="label001" name="label001" id="label001" style="width:100%">名称</label>
			</td>
			<td id="td003" class="tdValueCls" colspan="17" rowspan="1" style="width: 85%; border: 0px;">
				<div id="input001_div" style="vertical-align: middle;">
					<input id="input001" name="input001" type="text" value="${assign.name}" onkeyup="changeContent();" class="form-control" style="height:100%;width:90%;"/>
				</div>
			</td>
		</tr>
		<script>
			function changeContent(){
		         var name = Matrix.getFormItemValue('input001');//名称
				 var index = Matrix.getFormItemValue('index');
				 parent.updateName(name,index);
		    }
		</script>
		<tr id="tr002">
			<td id="td021" class="tdValueCls" colspan="3" rowspan="1" style="width: 15%;  border: 0px;text-align:center;">
				<label id="label002" name="label002" id="label002" style="width:100%;">条件</label>
			</td>
			<td id="td023" class="tdValueCls" colspan="17" rowspan="1" style="width: 85%; border: 0px;">
				<div id="popupSelectDialog001_div" class="input-group" style="width:90%;">
					<textarea class="form-control" rows="3" id="popupSelectDialog001" name="popupSelectDialog001" style="resize: none;" readonly="readonly">${assign.condition==null?'':assign.condition.value}</textarea>
            		 <span class="input-group-addon addon-udSelect udSelect" onclick="openpopupSelectDialog001();" id="popupSelectDialog001_button"><i class="fa fa-search"></i></span>
				</div>
			</td>
		</tr>
		<tr id="tr003">
			<td id="td041" colspan="20" rowspan="1" style="width: 100%; border: 0px;text-align:left;">
				<font id="font3">人员设定</font>
			</td>
		</tr>
		<tr id="tr004">
			<td id="td061" class="tdValueCls" colspan="1" rowspan="13" style="width: 5%; border: 0px;">&nbsp;</td>
			<td id="td062" class="tdValueCls" colspan="3" rowspan="1" style="width: 15%; border: 0px;text-align:left;">
				<div id="radio001_div" style="display: inline-table;" >
					<input type="radio" class="box" name="executor" id="executor_0" value="1" ${assign.assignWorkerType=='PROCESSSTARTER'?'checked':''}/>
				</div>
				<label name="label0032" id="label0032" class="control-label ">
					流程启动人员
				</label>	
			</td>
			<td id="td065" class="tdValueCls" colspan="16" rowspan="1" style="width: 80%; border: 0px;"></td>
		</tr>
		<tr id="tr005">
			<td id="td082" class="tdValueCls" colspan="3" rowspan="1" style="width: 15%; border: 0px;text-align:left;">
				<div id="radio002_div" style="display: inline-table;" >
					<input type="radio" class="box" name="executor" id="executor_1" value="3" ${assign.assignWorkerType=='ACTEXECUTOR'?'checked':''}/>
				</div>
				<label name="label0032" id="label0032" class="control-label ">
					选定活动的执行人员
				</label>
			</td>
			<td id="td085" class="tdValueCls" colspan="16" rowspan="1" style="width: 80%; border: 0px;">
				<div id="popupSelectDialog002_div" class="input-group" style="width:60%;">
					 <input type="text" id="popupSelectDialog002" name="popupSelectDialog002" value="${assign.assignWorkerType=='ACTEXECUTOR'?assign.actAssignValue:''}"  class="form-control" readonly="readonly">
            		 <span class="input-group-addon addon-udSelect udSelect" onclick="openpopupSelectDialog002();" id="popupSelectDialog002_button"><i class="fa fa-search"></i></span>
				</div>
			</td>
		</tr>
		<tr id="tr006">
			<td id="td102" class="tdValueCls" colspan="3" rowspan="1" style="width: 15%; border: 0px;text-align:left;">
				<div id="radio003_div" style="display: inline-table;" >
					<input type="radio" class="box" name="executor" id="executor_2" value="4" ${assign.assignWorkerType=='STATICUSER'?'checked':''}/>
				</div>
				<label name="label0032" id="label0032" class="control-label ">
					选定人员
				</label>
			</td>
			<td id="td105" class="tdValueCls" colspan="16" rowspan="1" style="width: 80%; border: 0px;">
				<div id="popupSelectDialog004_div" class="input-group" style="width:60%;">
					 <input type="text" id="popupSelectDialog004" name="popupSelectDialog004" value="${assign.assignWorkerType=='STATICUSER'?assign.actAssignValue:''}"  class="form-control" readonly="readonly">
            		 <span class="input-group-addon addon-udSelect udSelect" onclick="openpopupSelectDialog004();" id="popupSelectDialog004_button"><i class="fa fa-search"></i></span>
				</div>
			</td>
		</tr>
		<tr id="tr007">
			<td id="td122" class="tdValueCls" colspan="3" rowspan="1" style="width: 15%; border: 0px;text-align:left;">
				<div id="radio004_div" style="display: inline-table;" >
					<input type="radio" class="box" name="executor" id="executor_3" value="5" ${assign.assignWorkerType=='DYNAMICUSER'?'checked':''}/>
				</div>
				<label name="label0032" id="label0032" class="control-label ">
					源自变量人员
				</label>
			</td>
			<td id="td125" class="tdValueCls" colspan="16" rowspan="1" style="width: 80%; border: 0px;">
				<div id="popupSelectDialog003_div" class="input-group" style="width:60%;">
					 <input type="text" id="popupSelectDialog003" name="popupSelectDialog003" value="${assign.assignWorkerType=='DYNAMICUSER'?assign.actAssignValue:''}"  class="form-control" readonly="readonly">
            		 <span class="input-group-addon addon-udSelect udSelect" onclick="openpopupSelectDialog003();" id="popupSelectDialog003_button"><i class="fa fa-search"></i></span>
				</div>
			</td>
		</tr>
		<tr id="tr008">
			<td id="td142" class="tdValueCls" colspan="3" rowspan="1" style="width: 15%; border: 0px;text-align:left;">
				<div id="radio005_div" style="display: inline-table;" >
					<input type="radio" class="box" name="executor" id="executor_4" value="9" ${assign.assignWorkerType=='COMPLEXSETTING'?'checked':''}/>
				</div>
				<label name="label0032" id="label0032" class="control-label ">
					通过部门、角色进行分派
				</label>
			</td>
			<td id="td145" class="tdValueCls" colspan="16" rowspan="1" style="width: 80%; border: 0px;">&nbsp;</td>
		</tr>
		<tr id="tr009">
			<td id="td162" class="tdValueCls" colspan="1" rowspan="7" style="width: 5%; border: 0px;">&nbsp;</td>
			<td id="td163" class="tdValueCls" colspan="2" rowspan="1" style="width: 10%; text-align:left; border: 0px;">
				<div name="checkBox001_div" id="checkBox001_div" style="display: inline-table;margin-left: 40px;" >
					<input type="checkbox" class="box" name="checkBox001" id="checkBox001" value="${isSelectRole=='false'?'':'1'}"  ${isSelectRole=='false'?'':'checked'}/>
				</div>
				<label name="label0032" id="label0032" class="control-label ">
					角色
				</label>	
			</td>
			<td id="td165" class="tdValueCls" colspan="16" rowspan="1" style="width: 80%; border: 0px;"></td>
		</tr>
		<tr id="tr010">
			<td id="td183" class="tdValueCls" colspan="1" rowspan="2" style="width: 5%; border: 0px;">&nbsp;</td>
			<td id="td184" class="tdValueCls" colspan="2" rowspan="1" style="width: 10%; text-align:left;border: 0px;">
				<div id="radio007_div" style="display: inline-table;" >
					<input type="radio" class="box" name="role" id="role_0" value="1" ${assign.roleFromType=='STATIC'?'checked':''}/>
				</div>
				<label name="label0032" id="label0032" class="control-label ">
					选定角色
				</label>	
			</td>
			<td id="td186" class="tdValueCls" colspan="15" rowspan="1" style="width: 80%; border: 0px;">
				<div id="popupSelectDialog005_div" class="input-group" style="width:60%;">
					<input type="text" id="popupSelectDialog005" name="popupSelectDialog005" value="${roleName}"  class="form-control" readonly="readonly">
            		<span class="input-group-addon addon-udSelect udSelect" onclick="openpopupSelectDialog005();" id="popupSelectDialog005_button"><i class="fa fa-search"></i></span>
				</div>
			</td>
		</tr>
		<tr id="tr011">
			<td id="td204" class="tdValueCls" colspan="2" rowspan="1" style="width: 10%; text-align:left;border: 0px;">
				<div id="radio008_div" style="display: inline-table;" >
					<input type="radio" class="box" name="role" id="role_1" value="2" ${assign.roleFromType=='DYNAMIC'?'checked':''}/>
				</div>
				<label name="label0032" id="label0032" class="control-label ">
					源自变量的角色
				</label>
			</td>
			<td id="td206" class="tdValueCls" colspan="15" rowspan="1" style="width: 80%; border: 0px;">
				<div id="popupSelectDialog006_table" class="input-group" style="width:60%;">
					<input type="text" id="popupSelectDialog006" name="popupSelectDialog006" value="${assign.roleFromType=='DYNAMIC'?assign.roleValue:''}"  class="form-control" readonly="readonly">
            		<span class="input-group-addon addon-udSelect udSelect" onclick="openpopupSelectDialog006();" id="popupSelectDialog006_button"><i class="fa fa-search"></i></span>
				</div>
			</td>
		</tr>
		<tr id="tr012">
			<td id="td223" class="tdValueCls" colspan="2" rowspan="1" style="width: 10%;text-align:left; border: 0px;">
				<div name="checkBox002_div" id="checkBox002_div" style="display: inline-table;margin-left: 40px;" >
					<input type="checkbox" class="box" name="checkBox002" id="checkBox002" value="${isSelectDep=='false'?'':'1'}"  ${isSelectDep=='false'?'':'checked'}/>
				</div>
				<label name="label0032" id="label0032" class="control-label ">
					部门
				</label>
			</td>
			<td id="td225" class="tdValueCls" colspan="16" rowspan="1" style="width: 85%; border: 0px;"></td>
		</tr>
		<tr id="tr013">
			<td id="td243" class="tdLayout" colspan="1" rowspan="3" style="width: 5%; border: 0px;"></td>
			<td id="td244" class="tdValueCls" colspan="2" rowspan="1" style="width: 10%; text-align:left;border: 0px;">
				<div id="radio009_div" style="display: inline-table;" >
					<input type="radio" class="box" name="dept" id="dept_0" value="1" ${assign.depFromType=='STATIC'?'checked':''}/>
				</div>
				<label name="label0032" id="label0032" class="control-label ">
					选定部门
				</label>
			</td>
			<td id="td246" class="tdValueCls" colspan="15" rowspan="1" style="width: 80%; border: 0px;">
				<div id="popupSelectDialog007_table" class="input-group" style="width:60%;">
					<input type="text" id="popupSelectDialog007" name="popupSelectDialog007" value="${depName}"  class="form-control" readonly="readonly">
            		<span class="input-group-addon addon-udSelect udSelect" onclick="openpopupSelectDialog007();" id="popupSelectDialog007_button"><i class="fa fa-search"></i></span>
				</div>
			</td>
		</tr>
		<tr id="tr014">
			<td id="td264" class="tdValueCls" colspan="2" rowspan="1" style="width: 10%; text-align:left;border: 0px;">
				<div id="radio010_div" style="display: inline-table;" >
					<input type="radio" class="box" name="dept" id="dept_1" value="2" ${assign.depFromType=='DYNAMIC'?'checked':''}/>
				</div>
				<label name="label0032" id="label0032" class="control-label ">
					源自变量的部门
				</label>
			</td>
			<td id="td266" class="tdValueCls" colspan="15" rowspan="1" style="width: 80%; border: 0px;">
				<div id="popupSelectDialog008_table" class="input-group" style="width:60%;">
					<input type="text" id="popupSelectDialog008" name="popupSelectDialog008" value="${assign.depFromType=='DYNAMIC'?assign.depValue:''}"  class="form-control" readonly="readonly">
            		<span class="input-group-addon addon-udSelect udSelect" onclick="openpopupSelectDialog008();" id="popupSelectDialog008_button"><i class="fa fa-search"></i></span>
				</div>
			</td>
		</tr>
		<tr id="tr015">
			<td id="td284" class="tdValueCls" colspan="2" rowspan="1" style="width: 10%; text-align:left;border: 0px;">
				<div id="radio011_div" style="display: inline-table;" >
					<input type="radio" class="box" name="dept" id="dept_2" value="3" ${assign.depFromType=='RELATION'?'checked':''}/>
				</div>
				<label name="label0032" id="label0032" class="control-label ">
					源自关联部门
				</label>
			</td>
			<td id="td286" class="tdValueCls" colspan="15" rowspan="1" style="width: 80%; border: 0px;">
				<div id="comboBox001_div" style="vertical-align: middle;">
					<select id="comboBox001" name="comboBox001" value="${assign.depFromType=='RELATION'?assign.depValue:''}" class="form-control" style="height:100%;width:60%;">
                       <option value="PROCSTARTER_DEP" ${assign.depValue == 'PROCSTARTER_DEP' ? "selected" : ""}>流程启动人员部门</option>
                       <option value="PROCSTARTER_PARENT_DEP" ${assign.depValue == 'PROCSTARTER_PARENT_DEP' ? "selected" : ""}>流程启动人员上级部门</option>
                       <option value="PROCSTARTER_ORG" ${assign.depValue == 'PROCSTARTER_ORG' ? "selected" : ""}>流程启动人员所在机构</option>
                       <option value="ACTSTARTER_DEP" ${assign.depValue == 'ACTSTARTER_DEP' ? "selected" : ""}>上一环节提交人员所在部门</option>
                       <option value="ACTSTARTER_PARENT_DEP" ${assign.depValue == 'ACTSTARTER_PARENT_DEP' ? "selected" : ""}>上一环节提交人员的上级部门</option>
                       <option value="ACTSTARTER_ORG" ${assign.depValue == 'ACTSTARTER_ORG' ? "selected" : ""}>环节启动人员所在机构</option>
                       <option value="PROCESSSTARTER_TOP_DEP" ${assign.depValue == 'PROCESSSTARTER_TOP_DEP' ? "selected" : ""}>流程启动人员一级部门</option>
                       <option value="PROCESSSTARTER_SECOND_DEP" ${assign.depValue == 'PROCESSSTARTER_SECOND_DEP' ? "selected" : ""}>流程启动人员二级部门</option>
                       <option value="ACTIVITYSTARTER_TOP_DEP" ${assign.depValue == 'ACTIVITYSTARTER_TOP_DEP' ? "selected" : ""}>上一环节提交人员的一级部门</option>
                       <option value="ACTIVITYSTARTER_SECOND_DEP" ${assign.depValue == 'ACTIVITYSTARTER_SECOND_DEP' ? "selected" : ""}>上一环节提交人员的二级部门</option>
                    </select>
				</div>
			</td>
		</tr>
		<tr id="tr017">
			<td id="td287" class="tdValueCls" colspan="2" rowspan="1" style="width: 10%;border: 0px;"></td>
			<td id="td288" class="tdValueCls" colspan="15" rowspan="1" style="width: 90%; border: 0px;text-align:left;padding-left:2px;">
				<div name="includeSubDep_div" id="includeSubDep_div" style="display: inline-table;" >
					<input type="checkbox" class="box" name="includeSubDep" id="includeSubDep" value="${includeSubDep=='false'?'':'1'}"  ${includeSubDep=='false'?'':'checked'}/>
				</div>
				<label name="label0032" id="label0032" class="control-label ">
					包含子部门
				</label>
			</td>	
		</tr>
		<tr id="tr016">
			<td id="td033" class="tdValueCls" colspan="1" rowspan="13" style="width: 5%; border: 0px;">&nbsp;</td>
			<td id="td022" class="tdValueCls" colspan="3" rowspan="1" style="width: 15%; text-align:left;border: 0px;">
				<div id="radio006_div" style="display: inline-table;" >
					<input type="radio" class="box" name="executor" id="executor_5" value="10" ${assign.assignWorkerType=='COMPONENT'?'checked':''}/>
				</div>
				<label name="label0032" id="label0032" class="control-label ">
					设置人员辅助类
				</label>
			</td>
			<td id="td285" class="tdValueCls" colspan="16" rowspan="1" style="width: 80%;border: 0px;">
				<div id="popupSelectDialog009_table" class="input-group" style="width:60%;">
					<input type="text" id="popupSelectDialog009" name="popupSelectDialog009" value="${comName}"  class="form-control" readonly="readonly">
            		<span class="input-group-addon addon-udSelect udSelect" onclick="openpopupSelectDialog009();" id="popupSelectDialog009_button"><i class="fa fa-search"></i></span>
				</div>
			</td>
		</tr>
	</table>
 </form>
</div>
</body>
</html>