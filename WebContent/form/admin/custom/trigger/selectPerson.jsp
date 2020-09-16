<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE HTML>
<html>
	<meta http-equiv='pragma' content='no-cache'>
	<meta http-equiv='cache-control' content='no-cache'>
	<meta http-equiv='expires' content='0'>
	<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
	<head>
		<jsp:include page="/form/admin/common/taglib.jsp"/>
		<jsp:include page="/form/admin/common/resource.jsp"/>
		<style>
#div1_div {
	position: absolute;
	bottom: 0;
	left: 0;
	height: 60px;
}
</style>
		<script>
    //*********************************************
    //文档库管理时在修改文档库权限时会涉及
    var authUser = parent.authUser;
    
    window.onload=function(){
        var addOrUpdate = Matrix.getFormItemValue('add');
        if((addOrUpdate !=null && addOrUpdate!='add')||addOrUpdate == "undefined"){
         if(authUser!=null){
           var areaName = authUser.areaName;
           var areaIds = authUser.areaIds;
           var nameArr = areaName.split("、"); 
           var id_type = areaIds.split(";");
           var items = [];
           
           for(var i = 0;i<nameArr.length;i++){
             var data = {};
             data.allName = nameArr[i];
              data.allId = (id_type[i].split(":"))[0];
              data.type= (id_type[i].split(":"))[1];
              items.add(data);
           }    
           MDataGrid002.setData(items);
          } 
       }

    }
    //*********************************************
//确认
    function complete(){
   var grid = Matrix.getComponentById("DataGrid002");
     var data = grid.getData();
     var allIds = "";
     var allNames = "";
     var datas = {};
    // var flag = true;
    //var optType = Matrix.getFormItemValue('optType');//只要有传值，则只能选用户，不传值默认混合任意选
     if(data!=null && data.length>0){
       //if(optType!=null&&optType!=""){
         for(var i = 0;i<data.length;i++){
               var dataContent = data[i];
               var allId = dataContent.allId;
               var allName = dataContent.allName;
                    if(allIds!="")
                            allIds += ";";
                            allIds += allId;
                    if(allNames!="")
                            allNames += "、";
                            allNames += allName;
            }
        /* }else{
            for(var k = 0;k<data.length;k++){
               var dataContent = data[k];
               var allId = dataContent.allId;
               var allName = dataContent.allName;
               var type = dataContent.type;
               var cont = allId+":"+type;
                    if(allIds!="")
                            allIds += ";";
                            allIds += cont;
                    if(allNames!="")
                            allNames += "、";
                            allNames += allName;
               }
            } */
		datas="{'allIds':'"+allIds;
		datas+="','allNames':'"+allNames;
		datas+="',}";
		var datas2 = isc.JSON.decode(datas);
		Matrix.closeWindow(datas2);
      }
		else{
			Matrix.warn("至少选择一项");
			return false;
		}
	}
//展开部门树节点
    function expandUser(){
      var dept = MTree001.getSelection();
   var depId= "";
	if(dept !=null &&dept.length==1){
	   for(var i=0;i<dept.length;i++){
	       var dep= dept[i];
             
	       depId= dep.entityId;
        }
	
     Matrix.setFormItemValue('depId',depId);
}if(dept !=null &&dept.length>1){
}
     var condi = Matrix.getFormItemValue('input001');
        if(typeof(condi)=="undefined"){
            Matrix.setFormItemValue('userNameCondi','');
        }
          else{
           Matrix.setFormItemValue('userNameCondi',condi);
        }
     Matrix.refreshDataGridData('DataGrid001');
   }
//部门人员查询
    function imgClick(){
     var condi = Matrix.getFormItemValue('input001');
        if(typeof(condi)=="undefined"){
          Matrix.setFormItemValue('userNameCondi','');
          }
else{
Matrix.setFormItemValue('userNameCondi',condi);
}
Matrix.refreshDataGridData('DataGrid001');
}
function addUserPre(grid0,selection1){
   var grid1 = Matrix.getComponentById("DataGrid002");
          var list = new Array();
            var grid1data = grid1.getData();
         var opt = Matrix.getFormItemValue('opt');
var selection0 = grid0.getSelection();
  if(selection0!=null && selection0.length>0){
          var newData = isc.JSON.decode(isc.JSON.encode(selection0));
          for(var i=0;i<newData.length;i++){
                var data = newData[i];
                            if(grid1data!=null && grid1data.length>0){
                    var containsFlag = false;
                    for(var j=0;j<grid1data.length;j++){
                        var olddata = grid1data[j];
                        if(olddata.allId==data.userId && olddata.type==1){
                            containsFlag = true;
                            break;
                        }
                    }
                    if(!containsFlag){
                          var org={};
                          org.allId = data.userId;
                          org.allName = data.userName;
                          org.type = 1;
                        list.add(org);
                    }
                }else{
                  var org={};
                          org.allId = data.userId;

                          org.type = 1;
                          org.allName = data.userName;         
                    list.add(org);  
                }
            }
            grid1.getData().addAll(list);
}
if(selection1 != null && selection1.length>0 && (selection0==null || selection0.length==0)){
  var newData = isc.JSON.decode(isc.JSON.encode(selection1));
          for(var i=0;i<newData.length;i++){
                var data = newData[i];
                            if(grid1data!=null && grid1data.length>0){
                    var containsFlag = false;
                             if(opt == 1){
                    for(var j=0;j<grid1data.length;j++){
                        var olddata = grid1data[j];
                                       
                        if(olddata.allId==data.entityId && olddata.type==2){
                            containsFlag = true;
                            break;
                      
                                        }
                                  }
                            }else if(opt == 3){
                                    for(var j=0;j<grid1data.length;j++){
                        var olddata = grid1data[j];
                                            if(olddata.allId==data.entityId && olddata.type==3){
                            containsFlag = true;
                            break;
                        }
                                    }
                }
                    if(!containsFlag){
var org={};
org.allId = data.entityId;
org.allName = data.text;
if(opt == 1)
org.type = 2;
if(opt == 3)
org.type = 3;
                        list.add(org);
                    }
                }else{
          var org={};
org.allId = data.entityId;
if(opt == 1)
org.type = 2;
if(opt == 3)
org.type = 3;
org.allName = data.text;         
                    list.add(org);  
                }
            }
            grid1.getData().addAll(list);
}
     
}
//增加人员
    function addUser(){
var optType = Matrix.getFormItemValue('optType');
if(optType!=null&&optType!=""){
doubleUser();
}else{
         var grid1 = Matrix.getComponentById("DataGrid002");
          var list = new Array();
            var grid1data = grid1.getData();
           var opt = Matrix.getFormItemValue('opt');
if(opt==1){
            var grid0 = Matrix.getComponentById("DataGrid001");
            var selection1 = MTree001.getSelection();
addUserPre(grid0,selection1);
}else if(opt==3){
  var grid0 = Matrix.getComponentById("DataGrid003");
  var selection1 = MTree002.getSelection();
addUserPre(grid0,selection1);
}else if(opt==4){
  var grid0 = Matrix.getComponentById("DataGrid004");
var selection0 = grid0.getSelection();
  if(selection0!=null && selection0.length>0){
          var newData = isc.JSON.decode(isc.JSON.encode(selection0));
          for(var i=0;i<newData.length;i++){
                var data = newData[i];
                            if(grid1data!=null && grid1data.length>0){
                    var containsFlag = false;
                    for(var j=0;j<grid1data.length;j++){
                        var olddata = grid1data[j];
                        if(olddata.allId==data.userId && olddata.type==1){
                            containsFlag = true;
                            break;
                        }
                    }
                    if(!containsFlag){
                          var org={};
                          org.allId = data.userId;
                          org.allName = data.userName;
                          org.type = 1;
                        list.add(org);
                    }
                }else{
                  var org={};
                          org.allId = data.userId;

                          org.type = 1;
                          org.allName = data.userName;         
                    list.add(org);  
                }
            }
            grid1.getData().addAll(list);
}
}else if(opt==5){
    var selection3 = MTree003.getSelection();
    var selection4 = MTree004.getSelection();
if(selection3!=null&&selection3.length>0&&selection4!=null&&selection4.length>0){
    var newData3 = isc.JSON.decode(isc.JSON.encode(selection3));
    var newData4 = isc.JSON.decode(isc.JSON.encode(selection4));
	var sequenceId = newData3[0].entityId;
	var roleId = newData4[0].entityId;
	var depName = newData3[0].text;
	var roleName = newData4[0].text;
	    if(grid1data!=null && grid1data.length>0){
	        var containsFlag = false;
			for(var j=0;j<grid1data.length;j++){
			var olddata = grid1data[j];
			if(olddata.type==4){
			var allId = olddata.allId;
			var p = allId.split(',');
			if(p[0]==sequenceId&&p[1]==roleId){
			containsFlag = true;
			break;
			}
			}
			}
			if(!containsFlag){
			var org={};
			org.type = 4;
			org.allId = sequenceId+","+roleId;
			org.allName = depName+" "+roleName;
                        list.add(org);
			}
			}else{
			var org={};
			org.type = 4;
			org.allId = sequenceId+","+roleId;
			org.allName = depName+" "+roleName;
                        list.add(org);
			}
	   grid1.getData().addAll(list);		
}
}
}

      
        }
//双击左边行
function doubleUser(){
   var grid1 = Matrix.getComponentById("DataGrid002");
          var list = new Array();
            var grid1data = grid1.getData();
var opt = Matrix.getFormItemValue('opt');
if(opt==1){
            var grid0 = Matrix.getComponentById("DataGrid001");
}else if(opt==3){
  var grid0 = Matrix.getComponentById("DataGrid003");
}else if(opt==4){
  var grid0 = Matrix.getComponentById("DataGrid004");
}
var selection0 = grid0.getSelection();
  if(selection0!=null && selection0.length>0){
          var newData = isc.JSON.decode(isc.JSON.encode(selection0));
          for(var i=0;i<newData.length;i++){
                var data = newData[i];
                            if(grid1data!=null && grid1data.length>0){
                    var containsFlag = false;
                    for(var j=0;j<grid1data.length;j++){
                        var olddata = grid1data[j];
                        if(olddata.allId==data.userId){
                            containsFlag = true;
                            break;
                        }
                    }
                    if(!containsFlag){
var org={};
org.allId = data.userId;
org.allName = data.userName;
org.type = 1;
                        list.add(org);
                    }
                }else{
          var org={};
org.allId = data.userId;
org.type = 1;
org.allName = data.userName;         
                    list.add(org);  
                }
            }
            grid1.getData().addAll(list);
}
}
//移除人员
    function removeUser(){
        var grid2 = Matrix.getComponentById("DataGrid002");
        var selection1 = grid2.getSelection();
        if(selection1!=null && selection1.length>0){
            grid2.removeSelectedData();
        }

    }
//下移
    function moveDown(){
		var dataGrid = Matrix.getMatrixComponentById("DataGrid002");
		if(dataGrid){
		 	if(!dataGrid.getSelection() || dataGrid.getSelection().length==0){
				isc.warn("没有数据被选中，不能执行此操作。");
				return null;
			}
			if(dataGrid.getSelection() && dataGrid.getSelection().length>1){
				isc.warn("只能选择一条数据进行下移操作!");
				return null;
			}
			var recordData = dataGrid.getData();
			var selectedRecord = dataGrid.getSelection()[0];
			var recordIndex = recordData.indexOf(selectedRecord);
			var listSize = recordData.getLength();
			if(recordIndex<listSize-1){
			    recordIndex++;
			    //获取上条数据记录
			    var afterRecord = recordData.get(recordIndex);
			    //交换数据记录，更新数据表格
			    recordData.set(recordIndex,selectedRecord);
			    recordData.set(recordIndex-1,afterRecord);
			}
		}
	}
//上移
    function moveUp(){
		var dataGrid = Matrix.getMatrixComponentById("DataGrid002");
		if(dataGrid){
		 	if(!dataGrid.getSelection() || dataGrid.getSelection().length==0){
				isc.warn("没有数据被选中，不能执行此操作。");
				return null;
			}
			if(dataGrid.getSelection() && dataGrid.getSelection().length>1){
				isc.warn("只能选择一条数据进行上移操作!");
				return null;
			}
			var recordData = dataGrid.getData();
			var selectedRecord = dataGrid.getSelection()[0];
			var recordIndex = recordData.indexOf(selectedRecord);
			var listSize = recordData.getLength();
			if(recordIndex>0){
			    recordIndex--;
			    //获取下条数据记录
			    var afterRecord = recordData.get(recordIndex);
			    //交换数据记录，更新数据表格
			    recordData.set(recordIndex,selectedRecord);
			    recordData.set(recordIndex+1,afterRecord);
			}
		}
	}
function expandUser2(){
      var roles = MTree002.getSelection();
   var role= "";
	if(roles !=null && roles.length==1){
	   for(var i=0;i<roles.length;i++){
	       var roleArr= roles[i];
           
	       role = roleArr.entityId;
        }
	
Matrix.setFormItemValue('roleId',role);
}
if(roles !=null &&roles.length>1){
}
var condi2 = Matrix.getFormItemValue('input002');
  if(typeof(condi2)=="undefined"){
            Matrix.setFormItemValue('userNameCondi2','');
        }
          else{
           Matrix.setFormItemValue('userNameCondi2',condi2);
        }

Matrix.refreshDataGridData('DataGrid003');
}
function imgClick2(){
var condi2 = Matrix.getFormItemValue('input002');
  if(typeof(condi2)=="undefined"){
          Matrix.setFormItemValue('userNameCondi2','');
          }
else{
Matrix.setFormItemValue('userNameCondi2',condi2);
}

Matrix.refreshDataGridData('DataGrid003');
}
  isc.Page.setEvent(isc.EH.KEY_PRESS,function(){
        var _key = isc.Event.getKey();
              var opt = Matrix.getFormItemValue('opt');
        if(_key=="Enter" && opt==1){
           imgClick();
        } else if(_key=="Enter" && opt==3){
           imgClick2();
        }else if(_key=="Enter" && MconditionValue==MconditionValue.form.getFocusItem() && opt==4){
          MtoolBarItem003.click();
        }
    });

</script>
	</head>
	<body>
		<div id='loading' name='loading' class='loading'>
			<script>Matrix.showLoading();</script>
		</div>

		<script> var Mform0=isc.MatrixForm.create({ID:"Mform0",name:"Mform0",position:"absolute",action:"<%=path%>/matrix.rform",canSelectText: true,fields:[{name:'form0_hidden_text',width:0,height:0,displayId:'form0_hidden_text_div'}]});</script>
		<div
			style="width: 100%; height: 100%; overflow: auto; position: relative;">
			<form id="form0" name="form0" eventProxy="Mform0" method="post"
				action="<%=path%>/matrix.rform"
				style="margin: 0px; position: relative; overflow: auto; width: 100%; height: 100%;"
				enctype="application/x-www-form-urlencoded">
				<input type="hidden" name="form0" value="form0" />
				<input type="hidden" name="is_mobile_request" />
				<input type="hidden" id="matrix_form_tid" name="matrix_form_tid"
					value="e1caada9-3ba7-439e-98fd-02d811ca9f74" />
				<input type="hidden" id="matrix_form_datagrid_form0"
					name="matrix_form_datagrid_form0" value="" />
				<div type="hidden" id="form0_hidden_text_div"
					name="form0_hidden_text_div"
					style="position: absolute; width: 0; height: 0; z-index: -9999999999; top: 0; left: 0; display: none;"></div>
				
				<table id="table001" class="tableLayout"
					style="width: 100%; height: 95%;">
					<tr id="tr001">
						<td id="td001" class="tdLayout" style="width: 250px;">
							<div id="TabContainer001_div" class="matrixComponentDiv"
								style="width: 99.9%; height: 100%; position: relative;">
								<script> var MTabContainer001 = isc.TabSet.create({ID:"MTabContainer001",displayId:"TabContainer001_div",height: "100%",width: "100%",position: "relative",align: "center",canSelectText: true,tabBarPosition: "top",tabBarAlign: "left",showPaneContainerEdges: false,showTabPicker: false,showTabScroller: false,selectedTab: 0,tabs: [ {title: "部门",autoDraw: false,canSelectText: true,click:"Matrix.setFormItemValue('opt',1);",pane:isc.MatrixHTMLFlow.create({ID:"MTabPanel001",autoDraw: false,width: "100%",height: "100%",overflow: "hidden",contents:"<div id='TabPanel001_div' style='width:100%;height:100%'></div>"})},{title: "角色",autoDraw: false,canSelectText: true,click:"Matrix.setFormItemValue('opt',3);",pane:isc.MatrixHTMLFlow.create({ID:"MTabPanel002",autoDraw: false,width: "100%",height: "100%",overflow: "hidden",contents:"<div id='TabPanel002_div' style='width:100%;height:100%'></div>"})},{title: "岗位",autoDraw: false,canSelectText: true,click:"Matrix.setFormItemValue('opt',5);",pane:isc.MatrixHTMLFlow.create({ID:"MTabPanel004",autoDraw: false,width: "100%",height: "100%",overflow: "hidden",contents:"<div id='TabPanel004_div' style='width:100%;height:100%'></div>"})},{title: "人员",autoDraw: false,canSelectText: true,click:"Matrix.setFormItemValue('opt',4);",pane:isc.MatrixHTMLFlow.create({ID:"MTabPanel003",autoDraw: false,width: "100%",height: "100%",overflow: "hidden",contents:"<div id='TabPanel003_div' style='width:100%;height:100%'></div>"})} ] });document.getElementById('TabContainer001_div').style.display='none';MTabPanel001.draw();MTabPanel002.draw();MTabPanel004.draw();MTabPanel003.draw();MTabContainer001.selectTab(1);MTabContainer001.selectTab(2);MTabContainer001.selectTab(3);MTabContainer001.selectTab(0);</script>
							</div>
							<div id="TabPanel001_div2"
								style="width: 100%; height: 100%; position: relative; overflow: hidden;"
								class="matrixInline">
								<div id="VerticalContainer001_div" class="matrixInline"
									style="width: 100%; height: 100%;; overflow: hidden;">
									<script>isc.VLayout.create({ID:"MVerticalContainer001",displayId:"VerticalContainer001_div",position: "relative",height: "100%",width: "100%",align: "center",overflow: "auto",defaultLayoutAlign: "center",members: [ isc.MatrixHTMLFlow.create({ID:"MBorderPanel001Panel1",width: "100%",height: '50%',overflow: "hidden",showResizeBar:true,contents:"<div id='BorderPanel001Panel1_div' class='matrixComponentDiv'></div>"}),isc.MatrixHTMLFlow.create({ID:"MBorderPanel001Panel2",width: "100%",overflow: "hidden",contents:"<div id='BorderPanel001Panel2_div' class='matrixComponentDiv'></div>"}) ],canSelectText: true });if(MTabPanel001)if(!MTabPanel001.customMembers)MTabPanel001.customMembers=[];MTabPanel001.customMembers.add(MVerticalContainer001);</script>
								</div>
								<div id="BorderPanel001Panel1_div2"
									style="width: 100%; height: 100%; overflow: hidden;"
									class="matrixInline">
									<table id="table002" style="width: 100%; height: 100%;">
										<tr id="tr003">
											<td id="td006" style="width: 100%; height: 5%;">
												<div id="input001_div" eventProxy="Mform0"
													class="matrixInline" style=""></div>
												<script> var input001=isc.TextItem.create({ID:"Minput001",name:"input001",editorType:"TextItem",displayId:"input001_div",position:"relative",autoDraw:false,hint:"请输入部门/人员名称",showHintInField:true});Mform0.addField(input001);</script>
												<script>isc.ImgButton.create({ID:"MimgButton001",name:"imgButton001",showDisabled:false,showDisabledIcon:false,showDown:false,showDownIcon:false,showRollOver:false,showRollOverIcon:false,position:"relative",width:18,height:18,src:"[skin]/images/matrix/actions/query.png"});MimgButton001.click=function(){Matrix.showMask();var x = eval("imgClick();");if(x!=null && x==false){Matrix.hideMask();return false;}if(!false){Matrix.hideMask();return false;}if(!Mform0.validate()){Matrix.hideMask();return false;}var vituralbuttonHidden = document.getElementById('matrix_command_id');if(vituralbuttonHidden)vituralbuttonHidden.parentNode.removeChild(vituralbuttonHidden);var currentForm = document.getElementById('form0');var buttonHidden = document.createElement('input');buttonHidden.type='hidden';buttonHidden.name='matrix_command_id';buttonHidden.id='matrix_command_id';buttonHidden.value='imgButton001';currentForm.appendChild(buttonHidden);var buttonIdHidden = document.createElement('input');buttonIdHidden.type='hidden';buttonIdHidden.name='imgButton001';buttonIdHidden.value='图片按钮';document.getElementById('form0').appendChild(buttonIdHidden);var _mgr=Matrix.convertDataGridDataOfForm('form0');if(_mgr!=null&&_mgr==false){Matrix.hideMask();return false;}Matrix.convertFormItemValue('form0');document.getElementById('form0').submit();Matrix.hideMask();}</script>
											</td>
										</tr>
										<tr id="tr004">
											<td id="td007" style="width: 100%;">
												<div id="Tree001_div" class="matrixComponentDiv">
													<script> isc.MatrixTree.create({ ID:"MTree001_DS",modelType:"children",ownerType:"tree",formId:"form0",autoOpenRoot:false,ownerId:"Tree001",childrenProperty:"children",nameProperty:"text",root:{id:"RootTreeNode",entityId:"RootTreeNode",text:"RootTreeNode"}});isc.Page.setEvent('load','MTree001_DS.openFolder(MTree001_DS.root)',isc.Page.FIRE_ONCE);isc.MatrixTreeGrid.create({ID:"MTree001",name:"Tree001",displayId:"Tree001_div",position:"relative",showHeader:false,showCellContextMenus:true,leaveScrollbarGap:false,data:MTree001_DS,autoFetchData:true,canAutoFitFields:true,showHover:false,showRoot:false,wrapCells:false,fixedRecordHeights:true,selectionType:"single",selectionAppearance:"rowStyle",showConnectors:true,showSelectedStyle:true,showOpenIcons:false,closedIconSuffix:'',showPartialSelection:false,cascadeSelection:false,border:0,showRollOver:false});if(MBorderPanel001Panel1)if(!MBorderPanel001Panel1.customMembers)MBorderPanel001Panel1.customMembers=[];MBorderPanel001Panel1.customMembers.add(MTree001);isc.Page.setEvent(isc.EH.LOAD,"MTree001.resizeTo('100%','100%');");isc.Page.setEvent(isc.EH.RESIZE,"MTree001.resizeTo(0,0);MTree001.resizeTo('100%','100%');",null);</script>
												</div>
											</td>
										</tr>
									</table>
								</div>
								<script>document.getElementById('BorderPanel001Panel1_div').appendChild(document.getElementById('BorderPanel001Panel1_div2'));</script>
								<div id="BorderPanel001Panel2_div2"
									style="width: 100%; height: 100%; overflow: hidden;"
									class="matrixInline">
									<input id="QueryField001" type="hidden" name="QueryField001" />
									<table class="query_form_content"
										style="height: 100%; width: 100%; overflow: hidden; border-collapse: collapse; border-spacing: 0px; table-layout: fixed;">
										<tr>
											<td colspan="2"
												style="border-style: none; width: 100%; margin: 0px; padding: 0px;">
												<div id="DataGrid001_div" class="matrixComponentDiv"
													style="width: 100%; height: 100%;">
													<script> var MDataGrid001_DS=[{userName:'user001',userId:'402881e555474c680155478cd5130003',depId:'402881e455237ab001552396af0d0007'},{userName:'部门经理',userId:'402881e555474c680155478d1bc00004',depId:'402881e455237ab001552396af0d0007'},{userName:'user003',userId:'402881e555474c680155478d55130005',depId:'402881e455237ab001552396ebee0008'},{userName:'user004',userId:'402881e555474c680155478df4f90006',depId:'402881e455237ab001552397d6c7000b'},{userName:'邓磊',userId:'402881e555474c680155479a2723000a',depId:'402881e455237ab001552396ebee0008'},{userName:'user007',userId:'402881e555474c680155479b79ff000b',depId:'402881e455237ab001552396ebee0008'}];isc.MatrixListGrid.create({ID:"MDataGrid001",name:"DataGrid001",displayId:"DataGrid001_div",position:"relative",width:"100%",height:"100%",fields:[{title:"用户名称",matrixCellId:"userName",name:"userName",canEdit:false,editorType:'Text',type:'text'}],autoSaveEdits:false,isMLoaded:false,autoDraw:false,autoFetchData:true,selectionType:"single",selectionAppearance:"rowStyle",canDragSelect:true,alternateRecordStyles:true,showRollOver:true,canSort:true,showHeader:false,autoFitFieldWidths:false,cellDoubleClick:function(record, rowNum, colNum){doubleUser();(record, rowNum, colNum);},editEvent:"doubleClick",canCustomFilter:true,exportCells:[{id:'userName',title:'用户名称'}],showRecordComponents:true,showRecordComponentsByCell:true});isc.MatrixDataSource.create({ID:'MDataGrid001_custom_filter_ds',fields:[{title:"用户名称",name:"userName",type:'text',editorType:'Text'}]});isc.FilterBuilder.create({ID:'MDataGrid001_custom_filter',dataSource:MDataGrid001_custom_filter_ds,overflow:'auto',topOperatorAppearance:"none"});isc.Button.create({ID:'MDataGrid001_custom_filter_btn',title:"确认",autoDraw:false,click:"MDataGrid001.hideCustomFilter()"});isc.Button.create({ID:'MDataGrid001_custom_filter_btn_reset',title:"重置",autoDraw:false,click:"MDataGrid001_custom_filter.clearCriteria()"});isc.Button.create({ID:'MDataGrid001_custom_filter_btn_cancel',title:"取消",autoDraw:false,click:"MDataGrid001_custom_filter_window.hide()"});isc.Window.create({ID:'MDataGrid001_custom_filter_window',title:"高级查询",autoCenter:true,overflow:"auto",isModal:true,autoDraw:true,height:300,width:500,canDragResize:true,showMaximizeButton:true,items: [MDataGrid001_custom_filter],showFooter:true,footerHeight:20,footerControls:[isc.HTMLFlow.create({width:'30%',contents:"&nbsp;",autoDraw:false}),MDataGrid001_custom_filter_btn,isc.HTMLFlow.create({width:'5%',contents:"&nbsp;",autoDraw:false}),MDataGrid001_custom_filter_btn_reset,isc.HTMLFlow.create({width:'5%',contents:"&nbsp;",autoDraw:false}),MDataGrid001_custom_filter_btn_cancel,isc.HTMLFlow.create({width:'30%',contents:"&nbsp;",autoDraw:false})]});MDataGrid001_custom_filter.resizeTo('100%','100%');MDataGrid001_custom_filter_window.hide();if(MBorderPanel001Panel2)if(!MBorderPanel001Panel2.customMembers)MBorderPanel001Panel2.customMembers=[];MBorderPanel001Panel2.customMembers.add(MDataGrid001);isc.Page.setEvent(isc.EH.LOAD,function(){MDataGrid001.isMLoaded=true;MDataGrid001.draw();MDataGrid001.setData(MDataGrid001_DS);MDataGrid001.resizeTo('100%','100%');isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"MDataGrid001.resizeTo(0,0);MDataGrid001.resizeTo('100%','100%');",null);},isc.Page.FIRE_ONCE);},isc.Page.FIRE_ONCE);if(Matrix.getDataGridIdsHiddenOfForm('form0')){Matrix.getDataGridIdsHiddenOfForm('form0').value=Matrix.getDataGridIdsHiddenOfForm('form0').value+',DataGrid001'}</script>
												</div>
												<input id="DataGrid001_data_entity"
													name="DataGrid001_data_entity"
													value="office.common.selorg.DepUsers" type="hidden" />
											</td>
										</tr>
									</table>

								</div>
								<script>document.getElementById('BorderPanel001Panel2_div').appendChild(document.getElementById('BorderPanel001Panel2_div2'));</script>
							</div>
							<script>document.getElementById('TabPanel001_div').appendChild(document.getElementById('TabPanel001_div2'));</script>
							<div id="TabPanel002_div2"
								style="width: 100%; height: 100%; position: relative; overflow: hidden;"
								class="matrixInline">
								<div id="VerticalContainer002_div" class="matrixInline"
									style="width: 100%; height: 100%;; overflow: hidden;">
									<script>isc.VLayout.create({ID:"MVerticalContainer002",displayId:"VerticalContainer002_div",position: "relative",height: "100%",width: "100%",align: "center",overflow: "auto",defaultLayoutAlign: "center",members: [ isc.MatrixHTMLFlow.create({ID:"MBorderPanel002Panel1",width: "100%",height: '50%',overflow: "hidden",showResizeBar:true,contents:"<div id='BorderPanel002Panel1_div' class='matrixComponentDiv'></div>"}),isc.MatrixHTMLFlow.create({ID:"MBorderPanel002Panel2",width: "100%",overflow: "hidden",contents:"<div id='BorderPanel002Panel2_div' class='matrixComponentDiv'></div>"}) ],canSelectText: true });if(MTabPanel002)if(!MTabPanel002.customMembers)MTabPanel002.customMembers=[];MTabPanel002.customMembers.add(MVerticalContainer002);</script>
								</div>
								<div id="BorderPanel002Panel1_div2"
									style="width: 100%; height: 100%; overflow: hidden;"
									class="matrixInline">
									<table id="table003" style="width: 100%; height: 100%;">
										<tr id="tr005">
											<td id="td008" style="width: 100%; height: 5%;">
												<div id="input002_div" eventProxy="Mform0"
													class="matrixInline" style=""></div>
												<script> var input002=isc.TextItem.create({ID:"Minput002",name:"input002",editorType:"TextItem",displayId:"input002_div",position:"relative",autoDraw:false,hint:"请输入角色/人员名称",showHintInField:true});Mform0.addField(input002);</script>
												<script>isc.ImgButton.create({ID:"MimgButton002",name:"imgButton002",showDisabled:false,showDisabledIcon:false,showDown:false,showDownIcon:false,showRollOver:false,showRollOverIcon:false,position:"relative",width:18,height:18,src:"[skin]/images/matrix/actions/query.png"});MimgButton002.click=function(){Matrix.showMask();var x = eval("imgClick2();");if(x!=null && x==false){Matrix.hideMask();return false;}if(!false){Matrix.hideMask();return false;}if(!Mform0.validate()){Matrix.hideMask();return false;}var vituralbuttonHidden = document.getElementById('matrix_command_id');if(vituralbuttonHidden)vituralbuttonHidden.parentNode.removeChild(vituralbuttonHidden);var currentForm = document.getElementById('form0');var buttonHidden = document.createElement('input');buttonHidden.type='hidden';buttonHidden.name='matrix_command_id';buttonHidden.id='matrix_command_id';buttonHidden.value='imgButton002';currentForm.appendChild(buttonHidden);var _mgr=Matrix.convertDataGridDataOfForm('form0');if(_mgr!=null&&_mgr==false){Matrix.hideMask();return false;}Matrix.send('form0',{'imgButton002':'图片按钮'},Matrix.update);Matrix.hideMask();}</script>
											</td>
										</tr>
										<tr id="tr006">
											<td id="td009" style="width: 100%;">
												<div id="Tree002_div" class="matrixComponentDiv"
													style="width: 100%; height: 100%;; position: relative;">
													<script> isc.MatrixTree.create({ ID:"MTree002_DS",modelType:"children",ownerType:"tree",formId:"form0",autoOpenRoot:false,ownerId:"Tree002",childrenProperty:"children",nameProperty:"text",root:{id:"RootTreeNode",entityId:"RootTreeNode",text:"RootTreeNode"}});isc.Page.setEvent('load','MTree002_DS.openFolder(MTree002_DS.root)',isc.Page.FIRE_ONCE);isc.MatrixTreeGrid.create({ID:"MTree002",name:"Tree002",displayId:"Tree002_div",position:"relative",showHeader:false,showCellContextMenus:true,leaveScrollbarGap:false,data:MTree002_DS,autoFetchData:true,canAutoFitFields:true,showHover:false,showRoot:false,wrapCells:false,fixedRecordHeights:true,selectionType:"single",selectionAppearance:"rowStyle",showSelectedStyle:true,showOpenIcons:false,closedIconSuffix:'',showPartialSelection:false,cascadeSelection:false,border:0,showRollOver:false});if(MBorderPanel002Panel1)if(!MBorderPanel002Panel1.customMembers)MBorderPanel002Panel1.customMembers=[];MBorderPanel002Panel1.customMembers.add(MTree002);isc.Page.setEvent(isc.EH.LOAD,"MTree002.resizeTo('100%','100%');");isc.Page.setEvent(isc.EH.RESIZE,"MTree002.resizeTo(0,0);MTree002.resizeTo('100%','100%');",null);</script>
												</div>
											</td>
										</tr>
									</table>
								</div>
								<script>document.getElementById('BorderPanel002Panel1_div').appendChild(document.getElementById('BorderPanel002Panel1_div2'));</script>
								<div id="BorderPanel002Panel2_div2"
									style="width: 100%; height: 100%; overflow: hidden;"
									class="matrixInline">
									<input id="QueryField003" type="hidden" name="QueryField003" />
									<table class="query_form_content"
										style="height: 100%; width: 100%; overflow: hidden; border-collapse: collapse; border-spacing: 0px; table-layout: fixed;">
										<tr>
											<td colspan="2"
												style="border-style: none; width: 100%; margin: 0px; padding: 0px;">
												<div id="DataGrid003_div" class="matrixComponentDiv"
													style="width: 100%; height: 100%;">
													<script> var MDataGrid003_DS=[{userName:'部门经理',userId:'402881e555474c680155478d1bc00004',roleId:'402881e455237ab00155239d0dbd0013',roleName:'部门经理'},{userName:'user003',userId:'402881e555474c680155478d55130005',roleId:'402881e455237ab00155239d40cd0014',roleName:'车辆管理员'},{userName:'user007',userId:'402881e555474c680155479b79ff000b',roleId:'402881e555474c680155479babc6000c',roleName:'行政部门副经理'},{userName:'设计人员',userId:'designer',roleId:'designer',roleName:'设计人员'},{userName:'系统管理员',userId:'admin',roleId:'SysAdmin',roleName:'系统管理员'}];isc.MatrixListGrid.create({ID:"MDataGrid003",name:"DataGrid003",displayId:"DataGrid003_div",position:"relative",width:"100%",height:"100%",fields:[{title:"用户名称",matrixCellId:"userName",name:"userName",canEdit:false,editorType:'Text',type:'text'}],autoSaveEdits:false,isMLoaded:false,autoDraw:false,autoFetchData:true,selectionType:"single",selectionAppearance:"rowStyle",canDragSelect:true,alternateRecordStyles:true,showRollOver:true,canSort:true,showHeader:false,autoFitFieldWidths:false,cellDoubleClick:function(record, rowNum, colNum){doubleUser();(record, rowNum, colNum);},editEvent:"doubleClick",canCustomFilter:true,exportCells:[{id:'userName',title:'用户名称'}],showRecordComponents:true,showRecordComponentsByCell:true});isc.MatrixDataSource.create({ID:'MDataGrid003_custom_filter_ds',fields:[{title:"用户名称",name:"userName",type:'text',editorType:'Text'}]});isc.FilterBuilder.create({ID:'MDataGrid003_custom_filter',dataSource:MDataGrid003_custom_filter_ds,overflow:'auto',topOperatorAppearance:"none"});isc.Button.create({ID:'MDataGrid003_custom_filter_btn',title:"确认",autoDraw:false,click:"MDataGrid003.hideCustomFilter()"});isc.Button.create({ID:'MDataGrid003_custom_filter_btn_reset',title:"重置",autoDraw:false,click:"MDataGrid003_custom_filter.clearCriteria()"});isc.Button.create({ID:'MDataGrid003_custom_filter_btn_cancel',title:"取消",autoDraw:false,click:"MDataGrid003_custom_filter_window.hide()"});isc.Window.create({ID:'MDataGrid003_custom_filter_window',title:"高级查询",autoCenter:true,overflow:"auto",isModal:true,autoDraw:true,height:300,width:500,canDragResize:true,showMaximizeButton:true,items: [MDataGrid003_custom_filter],showFooter:true,footerHeight:20,footerControls:[isc.HTMLFlow.create({width:'30%',contents:"&nbsp;",autoDraw:false}),MDataGrid003_custom_filter_btn,isc.HTMLFlow.create({width:'5%',contents:"&nbsp;",autoDraw:false}),MDataGrid003_custom_filter_btn_reset,isc.HTMLFlow.create({width:'5%',contents:"&nbsp;",autoDraw:false}),MDataGrid003_custom_filter_btn_cancel,isc.HTMLFlow.create({width:'30%',contents:"&nbsp;",autoDraw:false})]});MDataGrid003_custom_filter.resizeTo('100%','100%');MDataGrid003_custom_filter_window.hide();if(MBorderPanel002Panel2)if(!MBorderPanel002Panel2.customMembers)MBorderPanel002Panel2.customMembers=[];MBorderPanel002Panel2.customMembers.add(MDataGrid003);isc.Page.setEvent(isc.EH.LOAD,function(){MDataGrid003.isMLoaded=true;MDataGrid003.draw();MDataGrid003.setData(MDataGrid003_DS);MDataGrid003.resizeTo('100%','100%');isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"MDataGrid003.resizeTo(0,0);MDataGrid003.resizeTo('100%','100%');",null);},isc.Page.FIRE_ONCE);},isc.Page.FIRE_ONCE);if(Matrix.getDataGridIdsHiddenOfForm('form0')){Matrix.getDataGridIdsHiddenOfForm('form0').value=Matrix.getDataGridIdsHiddenOfForm('form0').value+',DataGrid003'}</script>
												</div>
												<input id="DataGrid003_data_entity"
													name="DataGrid003_data_entity"
													value="office.common.selorg.RoleUsers" type="hidden" />
											</td>
										</tr>
									</table>

								</div>
								<script>document.getElementById('BorderPanel002Panel2_div').appendChild(document.getElementById('BorderPanel002Panel2_div2'));</script>
							</div>
							<script>document.getElementById('TabPanel002_div').appendChild(document.getElementById('TabPanel002_div2'));</script>
							<div id="TabPanel004_div2"
								style="width: 100%; height: 100%; position: relative; overflow: hidden;"
								class="matrixInline">
								<div id="VerticalContainer003_div" class="matrixInline"
									style="width: 100%; height: 100%;; overflow: hidden;">
									<script>isc.VLayout.create({ID:"MVerticalContainer003",displayId:"VerticalContainer003_div",position: "relative",height: "100%",width: "100%",align: "center",overflow: "auto",defaultLayoutAlign: "center",members: [ isc.MatrixHTMLFlow.create({ID:"MBorderPanel003Panel1",width: "100%",height: '50%',overflow: "hidden",showResizeBar:true,contents:"<div id='BorderPanel003Panel1_div' class='matrixComponentDiv'></div>"}),isc.MatrixHTMLFlow.create({ID:"MBorderPanel003Panel2",width: "100%",overflow: "hidden",contents:"<div id='BorderPanel003Panel2_div' class='matrixComponentDiv'></div>"}) ],canSelectText: true });if(MTabPanel004)if(!MTabPanel004.customMembers)MTabPanel004.customMembers=[];MTabPanel004.customMembers.add(MVerticalContainer003);</script>
								</div>
								<div id="BorderPanel003Panel1_div2"
									style="width: 100%; height: 100%; overflow: hidden;"
									class="matrixInline">
									<div id="Tree003_div" class="matrixComponentDiv">
										<script> isc.MatrixTree.create({ ID:"MTree003_DS",modelType:"children",ownerType:"tree",formId:"form0",autoOpenRoot:false,ownerId:"Tree003",childrenProperty:"children",nameProperty:"text",root:{id:"RootTreeNode",entityId:"RootTreeNode",text:"RootTreeNode"}});isc.Page.setEvent('load','MTree003_DS.openFolder(MTree003_DS.root)',isc.Page.FIRE_ONCE);isc.MatrixTreeGrid.create({ID:"MTree003",name:"Tree003",displayId:"Tree003_div",position:"relative",showHeader:false,showCellContextMenus:true,leaveScrollbarGap:false,data:MTree003_DS,autoFetchData:true,canAutoFitFields:true,showHover:false,showRoot:false,wrapCells:false,fixedRecordHeights:true,selectionType:"single",selectionAppearance:"rowStyle",showConnectors:true,showSelectedStyle:true,showOpenIcons:false,closedIconSuffix:'',showPartialSelection:false,cascadeSelection:false,border:0,showRollOver:false});if(MBorderPanel003Panel1)if(!MBorderPanel003Panel1.customMembers)MBorderPanel003Panel1.customMembers=[];MBorderPanel003Panel1.customMembers.add(MTree003);isc.Page.setEvent(isc.EH.LOAD,"MTree003.resizeTo('100%','100%');");isc.Page.setEvent(isc.EH.RESIZE,"MTree003.resizeTo(0,0);MTree003.resizeTo('100%','100%');",null);</script>
									</div>
								</div>
								<script>document.getElementById('BorderPanel003Panel1_div').appendChild(document.getElementById('BorderPanel003Panel1_div2'));</script>
								<div id="BorderPanel003Panel2_div2"
									style="width: 100%; height: 100%; overflow: hidden;"
									class="matrixInline">
									<div id="Tree004_div" class="matrixComponentDiv"
										style="width: 100%; height: 100%;; position: relative;">
										<script> isc.MatrixTree.create({ ID:"MTree004_DS",modelType:"children",ownerType:"tree",formId:"form0",autoOpenRoot:false,ownerId:"Tree004",childrenProperty:"children",nameProperty:"text",root:{id:"RootTreeNode",entityId:"RootTreeNode",text:"RootTreeNode"}});isc.Page.setEvent('load','MTree004_DS.openFolder(MTree004_DS.root)',isc.Page.FIRE_ONCE);isc.MatrixTreeGrid.create({ID:"MTree004",name:"Tree004",displayId:"Tree004_div",position:"relative",showHeader:false,showCellContextMenus:true,leaveScrollbarGap:false,data:MTree004_DS,autoFetchData:true,canAutoFitFields:true,showHover:false,showRoot:false,wrapCells:false,fixedRecordHeights:true,selectionType:"single",selectionAppearance:"rowStyle",showSelectedStyle:true,showOpenIcons:false,closedIconSuffix:'',showPartialSelection:false,cascadeSelection:false,border:0,showRollOver:false});if(MBorderPanel003Panel2)if(!MBorderPanel003Panel2.customMembers)MBorderPanel003Panel2.customMembers=[];MBorderPanel003Panel2.customMembers.add(MTree004);isc.Page.setEvent(isc.EH.LOAD,"MTree004.resizeTo('100%','100%');");isc.Page.setEvent(isc.EH.RESIZE,"MTree004.resizeTo(0,0);MTree004.resizeTo('100%','100%');",null);</script>
									</div>
								</div>
								<script>document.getElementById('BorderPanel003Panel2_div').appendChild(document.getElementById('BorderPanel003Panel2_div2'));</script>
							</div>
							<script>document.getElementById('TabPanel004_div').appendChild(document.getElementById('TabPanel004_div2'));</script>
							<div id="TabPanel003_div2"
								style="width: 100%; height: 100%; position: relative; overflow: hidden;"
								class="matrixInline">
								<table class="query_form_content"
									style="height: 100%; width: 100%; overflow: hidden; border-collapse: collapse; border-spacing: 0px; table-layout: fixed;">
									<tr>
										<td class="query_form_toolbar" colspan="2">
											<script> var MconditionType_VM=[]; var conditionType=isc.ComboBoxItem.create({ID:"MconditionType",name:"conditionType",editorType:"ComboBoxItem",displayId:"conditionType_div",autoDraw:false,valueMap:[],value:"userName",position:"relative",width:70});Mform0.addField(conditionType);MconditionType_VM=['userName','userId'];MconditionType.displayValueMap={'userName':'姓名','userId':'工号'};MconditionType.setValueMap(MconditionType_VM);MconditionType.setValue('userName');</script>
											<script> var conditionValue=isc.TextItem.create({ID:"MconditionValue",name:"conditionValue",editorType:"TextItem",displayId:"conditionValue_div",position:"relative",autoDraw:false});Mform0.addField(conditionValue);</script>
											<script>isc.ToolStripButton.create({ID:"MtoolBarItem003",icon:"[skin]/images/matrix/actions/query.png",showDisabledIcon:false,showDownIcon:false });MtoolBarItem003.click=function(){Matrix.showMask();var x = eval("Matrix.refreshDataGridData('DataGrid004');");if(x!=null && x==false){Matrix.hideMask();return false;}Matrix.hideMask();}</script>
											<div id="QueryForm004_tb_div"
												style="width: 100%; height: 38px;; overflow: hidden;">
												<script>isc.ToolStrip.create({ID:"MQueryForm004_tb",displayId:"QueryForm004_tb_div",width: "100%",height: "100%",position: "relative",members: [ isc.MatrixHTMLFlow.create({ID:"conditionType",contents:"<div id='conditionType_div' eventProxy='Mform0' class='toolBarItemComboBox'  style='width:70px' ></div>"}),isc.MatrixHTMLFlow.create({ID:"conditionValue",contents:"<div id='conditionValue_div' eventProxy='Mform0' class='toolBarItemInputText' ></div>"}),MtoolBarItem003 ] });if(MTabPanel003)if(!MTabPanel003.customMembers)MTabPanel003.customMembers=[];MTabPanel003.customMembers.add(MQueryForm004_tb);isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"MQueryForm004_tb.resizeTo(0,0);MQueryForm004_tb.resizeTo('100%','100%');",null);},isc.Page.FIRE_ONCE);</script>
											</div>
										</td>
									</tr>
									<tr>
										<td colspan="2"
											style="border-style: none; width: 100%; margin: 0px; padding: 0px;">
											<div id="DataGrid004_div" class="matrixComponentDiv"
												style="width: 100%; height: 100%;">
												<script> var MDataGrid004_DS=[];isc.MatrixListGrid.create({ID:"MDataGrid004",name:"DataGrid004",displayId:"DataGrid004_div",position:"relative",width:"100%",height:"100%",fields:[{title:"用户编码",matrixCellId:"userId",name:"userId",canEdit:false,editorType:'InputHidden',type:'text'},{title:"姓名",matrixCellId:"userName",name:"userName",canEdit:false,editorType:'Text',type:'text'}],autoSaveEdits:false,isMLoaded:false,autoDraw:false,autoFetchData:true,selectionType:"single",selectionAppearance:"rowStyle",canDragSelect:true,alternateRecordStyles:true,showRollOver:true,canSort:true,autoFitFieldWidths:false,cellDoubleClick:function(record, rowNum, colNum){doubleUser();(record, rowNum, colNum);},editEvent:"doubleClick",canCustomFilter:true,exportCells:[{id:'userId',title:'用户编码'},{id:'userName',title:'姓名'}],showRecordComponents:true,showRecordComponentsByCell:true});isc.MatrixDataSource.create({ID:'MDataGrid004_custom_filter_ds',fields:[{title:"用户编码",name:"userId",type:'text',editorType:'InputHidden'},{title:"姓名",name:"userName",type:'text',editorType:'Text'}]});isc.FilterBuilder.create({ID:'MDataGrid004_custom_filter',dataSource:MDataGrid004_custom_filter_ds,overflow:'auto',topOperatorAppearance:"none"});isc.Button.create({ID:'MDataGrid004_custom_filter_btn',title:"确认",autoDraw:false,click:"MDataGrid004.hideCustomFilter()"});isc.Button.create({ID:'MDataGrid004_custom_filter_btn_reset',title:"重置",autoDraw:false,click:"MDataGrid004_custom_filter.clearCriteria()"});isc.Button.create({ID:'MDataGrid004_custom_filter_btn_cancel',title:"取消",autoDraw:false,click:"MDataGrid004_custom_filter_window.hide()"});isc.Window.create({ID:'MDataGrid004_custom_filter_window',title:"高级查询",autoCenter:true,overflow:"auto",isModal:true,autoDraw:true,height:300,width:500,canDragResize:true,showMaximizeButton:true,items: [MDataGrid004_custom_filter],showFooter:true,footerHeight:20,footerControls:[isc.HTMLFlow.create({width:'30%',contents:"&nbsp;",autoDraw:false}),MDataGrid004_custom_filter_btn,isc.HTMLFlow.create({width:'5%',contents:"&nbsp;",autoDraw:false}),MDataGrid004_custom_filter_btn_reset,isc.HTMLFlow.create({width:'5%',contents:"&nbsp;",autoDraw:false}),MDataGrid004_custom_filter_btn_cancel,isc.HTMLFlow.create({width:'30%',contents:"&nbsp;",autoDraw:false})]});MDataGrid004_custom_filter.resizeTo('100%','100%');MDataGrid004_custom_filter_window.hide();if(MTabPanel003)if(!MTabPanel003.customMembers)MTabPanel003.customMembers=[];MTabPanel003.customMembers.add(MDataGrid004);isc.Page.setEvent(isc.EH.LOAD,function(){MDataGrid004.isMLoaded=true;MDataGrid004.draw();MDataGrid004.setData(MDataGrid004_DS);MDataGrid004.resizeTo('100%','100%');isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"MDataGrid004.resizeTo(0,0);MDataGrid004.resizeTo('100%','100%');",null);},isc.Page.FIRE_ONCE);},isc.Page.FIRE_ONCE);if(Matrix.getDataGridIdsHiddenOfForm('form0')){Matrix.getDataGridIdsHiddenOfForm('form0').value=Matrix.getDataGridIdsHiddenOfForm('form0').value+',DataGrid004'}</script>
											</div>
											<input id="DataGrid004_data_entity"
												name="DataGrid004_data_entity" value="foundation.org.User"
												type="hidden" />
										</td>
									</tr>
								</table>

							</div>
							<script>document.getElementById('TabPanel003_div').appendChild(document.getElementById('TabPanel003_div2'));</script>
							<script>document.getElementById('TabContainer001_div').style.display='';</script>
						</td>
						<td id="td002" class="tdLayout"
							style="width: 50px; text-align: center;">
							<div id="button002_div" class="matrixInline"
								style="position: relative;; width: 100px;; height: 22px;">
								<script>isc.Button.create({ID:"Mbutton002",name:"button002",title:"→",displayId:"button002_div",position:"absolute",top:0,left:0,width:"100%",height:"100%",showDisabledIcon:false,showDownIcon:false,showRollOverIcon:false});Mbutton002.click=function(){Matrix.showMask();var x = eval("addUser();");if(x!=null && x==false){Matrix.hideMask();Mbutton002.enable();return false;}Matrix.hideMask();};</script>
							</div>
							<label id="label001" name="label001" id="label001">
								<br />
								<br />
							</label>
							<div id="button001_div" class="matrixInline"
								style="position: relative;; width: 100px;; height: 22px;">
								<script>isc.Button.create({ID:"Mbutton001",name:"button001",title:"←",displayId:"button001_div",position:"absolute",top:0,left:0,width:"100%",height:"100%",showDisabledIcon:false,showDownIcon:false,showRollOverIcon:false});Mbutton001.click=function(){Matrix.showMask();var x = eval("removeUser();");if(x!=null && x==false){Matrix.hideMask();Mbutton001.enable();return false;}Matrix.hideMask();};</script>
							</div>
						</td>
						<td id="td003" class="tdLayout" style="width: 250px;">
							<table class="query_form_content"
								style="height: 100%; width: 100%; overflow: hidden; border-collapse: collapse; border-spacing: 0px; table-layout: fixed;">
								<tr>
									<td colspan="2"
										style="border-style: none; width: 100%; margin: 0px; padding: 0px;">
										<div id="DataGrid002_div" class="matrixComponentDiv"
											style="width: 100%; height: 100%;">
											<script> var MDataGrid002_DS=[];isc.MatrixListGrid.create({ID:"MDataGrid002",name:"DataGrid002",displayId:"DataGrid002_div",position:"relative",width:"100%",height:"100%",fields:[{title:"姓名",matrixCellId:"allName",name:"allName",canEdit:false,editorType:'Text',type:'text'},{title:"类型",matrixCellId:"type",name:"type",canEdit:false,editorType:'Text',type:'text',formatCellValue:function(value, record, rowNum, colNum,grid){return function(value){ if(value==1) return '用户'; else if(value==2) return '部门'; else if(value==3) return '角色'; else if(value==4) return '岗位'; }(value,record, rowNum, colNum,grid);}}],autoSaveEdits:false,isMLoaded:false,autoDraw:false,autoFetchData:true,selectionType:"multiple",selectionAppearance:"rowStyle",alternateRecordStyles:true,showRollOver:true,canSort:true,showHeader:false,autoFitFieldWidths:false,cellDoubleClick:function(record, rowNum, colNum){removeUser();(record, rowNum, colNum);},editEvent:"doubleClick",canCustomFilter:true,exportCells:[{id:'allName',title:'姓名'},{id:'type',title:'类型'}],showRecordComponents:true,showRecordComponentsByCell:true});isc.MatrixDataSource.create({ID:'MDataGrid002_custom_filter_ds',fields:[{title:"姓名",name:"allName",type:'text',editorType:'Text'},{title:"类型",name:"type",type:'text',editorType:'Text'}]});isc.FilterBuilder.create({ID:'MDataGrid002_custom_filter',dataSource:MDataGrid002_custom_filter_ds,overflow:'auto',topOperatorAppearance:"none"});isc.Button.create({ID:'MDataGrid002_custom_filter_btn',title:"确认",autoDraw:false,click:"MDataGrid002.hideCustomFilter()"});isc.Button.create({ID:'MDataGrid002_custom_filter_btn_reset',title:"重置",autoDraw:false,click:"MDataGrid002_custom_filter.clearCriteria()"});isc.Button.create({ID:'MDataGrid002_custom_filter_btn_cancel',title:"取消",autoDraw:false,click:"MDataGrid002_custom_filter_window.hide()"});isc.Window.create({ID:'MDataGrid002_custom_filter_window',title:"高级查询",autoCenter:true,overflow:"auto",isModal:true,autoDraw:true,height:300,width:500,canDragResize:true,showMaximizeButton:true,items: [MDataGrid002_custom_filter],showFooter:true,footerHeight:20,footerControls:[isc.HTMLFlow.create({width:'30%',contents:"&nbsp;",autoDraw:false}),MDataGrid002_custom_filter_btn,isc.HTMLFlow.create({width:'5%',contents:"&nbsp;",autoDraw:false}),MDataGrid002_custom_filter_btn_reset,isc.HTMLFlow.create({width:'5%',contents:"&nbsp;",autoDraw:false}),MDataGrid002_custom_filter_btn_cancel,isc.HTMLFlow.create({width:'30%',contents:"&nbsp;",autoDraw:false})]});MDataGrid002_custom_filter.resizeTo('100%','100%');MDataGrid002_custom_filter_window.hide();isc.Page.setEvent(isc.EH.LOAD,function(){MDataGrid002.isMLoaded=true;MDataGrid002.draw();MDataGrid002.setData(MDataGrid002_DS);MDataGrid002.resizeTo('100%','100%');isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"MDataGrid002.resizeTo(0,0);MDataGrid002.resizeTo('100%','100%');",null);},isc.Page.FIRE_ONCE);},isc.Page.FIRE_ONCE);if(Matrix.getDataGridIdsHiddenOfForm('form0')){Matrix.getDataGridIdsHiddenOfForm('form0').value=Matrix.getDataGridIdsHiddenOfForm('form0').value+',DataGrid002'}</script>
										</div>
										<input id="DataGrid002_data_entity"
											name="DataGrid002_data_entity"
											value="office.common.selorg.QueryUser" type="hidden" />
									</td>
								</tr>
							</table>

						</td>
						<td id="td004" class="tdLayout"
							style="width: 50px; text-align: center;">
							<div id="button003_div" class="matrixInline"
								style="position: relative;; width: 100px;; height: 22px;">
								<script>isc.Button.create({ID:"Mbutton003",name:"button003",title:"↑",displayId:"button003_div",position:"absolute",top:0,left:0,width:"100%",height:"100%",showDisabledIcon:false,showDownIcon:false,showRollOverIcon:false});Mbutton003.click=function(){Matrix.showMask();var x = eval("moveUp();");if(x!=null && x==false){Matrix.hideMask();Mbutton003.enable();return false;}Matrix.hideMask();};</script>
							</div>
							<label id="label002" name="label002" id="label002">
								<br />
								<br />
							</label>
							<div id="button004_div" class="matrixInline"
								style="position: relative;; width: 100px;; height: 22px;">
								<script>isc.Button.create({ID:"Mbutton004",name:"button004",title:"↓",displayId:"button004_div",position:"absolute",top:0,left:0,width:"100%",height:"100%",showDisabledIcon:false,showDownIcon:false,showRollOverIcon:false});Mbutton004.click=function(){Matrix.showMask();var x = eval("moveDown();");if(x!=null && x==false){Matrix.hideMask();Mbutton004.enable();return false;}Matrix.hideMask();};</script>
							</div>
						</td>
					</tr>
					<tr id="tr007" style="height: 32px;">
						<td id="td010" class="cmdLayout">
							<div id="button005_div" class="matrixInline"
								style="position: relative;; width: 100px;; height: 22px;">
								<script>isc.Button.create({ID:"Mbutton005",name:"button005",title:"确认",displayId:"button005_div",position:"absolute",top:0,left:0,width:"100%",height:"100%",icon:"[skin]/images/matrix/actions/submit.png",showDisabledIcon:false,showDownIcon:false,showRollOverIcon:false});Mbutton005.click=function(){Matrix.showMask();var x = eval("complete();");if(x!=null && x==false){Matrix.hideMask();Mbutton005.enable();return false;}Matrix.hideMask();};</script>
							</div>
							<div id="button006_div" class="matrixInline"
								style="position: relative;; width: 100px;; height: 22px;">
								<script>isc.Button.create({ID:"Mbutton006",name:"button006",title:"取消",displayId:"button006_div",position:"absolute",top:0,left:0,width:"100%",height:"100%",icon:"[skin]/images/matrix/actions/exit.png",showDisabledIcon:false,showDownIcon:false,showRollOverIcon:false});Mbutton006.click=function(){Matrix.showMask();var x = eval("Matrix.closeWindow();");if(x!=null && x==false){Matrix.hideMask();Mbutton006.enable();return false;}Matrix.hideMask();};</script>
							</div>
						</td>
					</tr>
				</table>
				<input id="depId" type="hidden" name="depId" />
				<input id="userNameCondi" type="hidden" name="userNameCondi" />
				<input id="roleId" type="hidden" name="roleId" />
				<input id="userNameCondi2" type="hidden" name="userNameCondi2" />
				<input id="opt" type="hidden" name="opt" value="1" />
				<input id="optType" type="hidden" name="optType" />
				<input id="add" type="hidden" name="add" />
			</form>
		</div>
		<script>Mform0.initComplete=true;Mform0.redraw();isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"Mform0.redraw()",null);},isc.Page.FIRE_ONCE);</script>
	</body>
</html>
