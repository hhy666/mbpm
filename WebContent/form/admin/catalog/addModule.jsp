<!DOCTYPE HTML >
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.matrix.form.admin.common.utils.CommonUtil" %>
<%
	String productMode = CommonUtil.getFormUser();
	int curPhase = CommonUtil.getCurPhase();
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>添加模块</title>
<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>
<script type="text/javascript">
	function initPage(){
		//获取产品模式
		var productMode = "<%=productMode%>";
		//根据阶段值来判断
		var curPhase = "<%=curPhase%>";
		
		if("matrix"==productMode){//产品模式下 1阶段不显示逻辑和场景 3阶段不显示场景 4业务定制有
			if(curPhase=="1"||curPhase=="3"){
				var sceneDiv = document.getElementById("subItems_5_div");
				MForm0.setValue("subItems_5",null);
				sceneDiv.style.display ="none";
				return true;
			
			}
		}
		
		//流程场景行
		var flowAndSceneTr = document.getElementById("flowAndSceneTr");
		var subItemsDiv = document.getElementById("subItems_div");
		
		flowAndSceneTr.style.display ="none";
		MForm0.setValue("subItems_4","4");
		MForm0.setValue("subItems_5","5");
		subItemsDiv.style.height="25px";
		//zr规则:逻辑服务1.4阶段不显示,场景和流程只在第4阶段显示
		
		//zr逻辑服务不显示时，将实体对象覆盖displayId即可，逻辑项值会自动清空
	
		if(curPhase==4){//业务定制
		  //将实体div隐藏，将实体项显示id更改为逻辑div显示
		  subItemsDiv.style.height="50px";
		  flowAndSceneTr.style.display ="table-row";

		  MForm0.setValue("subItems_4","4");
		  MForm0.setValue("subItems_5","5");
		  
		  document.getElementById("subItemTr").style.display = "none";
		}
		
	
	}


</script>

</head>
<body onload="initPage()">
<jsp:include page="/form/admin/common/loading.jsp"/>
<div id="j_id1" jsId="j_id1"
	style="position: relative; _layout: flowlayout; width: 100%; height: 100%">
	<script> 
		var MForm0=isc.MatrixForm.create({
		ID:"MForm0",
		name:"MForm0",
		position:"absolute",
		action:"<%=request.getContextPath()%>/catalog_addSubCatalog.action",
		fields:[{
			name:'Form0_hidden_text',
			width:0,
			height:0,
			displayId:'Form0_hidden_text_div'
			}]
		});
		</script>
<form id="Form0" name="Form0" eventProxy="MForm0" method="post"
	action="<%=request.getContextPath()%>/catalog_addSubCatalog.action"
	style="margin: 0px; height: 100%;"
	enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="Form0" value="Form0" />
<div type="hidden" id="Form0_hidden_text_div"
	name="Form0_hidden_text_div"
	style="position: absolute; width: 0; height: 0; z-index: 0; top: 0; left: 0; display: none;"></div>
<div id="tabContainer0_div" class="matrixComponentDiv"
	style="width: 100%; height: 100%;; position: relative;">
	<script>
	 var MtabContainer0 = isc.TabSet.create({
		 ID:"MtabContainer0",
		 displayId:"tabContainer0_div",
		 height: "100%",
		 width: "100%",
		 position: "relative",
		 align: "center",
		 tabBarPosition: "top",
		 tabBarAlign: "left",
		 showPaneContainerEdges: false,
		 showTabPicker: true,
		 showTabScroller: true,selectedTab: 1,
		 tabBarControls : [
		 	isc.MatrixHTMLFlow.create({
		 		ID:"MtabContainer0Bar0",
		 		width:"300px",
		 		contents:"<div id='tabContainer0Bar0_div' style='text-align:right;' ></div>"
		 		})
		  ],
		  tabs: [ {
		  	title: "添加模块",
		  	pane:isc.MatrixHTMLFlow.create({
		  		ID:"MtabContainer0Panel0",
		  		width: "100%",
		  		height: "100%",
		  		overflow: "hidden",
		  		contents:"<div id='tabContainer0Panel0_div' style='width:100%;height:100%'></div>"
		  	})
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
<div id="tabContainer0Panel0_div2"
	style="width: 100%; height: 100%; overflow: hidden;"
	class="matrixInline">
<div style="text-valign: center; position: relative">
<table id="j_id3" jsId="j_id3" class="maintain_form_content">
	<tr id="j_id4" jsId="j_id4">
		<td id="j_id5" jsId="j_id5" class="maintain_form_label" colspan="1"
			rowspan="1" style="text-align: left; width: '20%'"><label
			id="j_id6" name="j_id6" style="margin-left: 10px"> 编码：</label></td>
		<td id="j_id7" jsId="j_id7" class="maintain_form_input" colspan="1"
			rowspan="1">
		<div id="mid_div" eventProxy="MForm0" class="matrixInline matrixInlineIE" style=""></div>
		<script> 
			var mid=isc.TextItem.create({
				ID:"Mmid",
				name:"mid",
				editorType:"TextItem",
				displayId:"mid_div",
				position:"relative",
				width:290,
				value:"${catalogNode.mid}",
				validators:[{
		      		    type:"custom",
		      		    condition:function(item, validator, value, record){
		      		         return catalogInputIdValidate(item, validator, value, record);
		      		         },
		      		         errorMessage:"名称不能为空!"
		      		 }]
			});
			MForm0.addField(mid);
		</script>
		<span id="MultiLabel1" style="width: 46px; height: 20px; color: #FF0000">*</span>
		<span id="idEchoMessage"
			style="color: #FF0000">${idEchoMessage}</span></td>
	</tr>
	<tr id="j_id9" jsId="j_id9">
		<td id="j_id10" jsId="j_id10" class="maintain_form_label" colspan="1"
			rowspan="1" style="text-align: left; width: '20%'"><label
			id="j_id11" name="j_id11" style="margin-left: 10px"> 名称：</label></td>
		<td id="j_id12" jsId="j_id12" class="maintain_form_input" colspan="1"
			rowspan="1">
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
		<span id="MultiLabel0" style="width: 50px; height: 20px; color: #FF0000"> *</span>
		<span id="nameEchoMessage"
			style="color: #FF0000">${requestScope.nameEchoMessage}</span></td>
	</tr>

	<tr id="subItemTr" jsId="j_id14">
		<td id="j_id15" jsId="j_id15" class="maintain_form_label" colspan="1"
			rowspan="1" style="text-align: left; width: '20%'"><label
			id="j_id16" name="j_id16" style="margin-left: 10px"> 子组件：</label></td>
			
		<td id="j_id17" jsId="j_id17" class="maintain_form_input" colspan="1" 
			rowspan="1">
			<span id="subItems_div" style="height: 56px; width: 329px;text-align:left;" >
		<table border="0" style="width: 100%; height: 100%; margin: 0px; padding: 0px; display: inline;"
			cellspacing="0" cellpadding="0">
			<tbody>
				<tr>
					<td
						style="padding-left: 2px; padding-top: 2px; border-style: none;; width: 109px;; height: 9px;">
					<div id="subItems_1_div" eventProxy="MForm0" ></div>
					<script> 
						var subItems_1=isc.CheckboxItem.create({
							   ID:"MsubItems_1",
							   name:"subItems_1",
							   editorType:"CheckboxItem",
							   displayId:"subItems_1_div",
							   value:"1",
							   valueMap:{"M_NULL":false,"1":true},
							   title:"表单",
							   position:"relative",
							   groupId:"subItems"
							  
							   
						   });
						   MForm0.addField(subItems_1);
						   MForm0.setValue("subItems_1","1");
					</script></td>
	

					<td
						style="padding-left: 2px; padding-top: 2px; border-style: none;; width: 109px;; height: 9px;">
					<div id="subItems_2_div" eventProxy="MForm0"></div>
					<script>
					   var subItems_2=isc.CheckboxItem.create({
						   	ID:"MsubItems_2",
						   	name:"subItems_2",
						   	editorType:"CheckboxItem",
						   	displayId:"subItems_2_div",
						   	value:"2",
						   	valueMap:{"M_NULL":false,"2":true},
						   	title:"逻辑服务",
						   	position:"relative",
						   	groupId:"subItems"
					   	});
					   	MForm0.addField(subItems_2);
					   	MForm0.setValue("subItems_2","2");
					  </script>
					 </td>


					<td
						style="padding-left: 2px; padding-top: 2px; border-style: none;; width: 109px;; height: 9px;">
					<div id="subItems_3_div" eventProxy="MForm0"></div>
					<script> 
						var subItems_3=isc.CheckboxItem.create({
								ID:"MsubItems_3",
								name:"subItems_3",
								editorType:"CheckboxItem",
								//displayId:("${requestScope.curPhase}"=="1"||"${requestScope.curPhase}"==4)?"subItems_2_div":"subItems_3_div",
								value:"3",
								valueMap:{"M_NULL":false,"3":true},
								title:"业务对象",
								position:"relative",
								groupId:"subItems"
							});
							var curPhase = "${requestScope.curPhase}";
							if(curPhase=="1"||curPhase=="4"){//需求分析和业务定制 
							 subItems_3.displayId = "subItems_2_div";//将逻辑服务覆盖
							}else{
							 subItems_3.displayId = "subItems_3_div";
							}
							MForm0.addField(subItems_3);
							MForm0.setValue("subItems_3","3");
						</script></td>
					<td></td>

				</tr>
				<tr id="flowAndSceneTr">

					<td style="padding-left: 2px; padding-top: 2px; border-style: none;; width: 109px;; height: 9px;">
					<div id="subItems_4_div" eventProxy="MForm0"></div>
					<script>
						 var subItems_4=isc.CheckboxItem.create({
							 	ID:"MsubItems_4",
							 	name:"subItems_4",
							 	editorType:"CheckboxItem",
							 	displayId:"subItems_4_div",
							 	value:"4",
							 	valueMap:{"M_NULL":false,"4":true},
							 	title:"协同流程",
							 	position:"relative",
							 	groupId:"subItems"
						 	});
						 	MForm0.addField(subItems_4);
						 	MForm0.setValue("subItems_4","4");
						 	</script></td>
					
					<td style="padding-left: 2px; padding-top: 2px; border-style: none;; width: 109px;; height: 9px;">
					<div id="subItems_5_div" eventProxy="MForm0"></div>
					<script> 
						var subItems_5=isc.CheckboxItem.create({
								ID:"MsubItems_5",
								name:"subItems_5",
								editorType:"CheckboxItem",
								displayId:"subItems_5_div",
								value:"5",
								valueMap:{"M_NULL":false,"5":true},
								title:"场景",
								position:"relative",
								groupId:"subItems"
							});
							MForm0.addField(subItems_5);
							MForm0.setValue("subItems_5","5");
					</script>
					</td>
				</tr>
			</tbody>
		</table>
		</span>
		</td>
	</tr>
	<tr id="j_id24" jsId="j_id24"></tr>
	<tr id="j_id25" jsId="j_id25"></tr>

	<tr id="j_id32" jsId="j_id32">
		<td id="j_id33" jsId="j_id33" class="maintain_form_label" colspan="1"
			rowspan="1" style="text-align: left; width: '20%'"><label
			id="j_id34" name="j_id34" style="margin-left: 10px"> 描述：</label></td>
		<td id="j_id35" jsId="j_id35" class="maintain_form_input" colspan="1"
			rowspan="1">
		<div id="InputTextArea0_div" eventProxy="MForm0" class="matrixInline"
			style=""></div>
		<script>
			 var desc=isc.TextAreaItem.create({
				 	ID:"MInputTextArea0",
				 	name:"desc",
				 	editorType:"TextAreaItem",
				 	displayId:"InputTextArea0_div",
				 	position:"relative",
				 	width:290,
				 	value:"${catalogNode.desc}",
				 	height:100
			 	});
			 	MForm0.addField(desc);
			 	</script>
			 	</td>
	</tr>
	<tr id="j_id36" jsId="j_id36">
		<td id="j_id37" jsId="j_id37" class="maintain_form_command"
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
				width:"100%",
				height:"100%",
				icon:Matrix.getActionIcon("save"),
				showDisabledIcon:false,
				showDownIcon:false,
				showRollOverIcon:false
			});
			MdataFormSubmitButton.click=function(){
				var flag = true;
			//var a = document.getElementById('MsubItems_4');
				var checkbox1 = MForm0.getValue("subItems_1");
				var checkbox2 = MForm0.getValue("subItems_2");
				var checkbox3 = MForm0.getValue("subItems_3");
				var checkbox4 = MForm0.getValue("subItems_4");
				var checkbox5 = MForm0.getValue("subItems_5"); 
				if(checkbox1 == 'M_NULL' && checkbox2 == 'M_NULL' && checkbox3 == 'M_NULL' && checkbox4 == 'M_NULL' ){
					//document.getElementById('checkfont').innerHTML = '请选择子组件！';
					isc.warn('至少选择一个子组件！');
					flag = false;
				}
				Matrix.showMask();
				if(!true){
					Matrix.hideMask();flag = false;
				}
				if(!MForm0.validate()){
					Matrix.hideMask(); 
				    flag = false;
			   	}
			   	if (!flag){
			   		return ;
			   	}
			Matrix.convertFormItemValue('Form0');
			document.getElementById('Form0').submit();Matrix.hideMask();
			};
			</script></div>
		</td>
	</tr>
</table>
</div>

	<input id="tenantId" type="hidden" name="tenantId" value="${catalogNode.tenantId}" />
    <input id="phase" type="hidden" name="phase" value="${catalogNode.phase}" />
	<input id="createdUser" type="hidden" name="createdUser" value="Jerry"/>
	<input id="isPublic" type="hidden" name="isPublic" value="1"/>
	<input id="parentUuid" type="hidden" name="parentUuid" value="${catalogNode.parentUuid}" />
	<input id="type" type="hidden" name="type" value="${catalogNode.type}" />
	
	<input id="createdDate" type="hidden" name="createdDate" value="${catalogNode.createdDate}" />
	
	<input id="parentId" type="hidden" name="parentId" value="${catalogNode.parentUuid}" />
	<input id="parentNodeId" type="hidden" name="parentNodeId" value="${param.parentNodeId}"/>



</div>
<script>
	document.getElementById('tabContainer0Panel0_div').appendChild(document.getElementById('tabContainer0Panel0_div2'));
</script>
<script>
	document.getElementById('tabContainer0_div').style.display='';
</script>
</form>
<script>
	MForm0.initComplete=true;MForm0.redraw();
	isc.Page.setEvent(isc.EH.RESIZE,"MForm0.redraw()",null);
</script>
</div>
<script type="text/javascript">
     


	//需要对subitems进行处理 不选则为M_NULL
   var  subItems = "${catalogNode.subItems}";
  if(subItems!=null && subItems.length>0){
     var itemValues = new Array();
    itemValues = subItems.split(","); 
   for(var j=1; j<=5;j++){
        if(itemValues.contains(j.toString())){             
               MForm0.setValue("subItems_"+j,j.toString());
            }else{
               MForm0.setValue("subItems_"+j,"M_NULL");
            }       
      }
    }

  //隐藏域值不为空时动态赋值
    
       
</script>

</body>
</html>