<!DOCTYPE HTML >
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>添加逻辑服务</title>

<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>
	<script type="text/javascript">
		//组件类型变化重写
		function comTypeChanged(value){
			var serviceNameTr = document.getElementById("serviceNameTr");
			var serviceLocationTr = document.getElementById("serviceLocationTr");
			MserviceName.setRequired(true);
			MserviceLocation.setRequired(true);
			if(value==1){//spring服务
			    serviceNameTr.style.display="table-row";
			    serviceLocationTr.style.display="table-row";
			}else if(value==2){//java服务
			    MserviceName.clearValue();
			    serviceNameTr.style.display="none";
			     MserviceName.setRequired(false);
			    serviceLocationTr.style.display="table-row";
			}else{
			    MserviceName.clearValue();
			    MserviceLocation.clearValue();
			    //脚本类型时不验证
			    MserviceName.setRequired(false);
			    MserviceLocation.setRequired(false);
			    serviceNameTr.style.display="none";
			    serviceLocationTr.style.display="none";
			}
		}
		
		//初始页面
		function initPage(){
			var comType = "${catalogNode.comType}";
			if(comType!=null){
				var serviceNameTr = document.getElementById("serviceNameTr");
				var serviceLocationTr = document.getElementById("serviceLocationTr");
				if("2"==comType){//java服务
					 serviceNameTr.style.display="none";
					  MserviceName.setRequired(false);
				}else if("3"==comType){//脚本逻辑
					 serviceNameTr.style.display="none";
					 serviceLocationTr.style.display="none";
					 MserviceName.setRequired(false);
			   		 MserviceLocation.setRequired(false);
				}
				
			}	
		
		}
	
	
	</script>
</head>
<body onload="initPage()">
<jsp:include page="/form/admin/common/loading.jsp"/>
<div id="j_id1" jsId="j_id1" style="position: relative; _layout: flowlayout; width: 100%; height: 100%">
<script> 
	var MForm0=isc.MatrixForm.create({
		ID:"MForm0",
		name:"MForm0",
		position:"absolute",
		action:"<%=request.getContextPath()%>/catalog_addComponent.action",
		fields:[{
			name:'Form0_hidden_text',
			width:0,height:0,
			displayId:'Form0_hidden_text_div'
		}]
	});
 </script>
<form id="Form0" name="Form0" eventProxy="MForm0" method="post"  action="<%=request.getContextPath()%>/catalog_addComponent.action"
	style="margin: 0px; height: 100%;" enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="Form0" value="Form0" />
<div type="hidden" id="Form0_hidden_text_div" name="Form0_hidden_text_div"
	 style="position: absolute; width: 0; height: 0; z-index: 0; top: 0; left: 0; display: none;"></div>

<div id="tabContainer0_div" class="matrixComponentDiv" style="width: 100%; height: 100%;; position: relative;">
<script>
	 var MtabContainer0 = isc.TabSet.create({
	 	ID:"MtabContainer0",
	 	displayId:"tabContainer0_div",
	 	height: "100%",width: "100%",
	 	position: "relative",
	 	align: "center",
	 	tabBarPosition: "top",
	 	tabBarAlign: "left",
	 	showPaneContainerEdges: false,
	 	showTabPicker: true,
	 	showTabScroller: true,
	 	selectedTab: 1,
	 	tabBarControls : [
	 		isc.MatrixHTMLFlow.create({
	 			ID:"MtabContainer0Bar0",
	 			width:"300px",
	 			contents:"<div id='tabContainer0Bar0_div' style='text-align:right;' ></div>"
	 		})
	    ],
	    tabs: [ {
	    	title: "添加逻辑服务",
	    	pane:isc.MatrixHTMLFlow.create({
	    	     ID:"MtabContainer0Panel0",
	    	     width: "100%",height: "100%",
	    	     overflow: "hidden",
	    	     contents:"<div id='tabContainer0Panel0_div' style='width:100%;height:100%'></div>"})
	    	     } ] 
	 });
	 document.getElementById('tabContainer0_div').style.display='none';
	 MtabContainer0.selectTab(0);
	 isc.Page.setEvent("load","MtabContainer0.selectTab(0);");
  </script>
 </div>
<div id="tabContainer0Bar0_div2" style="text-align: right" class="matrixInline"></div>
<script>
	document.getElementById('tabContainer0Bar0_div').appendChild(document.getElementById('tabContainer0Bar0_div2'));
</script>
<div id="tabContainer0Panel0_div2" style="width: 100%; height: 100%; overflow: hidden;" class="matrixInline">
<div style="text-valign: center; position: relative">
<table id="j_id3" jsId="j_id3" class="maintain_form_content">
	<tr id="j_id4" jsId="j_id4">
		<td id="j_id5" jsId="j_id5" class="maintain_form_label" colspan="1"
			rowspan="1" style="width: '20%'"><label
			id="j_id6" name="j_id6" style="margin-left: 10px"> 编码：</label>
		</td>
		<td id="j_id7" jsId="j_id7" class="maintain_form_input" colspan="1" rowspan="1">
		<div id="mid_div" eventProxy="MForm0" class="matrixInline matrixInlineIE" style=""></div>
		<script>
			 var mid=isc.TextItem.create({
			  	ID:"Mmid",
			  	name:"mid",
			  	editorType:"TextItem",
			  	displayId:"mid_div",
			  	position:"relative",
			  	value:"${catalogNode.mid}",
			  	width:290,
			  	validators:[{
		      		    type:"custom",
		      		    condition:function(item, validator, value, record){
		      		        return  componentIdValidate(item, validator, value, record);
		      		     },
		      		     errorMessage:"编码不能为空!"
		      		 }]
			 });
		 MForm0.addField(mid);
		</script>
		<span id="MultiLabel0" style="width: 19px; height: 20px; color: #FF0000">*</span>
		<span id="idEchoMessage"
			style="color: #FF0000">${idEchoMessage}</span>
		</td>
	</tr>
	<tr id="j_id9" jsId="j_id9">
		<td id="j_id10" jsId="j_id10" class="maintain_form_label" colspan="1"
			rowspan="1" style=" width: '20%'">
			<label id="j_id11" name="j_id11" style="margin-left: 10px"> 名称：</label></td>
		<td id="j_id12" jsId="j_id12" class="maintain_form_input" colspan="1" rowspan="1">
		<div id="name_div" eventProxy="MForm0" class="matrixInline matrixInlineIE" style=""></div>
		<script> 
			var name2=isc.TextItem.create({
				ID:"Mname",
				name:"name",
				editorType:"TextItem",
				displayId:"name_div",
				position:"relative",
				width:290,
				value:"${catalogNode.name}",
				validators:[{
		      		    	type:"custom",
		      		    	condition:function(item, validator, value, record){
		      		         	return inputNameValidate(item, validator, value, record);
		      		         },
		      		         errorMessage:"名称不能为空!"
		      		 	}]
			});
			MForm0.addField(name2);
		</script>
		<span id="MultiLabel1" style="width: 19px; height: 20px; color: #FF0000">*</span>
		<span id="nameEchoMessage"
			style="color: #FF0000">${nameEchoMessage}</span></td>
	</tr>
	<tr id="j_id14" jsId="j_id14">
		<td id="j_id15" jsId="j_id15" class="maintain_form_label" colspan="1" rowspan="1" style=" width: '20%'">
		<label id="j_id16" name="j_id16" style="margin-left: 10px"> 类型：</label>
		</td>
		<td id="j_id17" jsId="j_id17" class="maintain_form_input" colspan="1" rowspan="1">
		<div id="comType_div" eventProxy="MForm0" class="matrixInline" style=""></div>
		<script>
		 	var McomType_VM=[];
		    var comType=isc.SelectItem.create({
		    		ID:"McomType",
		    		name:"comType",
		    		editorType:"SelectItem",
		    		displayId:"comType_div",
		    		valueMap:[],
		    		value:"1",
		    		position:"relative",
		    		width:290,
			    	changed:function(form, item, value){
			    			comTypeChanged(value);
			        }
		    });
		    MForm0.addField(comType);
		    McomType_VM=['1','2','3'];
		    McomType.displayValueMap={'1':'Spring服务','2':'Java服务','3':'脚本逻辑'};
		    McomType.setValueMap(McomType_VM);
		    var comtypeValue = "${catalogNode.comType}";
		    //编码名称重复时处理
		    if(comtypeValue!=null && comtypeValue.length>0){
		        McomType.setValue(comtypeValue);
		    }else{
		       McomType.setValue('1'); 
		    }
		</script></td>
	</tr>
	<!-- 服务标识和实现类 -->
	
	<tr id="serviceNameTr" jsId="serviceNameTr">
		<td id="j_id10eN" jsId="j_id10eN" class="maintain_form_label" colspan="1"
			rowspan="1" style=" width: '20%'">
			<label id="j_id11eN" name="j_id11eN" style="margin-left: 10px"> 服务标识：</label></td>
		<td id="j_id12eN" jsId="j_id12eN" class="maintain_form_input" colspan="1" rowspan="1">
		<div id="serviceName_div" eventProxy="MForm0" class="matrixInline matrixInlineIE" style=""></div>
		<script> 
			var serviceName=isc.TextItem.create({
				ID:"MserviceName",
				name:"serviceName",
				editorType:"TextItem",
				displayId:"serviceName_div",
				position:"relative",
				width:290,
				value:"${requestScope.serviceName}",
				required:true
			});
			MForm0.addField(serviceName);
		</script>
		<span id="MultiLabelservice" style="width: 19px; height: 20px; color: #FF0000">*</span>
		<span id="serviceNameEchoMsg"
			style="color: #FF0000">${serviceNameEchoMsg}</span>
		
		</td>
	</tr>
	
	<tr id="serviceLocationTr" jsId="serviceLocationTr">
		<td id="j_id10eL" jsId="j_id10eL" class="maintain_form_label" colspan="1"
			rowspan="1" style=" width: '20%'">
			<label id="j_id11eL" name="j_id11eL" style="margin-left: 10px"> 实现类：</label></td>
		<td id="j_id12eL" jsId="j_id12eL" class="maintain_form_input" colspan="1" rowspan="1">
		<div id="serviceLocation_div" eventProxy="MForm0" class="matrixInline" style=""></div>
		<script> 
			var serviceLocation=isc.TextItem.create({
				ID:"MserviceLocation",
				name:"serviceLocation",
				editorType:"TextItem",
				displayId:"serviceLocation_div",
				position:"relative",
				width:290,
				value:"${requestScope.serviceLocation}",
				required:true
			});
			MForm0.addField(serviceLocation);
		</script>
		</td>
	</tr>
	
	
	
	<tr id="j_id20" jsId="j_id20">
		<td id="j_id21" jsId="j_id21" class="maintain_form_label" colspan="1" rowspan="1" style="width: '20%'"><label
			id="j_id22" name="j_id22" style="margin-left: 10px"> 描述：</label></td>
		<td id="j_id23" jsId="j_id23" class="maintain_form_input" colspan="1"
			rowspan="1">
		<div id="desc_div" eventProxy="MForm0" class="matrixInline" style=""></div>
		<script> 
			var desc=isc.TextAreaItem.create({
				ID:"Mdesc",
				name:"desc",
				editorType:"TextAreaItem",
				displayId:"desc_div",
				position:"relative",
				value:"${catalogNode.desc}",
				width:290
			});
			MForm0.addField(desc);
		</script>
	</td>
	</tr>
	<tr id="j_id24" jsId="j_id24"></tr>
	<tr id="j_id25" jsId="j_id25"></tr>
	<tr id="j_id26" jsId="j_id26"></tr>
	<tr id="j_id27" jsId="j_id27">
		<td id="j_id28" jsId="j_id28" class="maintain_form_command"
			colspan="2" rowspan="1">
		<div id="dataFormSubmitButton_div" class="matrixInline matrixInlineIE"
			style="position: relative;; width: 100px;; height: 22px;">
			<script>
			isc.Button.create({
				ID:"MdataFormSubmitButton",
				name:"dataFormSubmitButton",
				title:"保存",
				displayId:"dataFormSubmitButton_div",
				position:"absolute",
				top:0,left:0,
				width:"100%",height:"100%",
				icon:Matrix.getActionIcon("save"),
				showDisabledIcon:false,
				showDownIcon:false,
				showRollOverIcon:false
				});
				MdataFormSubmitButton.click=function(){
					Matrix.showMask();
				
				    if(!MForm0.validate()){Matrix.hideMask();
				    return false;
				}
				
				Matrix.convertFormItemValue('Form0');
				document.getElementById('Form0').submit();
				Matrix.hideMask();
			};
			</script></div>
		</td>
	</tr>
</table>
</div>
	<input id="tenantId" type="hidden" name="tenantId" value="${catalogNode.tenantId}" />
    <input id="phase" type="hidden" name="phase" value="${catalogNode.phase}" />
	<input id="createdUser" type="hidden" name="createdUser" value="Jerry"/>
	<input id="parentId" type="hidden" name="parentId" value="${catalogNode.parentUuid}" />
	<input id="isPublic" type="hidden" name="isPublic" value="1"/>
	<input id="type" type="hidden" name="type" value="${catalogNode.type}"/>
	
	<input id="parentNodeId" type="hidden" name="parentNodeId" value="${param.parentNodeId}"/>
	
	</div>
<script>
document.getElementById('tabContainer0Panel0_div').appendChild(document.getElementById('tabContainer0Panel0_div2'));
</script>
<script>document.getElementById('tabContainer0_div').style.display='';</script>
</form>
<script>
MForm0.initComplete=true;MForm0.redraw();isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);
</script>
</div>

</body>
</html>