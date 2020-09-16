<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.matrix.api.template.activity.ActivityTemplate,
			com.matrix.api.template.activity.AvailableTransition,
			com.matrix.client.TextUtils,
			java.util.*"%>	
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>强制完成弹出页</title>
<%
	//	String dialogId = request.getParameter("dialogId");
		List transitions = (List)request.getAttribute("transitions");
		List actTmpls = (List)request.getAttribute("actTmpls");
%>
<jsp:include page="/form/admin/common/taglib.jsp" />
<jsp:include page="/form/admin/common/resource.jsp" />

<script type="text/javascript">


	function convertSubmitData(){
		var transType = document.getElementById("transType").value;
		var transDid = MComboBox_transDid.getValue();
		var actDid  = MComboBox_actDid.getValue();
		
		var data = {transType:transType,transDid:transDid,actDid:actDid};
		Matrix.closeWindow(data);
	
	}
	//单选框变化时
	function radioChanged(value){
		var transType = document.getElementById("transType");
	
		var transByHandlerTr = document.getElementById("transByHandlerTr");
		var anyTransTr = document.getElementById("anyTransTr");
	
		if(value==1){
			transByHandlerTr.style.display="none";
			anyTransTr.style.display="none";
			transType.value="1";
		}else if(value==2){
		   	transByHandlerTr.style.display="table-row";
			anyTransTr.style.display="none";
			transType.value="2";
		}else if(value==3){
			transByHandlerTr.style.display="none";
			anyTransTr.style.display="table-row";
			transType.value="3";
		}
	}


</script>
</head>

<body>
<jsp:include page="/form/admin/common/loading.jsp" />
<div id="j_id1" jsId="j_id1"
	style="position: relative; _layout: flowlayout; width: 100%; height: 100%; overflow: auto;">
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
<form id="Form0" name="Form0" eventProxy="MForm0" method="post"
	action=""
	style="margin: 0px; height: 100%;"
	enctype="application/x-www-form-urlencoded"><input type="hidden"
	name="Form0" value="Form0" />
	
	<input id="iframewindowid" type="hidden" name="iframewindowid" value="${param.iframewindowid}" />
    <input type="hidden" id="transDid" name="transDid" >
	<input type="hidden" id="actDid" name="actDid" >
	<input type="hidden" id="transType" name="transType" value="1" >
<div type="hidden" id="Form0_hidden_text_div"
	name="Form0_hidden_text_div"
	style="position: absolute; width: 0; height: 0; z-index: -9999999999; top: 0; left: 0; display: none;">
</div>

<table id="table0css" jsId="table0css" class="maintain_form_content"
	cellpadding="0px" cellspacing="0px" style="width: 100%; height: 100%">
	<tr id="j_id2" jsId="j_id2">
		<td id="j_id3" jsId="j_id3" class="maintain_form_content" colspan="2"
			rowspan="1" style="height: 30px;">流转方式:</td>
	</tr>
	
	<tr id="j_id5" jsId="j_id5" height="100%">
		
			
		<td id="td13874300245170" jsId="td13874300245170" style="height:100%"
			class="maintain_form_input" colspan="1" rowspan="1" style="vertical-align:top">
			
		<table id="basicContent" jsId="basicContent" class="maintain_form_content">
			
			<tr id="j_id9" jsId="j_id9" >
		
				<td id="j_id12" jsId="j_id12" class="" style="text-align:left" >
					<div id="selectedType_RadioGroup0_0_div" eventProxy="MForm0">
            </div>
            <script>
                var selectedType_RadioGroup0_0 = isc.RadioItem.create({
                    ID: "MselectedType_RadioGroup0_0",
                    name: "selectedType",
                    editorType: "RadioItem",
                    displayId: "selectedType_RadioGroup0_0_div",
                    value: "1",
                    title: "根据业务流程规则进行流转",
                    position: "relative",
                    changed:function(form, item, value){
                    	radioChanged(value);
                    } ,
                    groupId: "selectedType_RadioGroup0"
                });
                MForm0.addField(selectedType_RadioGroup0_0);
            </script>
		
				</td>
		 </tr>
		<tr id="j_id9" jsId="j_id9" >
		
				<td id="j_id12" jsId="j_id12" class="" style="text-align:left" >
			 <div id="selectedType_RadioGroup0_1_div" eventProxy="MForm0">
            </div>
            <script>
                var selectedType_RadioGroup0_1 = isc.RadioItem.create({
                    ID: "MselectedType_RadioGroup0_1",
                    name: "selectedType",
                    editorType: "RadioItem",
                    displayId: "selectedType_RadioGroup0_1_div",
                    value: "2",
                    title: "手工选择设计流转路径",
                    position: "relative",
                    changed:function(form, item, value){
                    	radioChanged(value);
                    } ,
                    groupId: "selectedType_RadioGroup0"
                });
                MForm0.addField(selectedType_RadioGroup0_1);
                //表单里面看name
                MForm0.setValue("selectedType", "1");
            </script>
		
				</td>
		 </tr>	
		 <tr id="transByHandlerTr" jsId="j_id9" style="display:none" >
		
				<td id="j_id12" jsId="j_id12" class="" style="text-align:left" >
				选择下一步：
				<div id="ComboBox_transDid_div" eventProxy="MForm0" class="matrixInline" ></div>
				<script>
				 	var MComboBox_transDid_VM=[];
				    var ComboBox_transDid=isc.SelectItem.create({
				    		ID:"MComboBox_transDid",
				    		name:"ComboBox_transDid",
				    		editorType:"SelectItem",
				    		displayId:"ComboBox_transDid_div",
				    		valueMap:[],
				    		//value:"1",
				    		position:"relative",
				    		width:220
				    });
				    MForm0.addField(ComboBox_transDid);
				    var transValueMap = {};
				    
				    <%
						for(Iterator iter = transitions.iterator(); iter.hasNext();){
						AvailableTransition transition = (AvailableTransition)iter.next();
					%>
					
							 MComboBox_transDid_VM.push('<%=transition.getTdid()%>');
							 
							 transValueMap['<%=transition.getTdid()%>'] = '<%=TextUtils.displayStr(transition.getName())%>';
					<%
						}
					%>
				    
				    //MComboBox_transDid_VM=['1','0'];
				    MComboBox_transDid.displayValueMap=transValueMap;
				    
				    MComboBox_transDid.setValueMap(MComboBox_transDid_VM);
				    transValueMap = null;
				</script>
		
				</td>
		 </tr>
		 
		 <tr id="j_id91" jsId="j_id91" >
		
				<td id="j_id12" jsId="j_id12" class="" style="text-align:left" >
			 <div id="selectedType_RadioGroup0_2_div" eventProxy="MForm0">
            </div>
            <script>
                var selectedType_RadioGroup0_2 = isc.RadioItem.create({
                    ID: "MselectedType_RadioGroup0_2",
                    name: "selectedType",
                    editorType: "RadioItem",
                    displayId: "selectedType_RadioGroup0_2_div",
                    value: "3",
                    title: "任意跳转流转环节",
                    position: "relative",
                    changed:function(form, item, value){
                    	radioChanged(value);
                    } ,
                    groupId: "selectedType_RadioGroup0"
                });
                MForm0.addField(selectedType_RadioGroup0_2);
               
            </script>
		
				</td>
		 </tr>	
			
			
			<tr id="anyTransTr" jsId="anyTransTr" style="display:none" >
		
				<td id="j_id12" jsId="j_id12" class="" style="text-align:left" >
					选择下一步：
				<div id="ComboBox_actDid_div" eventProxy="MForm0" class="matrixInline" ></div>
				<script>
				 	var MComboBox_actDid_VM=[];
				    var ComboBox_actDid=isc.SelectItem.create({
				    		ID:"MComboBox_actDid",
				    		name:"ComboBox_actDid",
				    		editorType:"SelectItem",
				    		displayId:"ComboBox_actDid_div",
				    		valueMap:[],
				    		//value:"1",
				    		position:"relative",
				    		width:220
				    });
				    MForm0.addField(ComboBox_actDid);
				    var actDitValueMap ={};
				    <%
						String adid = request.getParameter("adid");
						for(Iterator iter = actTmpls.iterator(); iter.hasNext();){
							ActivityTemplate actTmpl = (ActivityTemplate)iter.next();
								if(!actTmpl.getAdid().equals(adid)){
					%>
							MComboBox_actDid_VM.push('<%=actTmpl.getAdid()%>');
							actDitValueMap['<%=actTmpl.getAdid()%>'] ='<%=TextUtils.displayStr(actTmpl.getName())%>';
										
					<%
								}
						}
					%>
				    
				    
				   
				    MComboBox_actDid.displayValueMap=actDitValueMap;
				    MComboBox_actDid.setValueMap(MComboBox_actDid_VM);
				    actDitValueMap = null;
				    
				</script>
		
				</td>
		 </tr>


		</table>
		</td>
	</tr>
	
	<tr id="j_id9" jsId="j_id9" height="20px">
		<td id="j_id10" jsId="j_id10" class="maintain_form_input" colspan="2"
			rowspan="1"><script>
                                isc.ToolStripButton.create({
                                    ID: "MToolBarItem3",
                                    icon:Matrix.getActionIcon("save"),
                                    title: "确认",
                                    
                                    showDisabledIcon: false,
                                    showDownIcon: false
                                });
                                MToolBarItem3.click = function() {
                                    Matrix.showMask();
                                   convertSubmitData();
                                    Matrix.hideMask();
                                }
                            </script> <script>
                                isc.ToolStripButton.create({
                                    ID: "MToolBarItem4",
                                    icon:Matrix.getActionIcon("exit"),
                                    title: "取消",
                                    showDisabledIcon: false,
                                    showDownIcon: false
                                });
                                MToolBarItem4.click = function() {
                                    Matrix.showMask();
                                    Matrix.closeWindow(null,0);
                                    Matrix.hideMask();
                                }
                            </script>
                            
		<div id="ToolBar0_div" style="width: 100%; overflow: hidden;"><script>
                                    isc.ToolStrip.create({
                                        ID: "MToolBar0",
                                        displayId: "ToolBar0_div",
                                        width: "100%",
                                        height: "*",
                                        position: "relative",
                                        align: "center",
                                         members: [MToolBarItem3, "separator", MToolBarItem4]
                                    });
                                    isc.Page.setEvent(isc.EH.RESIZE, "MToolBar0.resizeTo(0,0);MToolBar0.resizeTo('100%','100%');", null);
                                </script></div>
		</td>
	</tr>
</table>

	
	</form>
<script>
                MForm0.initComplete = true;
                MForm0.redraw();
                isc.Page.setEvent(isc.EH.RESIZE, "MForm0.redraw()", null);
            </script></div>
</body>

</html>
