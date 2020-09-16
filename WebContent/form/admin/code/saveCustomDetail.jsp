<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
    <!DOCTYPE HTML >
    <html>
        
        <head>
            <meta http-equiv="pragma" content="no-cache">
            <meta http-equiv="cache-control" content="no-cache">
            <meta http-equiv="expires" content="0">
            <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
            <title>
                更新自定义项!
            </title>
            <jsp:include page="/form/admin/common/taglib.jsp" />
            <jsp:include page="/form/admin/common/resource.jsp" />
            <jsp:include page="/form/admin/common/loading.jsp" />
            <script type="text/javascript">
              //选择实体
              function selectEntity(){
              	//选择实体成功后 显示值 和选项值都清空
              	MDialog0.initSrc = "<%=request.getContextPath()%>/common/common_loadCommonTreePage.action?componentType=16";
              	Matrix.showWindow('Dialog0');
              } 
              
              function getSelectedEntityId(){
                  var entityId = document.getElementById("entityId").value;
                  if(entityId!=null&&entityId.length>0){
                        var lastIndexof = entityId.lastIndexOf(".");
                        //回显全路径时需要处理
                        if(lastIndexof!=-1){
                            
                            entityId = entityId.substring(lastIndexof+1);
                            document.getElementById("entityId").value = entityId;
                        }
                        return entityId;
                  
                  }else{
                  		return null;
                  }
              }
              //选择选项值
              function selectItemValue(){
                //var entityId =  getSelectedEntityId();
              	var entityId = document.getElementById("entityId").value;
              	if(entityId!=null&&entityId.length>0){
              		var moduleId = document.getElementById("moduleId").value;
              		var entityType = document.getElementById("entityType").value;
              	
              		var url = "<%=request.getContextPath()%>/common/commonProperties_getEntityProperties.action?entityId="+entityId+"&moduleId="+moduleId+"&entityType="+entityType;
              		MDialog1.initSrc = url;
              		Matrix.showWindow("Dialog1");
              	}else{
              		parent.isc.say("请选择实体!");
              	}
              	//是否已经选择实体
              }
              
              //选择 选项显示值
              function selectItemLabel(){
              	//var entityId = getSelectedEntityId();
              	var entityId = document.getElementById("entityId").value;
              	if(entityId!=null&&entityId.length>0){
              		var moduleId = document.getElementById("moduleId").value;
              		var entityType = document.getElementById("entityType").value;
              		var url = "<%=request.getContextPath()%>/common/commonProperties_getEntityProperties.action?entityId="+entityId+"&moduleId="+moduleId+"&entityType="+entityType;
              		MDialog2.initSrc = url;
              		Matrix.showWindow("Dialog2");
              	}else{
              		parent.isc.say("请选择实体!");
              	}
              
              }
              //选实体 关闭触发
              function onDialog0Close(data, oType){
               
              	if(data!=null){
	              	var jsonObj = isc.JSON.decode(data);
              		//zr设计 parentId  comType
              		document.getElementById("moduleId").value=jsonObj.parentId;
              		document.getElementById("entityType").value=jsonObj.comType;
              		
	              	var entity = Matrix.getMatrixComponentById("entity");
	              	var itemValue = Matrix.getMatrixComponentById("itemValue");
	              	var itemLable = Matrix.getMatrixComponentById("itemLable");
	              	//记录实体设计时id
	              	var entityId = document.getElementById("entityId");
	              	var entityValue = jsonObj.proEntityType;//实体全路径
	              	entityId.value = jsonObj.proEntityType;//记录id值
	              	entity.setValue(entityValue);
	              	itemValue.clearValue();
	              	itemLable.clearValue();
	              	//将选项值 选项显示值 清空
	              	return true;
              	}
              	return true;
              }
              //选项值
              function onDialog1Close(data, oType){
              	if(data!=null){
	              	var entityId = document.getElementById("entityId").value;
	              	var proId = data.mid;
	              	var itemValue = Matrix.getMatrixComponentById("itemValue");
	              	//itemValue.setValue(entityId+"."+proId);
	              	itemValue.setValue(proId);
              		return true;
              	}
              	return true;//关闭按钮
              }
              
               //选项显示值
              function onDialog2Close(data, oType){
              	if(data!=null){
	              	var entityId = document.getElementById("entityId").value;
	              	var proId = data.mid;
	              	var itemLable = Matrix.getMatrixComponentById("itemLable");
	              	//itemLable.setValue(entityId+"."+proId);
	              	itemLable.setValue(proId);
              		return true;
              	}
              	
              	return true;
              }
              //异步提交自定义选项信息
              function asynSubmitCusDetail(){
              		var uuid = document.getElementById("UUID").value;
              
              		var entity = Matrix.getMatrixComponentById("entity").getValue();
              		var itemValue = Matrix.getMatrixComponentById("itemValue").getValue();
              		var itemLable = Matrix.getMatrixComponentById("itemLable").getValue();
              		var filter = Matrix.getMatrixComponentById("filter").getValue();
              		var isEnable = Matrix.getMatrixComponentById("isEnable").getValue();
              		
              		var data = {'data':{'UUID':uuid,'entity':entity,'itemValue':itemValue,'itemLable':itemLable,'filter':filter,'isEnable':isEnable}};
              		var url="code/customCode_asynSaveCustomDetail.action";			
                    dataSend(data,url,"POST",function(data){
						    var callbackStr = data.data;
						    var callbackJson = isc.JSON.decode(callbackStr);
						    if(callbackJson!=null&&callbackJson.message==true){
						    	// parent.parent.Matrix.forceFreshTreeNode("Tree0", "${param.parentNodeId}");
							   	 	parent.isc.say('更新自定义项成功');
						      	  
						    }else{
						    	parent.isc.say('更新失败');
						    }
						    
						    },null);   
              
              }
              
            </script>
        </head>
        
        <body>
            <div id="j_id1" jsId="j_id1" style="position: relative; _layout: flowlayout; width: 100%; height: 100%;">
                <script>
                    var MForm0 = isc.MatrixForm.create({
                        ID: "MForm0",
                        name: "MForm0",
                        position: "absolute",
                        action: "",
                        fields: [{
                            name: 'Form0_hidden_text',
                            width: 0,
                            height: 0,
                            displayId: 'Form0_hidden_text_div'
                        }]
                    });
                </script>
                <form id="Form0" name="Form0" eventProxy="MForm0" method="post" action=""
                style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
                    <input type="hidden" name="Form0" value="Form0" />
                    <!-- 用于辨别是否选择了实体 -->
                    <input type="hidden" name="entityId" id="entityId" value="${customCode.entity}"/>
                    <input type="hidden" name="moduleId" id="moduleId" />
                    <input type="hidden" name="entityType" id="entityType" />
                    
                    <input type="hidden" name="UUID" id="UUID" value="${customCode.UUID}" />
                     <input type="hidden" name="codeUUID" id="codeUUID" value="${customCode.codeUUID}" />
                    <div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div"
                    style="position: absolute; width: 0; height: 0; z-index: 0; top: 0; left: 0; display: none;">
                    </div>
                   
                
                        <table id="table1" jsId="table1" class="maintain_form_content" cellpadding="0px"
                        cellspacing="0px" style="width: 100%;margin-left: 2px;border: 1px;margin-right:20px;">
                            <tr id="j_id4" jsId="j_id4">
                                <td id="j_id5" jsId="j_id5" class="maintain_form_label" colspan="1" rowspan="1">
                                    <label id="j_id6" name="j_id6" style="margin-left: 10px">
                                        实体类型：
                                    </label>
                                </td>
                                <td id="j_id7" jsId="j_id7" colspan="1" rowspan="1" class="maintain_form_input">
                                    <div id="entity_div" eventProxy="MForm0" class="matrixInline" style="float:left;">
                                    </div>
                                    <script>
                                        var entity = isc.TextItem.create({
                                            ID: "Mentity",
                                            name: "entity",
                                            editorType: "TextItem",
                                            displayId: "entity_div",
                                            position: "relative",
                                            canEdit: false,
                                            width: 290,
                                            value: "${customCode.entity}",
                                            validators: [{
                                                type: "custom",
                                                condition: function(item, validator, value, record) {
                                                	if(value==null||value.length==0){
													  validator.errorMessage="请选择实体!";
													  return false;
													}
                                                    return Matrix.validateLength(1, 255, value);
                                                },
                                                errorMessage: "请选择实体!"
                                            }]
                                        });
                                        MForm0.addField(entity);
                                    </script>
                                    <script>
                                        isc.ImgButton.create({
                                            ID: "MEntityButton2",
                                            name: "EntityButton2",
                                            showDisabled: false,
                                            showDisabledIcon: false,
                                            showDown: false,
                                            showDownIcon: false,
                                            showRollOver: false,
                                            showRollOverIcon: false,
                                            position: "relative",
                                            width: 18,
                                            height: 18,
                                            src:Matrix.getActionIcon("query"),
                                            prompt: "添加"
                                        });
                                        MEntityButton2.click = function() {
                                            Matrix.showMask();
                                             selectEntity();
                                            Matrix.hideMask();
                                        }
                                    </script>
                                    
                            </tr>
                            <tr id="j_id45" jsId="j_id45">
                                <td id="j_id46" jsId="j_id46" class="maintain_form_label" colspan="1"
                                rowspan="1">
                                    <label id="j_id47" name="j_id47" style="margin-left: 10px">
                                        选&nbsp;项&nbsp;值：
                                    </label>
                                </td>
                                <td id="j_id48" jsId="j_id48" colspan="1" rowspan="1"class="maintain_form_input">
                                    <div id="itemValue_div" eventProxy="MForm0" class="matrixInline" style="float:left;">
                                    </div>
                                    <script>
                                        var itemValue = isc.TextItem.create({
                                            ID: "MitemValue",
                                            name: "itemValue",
                                            editorType: "TextItem",
                                            displayId: "itemValue_div",
                                            position: "relative",
                                            width: 290,
                                            canEdit: false,
                                            value: "${customCode.itemValue}",
                                            validators: [{
                                                type: "custom",
                                                condition: function(item, validator, value, record) {
                                                    //当选完服务[服务逻辑]时验证
                                                    var hasInput = true;
                                                    if(value==null||value.length==0){
													  validator.errorMessage="请选择选项值!";
													  return false;
													}
                                                    hasInput = Matrix.validateLength(1, 40, value);
                                                  
                                                    return hasInput;
                                                },
                                                errorMessage: "请选择选项值!"
                                            }]

                                        });
                                        MForm0.addField(itemValue);
                                    </script>
                                    <script>
                                        isc.ImgButton.create({
                                            ID: "MselectItemValue",
                                            name: "selectItemValue",
                                            showDisabled: false,
                                            showDisabledIcon: false,
                                            showDown: false,
                                            showDownIcon: false,
                                            showRollOver: false,
                                            showRollOverIcon: false,
                                            position: "relative",
                                            width: 18,
                                            height: 18,
                                            src: Matrix.getActionIcon("query"),
                                            prompt: "添加"
                                        });
                                        MselectItemValue.click = function() {
                                            
                                            Matrix.showMask();
                                            selectItemValue();
                                            Matrix.hideMask();
                                        }
                                    </script>
                                </td>
                               
                            </tr>
                             <tr id="j_id45" jsId="j_id45">
                                <td id="j_id46" jsId="j_id46" class="maintain_form_label" colspan="1"
                                rowspan="1">
                                    <label id="j_id47" name="j_id47" style="margin-left: 10px">
                                        选项显示值：
                                    </label>
                                </td>
                                <td id="j_id48" jsId="j_id48" colspan="1" rowspan="1" class="maintain_form_input">
                                    <div id="itemLable_div" eventProxy="MForm0" class="matrixInline" style="float:left;">
                                    </div>
                                    <script>
                                        var itemLable = isc.TextItem.create({
                                            ID: "MitemLable",
                                            name: "itemLable",
                                            editorType: "TextItem",
                                            displayId: "itemLable_div",
                                            position: "relative",
                                            width: 290,
                                            canEdit: false,
                                            value: "${customCode.itemLable}",
                                            validators: [{
                                                type: "custom",
                                                condition: function(item, validator, value, record) {
                                                    //当选完服务[服务逻辑]时验证
                                                    var hasInput = true;
                                                    if(value==null||value.length==0){
													  validator.errorMessage="请选择显示值!";
													  return false;
													}
                                                            hasInput = Matrix.validateLength(1, 40, value);
                                                    return hasInput;
                                                },
                                                errorMessage: "请选择显示值!"
                                            }]

                                        });
                                        MForm0.addField(itemLable);
                                    </script>
                                    <script>
                                        isc.ImgButton.create({
                                            ID: "MselectItemLable",
                                            name: "selectItemLable",
                                            showDisabled: false,
                                            showDisabledIcon: false,
                                            showDown: false,
                                            showDownIcon: false,
                                            showRollOver: false,
                                            showRollOverIcon: false,
                                            position: "relative",
                                            width: 18,
                                            height: 18,
                                            src:Matrix.getActionIcon("query"),
                                            prompt: "添加"
                                        });
                                        MselectItemLable.click = function() {
                                            Matrix.showMask();
                                            selectItemLabel();
                                            Matrix.hideMask();
                                        }
                                    </script>
                                </td>
                               
                            </tr>
                            <!-- 88888888888888888888888888888888888 -->
                            <tr id="j_id20" jsId="j_id20">
                                <td id="j_id10" jsId="j_id10" class="maintain_form_label" colspan="1"
                                rowspan="1">
                                    <label id="j_id11" name="j_id11" style="margin-left: 10px">
                                        查询条件：
                                    </label>
                                </td>
                                <td id="td13746607184840" jsId="td13746607184840" align="left" colspan="1"
                                rowspan="1" class="maintain_form_input">
                                    <div id="filter_div" eventProxy="MForm0" class="matrixInline" style="float:left;">
                                    </div>
                                    <script>
                                        var filter = isc.TextItem.create({
                                            ID: "Mfilter",
                                            name: "filter",
                                            editorType: "TextItem",
                                            displayId: "filter_div",
                                            position: "relative",
                                            width: 290,
                                            value: "${customCode.filter}"
                                        });
                                        MForm0.addField(filter);
                                    </script>
                                </td>
                                
                            </tr>
                            <tr id="j_id14" jsId="j_id14">
		<td id="j_id15" jsId="j_id15" class="maintain_form_label" colspan="1" rowspan="1" >
			<label id="j_id16" name="j_id16" style="margin-left: 10px"> 启用查询缓存：</label>
		</td>
		
		<td id="j_id17" jsId="j_id17" class="maintain_form_input" colspan="1" rowspan="1">
		
		<div id="isEnable_div" eventProxy="MForm0" class="matrixInline" style="float:left;"></div>
		<script>
		 	var MisEnable_VM=[];
		    var isEnable=isc.ComboBoxItem.create({
		    		ID:"MisEnable",
		    		name:"isEnable",
		    		editorType:"ComboBoxItem",
		    		displayId:"isEnable_div",
		    		valueMap:[],
		    		value:(("${customCode.isEnable}".length>0)&&("${customCode.isEnable}"!="0"))?"${customCode.isEnable}":2,
		    		position:"relative",
		    		width:290
		    });
		    MForm0.addField(isEnable);
		    MisEnable_VM=['1','2'];
		    MisEnable.displayValueMap={'1':'是','2':'否'};
		    MisEnable.setValueMap(MisEnable_VM);
		    
		    
		   
		</script></td>
	</tr>
	
                            <tr id="j_id49" jsId="j_id49">
                                <td id="j_id50" jsId="j_id50" class="maintain_form_command" colspan="2"
                                rowspan="1">
                                    <div id="dataFormSubmitButton_div" class="matrixInline matrixInlineIE" style="width: 70px; position: relative;; height: 22px;">
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
                                                icon: Matrix.getActionIcon("save"),
                                                showDisabledIcon: false,
                                                showDownIcon: false,
                                                showRollOverIcon: false
                                            });
                                            MdataFormSubmitButton.click = function() {
                                                Matrix.showMask();
                                                if (!MForm0.validate()) { //表单验证
                                                    Matrix.hideMask();
                                                    return false;
                                                }
                                               asynSubmitCusDetail();
                                                Matrix.hideMask();
                                            };
                                        </script>
                                    </div>
                                   
                                </td>
                            </tr>
                        </table>
                        <script>
               
                            isc.Window.create({
                                ID: "MDialog0",
                                id:"Dialog0",
                                name:"Dialog0",
                               targetDialog:"CodeMain",
                                autoCenter: true,
                                position: "absolute",
                                height: "350px",
                                width: "300px",
                                title: "实体选择",
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

                            MDialog0.hide();
                        </script>
                        <script>
                            function getParamsForDialog1() {
                                var params = 'iframewindowid=Dialog1&';
                                var value;
                                value = null;
                                return params;
                            }
                            isc.Window.create({
                                ID: "MDialog1",
                                id:"Dialog1",
                                name:"Dialog1",
                                targetDialog:"codeMain",
                                autoCenter: true,
                                position: "absolute",
                                height: "350px",
                                width: "500px",
                                title: "选项值选择",
                                canDragReposition: false,
                                showMinimizeButton: false,
                                showMaximizeButton: false,
                                showCloseButton: true,
                                showModalMask: false,
                                modalMaskOpacity: 0,
                                isModal: true,
                                autoDraw: false,
                                headerControls: ["headerIcon", "headerLabel", "minimizeButton", "maximizeButton", "closeButton"],
                                getParamsFun: getParamsForDialog1
                                
                            });

                            MDialog1.hide();
                        </script>
                        <script>
                            function getParamsForDialog2() {
                                var params = '&iframewindowid=Dialog2&';
                                var value;
                                value = null;
                                return params;
                            }

                            isc.Window.create({
                                ID: "MDialog2",
                                id:"Dialog2",
                                name:"Dialog2",
                                targetDialog:"codeMain",
                                autoCenter: true,
                                position: "absolute",
                                height: "350px",
                                width: "500px",
                                title: "选项显示值选择",
                                canDragReposition: false,
                                showMinimizeButton: false,
                                showMaximizeButton: false,
                                showCloseButton: true,
                                showModalMask: false,
                                modalMaskOpacity: 0,
                                isModal: true,
                                autoDraw: false,
                                headerControls: ["headerIcon", "headerLabel", "minimizeButton", "maximizeButton", "closeButton"],
                                getParamsFun: getParamsForDialog2
                            });

                            MDialog2.hide();
                        </script>
                        
                </form>
                <script>
                    MForm0.initComplete = true;
                    MForm0.redraw();
                    isc.Page.setEvent(isc.EH.RESIZE, "MForm0.redraw()", null);
                    //isc.Page.setEvent(isc.EH.LOAD,"initPage()",null);
                    
                </script>
               
        </body>
    
    </html>