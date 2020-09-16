<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML >
<html>
    
    <head>
        <meta http-equiv="pragma" content="no-cache">
        <meta http-equiv="cache-control" content="no-cache">
        <meta http-equiv="expires" content="0">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <title>
            添加权限
        </title>
       <jsp:include page="/form/admin/common/taglib.jsp"/>
	   <jsp:include page="/form/admin/common/resource.jsp"/>
	   <!-- 显示组件仅显示编码，对应隐藏域存储所选择的组件值 -->
        <script type="text/javascript">
        
	        // '1': '人员',
	        // '2': '角色',
	        // '3': '部门',
	        //'4': '岗位',
	        
        
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
	        	   
        	   
        	   }
        	   
        	  // Matrix.closeWindow(data, oType);
        	  Matrix.submitWindow("Form0");
        	 
        	
        	}
        
        
        
        	function selectUser(){//选用户 Dialog0
        		//弹出选择用户树
        		MDialog0.initSrc="<%=request.getContextPath()%>/common/userSelected_loadUserTreePage.action";
        		Matrix.showWindow("Dialog0");
        	}
        
        	function selectDep(){//选部门 Dialog1 
        	      MDialog1.initSrc="<%=request.getContextPath()%>/common/depSelected_loadDepartTreePage.action";
        		Matrix.showWindow("Dialog1");
        	}
        	
        	function selectRole(){//选角色 Dialog2
        		MDialog2.initSrc="<%=request.getContextPath()%>/common/roleSelected_loadRoleTreePage.action";
        			Matrix.showWindow("Dialog2");
        	}
        	
        	
        	//选择用户 data 为 str
        	function onDialog0Close(data, oType){
        		//userName  userId
        		if(data!=null){
        			var userJson = isc.JSON.decode(data);//{text,id}
        			var userName = Matrix.getMatrixComponentById("userName");
        			var userId = document.getElementById("userId");
        			
        			userName.setValue(userJson.text);
        			userId.value = userJson.id;
        			return true;
        		}else{       	
        			return true;
        		}
        	}
        	
        	//选择部门  depId  depName
        	function onDialog1Close(data, oType){
        	   
        		//userName  userId
        		if(data!=null){
        			var depJson = isc.JSON.decode(data);//{text,id}
        			var depName = Matrix.getMatrixComponentById("depName");
        			var depId = document.getElementById("depId");
        			
        			depName.setValue(depJson.text);
        			depId.value = depJson.id;
        			return true;
        		}else{
        			return true;
        		}
        	}
        	
        	//选择角色 roleId  roleName
        	function onDialog2Close(data, oType){
        		//roleName  roleId
        		if(data!=null){
        			var roleJson = isc.JSON.decode(data);//{text,id}
        			var roleName = Matrix.getMatrixComponentById("roleName");
        			var roleId = document.getElementById("roleId");
        			roleName.setValue(roleJson.text);
        			roleId.value = roleJson.id;
        			return true;
        		}else{
        		 	return true;
        		}
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
                //var activity = document.getElementById("activity");//活动节点

                //将各个选项设置行都设置成不显示
                user.style.display = "none";
                role.style.display = "none";
                depart.style.display = "none";
                //activity.style.display = "none";

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
                    
                }
            }

            function hideRows() {
                //获取配置项的行id
                var user = document.getElementById("user");
                var role = document.getElementById("role");
                var depart = document.getElementById("depart");

                //将各个选项设置行都设置成不显示
                user.style.display = "none";
                role.style.display = "none";
                depart.style.display = "none";

            }
            
            //初始化页面
            function initPage(){
            	var opType = "add";
            	if(opType!=null&&opType =="add"){//添加
            	     hideRows();
            	}
            
            }
        </script>
    </head>
    
    <body onload="initPage()">
       <jsp:include page="/form/admin/common/loading.jsp"/>
        <div id="j_id1" jsId="j_id1" style="position:relative;_layout:flowlayout;width:800;height:600; overflow:auto">
            <script>
                var MForm0 = isc.MatrixForm.create({
                    ID: "MForm0",
                    name: "MForm0",
                    position: "absolute",
                    action: "<%=request.getContextPath()%>/",
                    fields: [{
                        name: 'Form0_hidden_text',
                        width: 500,
                        height: 500,
                        displayId: 'Form0_hidden_text_div'
                    }]
                });
            </script>
  <form id="Form0" name="Form0" eventProxy="MForm0" method="post" action=""
            style="margin:0px;width:100%;height:100%;" enctype="application/x-www-form-urlencoded">
                <input type="hidden" name="Form0" value="Form0" />
                <input type="hidden" name="oType" id="oType" value="add" />
                
                
                <!-- 子项中选择的 id -->
                <input type="hidden" name="userId" id="userId" />
                <input type="hidden" name="depId" id="depId" />
                <input type="hidden" name="roleId" id="roleId" />
                <div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div"
                style="position:absolute;width:0;height:0;z-index:-9999999999;top:0;left:0;display:none;">
                </div>
              
                <table id="j_id2" jsId="j_id2" class="maintain_form_content">
                    <tr id="j_id3" jsId="j_id3">
                        <td id="j_id4" jsId="j_id4" class="maintain_form_label" colspan="1" rowspan="1"
                        style="text-align:center;width:20%;">
                            <label id="j_id5" name="j_id5" style="margin-left:10px">
                                类型：
                            </label>
                        </td>
                        <td id="j_id6" jsId="j_id6" class="maintain_form_input" colspan="1" rowspan="1">
                            <div id="type_div" eventProxy="MForm0" class="matrixInline" style="">
                            </div>
                            <script>
                            	//下拉框
                                var Mtype_VM = [];
                                var type = isc.SelectItem.create({
                                    ID: "Mtype",
                                    name: "type",
                                    editorType: "SelectItem",
                                    displayId: "type_div",
                                    valueMap: [],
                                    value:("${secScopeItem.type}".length==0)? "0":"${secScopeItem.type}",
                                    position: "relative",
                                    width: 180,
                                    changed:function (form, item, value){
                                    	changeShow(value);
                                    }  
                                    
                                });
                                MForm0.addField(type);
                                Mtype_VM = ['1', '2','3', '4', '0'];
                                Mtype.displayValueMap = {
                                    '1': '人员',
                                    '2': '部门',
                                    '3': '角色',
                                    '4': '岗位',
                                    '0': '---请选择类型---'
                                };
                                Mtype.setValueMap(Mtype_VM);
                               // Mtype.setValue('0');
                            </script>
                        </td>
                    </tr>
                    <tr id="user" jsId="user">
                        <td id="j_id13" jsId="j_id13" class="maintain_form_label" colspan="1"
                        rowspan="1" style="text-align:center;width:20%;">
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
                                    autoCenter: true,
                                    position: "absolute",
                                    height:"99%",
                                    width:"80%",
                                    title: "选择要添加的人员",
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
                                MDialog0.hide();
                            </script>
                        </td>
                    </tr>
                    <tr id="depart" jsId="depart">
                        <td id="j_id19" jsId="j_id19" class="maintain_form_label" colspan="1"
                        rowspan="1" style="text-align:center;width:20%;">
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
                                    canEdit:false,
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
                                    autoCenter: true,
                                    position: "absolute",
                                    height: "99%",
                                    width: "80%",
                                    title: "选择要添加的部门",
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
                                MDialog1.hide();
                            </script>
                        </td>
                    </tr>
                    <tr id="role" jsId="role">
                        <td id="j_id16" jsId="j_id16" class="maintain_form_label" colspan="1"
                        rowspan="1" style="text-align:center;width:20%;">
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
                                    autoCenter: true,
                                    position: "absolute",
                                    height: "99%",
                                    width: "80%",
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
										icon:Matrix.getActionIcon("save"),
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
										icon:Matrix.getActionIcon("exit"),
                                        showDisabledIcon: false,
                                        showDownIcon: false,
                                        showRollOverIcon: false
                                    });
                                    MdataFormCancelButton.click = function() {
                                        Matrix.showMask();
                                        Matrix.closeWindow();
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