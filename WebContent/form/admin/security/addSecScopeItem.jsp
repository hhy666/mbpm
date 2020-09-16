<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML >
<html>
    
    <head>
        <meta http-equiv="pragma" content="no-cache">
        <meta http-equiv="cache-control" content="no-cache">
        <meta http-equiv="expires" content="0">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <title>
            添加范围子项
        </title>
        <SCRIPT SRC='<%=path%>/resource/html5/js/jquery.min.js'></SCRIPT>
		<SCRIPT SRC='<%=path%>/resource/html5/js/layer.min.js'></SCRIPT>
       <jsp:include page="/form/admin/common/taglib.jsp"/>
	   <jsp:include page="/form/admin/common/resource.jsp"/>
	   <!-- 显示组件仅显示编码，对应隐藏域存储所选择的组件值 -->
        <script type="text/javascript">
        	var windowId = this;
        
	        // '1': '人员',
	        // '2': '角色',
	        // '3': '部门',
	        //'4': '岗位',
	        //'5': '流程节点',
        
            //提交添加的数据
        	function submitAddData(){
        	   var oType = document.getElementById('oType').value;//操作类型
    
        	   var type = Matrix.getMatrixComponentById("type").getValue();
        	   var data = null;
        	   switch(parseInt(type)){
	        	   case 0://未选择
	        	   	 parent.isc.say('请选择权限范围类型!',{width:150,height:70 });
	        	   	 return false;
	        	   break;
	        	   case 1://人员{type:,userName,userId}
	        	   	var userName = Matrix.getMatrixComponentById("userName").getValue();
	        	   	var userId = document.getElementById("userId").value;
	        	   	if(userId!=null&&userId.length>0){
	        	   		data = {'type':type,'userId':userId,'userName':userName};
	        	   	}else{
	        	   		parent.isc.say("请选择人员!",{width:150,height:70 });
	        	   		return false;
	        	   	}
	        	   break;
	        	   case 2://部门
	        	 	 var depName = Matrix.getMatrixComponentById("depName").getValue();
	        	  	 	var depId = document.getElementById("depId").value;
	        	  	 	if(depId!=null&&depId.length>0){
	        	   			data = {'type':type,'depId':depId,'depName':depName};
	        	  	 	}else{
	        	   			parent.isc.say("请选择部门!",{width:150,height:70 });
	        	   			return false;
	        	   	}
	        	   	
	        	   break;
	        	   case 3://角色
	        	   	var roleName = Matrix.getMatrixComponentById("roleName").getValue();
	        	   	var roleId = document.getElementById("roleId").value;
	        	   	
	        	   	if(roleId!=null&&roleId.length>0){
	        	   		data = {'type':type,'roleId':roleId,'roleName':roleName};
	        	   	}else{
	        	   		parent.isc.say("请选择角色!",{width:150,height:70 });
	        	   		return false;
	        	   	}
	        	   	
	        	   break;
	        	   case 4://岗位:部门+角色
	        	   		var depName = Matrix.getMatrixComponentById("depName").getValue();
	        	   		var depId = document.getElementById("depId").value;
	        	   	
	        	   		var roleName = Matrix.getMatrixComponentById("roleName").getValue();
	        	   		var roleId = document.getElementById("roleId").value;
	        	   		if(depId==null||depId.length==0){
	        	   			parent.isc.say("请选择部门!",{width:150,height:70 });
	        	   			return false;
	        	   		}
	        	   		if(roleId==null||roleId.length==0){
	        	   			parent.isc.say("请选择角色!",{width:150,height:70 });
	        	   			return false;
	        	   		}
	        	   		
	        	   		data ={'type':type,'depName':depName,'depId':depId,'roleName':roleName,'roleId':roleId};
	        	   		
	        	   break;
	        	   case 5://流程节点
	        	   	    
	        	   		var pdId = document.getElementById("pdId").value;
	        	   		/***************/
	        	   		
						<% 
	            		int phase =(Integer)session.getAttribute("matrix_phaseId");

		            	//int phase = 4;
		            		if(phase==4){
		            	%>	
				            	var pcTemp = Matrix.getFormItemValue("pc");
			        	   		var v = pcTemp.toString();
			        	   		var str = Mpc.displayValueMap;
								for(var item in str){
									if(item==v){
										var pdName = str[item];
									}
								}
		            	<%
		            		}else{
		            	%>
		            			var pdName = Matrix.getMatrixComponentById("pdName").getValue();
		            	<%
		            		}
		            	%>
	        	   		var adName = Matrix.getMatrixComponentById("adName").getValue();
	        	   		var adId = document.getElementById("adId").value;
	        	   		
	        	   		
		        	   		if(pdId==null||pdId.length==0){
		        	   			parent.isc.say("请选择流程!",{width:150,height:70 });
		        	   			return false;
		        	   		}
		        	   		
		        	   		if(adId==null||adId.length==0){
		        	   			isc.say("请选择活动节点!",{width:150,height:70 });
		        	   			return false;
		        	   		}
	        	   		
	        	   		
	        	   		
	        	   		data ={'pc':pc,'type':type,'pdName':pdName,'pdId':pdId,'adName':adName,'adId':adId};
	        	   break;
        	   
        	   }
        	   var iframewindowid = document.getElementById('iframewindowid').value;
        	   var closeFunction = eval("parent.on"+iframewindowid+"Close");
        	   parent.layer.close(parent.layer.getFrameIndex(window.name));
        	   closeFunction(data,oType);
        	
        	}
        
        
        
        	function selectUser(){//选用户 Dialog0
        		//弹出选择用户树 
        		MDialog0.initSrc="<%=request.getContextPath()%>/common/userSelected_loadUserTreePage.action";
        		//Matrix.showWindow("Dialog0");
        		//在父父页面弹出
        		parent.parent.getWindow(windowId);
        		parent.parent.layer.open({
	        		type:2,
	        		title:['选择用户'],
	        		area:['85%','100%'],
	        		content:'<%=path%>/office/html5/select/SingleSelectPerson.jsp?iframewindowid=Dialog0'
	        	});
        	}
        
        	function selectDep(){//选部门 Dialog1 
        	      MDialog1.initSrc="<%=request.getContextPath()%>/common/depSelected_loadDepartTreePage.action?flag=false";
        		//Matrix.showWindow("Dialog1");
        		layer.open({
	        		type:2,
	        		title:['选择部门'],
	        		area:['85%','100%'],
	        		content:'<%=path%>/office/html5/select/SingleSelectDep.jsp?flag=false&iframewindowid=Dialog1'
	        	});
        	}
        	
        	function selectRole(){//选角色 Dialog2
        		MDialog2.initSrc="<%=request.getContextPath()%>/common/roleSelected_loadRoleTreePage.action";
        			//Matrix.showWindow("Dialog2");
        			layer.open({
    	        		type:2,
    	        		title:['选择角色'],
    	        		area:['85%','100%'],
    	        		content:'<%=path%>/office/html5/select/SingleSelectRole.jsp?iframewindowid=Dialog2'
    	        	});
        	}
        	
        	
        	function selectProcess(){//选流程Dialog3
        		MDialog3.initSrc="<%=request.getContextPath()%>/common/processTmpl_loadProcessTreePage.action";
        		//Matrix.showWindow("Dialog3");
        		layer.open({
	        		type:2,
	        		title:['选择流程'],
	        		area:['85%','100%'],
	        		content:'<%=path%>/common/processTmpl_loadProcessTreePage.action?&iframewindowid=Dialog3'
	        	});
        	}
        	
        	function selectActivity(){//选活动节点 Dialog4
        		var pdId = document.getElementById("pdId").value;
        		if(pdId==null||pdId.length==0){
        			isc.say("请先选择流程!",{width:150,height:70 });
        			return;
        		}
	        	MDialog4.initSrc="<%=request.getContextPath()%>/common/processTmpl_loadProcessActivitys.action?processDid="+pdId;
	        	//Matrix.showWindow("Dialog4");	
	        	layer.open({
	        		type:2,
	        		title:['选择流程环节'],
	        		area:['85%','100%'],
	        		content:'<%=path%>/common/processTmpl_loadProcessActivitys.action?processDid='+pdId+'&iframewindowid=Dialog4'
	        	});
        	}
        	
        	//选择用户 data 为 str
        	function onDialog0Close(data, oType){
        		//userName  userId
        		if(data!=null){
        			//var userJson = isc.JSON.decode(data);//{text,id}
        			var userName = Matrix.getMatrixComponentById("userName");
        			var userId = document.getElementById("userId");
        			
        			userName.setValue(data.names);
        			userId.value = data.ids;
        			return true;
        		}
        		
        	
        		return true;
        	}
        	
        	//选择部门  depId  depName
        	function onDialog1Close(data, oType){
        	    
        		//userName  userId
        		if(data!=null){
        			//var depJson = isc.JSON.decode(data);//{text,id}
        			var depName = Matrix.getMatrixComponentById("depName");
        			var depId = document.getElementById("depId");
        			
        			depName.setValue(data.names);
        			depId.value = data.ids;
        			return true;
        		}
        	}
        	
        	//选择角色 roleId  roleName
        	function onDialog2Close(data, oType){
        		//roleName  roleId
        		if(data!=null){
        			//var roleJson = isc.JSON.decode(data);//{text,id}
        			var roleName = Matrix.getMatrixComponentById("roleName");
        			var roleId = document.getElementById("roleId");
        			
        			roleName.setValue(data.names);
        			roleId.value = data.ids;
        			return true;
        		}
        	}
        	
        	//选择流程 pdId pdName
        	function onDialog3Close(data, oType){
        			//pdName  pdId
        		if(data!=null){
        			var pdJson = isc.JSON.decode(data);//{text,id}
        			var pdName = Matrix.getMatrixComponentById("pdName");
        			var pcName = Matrix.getMatrixComponentById("pc");
        			var pdId = document.getElementById("pdId");
        			if(pcName!=null){
	        			pcName.setValue(pdJson.text);
        			}
        			if(pdName!=null){
	        			pdName.setValue(pdJson.text);
        			}
        			pdId.value = pdJson.pdid;
        			return true;
        		}
        	}
        	
        	
        	//选择活动节点 adName adId
        	function onDialog4Close(data, oType){
        		//adName  adId
        		if(data!=null){
        			var adJson =data;//{text,id}
        			var adName = Matrix.getMatrixComponentById("adName");
        			var adId = document.getElementById("adId");
        			
        			adName.setValue(adJson.name);
        			adId.value = adJson.adid;
        			return true;
        		}
        		return true;
        	}
        	
            
            
        
        	//------------------------------------------------------
            function changeButtonByType() {
                // test type value
                var type = Matrix.getMatrixComponentById("type").value;
            }

     

            //类型：user role  depart post flowNode
            //对应选项：user role  depart  process activity
            function changeShow(type) {
               //var type = Matrix.getMatrixComponentById("type").getValue();

                //获取配置项的行id
                var user = document.getElementById("user");
                var role = document.getElementById("role");
                var depart = document.getElementById("depart");
                var process = document.getElementById("process");//流程
                var activity = document.getElementById("activity");//活动节点
                var process_admin = document.getElementById("process_admin");

                //将各个选项设置行都设置成不显示
                user.style.display = "none";
                role.style.display = "none";
                depart.style.display = "none";
                process.style.display = "none";
                activity.style.display = "none";
                process_admin.style.display = "none";

                //根据type类型来设定要显示的配置
                //类型：user role  depart post processNode
                if (type == "1") { //关联对象属性设置
                    user.style.display = "table-row";
                    //
                }  else if (type == "2") {//部门
                    depart.style.display = "table-row";
                }else if (type == "3") {
                    role.style.display = "table-row";
                } else if (type == "4") {//岗位
                   
                    depart.style.display = "table-row";
                    role.style.display = "table-row";
                    
                } else if (type == "5") {
                	<% 

	            	//int phase = 4;
	            		if(phase==4){
	            	%>	
	            		process.style.display = "none";
	            		process_admin.style.display = 'table-row';
	            	<%
	            		}else{
	            	%>
	        			process_admin.style.display = 'none';
	        			process.style.display = "table-row";
	
	            	<%
	            		}
	            	%>
                    activity.style.display = "table-row";
                }

            }

            function hideRows() {
                //获取配置项的行id
                var user = document.getElementById("user");
                var role = document.getElementById("role");
                var depart = document.getElementById("depart");
                var process = document.getElementById("process");
                var activity = document.getElementById("activity");
                var process_admin = document.getElementById("process_admin");

                //将各个选项设置行都设置成不显示
                user.style.display = "none";
                role.style.display = "none";
                depart.style.display = "none";
                //process.style.display = "none";
                <% 

            	//int phase = 4;
            		if(phase==4){
            	%>	
            		process.style.display = "none";
            		process_admin.style.display = 'table-row';
            	<%
            		}else{
            	%>
        			process_admin.style.display = 'none';
        			process.style.display = "table-row";

            	<%
            		}
            	%>
                //activity.style.display = "none";

            }
        
            
            //初始化页面
            function initPage(){
            	var opType = "${param.oType}";
            	if(opType!=null&&opType =="add"){//添加
            	     hideRows();
            	}else if(opType!=null&&opType =="update1"){//更新
            		var scopeItemType = "${secScopeItem.type}";
            		if(scopeItemType!=null){
            		 // Matrix.getMatrixComponentById("type").setValue(scopeItemType);
            	   	    changeShow(scopeItemType);
            		}
            	}
            	
            	
            	
            	
            }
        </script>
    </head>
    
    <body onload="initPage()">
       <jsp:include page="/form/admin/common/loading.jsp"/>
        <div id="j_id1" jsId="j_id1" style="position:relative;_layout:flowlayout;width:100%;height:100%; overflow:auto">
            <script>
                var MForm0 = isc.MatrixForm.create({
                    ID: "MForm0",
                    name: "MForm0",
                    position: "absolute",
                    action: "<%=request.getContextPath()%>/",
                    fields: [{
                        name: 'Form0_hidden_text',
                        width: 0,
                        height: 0,
                        displayId: 'Form0_hidden_text_div'
                    }]
                });
            </script>
  <form id="Form0" name="Form0" eventProxy="MForm0" method="post" action=""
            style="margin:0px;width:100%;height:100%;overflow:hidden;" enctype="application/x-www-form-urlencoded">
                <input type="hidden" name="Form0" value="Form0" />
                <input type="hidden" name="scopeUuid" id="scopeUuid" value="${param.scopeUuid}" />
                <input type="hidden" name="oType" id="oType" value="${param.oType}" />
                <input type="hidden" name="iframewindowid" id="iframewindowid" value="${param.iframewindowid}" />
                
                
                
                <!-- 子项中选择的 id -->
                <input type="hidden" name="userId" id="userId" value="${secScopeItem.userId}" />
                <input type="hidden" name="depId" id="depId" value="${secScopeItem.depId}" />
                <input type="hidden" name="roleId" id="roleId" value="${secScopeItem.roleId}" />
                <input type="hidden" name="pdId" id="pdId" value="${secScopeItem.pdId}" />
                <input type="hidden" name="adId" id="adId" value="${secScopeItem.adId}" />
                <input type="hidden" name="uuid" id="uuid" value="${secScopeItem.uuid}" />
                <div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div"
                style="position:absolute;width:0;height:0;z-index:-9999999999;top:0;left:0;display:none;">
                </div>
              
                <table id="j_id2" jsId="j_id2" class="maintain_form_content" style="height:100%;width:100%">
                    <tr id="j_id3" jsId="j_id3">
                        <td id="j_id4" jsId="j_id4" class="maintain_form_label" colspan="1" rowspan="1"
                        style="text-align:left;width:20%">
                            <label id="j_id5" name="j_id5" style="margin-left:10px">
                                类型：
                            </label>
                        </td>
                        <td id="j_id6" jsId="j_id6" class="maintain_form_input" colspan="1" rowspan="1">
                            <div id="type_div" eventProxy="MForm0" class="matrixInline" style="">
                            </div>
                            <script>
                                var Mtype_VM = [];
                                var type = isc.SelectItem.create({
                                    ID: "Mtype",
                                    name: "type",
                                    disabled:"",
                                    backgroundColor:"#EEEEEE",
                                    editorType: "SelectItem",
                                    displayId: "type_div",
                                    valueMap: [],
                                    value: ("${secScopeItem.type}".length==0)? "0":"${secScopeItem.type}",
                                    position: "relative",
                                    width: 300,
                                    changed:function (form, item, value){
                                    	changeShow(value);
                                    }  
                                    
                                });
                                MForm0.addField(type);
                                Mtype_VM = ['1', '2','3', '4', '5', '0'];
                                Mtype.displayValueMap = {
                                    '1': '人员',
                                    '2': '部门',
                                    '3': '角色',
                                    '4': '岗位',
                                    '5': '流程节点',
                                    '0': '---请选择类型---'
                                };
                                Mtype.setValueMap(Mtype_VM);
                                Mtype.setValue('5');
                                if(document.getElementById("oType").value=="update1"){
                                	Mtype.setValue("${secScopeItem.type}");
                                }
                                
                                
                                
                           
                            </script>
                        </td>
                    </tr>
                    <tr id="process_admin" jsid="process_admin">
                   		<td id="j_id101" jsId="j_id101" class="maintain_form_label" colspan="1"
                      	  rowspan="1" style="text-align:left;width:20%">
                            <label id="j_id102" name="j_id102" style="margin-left:10px">
                                流程：
                            </label>
                        </td>
                        <td id="j_id103" jsId="j_id103" class="maintain_form_input" colspan="1" rowspan="1">
                            <div id="pc_div" eventProxy="MForm0" class="matrixInline" style="">
                            </div>
		                    <script>
		                    var Mpc_vm = [];
		                    var pc = isc.SelectItem.create({
		                        ID: "Mpc",
		                        name: "pc",
		                        editorType: "SelectItem",
		                        displayId: "pc_div",
		                        valueMap: [],
		                        value:"",
		                        position: "relative",
		                        width: 300,
		                        changed:function pcChange(){/* 
		                        	 
		                        	 return true; 
		                        	  */
		                        	var pdId = document.getElementById("pdId");
			                        pdId.value = Matrix.getFormItemValue('pc');
		                        	
		                    	}
		                    });
		                    //alert("${pcvalue}");
		                    MForm0.addField(pc);
		                    Mpc_vm=${pcvm};
		                    Mpc.displayValueMap=${pcvalue};
		                    Mpc.setValueMap(Mpc_vm);
		                    <% 

		                	//int phase = 4;
		                		if(phase==4){
		                	%>
		                			Mpc.setValue("${temp}");
		                	<%
		                		}
		                	%>
		                    
		                    var pdId = document.getElementById("pdId");
	                        pdId.value = Matrix.getFormItemValue('pc');
                        	
		                    
		                    </script>
                    	</td>
                    </tr>
                    <tr id="user" jsId="user">
                        <td id="j_id13" jsId="j_id13" class="maintain_form_label" colspan="1"
                        rowspan="1" style="text-align:left;width:20%">
                            <label id="j_id14" name="j_id14" style="margin-left:10px">
                                人员：
                            </label>
                        </td>
                        <td id="j_id15" jsId="j_id15" class="maintain_form_input" colspan="1"
                        rowspan="1">
                            <div id="userName_div" eventProxy="MForm0" class="matrixInline" style="float:left;">
                            </div>
                            <script>
                                var userName = isc.TextItem.create({
                                    ID: "MuserName",
                                    name: "userName",
                                    editorType: "TextItem",
                                    displayId: "userName_div",
                                    position: "relative",
                                    canEdit:false,
                                    value:"${secScopeItem.userName}",
                                    width:300
                                  
                                });
                                MForm0.addField(userName);
                            </script>
                            <script>
                                //选用户按钮
                                isc.ImgButton.create({
                                    ID: "MCommandButton2",
                                    name: "CommandButton2",
                                    showDisabled: false,
                                    showDisabledIcon: false,
                                    showDown: false,
                                    showDownIcon: false,
                                    showRollOver: false,
                                    showRollOverIcon: false,
                                    position: "relative",
                                    width: 18,
                                    height: 18,
                                    src:Matrix.getActionIcon("query")
                                });
                                MCommandButton2.click = function() {
                                    Matrix.showMask();
                                      selectUser();//选用户
                                    Matrix.hideMask();
                                }
                            </script>
                            <script>
                                function getParamsForDialog0() {
                                    var params = '&';
                                    var value;
                                    return params;
                                }
                                
                                isc.Window.create({
                                    ID: "MDialog0",
                                    id:"Dialog0",
                                    name:"Dialog0",
                                    targetDialog:"SelectTreeDialog",
                                    autoCenter: true,
                                    position: "absolute",
                                    height: 400,
                                    width: 300,
                                    title: "选择要添加的人员",
                                    canDragReposition: false,
                                    showMinimizeButton: true,
                                    showMaximizeButton: true,
                                    showCloseButton: true,
                                    showModalMask: false,
                                    modalMaskOpacity: 0,
                                    isModal: true,
                                    autoDraw: false,
                                    headerControls: ["headerIcon", "headerLabel", "closeButton"]
                                });
                            </script>
                            <script>
                                MDialog0.hide();
                            </script>
                        </td>
                    </tr>
                    <tr id="depart" jsId="depart">
                        <td id="j_id19" jsId="j_id19" class="maintain_form_label" colspan="1"
                        rowspan="1" style="text-align:left;width:20%">
                            <label id="j_id20" name="j_id20" style="margin-left:10px">
                                部门：
                            </label>
                        </td>
                        <td id="j_id21" jsId="j_id21" class="maintain_form_input" colspan="1"
                        rowspan="1">
                            <div id="depName_div" eventProxy="MForm0" class="matrixInline" style="float:left;">
                            </div>
                            <script>
                                var depName = isc.TextItem.create({
                                    ID: "MdepName",
                                    name: "depName",
                                    editorType: "TextItem",
                                    displayId: "depName_div",
                                    position: "relative",
                                    value:"${secScopeItem.depName}",
                                    width:300
                                });
                                MForm0.addField(depName);
                            </script>
                            <script>
                              	//选部门按钮
                                isc.ImgButton.create({
                                    ID: "MCommandButton4",
                                    name: "CommandButton4",
                                    showDisabled: false,
                                    showDisabledIcon: false,
                                    showDown: false,
                                    showDownIcon: false,
                                    showRollOver: false,
                                    showRollOverIcon: false,
                                    position: "relative",
                                    width: 18,
                                    height: 18,
                                    src:Matrix.getActionIcon("query")
                                });
                                MCommandButton4.click = function() {
                                    Matrix.showMask();
                                     selectDep();
                                 
                                    Matrix.hideMask();
                                }
                            </script>
                            <script>
                                function getParamsForDialog1() {
                                    var params = 'iframewindowid=Dialog1&';
                                    var value;
                                    return params;
                                }
                                isc.Window.create({
                                    ID: "MDialog1",
                                    id:"Dialog1",
                                    name:"Dialog1",
                                    targetDialog:"SelectTreeDialog",
                                    autoCenter: true,
                                    position: "absolute",
                                    height: 400,
                                    width: 300,
                                    title: "选择要添加的部门",
                                    canDragReposition: false,
                                    showMinimizeButton: true,
                                    showMaximizeButton: true,
                                    showCloseButton: true,
                                    showModalMask: false,
                                    modalMaskOpacity: 0,
                                    isModal: true,
                                    autoDraw: false,
                                    headerControls: ["headerIcon", "headerLabel", "closeButton"]
                                });
                            </script>
                            <script>
                                MDialog1.hide();
                            </script>
                        </td>
                    </tr>
                    <tr id="role" jsId="role">
                        <td id="j_id16" jsId="j_id16" class="maintain_form_label" colspan="1"
                        rowspan="1" style="text-align:left;width:20%">
                            <label id="j_id17" name="j_id17" style="margin-left:10px">
                                角色：
                            </label>
                        </td>
                        <td id="j_id18" jsId="j_id18" class="maintain_form_input" colspan="1"
                        rowspan="1">
                            <div id="roleName_div" eventProxy="MForm0" class="matrixInline" style="float:left;">
                            </div>
                            <script>
                                var roleName = isc.TextItem.create({
                                    ID: "MroleName",
                                    name: "roleName",
                                    editorType: "TextItem",
                                    displayId: "roleName_div",
                                    position: "relative",
                                    canEdit:false,
                                    value:"${secScopeItem.roleName}",
                                    width:300
                                });
                                MForm0.addField(roleName);
                            </script>
                            <script>
                                //选角色
                                isc.ImgButton.create({
                                    ID: "MCommandButton3",
                                    name: "CommandButton3",
                                    showDisabled: false,
                                    showDisabledIcon: false,
                                    showDown: false,
                                    showDownIcon: false,
                                    showRollOver: false,
                                    showRollOverIcon: false,
                                    position: "relative",
                                    width: 18,
                                    height: 18,
                                      src:Matrix.getActionIcon("query")
                                });
                                MCommandButton3.click = function() {
                                    Matrix.showMask();
                                  	selectRole();
                                   
                                    Matrix.hideMask();
                                }
                            </script>
                            <script>
                                function getParamsForDialog2() {
                                    var params = 'iframewindowid=Dialog2&';
                                    var value;
                                    return params;
                                }
                                isc.Window.create({
                                    ID: "MDialog2",
                                    id:"Dialog2",
                                    name:"Dialog2",
                                    targetDialog:"SelectTreeDialog",
                                    autoCenter: true,
                                    position: "absolute",
                                    height: 400,
                                    width: 300,
                                    title: "选择要添加的角色",
                                    canDragReposition: false,
                                    showMinimizeButton: false,
                                    showMaximizeButton: false,
                                    showCloseButton: true,
                                    showModalMask: false,
                                    modalMaskOpacity: 0,
                                    isModal: true,
                                    autoDraw: false,
                                    headerControls: ["headerIcon", "headerLabel", "closeButton"]
                                });
                            </script>
                            <script>
                                MDialog2.hide();
                            </script>
                        </td>
                    </tr>
                    
                    <tr id="process" jsId="process">
                        <td id="j_id22" jsId="j_id22" class="maintain_form_label" colspan="1"
                        rowspan="1" style="text-align:left;width:20%">
                            <label id="j_id23" name="j_id23" style="margin-left:10px">
                                流程：
                            </label>
                        </td>
                        <td id="j_id24" jsId="j_id24" class="maintain_form_input" colspan="1"
                        rowspan="1">
                            <div id="pdName_div" eventProxy="MForm0" class="matrixInline" style="float:left;">
                            </div>
                            <script>
                                var pdName = isc.TextItem.create({
                                    ID: "MpdName",
                                    name: "pdName",
                                    editorType: "TextItem",
                                    displayId: "pdName_div",
                                    position: "relative",
                                    canEdit:false,
                                    value:"${secScopeItem.pdName}",
                                    width:300
                                });
                                MForm0.addField(pdName);
                            </script>
                            <script>
                            	//选流程
                                isc.ImgButton.create({
                                    ID: "MCommandButtonFlow",
                                    name: "CommandButtonFlow",
                                    showDisabled: false,
                                    showDisabledIcon: false,
                                    showDown: false,
                                    showDownIcon: false,
                                    showRollOver: false,
                                    showRollOverIcon: false,
                                    position: "relative",
                                    width: 18,
                                    height: 18,
                                       src:Matrix.getActionIcon("query")
                                });
                                MCommandButtonFlow.click = function() {
                                    Matrix.showMask();
                                    selectProcess();
                                    Matrix.hideMask();
                                }
                            </script>
                            <script>
                                function getParamsForDialog3() {
                                    var params = 'iframewindowid=Dialog3&';
                                    var value;
                                    return params;
                                }
                                isc.Window.create({
                                    ID: "MDialog3",
                                    id:"Dialog3",
                                    name:"Dialog3",
                                    targetDialog:"SelectTreeDialog",
                                    autoCenter: true,
                                    position: "absolute",
                                    height: 400,
                                    width: 300,
                                    title: "选择要添加的流程",
                                    canDragReposition: false,
                                    showMinimizeButton: false,
                                    showMaximizeButton: false,
                                    showCloseButton: true,
                                    showModalMask: false,
                                    modalMaskOpacity: 0,
                                    isModal: true,
                                    autoDraw: false,
                                    headerControls: ["headerIcon", "headerLabel", "minimizeButton", "maximizeButton", "closeButton"]
                                });
                            </script>
                            <script>
                                MDialog3.hide();
                            </script>
                        </td>
                    </tr>
                    <tr id="activity" jsId="activity">
                        <td id="j_id25" jsId="j_id25" class="maintain_form_label" colspan="1"
                        rowspan="1" style="text-align:left;width:20%">
                            <label id="j_id26" name="j_id26" style="margin-left:10px">
                                环节：
                            </label>
                        </td>
                        <td id="j_id27" jsId="j_id27" class="maintain_form_input" colspan="1"
                        rowspan="1">
                            <div id="adName_div" eventProxy="MForm0" class="matrixInline" style="float:left;">
                            </div>
                            <script>
                                var adName = isc.TextItem.create({
                                    ID: "MadName",
                                    name: "adName",
                                    editorType: "TextItem",
                                    displayId: "adName_div",
                                    position: "relative",
                                    canEdit:false,
                                    value:"${secScopeItem.adName}",
                                   	width:300
                                });
                                MForm0.addField(adName);
                            </script>
                            <script>
                                //选流程活动节点
                                isc.ImgButton.create({
                                    ID: "MCmdButtonActivity",
                                    name: "CmdButtonActivity",
                                    showDisabled: false,
                                    showDisabledIcon: false,
                                    showDown: false,
                                    showDownIcon: false,
                                    showRollOver: false,
                                    showRollOverIcon: false,
                                    position: "relative",
                                    width: 18,
                                    height: 18,
                                       src:Matrix.getActionIcon("query")
                                });
                                MCmdButtonActivity.click = function() {
                                    Matrix.showMask();
                                     selectActivity();
                                    Matrix.hideMask();
                                }
                            </script>
                            <script>
                                function getParamsForDialog4() {
                                    var params = 'iframewindowid=Dialog4&';
                                    var value;
                                    return params;
                                }
                                isc.Window.create({
                                    ID: "MDialog4",
                                    id:"Dialog4",
                                    name:"Dialog4",
                                    targetDialog:"SelectTreeDialog",
                                    autoCenter: true,
                                    position: "absolute",
                                    height: 300,
                                    width: 400,
                                    title: "选择流程环节",
                                    canDragReposition: false,
                                    showMinimizeButton: false,
                                    showMaximizeButton: false,
                                    showCloseButton: true,
                                    showModalMask: false,
                                    modalMaskOpacity: 0,
                                    isModal: true,
                                    autoDraw: false,
                                    headerControls: ["headerIcon", "headerLabel", "closeButton"]
                                });
                            </script>
                            <script>
                                MDialog4.hide();
                            </script>
                        </td>
                    </tr>
                    <tr id="j_id28" jsId="j_id28">
                    </tr>
                    <tr id="j_id29" jsId="j_id29">
                        <td id="j_id30" jsId="j_id30" class="maintain_form_command" colspan="2"
                        rowspan="1">
                            <input id="scopeValue" type="hidden" name="scopeValue" />
                            <input id="id2" type="hidden" name="id2" />
                            <div id="dataFormSubmitButton_div" class="matrixInline matrixInlineIE" style="position:relative;;width:100px;;height:22px;">
                                <script>
                                    isc.Button.create({
                                        ID: "MdataFormSubmitButton",
                                        name: "dataFormSubmitButton",
                                        title: "保存",
                                        displayId: "dataFormSubmitButton_div",
                                        position: "absolute",
                                        top: 0,
                                        left: 0,
                                        width: "100%",
                                        height: "100%",
                                        showDisabledIcon: false,
                                        showDownIcon: false,
                                        showRollOverIcon: false
                                    });
                                    MdataFormSubmitButton.click = function() {
                                        Matrix.showMask();
                                        // Matrix.closeWindow("1");
                                        submitAddData();
                                        if (!MForm0.validate()) {
                                            Matrix.hideMask();
                                            return false;
                                        }
                                   
                                      //  document.getElementById('Form0').submit();
                                        Matrix.hideMask();
                                    };
                                </script>
                            </div>
                            <div id="dataFormCancelButton_div" class="matrixInline matrixInlineIE" style="position:relative;;width:100px;;height:22px;">
                                <script>
                                    isc.Button.create({
                                        ID: "MdataFormCancelButton",
                                        name: "dataFormCancelButton",
                                        title: "关闭",
                                        displayId: "dataFormCancelButton_div",
                                        position: "absolute",
                                        top: 0,
                                        left: 0,
                                        width: "100%",
                                        height: "100%",
                                        showDisabledIcon: false,
                                        showDownIcon: false,
                                        showRollOverIcon: false
                                    });
                                    MdataFormCancelButton.click = function() {
                                        Matrix.showMask();
                                        parent.layer.close(parent.layer.getFrameIndex(window.name));
                                        Matrix.hideMask();
                                    };
                                </script>
                            </div>
                            <input id="eId" type="hidden" name="eId" />
                        </td>
                    </tr>
                </table>
            </form>
            <script>
                MForm0.initComplete = true;
                MForm0.redraw();
                isc.Page.setEvent(isc.EH.RESIZE, "MForm0.redraw()", null);
            </script>
        </div>
    </body>

</html>