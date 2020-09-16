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
	<title>流程管理员列表的流程管理员信息</title>
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
			var processdid = Matrix.getFormItemValue('processdid');
			var url = "<%=request.getContextPath()%>/editor/process_updateProcessAdminInfo.action?index="+index+"&processdid="+processdid;
			if(data!=null){
				Matrix.sendRequest(url,data,function(){});
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
			setTimeout('setFocus()',300);
			
			var executor  = "${admin.type.value}";
			var SelectDep = "${isSetDep}";
			var SelectRole = "${isSetRole}";
			var DepFromType = "${admin.depType}";
			var RoleFromType = "${admin.roleType}";
			if(executor=='1'){//流程启动人员
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
				
				$('#popupSelectDialog003').val('');
				$('#popupSelectDialog004').val('');
				$('#popupSelectDialog005').val('');
				$('#popupSelectDialog006').val('');
				$('#popupSelectDialog007').val('');
				
			}else if(executor=='4'){//选定人员
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
				
				$('#popupSelectDialog003').val('');
				$('#popupSelectDialog005').val('');
				$('#popupSelectDialog006').val('');
				$('#popupSelectDialog007').val('');
				$('#popupSelectDialog008').val('');
				
			}else if(executor=='5'){//源自变量的人员
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
			
				$('#popupSelectDialog004').val('');
				$('#popupSelectDialog005').val('');
				$('#popupSelectDialog006').val('');
				$('#popupSelectDialog007').val('');
				$('#popupSelectDialog008').val('');
				
			}else if(executor=='9'){//通过部门、角色进行分派
				$('#popupSelectDialog003_button').addClass('notclickn');
				$('#popupSelectDialog004_button').addClass('notclickn');
				
				$('#popupSelectDialog003').val('');
				$('#popupSelectDialog004').val('');

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
					}else if(deptDetailType=='DYNAMIC'){
						$('#popupSelectDialog007_button').addClass('notclickn');
						$('#popupSelectDialog008_button').removeClass('notclickn');
						$('#popupSelectDialog007').val('');
					}else if(deptDetailType=='RELATION'){
						$('#popupSelectDialog007_button').addClass('notclickn');
						$('#popupSelectDialog008_button').addClass('notclickn');
						$('#popupSelectDialog007').val('');
						$('#popupSelectDialog008').val('');
					}
				}else{
					$('#dept_0').iCheck('disable');  //选定部门
					$('#dept_1').iCheck('disable'); //源自变量的部门
					$('#popupSelectDialog007_button').addClass('notclickn');
					$('#popupSelectDialog008_button').addClass('notclickn');
					$('#popupSelectDialog007').val('');
					$('#popupSelectDialog008').val('');
				} 
				
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
				var deptDetailType = document.getElementsByName("dept");
				if(deptDetailType[0].checked){
					$('#popupSelectDialog007_button').removeClass('notclickn');
					$('#popupSelectDialog008_button').addClass('notclickn');
					$('#popupSelectDialog008').val()
				}else if(deptDetailType[1].checked){
					$('#popupSelectDialog007_button').addClass('notclickn');
					$('#popupSelectDialog008_button').removeClass('notclickn');
					$('#popupSelectDialog007').val('');
				}else if(deptDetailType[2].checked){
					$('#popupSelectDialog007_button').addClass('notclickn');
					$('#popupSelectDialog008_button').addClass('notclickn');
					$('#popupSelectDialog007').val('');
					$('#popupSelectDialog008').val('');
				}
				$('#checkBox002').val(1);
				window.focus();
			});
			
			//部门复选框取消选中
			$("input:checkbox[name='checkBox002']").on('ifUnchecked', function(event){
				$('#dept_0').iCheck('disable');  //选定部门
				$('#dept_1').iCheck('disable'); //源自变量的部门
				$('#popupSelectDialog007_button').addClass('notclickn');
				$('#popupSelectDialog008_button').addClass('notclickn');
				$('#popupSelectDialog007').val('');
				$('#popupSelectDialog008').val('');	
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
			      var value = $(this).val();  //1.选定部门 。2. 源自变量的部门。
			      if(value == 1){
			    	  $('#popupSelectDialog007_button').removeClass('notclickn');
					  $('#popupSelectDialog008_button').addClass('notclickn');
					  $('#popupSelectDialog008').val('');
				  }else if(value == 2){
					  $('#popupSelectDialog007_button').addClass('notclickn');
					  $('#popupSelectDialog008_button').removeClass('notclickn');
					  $('#popupSelectDialog007').val('');
			      }
			      window.focus();
			});
		}
		
		function changeStatus(){
			$("input:radio[name='executor']").on('ifChecked', function(event){
				  debugger;
			      var value = $(this).val();  
			      if(value == 1){      //流程启动人员
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
						$('#popupSelectDialog004').val('');					
						$('#popupSelectDialog003').val('');
						$('#popupSelectDialog005').val('');
						$('#popupSelectDialog006').val('');
						$('#popupSelectDialog007').val('');
						$('#popupSelectDialog008').val('');						
				  }else if(value == 4){    //选定人员
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
						
						$('#popupSelectDialog003').val('');
						$('#popupSelectDialog005').val('');
						$('#popupSelectDialog006').val('');
						$('#popupSelectDialog007').val('');
						$('#popupSelectDialog008').val('');
			      }else if(value == 5){   //源自变量人员
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
						
						$('#popupSelectDialog004').val('');
						$('#popupSelectDialog005').val('');
						$('#popupSelectDialog006').val('');
						$('#popupSelectDialog007').val('');
						$('#popupSelectDialog008').val('');
			      }else if(value == 9){   //通过部门、角色进行分派
						$('#popupSelectDialog003_button').addClass('notclickn');
						$('#popupSelectDialog004_button').addClass('notclickn');
					
						$('#popupSelectDialog003').val('');
						$('#popupSelectDialog004').val('');
					
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
							var deptDetailType = document.getElementsByName("dept");
							if(deptDetailType[0].checked){
								$('#popupSelectDialog007_button').removeClass('notclickn');
								$('#popupSelectDialog008_button').addClass('notclickn');
								$('#popupSelectDialog008').val('');							   
							}else if(deptDetailType[1].checked){
								$('#popupSelectDialog007_button').addClass('notclickn');
								$('#popupSelectDialog008_button').removeClass('notclickn');
								$('#popupSelectDialog007').val('');
							}else if(deptDetailType[2].checked){
								$('#popupSelectDialog007_button').addClass('notclickn');
								$('#popupSelectDialog008_button').addClass('notclickn');
								$('#popupSelectDialog007').val('');
								$('#popupSelectDialog008').val('');
							}
							$('#popupSelectDialog007_button').addClass('notclickn');
							$('#popupSelectDialog008_button').addClass('notclickn');
						}else{
							$('#dept_0').iCheck('disable');  //选定部门
							$('#dept_1').iCheck('disable'); //源自变量的部门
							$('#popupSelectDialog007_button').addClass('notclickn');
							$('#popupSelectDialog008_button').addClass('notclickn');
							$('#popupSelectDialog007').val('');
							$('#popupSelectDialog008').val('');
						} 
						$('#popupSelectDialog007_button').addClass('notclickn');
						$('#popupSelectDialog008_button').addClass('notclickn');
						InitIsSelectRole();
						InitIsSelectDept();
	
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
				var deptDetailType = document.getElementsByName("dept");
				if(deptDetailType[0].checked){
					$('#popupSelectDialog007_button').removeClass('notclickn');
					$('#popupSelectDialog008_button').addClass('notclickn');
				}else if(deptDetailType[1].checked){
					$('#popupSelectDialog007_button').addClass('notclickn');
					$('#popupSelectDialog008_button').removeClass('notclickn');
				}else if(deptDetailType[2].checked){
					$('#popupSelectDialog007_button').addClass('notclickn');
					$('#popupSelectDialog008_button').addClass('notclickn');
				}
			}else if(isSelectDep == ''|| isSelectDep=='undefined'){
				$('#dept_0').iCheck('disable');  //选定部门
				$('#dept_1').iCheck('disable'); //源自变量的部门
				$('#popupSelectDialog007_button').addClass('notclickn');
				$('#popupSelectDialog008_button').addClass('notclickn');
			} 
		}
		
		//打开选择人员窗口
		function openpopupSelectDialog004(){
			Matrix.setFormItemValue('editFlag','edit');
			parent.parent.selectUser(this);     //editFlowProMainPage.jsp弹出
		}
		
		//打开源自变量人员窗口
		function openpopupSelectDialog003(){
			Matrix.setFormItemValue('editFlag','edit');
			parent.parent.openVariables1(this);     //editFlowProMainPage.jsp弹出
		}
		
		//打开选定角色窗口
		function openpopupSelectDialog005(){
			Matrix.setFormItemValue('editFlag','edit');
			parent.parent.openRoleTree(this);     //editFlowProMainPage.jsp弹出
		}
		
		//打开源自变量角色窗口
		function openpopupSelectDialog006(){
			Matrix.setFormItemValue('editFlag','edit');
			parent.parent.openVariables2(this);     //editFlowProMainPage.jsp弹出
		}
		
		//打开选择部门窗口
		function openpopupSelectDialog007(){
			Matrix.setFormItemValue('editFlag','edit');
			parent.parent.selectDept(this);     //editFlowProMainPage.jsp弹出
		}
		
		//打开源自变量部门窗口
		function openpopupSelectDialog008(){		
			Matrix.setFormItemValue('editFlag','edit');
			parent.parent.openVariables3(this);     //editFlowProMainPage.jsp弹出	
		}
		
	</script>
</head>
<body>
<div id="j_id1" jsId="j_id1" style="position: relative; _layout: flowlayout; width: 100%; height: 100%;overflow:auto">
  <form id="form0" name="form0" eventProxy="Mform0" method="post" action="<%=request.getContextPath()%>/mobile/showUser_loadDataGridData.action"
	style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="initData" id="initData" value="" /> 
	<input type="hidden" name="editFlag" id="editFlag" />
	<input type="hidden" name="index" id="index" value="${param.index }"/>
	<input type="hidden" name="processdid" id="processdid" value="${param.processdid }"/>
	<!-- 选定人员编码 -->
	<input name="selectedUserId" id="selectedUserId" type="hidden" value="${admin.userValue }"/>
	<!-- 源自变量的人员编码 -->
	<input name="formVarUserId" id="formVarUserId" type="hidden" value="${admin.userValue }"/>
	<!-- 角色编码 -->
	<input name="roleId" id="roleId" type="hidden" value="${admin.roleValue }"/>
	<!-- 部门编码 -->
	<input name="depId" id="depId" type="hidden" value="${admin.depValue }"/>
	
	<table id="table001" class="tableLayout" style="width: 100%; border: 0px; overflow: auto;">
		<tr id="tr107" name="tr107">
			<td id="td107" name="td107" colspan="20" rowspan="1"
				style="width: 100%;"><font id="font2">流程实例管理人员</font>
			</td>
		</tr>
		<tr id="tr001">
			<td id="td001" class="tdValueCls" colspan="3" rowspan="1" style="width: 15%;border: 0px;text-align:center;">
			   <label id="label001" name="label001" id="label001" style="width:100%">名称</label>
			</td>
			<td id="td003" class="tdValueCls" colspan="17" rowspan="1" style="width: 85%; border: 0px;">
				<div id="input001_div" style="vertical-align: middle;">
					<input id="input001" name="input001" type="text" value="${admin.name}" onkeyup="changeContent();" class="form-control" style="height:100%;width:40%;"/>
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
		<tr id="tr003">
			<td id="td041" colspan="20" rowspan="1" style="width: 100%; border: 0px;text-align:left;">
				<font id="font3">人员设定</font>
			</td>
		</tr>
		<tr id="tr004">
			<td id="td061" class="tdValueCls" colspan="1" rowspan="13" style="width: 5%; border: 0px;">&nbsp;</td>
			<td id="td062" class="tdValueCls" colspan="3" rowspan="1" style="width: 15%; border: 0px;text-align:left;">
				<div id="radio001_div" style="display: inline-table;" >
					<input type="radio" class="box" name="executor" id="executor_0" value="1" ${admin.type=='PROCESSSTARTER'?'checked':''}/>
				</div>
				<label name="label0032" id="label0032" class="control-label ">
					流程启动人员
				</label>	
			</td>
			<td id="td065" class="tdValueCls" colspan="16" rowspan="1" style="width: 80%; border: 0px;"></td>
		</tr>
		<tr id="tr006">
			<td id="td102" class="tdValueCls" colspan="3" rowspan="1" style="width: 15%; border: 0px;text-align:left;">
				<div id="radio003_div" style="display: inline-table;" >
					<input type="radio" class="box" name="executor" id="executor_2" value="4" ${admin.type=='STATICUSER'?'checked':''}/>
				</div>
				<label name="label0032" id="label0032" class="control-label ">
					选定人员
				</label>
			</td>
			<td id="td105" class="tdValueCls" colspan="16" rowspan="1" style="width: 80%; border: 0px;">
				<div id="popupSelectDialog004_div" class="input-group" style="width:40%;">
					 <input type="text" id="popupSelectDialog004" name="popupSelectDialog004" value="${admin.userType=='STATIC'?userName:''}"  class="form-control" readonly="readonly">
            		 <span class="input-group-addon addon-udSelect udSelect" onclick="openpopupSelectDialog004();" id="popupSelectDialog004_button"><i class="fa fa-search"></i></span>
				</div>
			</td>
		</tr>
		<tr id="tr007">
			<td id="td122" class="tdValueCls" colspan="3" rowspan="1" style="width: 15%; border: 0px;text-align:left;">
				<div id="radio004_div" style="display: inline-table;" >
					<input type="radio" class="box" name="executor" id="executor_3" value="5" ${admin.type=='DYNAMICUSER'?'checked':''}/>
				</div>
				<label name="label0032" id="label0032" class="control-label ">
					源自变量人员
				</label>
			</td>
			<td id="td125" class="tdValueCls" colspan="16" rowspan="1" style="width: 80%; border: 0px;">
				<div id="popupSelectDialog003_div" class="input-group" style="width:40%;">
					 <input type="text" id="popupSelectDialog003" name="popupSelectDialog003" value="${admin.userType=='DYNAMIC'?admin.userValue:''}"  class="form-control" readonly="readonly">
            		 <span class="input-group-addon addon-udSelect udSelect" onclick="openpopupSelectDialog003();" id="popupSelectDialog003_button"><i class="fa fa-search"></i></span>
				</div>
			</td>
		</tr>
		<tr id="tr008">
			<td id="td142" class="tdValueCls" colspan="3" rowspan="1" style="width: 15%; border: 0px;text-align:left;">
				<div id="radio005_div" style="display: inline-table;" >
					<input type="radio" class="box" name="executor" id="executor_4" value="9" ${admin.type=='COMPLEXSETTING'?'checked':''}/>
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
					<input type="checkbox" class="box" name="checkBox001" id="checkBox001" value="${isSetRole=='false'?'':'1'}"  ${isSetRole=='false'?'':'checked'}/>
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
					<input type="radio" class="box" name="role" id="role_0" value="1" ${admin.roleType=='STATIC'?'checked':''}/>
				</div>
				<label name="label0032" id="label0032" class="control-label ">
					选定角色
				</label>	
			</td>
			<td id="td186" class="tdValueCls" colspan="15" rowspan="1" style="width: 80%; border: 0px;">
				<div id="popupSelectDialog005_div" class="input-group" style="width:40%;">
					<input type="text" id="popupSelectDialog005" name="popupSelectDialog005" value="${admin.roleType=='STATIC'?roleName:''}"  class="form-control" readonly="readonly">
            		<span class="input-group-addon addon-udSelect udSelect" onclick="openpopupSelectDialog005();" id="popupSelectDialog005_button"><i class="fa fa-search"></i></span>
				</div>
			</td>
		</tr>
		<tr id="tr011">
			<td id="td204" class="tdValueCls" colspan="2" rowspan="1" style="width: 10%; text-align:left;border: 0px;">
				<div id="radio008_div" style="display: inline-table;" >
					<input type="radio" class="box" name="role" id="role_1" value="2" ${admin.roleType=='DYNAMIC'?'checked':''}/>
				</div>
				<label name="label0032" id="label0032" class="control-label ">
					源自变量的角色
				</label>
			</td>
			<td id="td206" class="tdValueCls" colspan="15" rowspan="1" style="width: 80%; border: 0px;">
				<div id="popupSelectDialog006_table" class="input-group" style="width:40%;">
					<input type="text" id="popupSelectDialog006" name="popupSelectDialog006" value="${admin.roleType=='DYNAMIC'?roleName:''}"  class="form-control" readonly="readonly">
            		<span class="input-group-addon addon-udSelect udSelect" onclick="openpopupSelectDialog006();" id="popupSelectDialog006_button"><i class="fa fa-search"></i></span>
				</div>
			</td>
		</tr>
		<tr id="tr012">
			<td id="td223" class="tdValueCls" colspan="2" rowspan="1" style="width: 10%;text-align:left; border: 0px;">
				<div name="checkBox002_div" id="checkBox002_div" style="display: inline-table;margin-left: 40px;" >
					<input type="checkbox" class="box" name="checkBox002" id="checkBox002" value="${isSetDep=='false'?'':'1'}"  ${isSetDep=='false'?'':'checked'}/>
				</div>
				<label name="label0032" id="label0032" class="control-label ">
					部门
				</label>
			</td>
			<td id="td225" class="tdValueCls" colspan="17" rowspan="1" style="width: 85%; border: 0px;"></td>
		</tr>
		<tr id="tr013">
			<td id="td243" class="tdLayout" colspan="1" rowspan="3" style="width: 5%; border: 0px;"></td>
			<td id="td244" class="tdValueCls" colspan="2" rowspan="1" style="width: 10%; text-align:left;border: 0px;">
				<div id="radio009_div" style="display: inline-table;" >
					<input type="radio" class="box" name="dept" id="dept_0" value="1" ${admin.depType=='STATIC'?'checked':''}/>
				</div>
				<label name="label0032" id="label0032" class="control-label ">
					选定部门
				</label>
			</td>
			<td id="td246" class="tdValueCls" colspan="15" rowspan="1" style="width: 80%; border: 0px;">
				<div id="popupSelectDialog007_table" class="input-group" style="width:40%;">
					<input type="text" id="popupSelectDialog007" name="popupSelectDialog007" value="${admin.depType=='STATIC'?depName:''}"  class="form-control" readonly="readonly">
            		<span class="input-group-addon addon-udSelect udSelect" onclick="openpopupSelectDialog007();" id="popupSelectDialog007_button"><i class="fa fa-search"></i></span>
				</div>
			</td>
		</tr>
		<tr id="tr014">
			<td id="td264" class="tdValueCls" colspan="2" rowspan="1" style="width: 10%; text-align:left;border: 0px;">
				<div id="radio010_div" style="display: inline-table;" >
					<input type="radio" class="box" name="dept" id="dept_1" value="2" ${admin.depType=='DYNAMIC'?'checked':''}/>
				</div>
				<label name="label0032" id="label0032" class="control-label ">
					源自变量的部门
				</label>
			</td>
			<td id="td266" class="tdValueCls" colspan="15" rowspan="1" style="width: 80%; border: 0px;">
				<div id="popupSelectDialog008_table" class="input-group" style="width:40%;">
					<input type="text" id="popupSelectDialog008" name="popupSelectDialog008" value="${admin.depType=='DYNAMIC'?depName:''}"  class="form-control" readonly="readonly">
            		<span class="input-group-addon addon-udSelect udSelect" onclick="openpopupSelectDialog008();" id="popupSelectDialog008_button"><i class="fa fa-search"></i></span>
				</div>
			</td>
		</tr>
	</table>
 </form>
</div>
</body>
</html>