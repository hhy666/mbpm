<!DOCTYPE HTML >
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.matrix.form.admin.common.utils.CommonUtil" %>
	<%  
		int currentPhase = CommonUtil.getCurPhase();

	%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>添加存储对象</title>

<jsp:include page="/form/admin/common/taglib.jsp"/>
<jsp:include page="/form/admin/common/resource.jsp"/>
<script type="text/javascript">
//主键生成策略变化 序列名
		 function keyStrategyChanged(value){
		 	var sequenceName = Matrix.getMatrixComponentById('sequenceName');
		 	var seqNameTr = document.getElementById("sequenceNameTr");
		 	if(value=='sequence'){//如果为序列 序列输入框可用
		 		//tr显示
		 		seqNameTr.style.display = "table-row";
		 		sequenceName.setDisabled(false);
		 		sequenceName.setRequired (true);
		 	}else{//其余类型不可用
		 	    sequenceName.clearValue();
		 	    sequenceName.setRequired (false);
		     	sequenceName.setDisabled(true);
		     	seqNameTr.style.display = "none";
		 	}
		 
		 }
		 
		 function  initPage(){
		 	var phase = "<%=currentPhase%>";
		 	if(phase=="1"||phase=="4"){//业务定制阶段
		 		 MtableName.setRequired (false);
		 		 MkeyStrategy.setRequired (false);
		 		 McacheType.setRequired (false);
		 		 document.getElementById("tableNameTr").style.display="none";
		 		 document.getElementById("keyStrategyTr").style.display="none";
		 		 document.getElementById("cacheTypeTr").style.display="none";
		 		
		 	     Mstate.setValue(1);//默认启用
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
	 style="position: absolute; width: 0; height: 0; z-index: -9999999999; top: 0; left: 0; display: none;"></div>
<div id="tabContainer0_div" class="matrixComponentDiv" style="width: 100%; height: 100%;; position: relative;">
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
	    	title: "添加存储对象",
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
			  	width:290,
			  	value:"${catalogNode.mid}",
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
			rowspan="1" >
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
	<tr id="j_id9" jsId="j_id9">
		<td id="j_id10" jsId="j_id10" class="maintain_form_label" colspan="1"
			rowspan="1" >
			<label id="j_id11" name="j_id11" style="margin-left: 10px"> 启用状态：</label></td>
		<td id="j_id12" jsId="j_id12" class="maintain_form_input" colspan="1" rowspan="1">
			<div id="state_div" eventProxy="MForm0" class="matrixInline" style=""></div>
		<script>
		 	var Mstate_VM=[];
		    var state=isc.SelectItem.create({
		    		ID:"Mstate",
		    		name:"state",
		    		editorType:"SelectItem",
		    		displayId:"state_div",
		    		valueMap:[],
		    		value:"${requestScope.state}",
		    		position:"relative",
		    		width:290
		    });
		    MForm0.addField(state);
		    Mstate_VM=['1','0'];
		    Mstate.displayValueMap={'1':'启用','0':'未启用'};
		    Mstate.setValueMap(Mstate_VM);
		    
		    
		   
		</script>
			
			
		</td>
	</tr>
	
	<tr id="tableNameTr" jsId="j_id14">
			<td id="j_id15" jsId="j_id15" class="maintain_form_label" colspan="1" rowspan="1" >
				<label id="j_id16" name="j_id16" style="margin-left:10px">表名：</label>
			</td>
			<td id="j_id17" jsId="j_id17" class="maintain_form_input" colspan="1" rowspan="1">
				<div id="tableName_div" eventProxy="MForm0" class="matrixInline matrixInlineIE" style=""></div>
				<script> var tableName=isc.TextItem.create({
								ID:"MtableName",
								name:"tableName",
								editorType:"TextItem",
								displayId:"tableName_div",
								position:"relative",
								width:290,
								required:true
					    });
					    MForm0.addField(tableName);
			    </script>
			    <span id="tableMultiLabel1" style="width: 29px;height:20px; color: #FF0000">*</span>
			  </td>
		</tr>
		
		<tr id="keyStrategyTr" jsId="j_id19">
			<td id="j_id20" jsId="j_id20" class="maintain_form_label" colspan="1" rowspan="1" style=" width: '20%'">
				<label id="j_id21" name="j_id21" style="margin-left:10px">主键生成策略：</label>
			</td>
		 <td id="j_id22" jsId="j_id22" class="maintain_form_input" colspan="1" rowspan="1">
			<div id="keyStrategy_div" eventProxy="MForm0" class="matrixInline" style=""></div>
			<script> 
				var MkeyStrategy_VM=[];
			    var keyStrategy=isc.SelectItem.create({
			    		ID:"MkeyStrategy",
			    		name:"keyStrategy",
			    		editorType:"SelectItem",
			    		displayId:"keyStrategy_div",
			    		valueMap:[],
			    		value:"uuid.hex",
			    		position:"relative",
			    		width:290,
			    		changed:function(form, item, value){
			    			keyStrategyChanged(value);
			    		
			    		}
			    });
			    MForm0.addField(keyStrategy);
			    MkeyStrategy_VM=['assigned','uuid.hex','increment','sequence'];
			    MkeyStrategy.displayValueMap={'assigned':'assigned','uuid.hex':'uuid.hex','increment':'increment','sequence':'sequence'};
			    MkeyStrategy.setValueMap(MkeyStrategy_VM);
			    MkeyStrategy.setValue('uuid.hex');
			  </script>
		  </td>
		</tr>
		
		<tr id="sequenceNameTr" jsId="j_id14">
			<td id="j_id15" jsId="j_id15" class="maintain_form_label" colspan="1" rowspan="1">
				<label id="j_id16" name="j_id16" style="margin-left:10px">序列名：</label>
			</td>
			<td id="j_id17" jsId="j_id17" class="maintain_form_input" colspan="1" rowspan="1">
				<div id="sequenceName_div" eventProxy="MForm0" class="matrixInline" style=""></div>
				<script> var sequenceName=isc.TextItem.create({
								ID:"MsequenceName",
								name:"sequenceName",
								editorType:"TextItem",
								displayId:"sequenceName_div",
								position:"relative",
								width:290,
								value:"${entityInfo.sequenceName}",//编码重复时返回
								disabled:'${entityInfo.keyStrategy}'!='sequence'
					    });
					    MForm0.addField(sequenceName);
			    </script>
			   
			  </td>
		</tr>
		 <script>
		    var sequTrDiv = document.getElementById("sequenceNameTr");
		    //初始值不为sequence,不用特殊处理
		    sequTrDiv.style.display = 'none';
		    var displayVal = ('${entityInfo.keyStrategy}'=='sequence')?"table-row":"none";
		 	sequTrDiv.style.display = displayVal;
		 </script>
		 
	    <tr id="cacheTypeTr" jsId="j_id14">
		<td id="j_id15" jsId="j_id15" class="maintain_form_label" colspan="1" rowspan="1" style="width: '20%'">
		<label id="j_id16" name="j_id16" style="margin-left: 10px"> 缓存类型：</label>
		</td>
		<td id="j_id17" jsId="j_id17" class="maintain_form_input" colspan="1" rowspan="1">
		<div id="cacheType_div" eventProxy="MForm0" class="matrixInline" style=""></div>
		<script>
		 	var McacheType_VM=[];
		    var cacheType=isc.SelectItem.create({
		    		ID:"McacheType",
		    		name:"cacheType",
		    		editorType:"SelectItem",
		    		displayId:"cacheType_div",
		    		valueMap:[],
		    		value:"none",
		    		position:"relative",
		    		width:290
		    });
		    MForm0.addField(cacheType);
		    McacheType_VM=['none','read-only','read-write','nonstrict-read-only'];
		    McacheType.displayValueMap={'none':'无','read-only':'只读型','read-write':'读写型','nonstrict-read-only':'非严格读写型'};
		    McacheType.setValueMap(McacheType_VM);
		    McacheType.setValue('none');
		</script></td>
	</tr>
	   <tr id="j_id4u" jsId="j_id4u">
               <td id="j_id5u" jsId="j_id5u" class="maintain_form_label" colspan="1" rowspan="1"
                      style="width: '20%'">
                     <label id="j_id6u" name="j_id6u" style="margin-left: 10px">
                         	数据源名称：
                      </label>
                </td>
                 <td id="j_id7u" jsId="j_id7u" class="maintain_form_input" colspan="1" rowspan="1">
                 <div id="dsName_div" eventProxy="MForm0" class="matrixInline" style=""></div>
		<script>
		 	var MdsName_VM=[];
		    var dsName=isc.SelectItem.create({
		    		ID:"MdsName",
		    		name:"dsName",
		    		editorType:"SelectItem",
		    		displayId:"dsName_div",
		    		valueMap:[],
		    		position:"relative",
		    		
		    		width:290,
		    		changed:function(form, item, value) {
		    				dsNameChanged(value);
		    		}
		    });
		    MForm0.addField(dsName);
		    MdsName_VM = ${requestScope.dsNameJson};
		    MdsName_VM.unshift("");
		    MdsName.displayValueMap={'':'默认'};
		    MdsName.setValueMap(MdsName_VM);
		    
		    if("${requestScope.dsName}".length>0){
		     	MdsName.setValue("${requestScope.dsName}");
		    }else{
			    var defaultDs = MdsName_VM[0];
			    if(defaultDs!=null){
			   		 MdsName.setValue(defaultDs);
		    	}
		    
		    }
		</script>
             
                                          
           </td>
        </tr>
	
	
		<tr id="j_id27" jsId="j_id27">
	  		<td id="j_id28" jsId="j_id28" class="maintain_form_label" colspan="1" rowspan="1" style="width: '20%'">
	  			<label id="j_id29" name="j_id29" style="margin-left:10px">描述：</label>
	  		</td>
	        <td id="j_id30" jsId="j_id30" class="maintain_form_input" colspan="1" rowspan="1">
	        	<div id="desc_div" eventProxy="MForm0" class="matrixInline" style=""></div>
	        	<script>
	        		 var desc=isc.TextAreaItem.create({
	        		 		ID:"Mdesc",
	        		 		name:"desc",
	        		 		editorType:"TextAreaItem",
	        		 		displayId:"desc_div",
	        		 		position:"relative",
	        		 		width:290,
	        		 		height:100
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
				width:70,
				height:"100%",
				icon:Matrix.getActionIcon("save"),
				showDisabledIcon:false,
				showDownIcon:false,
				showRollOverIcon:false
				});
				MdataFormSubmitButton.click=function(){
					Matrix.showMask();
					if(!true){Matrix.hideMask();
					return false;
				    }
				
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
	<input id="comType" type="hidden" name="comType" value="1"/>
	
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