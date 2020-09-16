
//------------------------------------------ mp begain ----------------------------------------

/**
*
*操作
*
*/
isc.defineClass("MTOperationInfo").addProperties({
	component:null,
	parent:null,
	operate:null,
	index:null
});


/*
 *
 *组件面板抽屉
 *
*/
isc.defineClass("MTComponentSectionStack","SectionStack").addProperties({
	canDragRecordsOut: true,   
	canAutoFitFields:true,
	canDragSelectText:"123",
	canReorderRecords: false,
    dragDataAction: "copy",
	selectionType:"single",
	selectionAppearance:"rowStyle",
	autoFetchData:true,
	//showOpenIcons:false,
	//closedIconSuffix:'',
	showPartialSelection:false,
	cascadeSelection:false,
	border:0,
	dragStop:function isc_ListGrid_dragStop(){
		// 拖拽停止事件
		
		/*var dragData = this.$758; // 先获得拖拽数据
		this.body.clearNoDropIndicator();
		this.hideDragLine();
		this.$758=null;
	//	isc.MH.createComponent(isc.EventHandler.getTarget(),dragData);
		var a = isc.EventHandler.getDragRect(); //[left,top,width,height]
		var b = isc.EventHandler.getX();
		var c = isc.EventHandler.getY();
		*/
		//alert("a::"+a.toString()+"---b::"+b+"--c::"+c);
		
		isc.EventHandler.getTarget();
		isc.EventHandler.getNativeMouseTarget();
		isc.EventHandler.getDragTarget();
	},
	getDragTrackerTitle2:function(record,rowNum){
		var _3=this.getTitleField(),_4=this.getColNum(_3),_5=this.getCellValue(record,rowNum,_4);
		var _6 = isc.EventHandler.getDragTarget().ID;
		//return"<nobr>"+_5+"-->"+_6+"</nobr>";
		return"<nobr>"+_5+"</nobr>";
	}
	
});

/*
 *
 *组件面板集合
 *
*/
isc.defineClass("MTComponentList","ListGrid").addProperties({
		//mType:null,
    	cellHeight:24, 
    	imageSize:16,
    	//showEdges:true, 
    	//border:"0px",
    	//width:"150", 
    	width:"100%", 
    	showEdges:false, 
    	border:0, 
    	bodyStyleName:"normal",
    	alternateRecordStyles:true, 
    	// canReorderRecords: true,
    	showHeader:false, 
    	leaveScrollbarGap:false,
        canDragRecordsOut: true,
        canAcceptDroppedRecords: true,
        dragDataAction: "copy",
        /* 设置hover */
      	canHover:true,
     	showHover:true,
   		//showHoverComponents: true, //实现getCellHoverComponent(record, rowNum, colNum)
   		cellHoverHTML:function(record, rowNum, colNum){
   			// 显示组件hover
   			if(record.hover)
   				return record.hover;
   			return null;	
   		},
   		/* 设置hover end */
	   // appImgDir:webContextPath+"/resource/images/designer/component/",
	    fields:[
	        {name:"micon", type:"image", width:24, imgDir:Page.getSkinDir()+"images/matrix/component/", imageURLSuffix:".png"},
	        {name:"mtitle"}
	    ]
	 //   ,trackerImage:{src:webContextPath+"/resource/images/designer/component/", width:24, height:24}
});


//组件元素模板
isc.defineClass("MTComponent").addProperties({
	id:null,
	name:null,
	mtitle:"",//组件面板中显示标题
	micon:"", //组件面板中显示图标
	title:"",
	type:"",
	icon:"",
	width:1,
	height:1,
	hover:"",
	initComponent:function(){
		// 请求输入创建参数
		return false;
	},
	getCreateParams:function(isURLPrams){
		// 获得创建参数
		if(isURLPrams){
			var params = "";
			params+=isc.MC.SERVER_PARAMS.command+"="+isc.MC.COMMAND.create;
			params+="&"+isc.MC.SERVER_PARAMS.componentType+"="+this.type;
			params+="&"+isc.MC.SERVER_PARAMS.componentIndex+"="+this.mindex;
			if(this.mparent!=null){
				params+="&"+isc.MC.SERVER_PARAMS.parentId+"="+this.mparent.id;
			}
			return params;
		}
		var data = {};
		data[isc.MC.SERVER_PARAMS.command] = isc.MC.COMMAND.create;
		data[isc.MC.SERVER_PARAMS.componentType] = this.type;
		data[isc.MC.SERVER_PARAMS.componentIndex] = this.mindex;
		if(this.mparent!=null){
			data[isc.MC.SERVER_PARAMS.parentId] = this.mparent.id;
		}
		return data;
	},
	enableToCreate:function(){
		// 判断是否允许创建
		return true;
	},
	getID:function(){
		return "M"+this.getName();
	},
	getName:function(){
		if(this.id==null){
			this.id = this.type+"_"+isc.MH.getNextSequence(this.type);
		}
		return this.id;
	},
	createComponent:function(){
		//创建组件
		return null;
	},
	createChildren:function(_mparent){
		//创建子组件
		var _mchildren = this.children;
		if(_mchildren && _mchildren.length>0){
			for(var i=0;i<_mchildren.length;i++){
				var _mchild = _mchildren[i];
				if(_mchild){
					var _mchildObj = _mchild.createComponent();
					if(_mchildObj){
						// 父组件添加成员
						_mparent.addMembers(_mchildObj,i);
						// 组件树添加组件
						isc.MH.addComponent(_mparent,_mchildObj,i);
					}
				}
			}
		}
	}
});

//表单元素组件
isc.defineClass("MTFormItem","MTComponent").addProperties({
	type:isc.MC.COMPONENT_TYPE.FormItem,
	editorType:isc.MC.COMPONENT_TYPE.FormItem,
	getCreateParams:function(){
		// 获得创建参数
		var data = this.invokeSuper(isc.MTFormItem,"getCreateParams");
		if(this.editorType!=null){
			data[isc.MC.SERVER_PARAMS.componentType] = this.editorType;
		}
		return data;
	}
});

//复合组件
isc.defineClass("MTMixedComponent","MTComponent").addProperties({
	initComponent:function(){
		isc.MH.showUpdateComponentWindow(this);
		return true;
	},
	getCreateParams:function(){
		// 获得创建参数
		var data = this.invokeSuper(isc.MTMixedComponent,"getCreateParams");
		//var data = this.invokeSuper(isc.MTQueryList,"getCreateParams");
		data[isc.MC.SERVER_PARAMS.command] = isc.MC.COMMAND.postCreate;
		return data;
	}
});

//标签
isc.defineClass("MTLabel","MTComponent").addProperties({
	type:isc.MC.COMPONENT_TYPE.Label,
	mtitle:isc.MatrixMessages.MT_Label_title,
	hover:isc.MatrixMessages.MT_Label_hover,
	micon:isc.MC.COMPONENT_TYPE.Label
});

//图片
isc.defineClass("MTImg","MTComponent").addProperties({
	type:isc.MC.COMPONENT_TYPE.Img,
	mtitle:isc.MatrixMessages.MT_Img_title,
	hover:isc.MatrixMessages.MT_Img_hover,
	micon:isc.MC.COMPONENT_TYPE.Img
});

//HTML片段
isc.defineClass("MTInnerHtml","MTComponent").addProperties({
	type:isc.MC.COMPONENT_TYPE.InnerHtml,
	mtitle:isc.MatrixMessages.MT_InnerHtml_title,
	hover:isc.MatrixMessages.MT_InnerHtml_hover,
	micon:isc.MC.COMPONENT_TYPE.InnerHtml
});

//单选按钮
isc.defineClass("MTRadioItem","MTFormItem").addProperties({
	editorType:isc.MC.COMPONENT_TYPE.RadioItem,
	mtitle:isc.MatrixMessages.MT_RadioItem_title,
	hover:isc.MatrixMessages.MT_RadioItem_hover,
	micon:isc.MC.COMPONENT_TYPE.RadioItem
});

//单选按钮组
isc.defineClass("MTRadioGroupItem","MTFormItem").addProperties({
	editorType:isc.MC.COMPONENT_TYPE.RadioGroupItem,
	mtitle:isc.MatrixMessages.MT_RadioGroupItem_title,
	hover:isc.MatrixMessages.MT_RadioGroupItem_hover,
	micon:isc.MC.COMPONENT_TYPE.RadioGroupItem
});

//按钮
isc.defineClass("MTButton","MTComponent").addProperties({
	type:isc.MC.COMPONENT_TYPE.Button,
	mtitle:isc.MatrixMessages.MT_Button_title,
	hover:isc.MatrixMessages.MT_Button_hover,
	micon:isc.MC.COMPONENT_TYPE.Button
});

isc.defineClass("MTImgButton","MTComponent").addProperties({
	type:isc.MC.COMPONENT_TYPE.ImgButton,
	mtitle:isc.MatrixMessages.MT_ImgButton_title,
	hover:isc.MatrixMessages.MT_ImgButton_hover,
	micon:isc.MC.COMPONENT_TYPE.ImgButton
});
	
//树
isc.defineClass("MTTreeGrid","MTMixedComponent").addProperties({
	type:isc.MC.COMPONENT_TYPE.TreeGrid,
	mtitle:isc.MatrixMessages.MT_TreeGrid_title,
	hover:isc.MatrixMessages.MT_TreeGrid_hover,
	micon:isc.MC.COMPONENT_TYPE.TreeGrid
});

//查询列表
isc.defineClass("MTQueryList","MTMixedComponent").addProperties({
	type:isc.MC.COMPONENT_TYPE.QueryList,
	mtitle:isc.MatrixMessages.MT_QueryList_title,
	hover:isc.MatrixMessages.MT_QueryList_hover,
	micon:isc.MC.COMPONENT_TYPE.QueryList
});

//查询视图
isc.defineClass("MTQueryView","MTMixedComponent").addProperties({
	type:isc.MC.COMPONENT_TYPE.QueryView,
	mtitle:isc.MatrixMessages.MT_QueryView_title,
	hover:isc.MatrixMessages.MT_QueryView_hover,
	micon:isc.MC.COMPONENT_TYPE.DataView
});

//数据视图
isc.defineClass("MTDataView","MTMixedComponent").addProperties({
	type:isc.MC.COMPONENT_TYPE.DataView,
	mtitle:isc.MatrixMessages.MT_DataView_title,
	hover:isc.MatrixMessages.MT_DataView_hover,
	micon:isc.MC.COMPONENT_TYPE.DataView
});

//单表编辑
isc.defineClass("MTEditForm","MTMixedComponent").addProperties({
	type:isc.MC.COMPONENT_TYPE.EditForm,
	mtitle:isc.MatrixMessages.MT_EditForm_title,
	hover:isc.MatrixMessages.MT_EditForm_hover,
	micon:isc.MC.COMPONENT_TYPE.EditForm
});

//编辑列表
isc.defineClass("MTEditList","MTMixedComponent").addProperties({
	type:isc.MC.COMPONENT_TYPE.EditList,
	mtitle:isc.MatrixMessages.MT_EditList_title,
	hover:isc.MatrixMessages.MT_EditList_hover,
	micon:isc.MC.COMPONENT_TYPE.EditList
});

//重复节
isc.defineClass("MTDataList","MTComponent").addProperties({
	type:isc.MC.COMPONENT_TYPE.DataList,
	mtitle:isc.MatrixMessages.MT_DataList_title,
	hover:isc.MatrixMessages.MT_DataList_hover,
	micon:isc.MC.COMPONENT_TYPE.DataList
});

//子表单
isc.defineClass("MTIncludeForm","MTMixedComponent").addProperties({
	type:isc.MC.COMPONENT_TYPE.IncludeForm,
	mtitle:isc.MatrixMessages.MT_IncludeForm_title,
	hover:isc.MatrixMessages.MT_IncludeForm_hover,
	micon:isc.MC.COMPONENT_TYPE.IncludeForm
});

//自定义组件
isc.defineClass("MTCustomComponent","MTComponent").addProperties({
	type:isc.MC.COMPONENT_TYPE.CustomComponent,
	mtitle:isc.MatrixMessages.MT_CustomComponent_title,
	hover:isc.MatrixMessages.MT_CustomComponent_hover,
	micon:isc.MC.COMPONENT_TYPE.CustomComponent,
	getCreateParams:function(){
		// 获得创建参数
		var data = this.invokeSuper(isc.MTCustomComponent,"getCreateParams");
		data[isc.MC.SERVER_PARAMS.customType] = this.customType;
		return data;
	}
});

//流转控件
isc.defineClass("MTStepsChoose","MTComponent").addProperties({
	type:isc.MC.COMPONENT_TYPE.StepsChoose,
	mtitle:isc.MatrixMessages.MT_StepsChoose_title,
	hover:isc.MatrixMessages.MT_StepsChoose_hover,
	micon:'cube_yellow.png'
});

//统计图
isc.defineClass("MTDiagram","MTComponent").addProperties({
	type:isc.MC.COMPONENT_TYPE.Diagram,
	mtitle:isc.MatrixMessages.MT_Diagram_title,
	hover:isc.MatrixMessages.MT_Diagram_hover,
	micon:'cube_yellow.png'
});

//仪表盘
isc.defineClass("MTDashboard","MTComponent").addProperties({
	type:isc.MC.COMPONENT_TYPE.Dashboard,
	mtitle:isc.MatrixMessages.MT_Dashboard_title,
	hover:isc.MatrixMessages.MT_Dashboard_hover,
	micon:'cube_yellow.png'
});

//工具栏
isc.defineClass("MTToolStrip","MTComponent").addProperties({
	type:isc.MC.COMPONENT_TYPE.ToolStrip,
	mtitle:isc.MatrixMessages.MT_ToolStrip_title,
	hover:isc.MatrixMessages.MT_ToolStrip_hover,
	micon:isc.MC.COMPONENT_TYPE.ToolStrip,
	enableToCreate:function(){
		//父组件不为工具栏时可创建
		if(this.mparent!=null){
			if(!isc.isA.MDToolStrip(this.mparent)){
				return true;
			}
		}
		return false;
	},
	initComponent2:function(){
		isc.MDToolStrip.create({ID:"MtoolBar001",
			id:"toolBar001",name:"toolBar001",
			height:30,
			overflow:'hidden'
		});
		isc.MH.addComponent(MTestLayout,MtoolBar001,1);
		isc.MDToolStripButton.create({ID:"MtoolBarItem001",
			id:"toolBarItem001",name:"toolBarItem001",
			componentType:'toolBarItem',
			height:24,
			icon:"/formconsole/resource/images/form/designer/component/piece_green.png",
			title: "测试",showDisabledIcon:false,showDownIcon:false 
		});
		isc.MH.addComponent(MtoolBar001,MtoolBarItem001,0);
		return true;
	}
});

//工具栏操作
isc.defineClass("MTToolStripButton","MTComponent").addProperties({
	type:isc.MC.COMPONENT_TYPE.ToolStripButton,
	mtitle:isc.MatrixMessages.MT_ToolStripButton_title,
	hover:isc.MatrixMessages.MT_ToolStripButton_hover,
	micon:isc.MC.COMPONENT_TYPE.ToolStripButton,
	icon:"",
	enableToCreate:function(){
		//父组件为工具栏时可创建
		if(this.mparent!=null){
			if(isc.isA.MDToolStrip(this.mparent)){
				return true;
			}
		}
		return false;
	}
});

// 工具栏菜单
isc.defineClass("MTToolStripMenuButton","MTComponent").addProperties({
	type:isc.MC.COMPONENT_TYPE.ToolStripMenuButton,
	mtitle:isc.MatrixMessages.MT_ToolStripMenuButton_title,
	hover:isc.MatrixMessages.MT_ToolStripMenuButton_hover,
	micon:isc.MC.COMPONENT_TYPE.ToolStripMenuButton,
	icon:"",
	enableToCreate:function(){
		//父组件为工具栏时可创建
		if(this.mparent!=null){
			if(isc.isA.MDToolStrip(this.mparent)){
				return true;
			}
		}
		return false;
	}
});

//工具栏分隔符
isc.defineClass("MTToolStripSeparator","MTComponent").addProperties({
	type:isc.MC.COMPONENT_TYPE.ToolStripSeparator,
	mtitle:isc.MatrixMessages.MT_ToolStripSeparator_title,
	hover:isc.MatrixMessages.MT_ToolStripSeparator_hover,
	micon:isc.MC.COMPONENT_TYPE.ToolStripSeparator,
	enableToCreate:function(){
		//父组件为工具栏时可创建
		if(this.mparent!=null){
			if(isc.isA.MDToolStrip(this.mparent)){
				return true;
			}
		}
		return false;
	}
});

//数据表格
isc.defineClass("MTListGrid","MTComponent").addProperties({
	type:isc.MC.COMPONENT_TYPE.ListGrid,
	mtitle:isc.MatrixMessages.MT_ListGrid_title,
	hover:isc.MatrixMessages.MT_ListGrid_hover,
	micon:'cube_blue.png',
	initComponent:function(){
		isc.MH.showUpdateComponentWindow(this);
		return true;
	}
});

//分页条
isc.defineClass("MTPaginator","MTComponent").addProperties({
	type:isc.MC.COMPONENT_TYPE.Paginator,
	mtitle:isc.MatrixMessages.MT_Paginator_title,
	hover:isc.MatrixMessages.MT_Paginator_hover,
	micon:'cube_blue.png'
});

//表格布局
isc.defineClass("MTTable","MTComponent").addProperties({
	type:isc.MC.COMPONENT_TYPE.Table,
	mtitle:isc.MatrixMessages.MT_Table_title,
	hover:isc.MatrixMessages.MT_Table_hover,
	micon:isc.MC.COMPONENT_TYPE.Table,
	initComponent:function(){
		if(this.initCompletedFlag){
			return false;
		}
		MatrixTableCreateWindow.mtable = this;
		MatrixTrCreateNum.setValue(2);
		MatrixTdCreateNum.setValue(2);
		MatrixTableCreateWindow.show();
		return true;
	},
	getCreateParams:function(){
		// 获得创建参数
		var data = this.invokeSuper(isc.MTTable,"getCreateParams");
		data[isc.MC.SERVER_PARAMS.trNum]=MatrixTrCreateNum.getValue();
		data[isc.MC.SERVER_PARAMS.tdNum]=MatrixTdCreateNum.getValue();
		return data;
	},
	createComponent:function(){
		this.initCompletedFlag = true;
		isc.MH.createComponent(this);
		delete this.initCompletedFlag;
	}
});

//表格行
isc.defineClass("MTTr","MTComponent").addProperties({
	type:isc.MC.COMPONENT_TYPE.Tr,
	createComponent:function(){
		var _ID = this.getID();
		return isc.MDTr.create({ID:_ID,name:this.getName()});
	},
	insertTr:function(){
		var htmlTable = this.table;
		var htmlTR = htmlTable.insertRow(this.index);
		var trName = this.getName();
		htmlTR.id = trName;
		if(this.style!=null){
			isc.MH.setElementStyle(htmlTR,this.style);
		}
		var mtds = this.tds;
		if(mtds){
			for(var j=0;j<mtds.length;j++){
				var mtd = mtds[j];
				if(mtd){
					mtd.tr = htmlTR;
					mtd.insertTd();
				}
			}
		}
	}
});

//表格列
isc.defineClass("MTTd","MTComponent").addProperties({
	type:isc.MC.COMPONENT_TYPE.Td,
	position:"relative",
	colSpan:1,
	rowSpan:1,
	createComponent:function(){
		var _ID = this.getID();
		var _defaultLayoutAlign = this.defaultLayoutAlign?this.defaultLayoutAlign:"center";
		var _mcomponent = isc.MDTd.create({
				ID:this.getName()+'_canvas',
				position:"relative",
				mchildren:new Array(),
				displayId:this.getName(),
				width:"100%",
				height:"100%",
				overflow:'hidden',
				align:this.align,
				defaultLayoutAlign:_defaultLayoutAlign,
				autoDraw:false,
				//contextMenu:MatrixMenu_Td_main,//右键菜单
				members:[
				]
		});
		
		if(this.colSpan!=null){
			_mcomponent.colSpan = this.colSpan;
		}
		if(this.rowSpan!=null){
			_mcomponent.rowSpan = this.rowSpan;
		}
		//创建子组件
		this.createChildren(_mcomponent);
		this.id=null;
		return _mcomponent;
	},
	insertTd:function(){
		//var htmlTable = this.table;
		var htmlTR = this.tr;
		var htmlTD = null;
		if(this.index>=htmlTR.cells.length){
			htmlTD = htmlTR.insertCell();
		}else{
			htmlTD = htmlTR.insertCell(this.index);
		}
		var tdName = this.getName();
		htmlTD.id = tdName;
		if(this.style!=null){
			isc.MH.setElementStyle(htmlTD,this.style);
		}
		htmlTD.className="tdLayout";
        htmlTD.style.width = this.width+"px";
        htmlTD.style.height = this.height+"px";
		htmlTD.rowSpan = this.rowSpan;
		htmlTD.colSpan = this.colSpan;
		var mcanvas = this.createComponent();
		//mcanvas.width = this.width;
		//mcanvas.height = this.height;
		mcanvas.mparent = this.mparent;
		mcanvas.mparent.mchildren.add(mcanvas);
		mcanvas.draw();
        htmlTD.style.width = "";
        htmlTD.style.height = "";
        mcanvas.resizeTo(this.width,this.height);
        return htmlTD;
	}
});

//标签布局
isc.defineClass("MTTabContainer","MTComponent").addProperties({
	type:isc.MC.COMPONENT_TYPE.TabContainer,
	mtitle:isc.MatrixMessages.MT_TabContainer_title,
	hover:isc.MatrixMessages.MT_TabContainer_hover,
	micon:isc.MC.COMPONENT_TYPE.TabContainer
});

//水平分栏
isc.defineClass("MTHorizontalContainer","MTComponent").addProperties({
	type:isc.MC.COMPONENT_TYPE.HorizontalContainer,
	mtitle:isc.MatrixMessages.MT_HorizontalContainer_title,
	hover:isc.MatrixMessages.MT_HorizontalContainer_hover,
	micon:isc.MC.COMPONENT_TYPE.HorizontalContainer
});

//垂直分栏
isc.defineClass("MTVerticalContainer","MTComponent").addProperties({
	type:isc.MC.COMPONENT_TYPE.VerticalContainer,
	mtitle:isc.MatrixMessages.MT_VerticalContainer_title,
	hover:isc.MatrixMessages.MT_VerticalContainer_hover,
	micon:isc.MC.COMPONENT_TYPE.VerticalContainer
});

//标题面板
isc.defineClass("MTTitlePanel","MTComponent").addProperties({
	type:isc.MC.COMPONENT_TYPE.TitlePanel,
	mtitle:isc.MatrixMessages.MT_TitlePanel_title,
	hover:isc.MatrixMessages.MT_TitlePanel_hover,
	micon:isc.MC.COMPONENT_TYPE.TitlePanel
});

//抽屉布局
isc.defineClass("MTSectionStack","MTComponent").addProperties({
	type:isc.MC.COMPONENT_TYPE.SectionStack,
	mtitle:isc.MatrixMessages.MT_SectionStack_title,
	hover:isc.MatrixMessages.MT_SectionStack_hover,
	micon:isc.MC.COMPONENT_TYPE.SectionStack
});

//容器控件
isc.defineClass("MTContainerPanel","MTComponent").addProperties({
	type:isc.MC.COMPONENT_TYPE.ContainerPanel,
	mtitle:isc.MatrixMessages.MT_ContainerPanel_title,
	hover:isc.MatrixMessages.MT_ContainerPanel_hover,
	micon:isc.MC.COMPONENT_TYPE.ContainerPanel
});

//测试组件
isc.defineClass("MTTestComponent","MTComponent").addProperties({
	mtitle:"测试组件",
	hover:"测试组件",
	micon:'cube_yellow.png',
	initComponent:function(){
		isc.MH.showUpdateComponentWindow(this);
		var MDataGrid0_DS=[
				{value:'10.jpg',id:'10',title:'101010',desc:'101010101010101010'},{value:'11.jpg',id:'11',title:'111111',desc:'111111111111111111'},{value:'12.jpg',id:'12',title:'121212',desc:'121212121212121212'},{value:'13.jpg',id:'13',title:'131313',desc:'131313131313131313'},{value:'14.jpg',id:'14',title:'141414',desc:'141414141414141414'},{value:'15.jpg',id:'15',title:'151515',desc:'151515151515151515'},{value:'16.jpg',id:'16',title:'161616',desc:'161616161616161616'},{value:'17.jpg',id:'17',title:'171717',desc:'171717171717171717'},{value:'18.jpg',id:'18',title:'181818',desc:'181818181818181818'},{value:'19.jpg',id:'19',title:'191919',desc:'191919191919191919'}
			];
			isc.MDDataView.create({ID:"MDataGrid0",name:"DataGrid0",displayId:"DataGrid0_div",
				position:"relative",
				fields:[
					{name:"value",type:'image',imageURLPrefix:'/SmartClient/resource/tiles/images/',formatCellValue:function(value, record, rowNum, colNum,grid){return Matrix.formatter(value,'normal','null');}},
					{name:"id",type:'text',formatCellValue:function(value, record, rowNum, colNum,grid){return Matrix.formatter(value,'normal','null');}},
					{name:"title",type:'text',formatCellValue:function(value, record, rowNum, colNum,grid){return Matrix.formatter(value,'normal','null');}},
					{name:"desc",type:'text',formatCellValue:function(value, record, rowNum, colNum,grid){return Matrix.formatter(value,'normal','null');}}
				],
				tileWidth:150,tileHeight:190,autoFetchData:true,
				selectionType:"single",showEdges:false
			});
			MDataGrid0.getTile=function(record){return testGetTile(record);};
			MDataGrid0.setData(MDataGrid0_DS);
			isc.MH.addComponent(MTestLayout,MDataGrid0,0);
		return true;
	}
})



//----------------------------------------------end------------------------------




//----------------------------------------- mp end ------------------------------------------------

//----------------------------------------- mp data begain ------------------------------------------------

/*显示组件*/
var MPDisplayComponentData = new Array();

/*
//测试组件
MPDisplayComponentData.add(
	isc.MTTestComponent.create({mposition:"relative",mtitle:"relative"})
);
//测试组件
MPDisplayComponentData.add(
	isc.MTTestComponent.create()
);

*/
//显示标签
MPDisplayComponentData.add(
	isc.MTLabel.create()
);
//图片
MPDisplayComponentData.add(
	isc.MTImg.create()
);
//HTML片段
MPDisplayComponentData.add(
	isc.MTInnerHtml.create()
);

/*输入组件*/
var MPInputComponentData = new Array();
//文本框
MPInputComponentData.add(
	isc.MTFormItem.create({
		mtitle:isc.MatrixMessages.MT_TextItem_title,
		editorType:isc.MC.COMPONENT_TYPE.TextItem,
		hover:isc.MatrixMessages.MT_TextItem_hover,
		micon:isc.MC.COMPONENT_TYPE.TextItem
	})
);
//数字框
MPInputComponentData.add(
	isc.MTFormItem.create({
		mtitle:isc.MatrixMessages.MT_SpinnerItem_title,
		editorType:isc.MC.COMPONENT_TYPE.SpinnerItem,
		hover:isc.MatrixMessages.MT_SpinnerItem_hover,
		micon:isc.MC.COMPONENT_TYPE.SpinnerItem
	})
);
//文本域
MPInputComponentData.add(
	isc.MTFormItem.create({
		mtitle:isc.MatrixMessages.MT_TextAreaItem_title,
		editorType:isc.MC.COMPONENT_TYPE.TextAreaItem,
		hover:isc.MatrixMessages.MT_TextAreaItem_hover,
		micon:isc.MC.COMPONENT_TYPE.TextAreaItem
	})
);
//日期框
MPInputComponentData.add(
	isc.MTFormItem.create({
		mtitle:isc.MatrixMessages.MT_DateItem_title,
		editorType:isc.MC.COMPONENT_TYPE.DateItem,
		hover:isc.MatrixMessages.MT_DateItem_hover,
		micon:isc.MC.COMPONENT_TYPE.DateItem
	})
);
//时间框
MPInputComponentData.add(
	isc.MTFormItem.create({
		mtitle:isc.MatrixMessages.MT_TimeItem_title,
		editorType:isc.MC.COMPONENT_TYPE.TimeItem,
		hover:isc.MatrixMessages.MT_TimeItem_hover,
		micon:isc.MC.COMPONENT_TYPE.TimeItem
	})
);
//富文本框
MPInputComponentData.add(
	isc.MTComponent.create({
		mtitle:isc.MatrixMessages.MT_RichText_title,
		type:isc.MC.COMPONENT_TYPE.RichText,
		hover:isc.MatrixMessages.MT_RichText_hover,
		micon:isc.MC.COMPONENT_TYPE.RichText
	})
);

/*选择组件*/
var MPSelectComponentData = new Array();
//单选按钮
MPSelectComponentData.add(
	isc.MTRadioItem.create()
);
//单选按钮组
MPSelectComponentData.add(
	isc.MTRadioGroupItem.create()
);
//复选按钮
MPSelectComponentData.add(
	isc.MTFormItem.create({
		mtitle:isc.MatrixMessages.MT_CheckBoxItem_title,
		editorType:isc.MC.COMPONENT_TYPE.CheckBoxItem,
		hover:isc.MatrixMessages.MT_CheckBoxItem_hover,
		micon:isc.MC.COMPONENT_TYPE.CheckBoxItem
	})
);
//复选按钮组
MPSelectComponentData.add(
	isc.MTFormItem.create({
		mtitle:isc.MatrixMessages.MT_CheckBoxGroupItem_title,
		editorType:isc.MC.COMPONENT_TYPE.CheckBoxGroupItem,
		hover:isc.MatrixMessages.MT_CheckBoxGroupItem_hover,
		micon:isc.MC.COMPONENT_TYPE.CheckBoxGroupItem
	})
);
//下拉框
MPSelectComponentData.add(
	isc.MTFormItem.create({
		mtitle:isc.MatrixMessages.MT_ComboBoxItem_title,
		editorType:isc.MC.COMPONENT_TYPE.ComboBoxItem,
		hover:isc.MatrixMessages.MT_ComboBoxItem_hover,
		micon:isc.MC.COMPONENT_TYPE.ComboBoxItem
	})
);
//多选下拉框
MPSelectComponentData.add(
	isc.MTFormItem.create({
		mtitle:isc.MatrixMessages.MT_MultiFilteringSelect_title,
		editorType:isc.MC.COMPONENT_TYPE.MultiFilteringSelect,
		hover:isc.MatrixMessages.MT_MultiFilteringSelect_hover,
		micon:isc.MC.COMPONENT_TYPE.MultiFilteringSelect
	})
);
//下拉列表
MPSelectComponentData.add(
	isc.MTFormItem.create({
		mtitle:isc.MatrixMessages.MT_ListBox_title,
		editorType:isc.MC.COMPONENT_TYPE.ListBox,
		hover:isc.MatrixMessages.MT_ListBox_hover,
		micon:isc.MC.COMPONENT_TYPE.ListBox
	})
);
//单文件上传
MPSelectComponentData.add(
	isc.MTFormItem.create({
		mtitle:isc.MatrixMessages.MT_FileUpload_title,
		editorType:isc.MC.COMPONENT_TYPE.FileUpload,
		hover:isc.MatrixMessages.MT_FileUpload_hover,
		micon:isc.MC.COMPONENT_TYPE.FileUpload
	})
);
//多文件上传
MPSelectComponentData.add(
	isc.MTFormItem.create({
		mtitle:isc.MatrixMessages.MT_MultiFileUpload_title,
		editorType:isc.MC.COMPONENT_TYPE.MultiFileUpload,
		hover:isc.MatrixMessages.MT_MultiFileUpload_hover,
		micon:isc.MC.COMPONENT_TYPE.MultiFileUpload
	})
);
//弹出选择
MPSelectComponentData.add(
	isc.MTFormItem.create({
		mtitle:isc.MatrixMessages.MT_PopupSelectDialog_title,
		editorType:isc.MC.COMPONENT_TYPE.PopupSelectDialog,
		hover:isc.MatrixMessages.MT_PopupSelectDialog_hover,
		micon:isc.MC.COMPONENT_TYPE.PopupSelectDialog
	})
);

/*动作组件*/
var MPActionComponentData = new Array();
//按钮
MPActionComponentData.add(
	isc.MTButton.create()
);
//链接
MPActionComponentData.add(
	isc.MTComponent.create({
		mtitle:isc.MatrixMessages.MT_Link_title,
		type:isc.MC.COMPONENT_TYPE.Link,
		hover:isc.MatrixMessages.MT_Link_hover,
		micon:isc.MC.COMPONENT_TYPE.Link
	})
);
//图片按钮
MPActionComponentData.add(
	isc.MTImgButton.create()
);

/*工具栏组件*/
var toolBarComponentData = new Array();
// 工具栏
toolBarComponentData.add(
	isc.MTToolStrip.create()
);
//工具栏按钮
toolBarComponentData.add(
	isc.MTToolStripButton.create()
);
//工具栏菜单
toolBarComponentData.add(
	isc.MTToolStripMenuButton.create()
);
//工具栏分隔符
toolBarComponentData.add(
	isc.MTToolStripSeparator.create()
);

/*复合组件*/
var compositeComponentData = new Array();
//单表编辑
compositeComponentData.add(
	isc.MTEditForm.create()
);
//编辑列表
compositeComponentData.add(
	isc.MTEditList.create()
);
//查询表单
compositeComponentData.add(
	isc.MTQueryList.create()
);

if(isc.MH && isc.MH.phase!=isc.MC.PHASE_CUSTOMIZE){
	//非业务定制阶段添加
	//重复节
	compositeComponentData.add(
		isc.MTDataList.create()
	);
	//数据视图
	compositeComponentData.add(
		//isc.MTDataView.create()
		isc.MTQueryView.create()
	);
	//树
	compositeComponentData.add(
		isc.MTTreeGrid.create()
	);
}

//子页面
compositeComponentData.add(
	isc.MTIncludeForm.create()
);

/*
//自定义组件
compositeComponentData.add(
	isc.MTCustomComponent.create()
);
//流转控件
compositeComponentData.add(
	isc.MTStepsChoose.create()
);
//统计图
compositeComponentData.add(
	isc.MTDiagram.create()
);
//仪表盘
compositeComponentData.add(
	isc.MTDashboard.create()
);
*/

/*布局组件*/
var layoutComponentData = new Array();
//表格布局
layoutComponentData.add(
	isc.MTTable.create()
);
//标签布局
layoutComponentData.add(
	isc.MTTabContainer.create()
);
//水平分栏
layoutComponentData.add(
	isc.MTHorizontalContainer.create()
);
//垂直分栏
layoutComponentData.add(
	isc.MTVerticalContainer.create()
);
//标题面板
layoutComponentData.add(
	isc.MTTitlePanel.create()
);
if(isc.MH && isc.MH.phase!=isc.MC.PHASE_CUSTOMIZE){
	//非业务定制阶段添加
	//抽屉布局
	layoutComponentData.add(
		isc.MTSectionStack.create()
	);
	//容器控件
	layoutComponentData.add(
		isc.MTContainerPanel.create()
	);
}

//----------------------------------------- mp data end ------------------------------------------------



//----------------------------------------- menu begain ------------------------------------------------

// 修改属性菜单项
var MatrixMenu_Common_sub_update = {title:isc.MatrixMessages.Label_Property,enableIf:"isc.MH.enableToUpdate(target)",click:"isc.MH.showUpdateComponentWindow(target)"};
// 删除组件菜单项
var MatrixMenu_Common_sub_remove = {title:isc.MatrixMessages.Label_Delete,enableIf:"isc.MH.enableToRemove(target)",click:"isc.MH.removeComponent(target)"};

//表格列插入子菜单
isc.Menu.create({
    ID:"MatrixMenu_Td_sub_insert",
    autoDraw:false,
    width:150,
    data:[
        {title:isc.MatrixMessages.Label_Td_insertLeft, click:"isc.MH.insertColumn(target,'left')"},
        {title:isc.MatrixMessages.Label_Td_insertRight, click:"isc.MH.insertColumn(target,'right')"},
        {title:isc.MatrixMessages.Label_Tr_insertTop, click:"isc.MH.insertRow(target,'top')"},
        {title:isc.MatrixMessages.Label_Tr_insertBottom, click:"isc.MH.insertRow(target,'bottom')"}
    ]
});

//表格列删除子菜单
isc.Menu.create({
    ID:"MatrixMenu_Td_sub_remove",
    autoDraw:false,
    data:[
        {title:isc.MatrixMessages.MT_Td_title,click:"isc.MH.deleteColumn(target);"},
        {title:isc.MatrixMessages.MT_Tr_title,click:"isc.MH.deleteRow(target);"},
        {title:isc.MatrixMessages.MT_TableLayout_title,click:"isc.MH.removeComponent(target.mparent);"}
    ],
    width:150
});

//表格属性子菜单
isc.Menu.create({
    ID:"MatrixMenu_Td_sub_property",
    autoDraw:false,
    data:[
        {title:isc.MatrixMessages.MT_Cell_title,click:"isc.MH.showUpdateComponentWindow(target);"},
        {title:isc.MatrixMessages.MT_Tr_title,click:"isc.MH.showUpdateTrWindow(target);"},
        {title:isc.MatrixMessages.MT_TableLayout_title,click:"isc.MH.showUpdateComponentWindow(target.mparent);"}
    ],
    width:150
});


//表格列主菜单
isc.Menu.create({
    ID:"MatrixMenu_Td_main",
    width:150,
    autoDraw:false,
    data:[
        {title:isc.MatrixMessages.Label_Insert, submenu:MatrixMenu_Td_sub_insert},
        {title:isc.MatrixMessages.Label_Delete, submenu:MatrixMenu_Td_sub_remove},
        {title:isc.MatrixMessages.Label_MergeCell,enableIf:"isc.MH.validateMergeCell(target)",click:"isc.MH.mergeCell(target);"},
        {title:isc.MatrixMessages.Label_SplitCell,enableIf:"isc.MH.validateSplitCell(target)",click:"isc.MH.splitCell(target)"},
        {title:isc.MatrixMessages.Label_Property, submenu:MatrixMenu_Td_sub_property}
    ]
});
		
//----------------------------------------- menu end ------------------------------------------------


//----------------------------------------- designer frame ------------------------------------------------

isc.VLayout.create({
			ID:"MMatrixDesignerMainLayout",
			name:"MatrixDesignerMainLayout",
			width: "100%",
			height:'100%',
			showEdges: true,
			edgeSize:2,
			members : [
				isc.HLayout.create({
					// 工具面板
					ID:"MMatrixDesignerToolsLayout",
					name:"MatrixDesignerToolsLayout",
					width: "100%",
					height: 30,
					overflow: "auto",
					//canDragResize: true,
					showResizeBar:false,
					members:[
						isc.ToolStrip.create({
							ID:"MMatrixDesignerTools",
							name:"MatrixDesignerTools",
							overflow:"hidden",
							defaultLayoutAlign:"center",
							width:"100%", 
							height:"100%",
							members:[
								isc.ToolStripMenuButton.create({
								    title:isc.MH.getDesignerMenuTitleWithIcon("file"),
								    menu:isc.Menu.create({
									    autoDraw: false,
									    showShadow: true,
									    shadowDepth: 10,
									    data: [
									        {title:isc.MatrixMessages.Label_Import,
									         click:"isc.MH.importFormXML()",
									         icon:isc.MH.getActionIcon("import_hd")
									         },
									        {title:isc.MatrixMessages.Label_Export,
									         click:"isc.MH.exportFormXML()",
									         icon:isc.MH.getActionIcon("save_hd")
									        }
									        ]
									})
								}),
							    isc.ToolStripMenuButton.create({
								    title:isc.MH.getDesignerMenuTitleWithIcon("edit"),
								    height:24,
								    menu:isc.Menu.create({
									    autoDraw: false,
									    showShadow: true,
									    shadowDepth: 10,
									    data: [
									        {title:isc.MatrixMessages.Label_Copy,click:"isc.MH.copyComponent();",icon:isc.MH.getActionIcon("copy")},
									        {title:isc.MatrixMessages.Label_Cut,click:"isc.MH.cutComponent();",icon:isc.MH.getActionIcon("cut")},
									        {title:isc.MatrixMessages.Label_Paste,click:"isc.MH.pasteComponent();",icon:isc.MH.getActionIcon("paste")},
									        {title:isc.MatrixMessages.Label_Delete,click:"isc.MH.removeComponent(isc.MH.selectedItems);",icon:isc.MH.getActionIcon("delete")}
									    ]
									})
								}),
							    isc.ToolStripButton.create({
									title:isc.MatrixMessages.Label_Property,
									click:"isc.MH.showUpdateComponentWindow(isc.MC.COMPONENT_TYPE.Form)",
									showDisabledIcon:false,
									height:24,icon:isc.MH.getActionIcon("property")
							    }),
							    "separator",
							     isc.ToolStripButton.create({
							    	ID:"MMatrixValidateButton",
									title:isc.MatrixMessages.Label_Validate,
									click:"isc.MH.validateFormModel();",
									showDisabledIcon:false,
									height:24,icon:isc.MH.getActionIcon("validate")
							    }),
							    isc.ToolStripButton.create({
							    	ID:"MMatrixDebugButton",
									title:isc.MatrixMessages.Label_Debug,
									click:"isc.MH.debugFormModel();",
									showDisabledIcon:false,
									height:24,icon:isc.MH.getActionIcon("debug")
							    }),
							    isc.ToolStripButton.create({
							    	ID:"MMatrixSaveButton",
									title:isc.MatrixMessages.Label_Save,
									click:"isc.MH.saveFormModel();",
									//showDisabled:false,
									showDisabledIcon:false,
									height:24,icon:isc.MH.getActionIcon("save")
							    }),
							    isc.ToolStripButton.create({
							    	ID:"MMatrixPublishButton",
									title:isc.MatrixMessages.Label_Publish,
									click:"isc.MH.publishFormModel();",
									//showDisabled:false,
									showDisabledIcon:false,
									height:24,icon:isc.MH.getActionIcon("publish")
							    }),
							    isc.ToolStripButton.create({
							    	ID:"MMatrixUnPublishButton",
									title:isc.MatrixMessages.Label_UnPublish,
									click:"isc.MH.unPublishFormModel();",
									//showDisabled:false,
									showDisabledIcon:false,
									height:24,icon:isc.MH.getActionIcon("undo")
							    }),
							    isc.ToolStripButton.create({
							    	ID:"MMatrixRefreshButton",
									title:isc.MatrixMessages.Label_Refresh,
									click:"isc.MH.reloadComponent();",
									//showDisabled:false,
									showDisabledIcon:false,
									height:24,icon:isc.MH.getActionIcon("refresh")
							    }),
							    "separator",
							    isc.ToolStripButton.create({
							    	ID:"MMatrixExitButton",
									title:isc.MatrixMessages.Label_Exit,
							    	click:"isc.MH.exitFormDesigner();",
									showDisabledIcon:false,
									height:24,icon:isc.MH.getActionIcon("exit")
							    }),
							   /* 
							    "separator",
							    isc.ToolStripButton.create({
									title:"debug",
									click:"isc.showConsole();",
									height:24,icon:webContextPath+"/resource/images/matrix/Query.png"
							    }),
							    */
								isc.Label.create({
								   ID:"MMatrixStatusLabel",
						           align:'right',width:'*'
						           //contents:isc.MH.getFormStatusInfo()
						        }),
						        isc.ToolStripButton.create({
						           ID:"MMatrixStatusButton",
								   title:isc.MatrixMessages.Label_ChangeStatus,
									//showDisabled:false,
									showDisabledIcon:false,
								   click:"isc.MH.changeStatus()",
							       icon:isc.MH.getStatusButtonIcon()
							    })
							]
						})
						
					]
				})
			 ,
			 isc.TabSet.create({
			    ID: "MMDTabSet",
			    id: "MDTabSet",
			    name: "MDTabSet",
			    tabBarPosition: "bottom",
			    width: "100%",
			    height:'*',
			    paneMargin:0,
			    tabSelected:function(tabNum, tabPane, ID, tab, name){
			    	if(this.isDrawn()){
				    	if(tab.mtype=="design"){
				    		// 重新加载组件
				    		isc.MH.reloadComponent();
				    	}else if(tab.mtype=="sourceCode"){
				    		// 重新加载源代码
				    		isc.MH.reloadSourceCode();
				    	}else if(tab.mtype=="preview"){
				    		// 预览
				    		isc.MH.preview();
				    	}
			    	}
			    },
			    //tabs begin
			    tabs: [
			        {title:isc.MatrixMessages.Label_Designer, 
			        	mtype:"design",//标识类型
			        	icon:isc.MH.getActionIcon("design"), iconSize:16,
			        	 pane:isc.HLayout.create({
							ID:"MMatrixDesignerBodyLayout",
							name:"MatrixDesignerBodyLayout",
						    width: "100%",
						     height:'*',
						    //showEdges: true,
						    dragAppearance: "target",
						    overflow: "hidden",
						    canDragResize: true,
						    resizeFrom: [ "L", "R" ],
						    minWidth: 100,
						    minHeight: 50,
						    members : [
						   		/*
						   		isc.MDBorder.create({
						    		ID:"MBorderLeft",
			   						backgroundColor: "#d0d0d0",
						    		width:100
						    	}),
						    	*/
								// 设计区域
								isc.HLayout.create({
									ID:"MMatrixDesignerContent",
									name:"MatrixDesignerContent",
									width: '*',
									height: '100%',
									overflow:'hidden',
									canFocus:false,
									canDragReposition:false,
									showResizeBar:true,
									resizeBarTarget:"next",
									members:[
									]
								}),
						    	/*
						    	isc.MDBorder.create({
						    		ID:"MBorderRight",
						    		width:100,
									//showEdges:true,
									resizeBarTarget:"next", //调整尺寸合并目标
									showResizeBar:true,
			   						backgroundColor: "#d0d0d0"
									//canDragReposition:false
									//canDragResize: true,
						    	}),
						    	*/
								 // 组件面板
							     isc.MTComponentSectionStack.create({
									border:0,
									ID: "MMatrixComponentSectionStack",
									name: "MatrixComponentSectionStack",
									//canDragResize: true,
									//showResizeBar:true,
									//resizeBarTarget:"next",
									//visibilityMode: "multiple",
									width: '20%',    
									height: '100%',
									sections: [
									//显示组件
									{ 
										ID:"MMTDisplayComponent",name:"MTDisplayComponent",canDragRecordsOut: true,title:isc.MatrixMessages.MT_DisplayComponent_title, expanded:true, type:"0",canDrag:false,
										items: [
											isc.MTComponentList.create({
											      data:MPDisplayComponentData
											})
										]
									},
									//输入组件
									{ 
										ID:"MMTInputComponent",name:"MTInputComponent",canDragRecordsOut: true,title:isc.MatrixMessages.MT_InputComponent_title, expanded:false, type:"0",canDrag:false,
										items: [
											isc.MTComponentList.create({
											      data:MPInputComponentData
											})
										]
									},
									//选择组件
									{ 
										ID:"MMTSelectComponent",name:"MTSelectComponent",canDragRecordsOut: true,title:isc.MatrixMessages.MT_SelectComponent_title, expanded:false, type:"0",canDrag:false,
										items: [
											isc.MTComponentList.create({
											      data:MPSelectComponentData
											})
										]
									},
									//动作组件
									{ 
										ID:"MMTActionComponent",name:"MTActionComponent",canDragRecordsOut: true,title:isc.MatrixMessages.MT_ActionComponent_title,
										expanded:false, type:"0",canDrag:false,
										items: [
											isc.MTComponentList.create({
											      data:MPActionComponentData
											})
										]
									},
									//工具栏组件
									{
										ID:"MMTToolBarComponent",name:"MTToolBarComponent",canDragRecordsOut: true,title:isc.MatrixMessages.MT_ToolBarComponent_title,expanded:false, type:"0",canDrag:false, 
										items: [
											isc.MTComponentList.create({
											      data:toolBarComponentData
											})
										]
									},
									//复合组件
									{
										ID:"MMTCompositeComponent",name:"MTCompositeComponent",canDragRecordsOut: true,title:isc.MatrixMessages.MT_CompositeComponent_title,expanded:false, type:"0",canDrag:false, 
										items: [
											isc.MTComponentList.create({
											      data:compositeComponentData
											})
										]
									},
									//布局组件
									{
										ID:"MMTLayoutComponent",name:"MTLayoutComponent",canDragRecordsOut: true,title:isc.MatrixMessages.MT_LayoutComponent_title,expanded:false, type:"0",canDrag:false, 
										items: [
											isc.MTComponentList.create({
											      data:layoutComponentData
											})
										]
									}
									]
								 })
						    ]
						})
			        },
			        {title:isc.MatrixMessages.Label_SourceCode, 
			        	id:"MDsourceCode",name:"MDsourceCode",
			        	mtype:"sourceCode",//标识类型
			        	icon:isc.MH.getActionIcon("source_code"), iconSize:16,
			        	 pane:isc.HTMLPane.create({ID:"MMatrixSourceCode",autoDraw:false,
			        	 			name:"MatrixSourceCode",contentsURL:"",
			        	 			showEdges:false,contentsType:"page",width:"100%",height:"100%",overflow:"hidden"
			        	 	   })
			        },
			        {title:isc.MatrixMessages.Label_Preview,
			        	icon:isc.MH.getActionIcon("preview"), iconSize:16,
			        	mtype:"preview",//标识类型
			        	 pane:isc.HTMLPane.create({ID:"MMatrixPreview",autoDraw:false,
			        	 			name:"MatrixPreview",contentsURL:"",
			        	 			showEdges:false,contentsType:"page",width:"100%",height:"100%",overflow:"hidden"
			        	 	   })
			        }
				],
		        // tabs end 
		        tabBarControls : [
		        	 //表单信息
			         isc.Label.create({
			           ID:"MMDformInfoLabel",id:"MDformInforLabel",name:"MDformInforLabel",
			           width:400,
			           contents:isc.MH.getFormInfoLabel()             
			        })
			     ]
		        
			})
			
			]
			});
			
			if(isc.MH){
				if(isc.MH.phase==isc.MC.PHASE_CUSTOMIZE){
					//业务定制阶段移除动作组件和工具栏组件模板
					MMatrixComponentSectionStack.removeSection(['MTActionComponent','MTToolBarComponent']);
				}
				
				if(isc.MH.phase==isc.MC.PHASE_CUSTOMIZE || isc.MH.isScene){
					//场景移除源码标签
					MMDTabSet.removeTab("MDsourceCode");
				}
				
				//设置操作按钮状态
				isc.MH.changeOperationStatus();
			}
			
			//创建设计器表单
	    	var MatrixDesignerForm=
				isc.MatrixForm.create({ID:"MMatrixDesignerForm",name:"MatrixDesignerForm",
				position:"absolute",
				fields:[{name:'MatrixDesignerForm_hidden_text',width:0,height:0,displayId:'MatrixDesignerForm_hidden_text_div'}]
			});
		    isc.MH.setFormComponent(MMatrixDesignerForm);
			
			var mdpHeight = isc.MH.isScene?500:550;
			
			mdpHeight = "80%";
				
			//属性编辑窗口
			isc.MatrixWindow.create({
			    ID: "MMDPropertyWindow",
			    id:"MDPropertyWindow",
			    title: "&nbsp;",
			    //targetDialog:isc.MH.isScene?"MTopPropertyWindow":null,
			    autoCenter: true,
			    width:860,
			    height:mdpHeight,
			    isModal: true,		
			    showModalMask: false,
				modalMaskOpacity:0,
			    autoDraw: false,
			    showMinimizeButton:false,
			    src:isc.MC.DESIGNER_REQUEST_URL
			});
			
			//表单导入窗口
			isc.MatrixWindow.create({
			    ID: "MMDImportFormXMLWindow",
			    id:"MDImportFormXMLWindow",
			    title: isc.MatrixMessages.Title_FormXML_import,
			    autoCenter: true,
			    width:400,
			    height:200,
			    isModal: true,		
			    showModalMask: false,
				modalMaskOpacity:0,
			    autoDraw: false,
			    showMinimizeButton:false,
			    initSrc:isc.MC.DESIGNER_IMPORT_FORM_XML_URL,
			    src:isc.MC.DESIGNER_IMPORT_FORM_XML_URL
			});
			
			//表格创建窗口
			isc.MatrixWindow.create({
				ID: "MatrixTableCreateWindow",
			    title:isc.MatrixMessages.Title_Table_create,
			    width:180,
			    height:150,
			    autoCenter: true,
			    isModal: true,		
			    showModalMask: false,
				modalMaskOpacity:0,
			    autoDraw: false,
			    closeClick:function () {
			    	this.Super("closeClick", arguments);
			    },
			    items: [
			    	isc.VLayout.create({
			    		width: "100%",
			    		height: "100%",
			   			members:[
					        isc.DynamicForm.create({
					            autoDraw: false,
					            width:"150",
					            padding:4,
					            align:"left",
					            fields: [
					                  {ID:"MatrixTrCreateNum",name:"matrixTrCreateNum",title:isc.MatrixMessages.Label_Tr_num,titleAlign:"left",editorType:"spinner",defaultValue:1,min:1,step:1,width:100},
					                  {ID:"MatrixTdCreateNum",name:"matrixTdCreateNum",title:isc.MatrixMessages.Label_Td_num,titleAlign:"left",editorType:"spinner", defaultValue:1,min:1,step:1,width:100}
					            ]
					        }),
					        isc.HLayout.create({
					            padding:4,
			    				membersMargin: 10,
			    				align:"center",
					        	members:[
					        		 isc.IButton.create({
			            				ID:"MatrixTableCreateSubmit",name:"matrixTableCreateSubmit",type: "button",width:50,title:isc.MatrixMessages.Label_Submit,click: "MatrixTableCreateWindow.hide();MatrixTableCreateWindow.mtable.createComponent();"
			        				 }),
					        		 isc.IButton.create({
			            				ID:"MatrixTableCreateCancel",name:"matrixTableCreateCancel",type: "button",width:50,title:isc.MatrixMessages.Label_Cancel,click: "MatrixTableCreateWindow.hide();"
			        				 })
					        	]
					        })
			        	]
			        })
			    ]
				
			});
			
			//表格布局拆分确认窗口
			isc.MatrixWindow.create({
				ID: "MatrixSplitCellWindow",
			    title:isc.MatrixMessages.Title_Cell_split,
			   // autoSize:true,
			    width:180,
			    height:150,
			    autoCenter: true,
			    isModal: true,		
			    showModalMask: false,
				modalMaskOpacity:0,
			    autoDraw: false,
			    closeClick:function () {
			    	this.Super("closeClick", arguments);
			    },
			    items: [
			    	isc.VLayout.create({
			    		width: "100%",
			    		height: "100%",
			    		//membersMargin:10,
			   			members:[
					        isc.DynamicForm.create({
					            autoDraw: false,
					            width:"150",
					            padding:4,
					            align:"left",
					            fields: [
					                  {ID:"MatirxSplitColumnNum",name:"mSplitColumnNum",title:isc.MatrixMessages.Label_Td_num,titleAlign:"left",editorType:"spinner",defaultValue:1,min:1,step:1,width:100},
					                  {ID:"MatirxSplitRowNum",name:"mSplitRowNum",title:isc.MatrixMessages.Label_Tr_num,titleAlign:"left",editorType:"spinner", defaultValue:1,min:1,step:1,width:100}
					            ]
					        }),
					        isc.DynamicForm.create({
					            autoDraw: false,
					            width:"100%",
					            align:"left",
					            fields: [
					                  {ID:"MatirxMergeBeforeSplit",name:"mMergeBeforeSplit",showTitle:false,title:isc.MatrixMessages.Label_MergeBeforeSplit,type:"checkbox"}
					            ]
					        }),
					        isc.HLayout.create({
					            padding:4,
			    				membersMargin: 10,
			    				align:"center",
					        	members:[
					        		 isc.IButton.create({
			            				ID:"MatirxSplitSubmit",name:"mSplitSubmit",type: "button",width:50,title:isc.MatrixMessages.Label_Submit,click: "MatrixSplitCellWindow.hide();isc.MH.splitCellSubmit(MatrixSplitCellWindow.mcell);"
			        				 }),
					        		 isc.IButton.create({
			            				ID:"MatirxSplitCancel",name:"mSplitCancel",type: "button",width:50,title:isc.MatrixMessages.Label_Cancel,click: "MatrixSplitCellWindow.hide();"
			        				 })
					        	]
					        })
			        	]
			        })
			    ]
				
			});
			
			//校验表单模型窗口
			isc.Window.create({
				ID:"MMValidateForm",
				id:"MValidateForm",
				name:"MValidateForm",
			    title:isc.MatrixMessages.Title_FormModel_validate,
			    autoCenter: true,
			    width:600,
			    height:500,
			    isModal: true,		
			    showModalMask: false,
				modalMaskOpacity:0,
			    autoDraw: false,
			    showMinimizeButton:false,
				initSrc:isc.MC.DESIGNER_VALIDATE_FORM_URL,
			    src:isc.MC.DESIGNER_VALIDATE_FORM_URL
			 });


//----------------------------------------- designer frame end ------------------------------------------------
