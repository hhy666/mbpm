<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.io.*,java.text.*,java.util.*,java.sql.*,java.text.SimpleDateFormat,java.text.DateFormat,java.util.Date,javax.servlet.*,javax.servlet.http.*,DBstep.iDBManager2000.*" %>
<%@page import="java.net.URLDecoder"%>
<%
  ResultSet result=null;
  
  String mStatus=null;
  String mAuthor=null;
  String mFileName=null;
  String mFileDate=null;
  String mHTMLPath="";

  String mDisabled="";
  String mDisabledSave="";
  String mWord="";
  String mExcel="";

  //自动获取OfficeServer和OCX文件完整URL路径
  String mHttpUrlName=request.getRequestURI();
  String mScriptName=request.getServletPath();
  String mServerName="OfficeServer";
 // String canEdit=request.getParameter("canEdit");     //可编辑
 // String canSave = request.getParameter("canSave");   //可保存
 // String canVBA = reqeust.getParameter("canVBA");     //可套红
 // String canCopy = request.getParameter("canCopy");   //可拷贝
 // String canPrint  = request.getParameter("canPrint");//可打印

  String mServerUrl="http://"+request.getServerName()+":"+request.getServerPort()+mHttpUrlName.substring(0,mHttpUrlName.lastIndexOf(mScriptName))+"/"+mServerName;//取得OfficeServer文件的完整URL
  String mHttpUrl="http://"+request.getServerName()+":"+request.getServerPort()+mHttpUrlName.substring(0,mHttpUrlName.lastIndexOf(mScriptName))+"/";
  String mRecordID=request.getParameter("RecordID");
  String mTemplate=request.getParameter("Template");
  String mFileType=request.getParameter("FileType");
  String mEditType=request.getParameter("EditType");
  String title = request.getParameter("title");
  String subTitle = request.getParameter("subTitle");
  String sign = request.getParameter("sign");
  String templateId = request.getParameter("templateId");
  String content = request.getParameter("content");
  String recordId = request.getParameter("recordId");
  String mSubject= "";
  String mUserName="user";
  boolean isNewDocument = false;
  //设置编号初始值
  if (mRecordID==null){
     mRecordID="";
  }

  //设置编辑状态初始值
  if (mEditType==null || mEditType==""){
    mEditType="1";
  }

  //设置文档类型初始值
  if (mFileType==null || mFileType==""){
    mFileType=".doc";
  }

  //设置用户名初始值
  if (mUserName==null || mUserName==""){
    mUserName="华创动力";
  }

  //设置模板初始值
  if (mTemplate==null){
    mTemplate="";
  }
        //取得唯一值(mRecordID)
        java.util.Date dt=new java.util.Date();
        long lg=dt.getTime();
        Long ld=new Long(lg);
        //初始化值
        mRecordID=ld.toString();//保存的是文档的编号，通过该编号，可以在里找到所有属于这条纪录的文档
        mTemplate=mTemplate;
        mSubject="请输入主题"+new Date();
        mAuthor=mUserName;
        mFileDate="";
        mStatus="DERF";
        mFileType=mFileType;
        mHTMLPath="";
        isNewDocument = true;
      
   String mWPS="";
   if (mEditType.equalsIgnoreCase("0")){
    mDisabled="disabled";
    mDisabledSave="disabled";

  }else{
	if (mFileType.equalsIgnoreCase(".doc") || mFileType.equalsIgnoreCase(".docx")){
		mWPS ="";
		mWord="";
		mExcel = "disabled";
	  }else if(mFileType.equalsIgnoreCase(".wps")){
		mWPS ="disabled";
		mWord="";
		mExcel = "disabled";
	  }
	  else if (mFileType.equalsIgnoreCase(".xls")||mFileType.equalsIgnoreCase(".xlsx")){
		mWord="disabled";
		mWPS ="";
		mExcel = "";
	  }
	  else{
		mDisabled="disabled";
	  }
  }
  mFileName=mRecordID + mFileType;  //取得完整的文档名称
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
 <title>华创动力智能文档中间件示例程序</title>
 <meta http-equiv="X-UA-Compatible" content="IE=9" />
 <script src="js/jquery-1.4.2.min.js"></script>
 <script src="js/WebOffice.js"></script>
 <jsp:include page="/foundation/common/taglib.jsp"/>
<jsp:include page="/foundation/common/resource.jsp"/>
 <script type="text/javascript">
 
</script>
<link rel='stylesheet' type='text/css' href='css/iWebProduct.css' />


<!-- 以下为2015主要方法 -->
<script type="text/javascript">
 	var WebOffice = new WebOffice2015(); //创建WebOffice对象
</script>
<script type="text/javascript">
 	function Load(){
 	  try{
 	  		var entity = Matrix.getFormItemValue('entity');
 	  		
 	  		WebOffice.WebUrl="<%=mServerUrl%>";             //WebUrl:系统服务器路径，与服务器文件交互操作，如保存、打开文档，重要文件
		   // WebOffice.RecordID="<%=mRecordID%>";            //RecordID:本文档记录编号
		    WebOffice.FileName="<%=mFileName%>";            //FileName:文档名称
		    WebOffice.FileType="<%=mFileType%>";            //FileType:文档类型  .doc  .xls  
		    WebOffice.UserName="<%=mUserName%>";            //UserName:操作用户名，痕迹保留需要
		    WebOffice.title="<%=title%>";
		    WebOffice.subTitle="<%=subTitle%>";
		    WebOffice.sign="<%=sign%>";
		    WebOffice.templateId="<%=templateId%>";
		    WebOffice.recordId = "<%=recordId%>";
		    WebOffice.Entity = entity;
		  var title = "<%=title%>";
		  var subTitle = "<%=subTitle%>";
		  var sign = "<%=sign%>";
		  var content =  Matrix.getFormItemValue('content');
			WebOffice.Skin('purple');                        //设置皮肤
			WebOffice.HookEnabled();
		   if(WebOffice.WebOpen()){                             //打开该文档    交互OfficeServer  调出文档OPTION="LOADFILE"
			  WebOffice.setEditType("<%=mEditType%>");         //EditType:编辑类型  方式一   WebOpen之后
			    WebOffice.VBASetUserName(WebOffice.UserName);    //设置用户名
			    StatusMsg(WebOffice.Status);
			   	
			   
 				self.resizeTo(screen.availWidth,screen.availHeight); 
		   }
		   WebOffice.FullSize(false);
 	  }catch(e){
 	  	 alert(e.description);       
 	  }
 	}
	 //作用：保存文档
	function SaveDocument(){
		//var path = WebOffice.getFilePath();
		//Matrix.setFormItemValue('path',path);
		//document.getElementById("iWebOfficeForm").submit();
	  if (WebOffice.WebSave()){    //交互OfficeServer的OPTION="SAVEFILE"
	  		window.opener.location.reload();
	  		window.close();
	     //document.getElementById("iWebOfficeForm").submit();
	     return true;
	  }else{
	     StatusMsg(WebOffice.Status);
	     return false;
	  }
	  
	}
 	
 	
 	//设置页面中的状态值
 	function StatusMsg(mValue){
 	   try{
	  	 document.getElementById('state').innerHTML = mValue;
	   }catch(e){
	     return false;
	   }
	}
	
	//作用：获取文档Txt正文
	function WebGetWordContent(){
	  try{
	    alert(WebOffice.WebObject.ActiveDocument.Content.Text);
	  }catch(e){alert(e.description);}
	}
	
	//作用：写Word内容
	function WebSetWordContent(){
	  var mText=window.prompt("lpz请输入内容:","lpz测试内容");
	  if (mText==null){
	     return (false);
	  }else{
	     WebOffice.WebObject.ActiveDocument.Application.Selection.Range.Text= mText+"\n";
	  }
	}

	//作用：获取文档页数
	function WebDocumentPageCount(){
	    if (WebOffice.FileType==".doc"||WebOffice.FileType==".docx"){
		var intPageTotal = WebOffice.WebObject.ActiveDocument.Application.ActiveDocument.BuiltInDocumentProperties(14);
		intPageTotal = WebOffice.blnIE()?intPageTotal:intPageTotal.Value();
		alert("文档页总数："+intPageTotal);
	    }
	    if (WebOffice.FileType==".wps"){
			var intPageTotal = WebOffice.WebObject.ActiveDocument.PagesCount();
			alert("文档页总数："+intPageTotal);
	    }
	}
	
	//作用：显示或隐藏痕迹[隐藏痕迹时修改文档没有痕迹保留]  true表示隐藏痕迹  false表示显示痕迹
	function ShowRevision(mValue){
	  if (mValue){
	     WebOffice.WebShow(true);
	     StatusMsg("显示痕迹...");
	  }else{
	     WebOffice.WebShow(false);
	     StatusMsg("隐藏痕迹...");
	  }
	}
	
	//接受文档中全部痕迹
	function WebAcceptAllRevisions(){
	  WebOffice.WebObject.ActiveDocument.Application.ActiveDocument.AcceptAllRevisions();
	  var mCount = WebOffice.WebObject.ActiveDocument.Application.ActiveDocument.Revisions.Count;
	  if(mCount>0){
	    return false;
	  }else{
	    return true;
	  }
	}
	
		//作用：VBA套红
	function WebInsertVBA(){
		var redTemplateId = Matrix.getFormItemValue('redTemplateId');
		var url = "<%=request.getContextPath()%>/SaveDocument";
		var json = "{'mOption':'VBA','redTemplateId':'"+redTemplateId+"'}";
		var synJson = isc.JSON.decode(json);
		Matrix.sendRequest(url,synJson,function(data){
			var VBA = isc.JSON.decode(data.data);
			var vbaContent = VBA.vba;
			var myRange=WebOffice.WebObject.ActiveDocument.Range(0,0);
			WebOffice.WebObject.ActiveDocument.Application.Selection.Range(0,0).InsertAfter (vbaContent+"\n");
			//套红之后设置边距
			WebOffice.WebObject.ActiveDocument.PageSetup.LeftMargin=70;
			WebOffice.WebObject.ActiveDocument.PageSetup.RightMargin=70;
			WebOffice.WebObject.ActiveDocument.PageSetup.TopMargin=70;
			WebOffice.WebObject.ActiveDocument.PageSetup.BottomMargin=70;
		});
		
	}

	//作用：设置书签值  vbmName:标签名称，vbmValue:标签值   标签名称注意大小写
	function SetBookmarks(){
		try{
			var mText=window.prompt("请输入书签名称和书签值，以','隔开。","例如：book1,book2");
			var mValue = mText.split(",");
			BookMarkName = mValue[0];
			BookMarkValue = mValue[1];
			WebOffice.WebSetBookmarks(mValue[0],mValue[1]);
			StatusMsg("设置成功");
			return true;
		}catch(e){
			StatusMsg("书签不存在");
			return false;
		}
	}

	function DelFile(){
	   var mFileName = WebOffice.FilePath+WebOffice.FileName;
       WebOffice.Close(); 
       WebOffice.WebDelFile(mFileName);
	}
	//作用：用Excel求和
	function WebGetExcelContent(){
	  if(!WebOffice.WebObject.ActiveDocument.Application.Sheets(1).ProtectContents){
		  WebOffice.WebObject.ExitExcelEditMode();
		  WebOffice.WebObject.Activate(true);  
		  WebOffice.WebObject.ActiveDocument.Application.Sheets(1).Select();
		  WebOffice.WebObject.ActiveDocument.Application.Range("C5").Select();
		  WebOffice.WebObject.ActiveDocument.Application.ActiveCell.FormulaR1C1 = "126";
		  WebOffice.WebObject.ActiveDocument.Application.Range("C6").Select();
		  WebOffice.WebObject.ActiveDocument.Application.ActiveCell.FormulaR1C1 = "446";
		  WebOffice.WebObject.ActiveDocument.Application.Range("C7").Select();
		  WebOffice.WebObject.ActiveDocument.Application.ActiveCell.FormulaR1C1 = "556";
		  WebOffice.WebObject.ActiveDocument.Application.Range("C5:C8").Select();
		  WebOffice.WebObject.ActiveDocument.Application.Range("C8").Activate();
		  WebOffice.WebObject.ActiveDocument.Application.ActiveCell.FormulaR1C1 = "=SUM(R[-3]C:R[-1]C)";
		  WebOffice.WebObject.ActiveDocument.Application.Range("D8").Select();
		  WebOffice.WebObject.ActiveDocument.application.sendkeys("{ESC}");
		  StatusMsg(WebOffice.WebObject.ActiveDocument.Application.Range("C8").Text);
	  }
	
	}
	
		//作用：保护工作表单元
	function WebSheetsLock(){
		 if(!WebOffice.WebObject.ActiveDocument.Application.Sheets(1).ProtectContents){
	  WebOffice.WebObject.ActiveDocument.Application.Range("A1").Select();
	  WebOffice.WebObject.ActiveDocument.Application.ActiveCell.FormulaR1C1 = "产品";
	  WebOffice.WebObject.ActiveDocument.Application.Range("B1").Select();
	  WebOffice.WebObject.ActiveDocument.Application.ActiveCell.FormulaR1C1 = "价格";
	  WebOffice.WebObject.ActiveDocument.Application.Range("C1").Select();
	  WebOffice.WebObject.ActiveDocument.Application.ActiveCell.FormulaR1C1 = "详细说明";
	  WebOffice.WebObject.ActiveDocument.Application.Range("D1").Select();
	  WebOffice.WebObject.ActiveDocument.Application.ActiveCell.FormulaR1C1 = "库存";
	  WebOffice.WebObject.ActiveDocument.Application.Range("A2").Select();
	  WebOffice.WebObject.ActiveDocument.Application.ActiveCell.FormulaR1C1 = "书签";
	  WebOffice.WebObject.ActiveDocument.Application.Range("A3").Select();
	  WebOffice.WebObject.ActiveDocument.Application.ActiveCell.FormulaR1C1 = "毛笔";
	  WebOffice.WebObject.ActiveDocument.Application.Range("A4").Select();
	  WebOffice.WebObject.ActiveDocument.Application.ActiveCell.FormulaR1C1 = "钢笔";
	  WebOffice.WebObject.ActiveDocument.Application.Range("A5").Select();
	  WebOffice.WebObject.ActiveDocument.Application.ActiveCell.FormulaR1C1 = "尺子";
	
	  WebOffice.WebObject.ActiveDocument.Application.Range("B2").Select();
	  WebOffice.WebObject.ActiveDocument.Application.ActiveCell.FormulaR1C1 = "0.5";
	  WebOffice.WebObject.ActiveDocument.Application.Range("C2").Select();
	  WebOffice.WebObject.ActiveDocument.Application.ActiveCell.FormulaR1C1 = "樱花";
	  WebOffice.WebObject.ActiveDocument.Application.Range("D2").Select();
	  WebOffice.WebObject.ActiveDocument.Application.ActiveCell.FormulaR1C1 = "300";
	
	  WebOffice.WebObject.ActiveDocument.Application.Range("B3").Select();
	  WebOffice.WebObject.ActiveDocument.Application.ActiveCell.FormulaR1C1 = "2";
	  WebOffice.WebObject.ActiveDocument.Application.Range("C3").Select();
	  WebOffice.WebObject.ActiveDocument.Application.ActiveCell.FormulaR1C1 = "狼毫";
	  WebOffice.WebObject.ActiveDocument.Application.Range("D3").Select();
	  WebOffice.WebObject.ActiveDocument.Application.ActiveCell.FormulaR1C1 = "50";
	
	  WebOffice.WebObject.ActiveDocument.Application.Range("B4").Select();
	  WebOffice.WebObject.ActiveDocument.Application.ActiveCell.FormulaR1C1 = "3";
	  WebOffice.WebObject.ActiveDocument.Application.Range("C4").Select();
	  WebOffice.WebObject.ActiveDocument.Application.ActiveCell.FormulaR1C1 = "蓝色";
	  WebOffice.WebObject.ActiveDocument.Application.Range("D4").Select();
	  WebOffice.WebObject.ActiveDocument.Application.ActiveCell.FormulaR1C1 = "90";
	
	  WebOffice.WebObject.ActiveDocument.Application.Range("B5").Select();
	  WebOffice.WebObject.ActiveDocument.Application.ActiveCell.FormulaR1C1 = "1";
	  WebOffice.WebObject.ActiveDocument.Application.Range("C5").Select();
	  WebOffice.WebObject.ActiveDocument.Application.ActiveCell.FormulaR1C1 = "20cm";
	  WebOffice.WebObject.ActiveDocument.Application.Range("D5").Select();
	  WebOffice.WebObject.ActiveDocument.Application.ActiveCell.FormulaR1C1 = "40";
	
	  //保护工作表
	  WebOffice.WebObject.ActiveDocument.Application.Range("B2:D5").Select();
	  WebOffice.WebObject.ActiveDocument.Application.Selection.Locked = false;
	  WebOffice.WebObject.ActiveDocument.Application.Selection.FormulaHidden = false;
	  WebOffice.WebObject.ActiveDocument.Application.ActiveSheet.Protect(true,true,true);
	  StatusMsg("已经保护工作表，只有B2-D5单元格可以修改。");
		 }
	}
	
	//根据当空打开的文档类型保存文档
	function WebOpenLocal(){
	   WebOffice.WebOpenLocal();
	   //WebOffice.WebDelFile(WebOffice.FilePath+WebOffice.FileName);
	   WebOffice.FileType = WebOffice.WebGetDocSuffix();
	   WebOffice.FileName = WebOffice.FileName.substring(0,WebOffice.FileName.lastIndexOf("."))+WebOffice.FileType;
	   document.getElementById('FileType').value = WebOffice.FileType;
	}
	//调用模板
	function WebUseTemplate(fileName){
	    var currFilePath;
	    if(WebOffice.WebAcceptAllRevisions()){//清除正文痕迹的目的是为了避免痕迹状态下出现内容异常问题。
	       currFilePath = WebOffice.getFilePath(); //获取2015特殊路径
	       WebOffice.WebSaveLocalFile(currFilePath+WebOffice.iWebOfficeTempName);//将当前文档保存下来
	       if(WebOffice.DownloadToFile(fileName,currFilePath)){//下载服务器指定的文件
	          WebOffice.OpenLocalFile(currFilePath+fileName);//打开该文件
	          if(!WebOffice.VBAInsertFile("Content",currFilePath+WebOffice.iWebOfficeTempName)){//插入文档
	           StatusMsg("插入文档失败"); 
	           return;
	          }
	          StatusMsg("模板套红成功");
				test();
	          return; 
	       }
	       StatusMsg("下载文档失败"); 
	       return;
	    }
	    StatusMsg("清除正文痕迹失败，套红中止"); 
	}
</script>
<script language="javascript" for="WebOffice2015" event="OnReady()">
   WebOffice.setObj(document.getElementById('WebOffice2015'));//给2015对象赋值
   Load();//避免页面加载完，控件还没有加载情况
</script>
<script language="javascript" for="WebOffice2015" event="OnRecvStart(nTotleBytes)">
    nSendTotleBytes = nTotleBytes;
    nSendedSumBytes = 0;
</script>
<script language="javascript" for="WebOffice2015" event="OnRecving(nRecvedBytes)">
    nSendedSumBytes += nRecvedBytes;
</script>
<script language="javascript" for="WebOffice2015" event="OnRecvEnd(bSucess)">

</script>
<script language="javascript" for="WebOffice2015" event="OnSendStart(nTotleBytes)">
    nSendTotleBytes = nTotleBytes;
    nSendedSumBytes = 0;
</script>
<script language="javascript" for="WebOffice2015" event="OnSending(nSendedBytes)">
    nSendedSumBytes += nSendedBytes;
</script>
<script language="javascript" for="WebOffice2015" event="OnSendEnd(bSucess)">
    if (bSucess){
        if(WebOffice.sendMode == "LoadImage"){
          var httpclient = WebOffice.WebObject.Http;
          WebOffice.hiddenSaveLocal(httpclient,WebOffice,false,false,WebOffice.ImageName);
          WebOffice.InsertImageByBookMark();
          WebOffice.ImageName = null;
          WebOffice.BookMark = null;
          StatusMsg("插入图片成功");
          return
	     } 
	      StatusMsg("插入图片失败"); 
    }
</script>
<script language="JavaScript" for="WebOffice2015" event="OnCommand(ID, Caption, bCancel)">
   switch(ID){
	    case 1:WebOpenLocal();break;//打开本地文件
	    case 2:WebOffice.WebSaveLocal();break;//另存本地文件
		case 4:WebOffice.PrintPreview();break;//启用
		case 5:WebOffice.PrintPreviewExit();WebOffice.ShowField();break;//启用
		case 17:WebOffice.SaveEnabled(true);StatusMsg("启用保存");break;//启用保存
		case 18:WebOffice.SaveEnabled(false);StatusMsg("关闭保存");break;//关闭保存
		case 19:WebOffice.PrintEnabled(true);StatusMsg("启用打印");break;//启用打印
		case 20:WebOffice.PrintEnabled(false);StatusMsg("关闭打印");break;//关闭打印
		default:;return;  
  }   
</script>


<script language="javascript" for="WebOffice2015" event="OnQuit()">
//DelFile();
</script>


<!--以下是多浏览器的事件方法 -->
<script >
function OnReady(){
 WebOffice.setObj(document.getElementById('WebOffice2015'));//给2015对象赋值
 //Load();//避免页面加载完，控件还没有加载情况
 window.onload = function(){Load();} //IE和谷歌可以直接调用Load方法，火狐要在页面加载完后去调用
}

//上传下载回调用事件
function OnSendStart(nTotleBytes){
 nSendTotleBytes = nTotleBytes;nSendedSumBytes = 0;
}
function OnSending(nSendedBytes){
        nSendedSumBytes += nSendedBytes;
}
//异步上传
function OnSendEnd() {
    if(WebOffice.sendMode == "LoadImage"){
    	var httpclient = WebOffice.WebObject.Http;
    	WebOffice.hiddenSaveLocal(httpclient,WebOffice,false,false,WebOffice.ImageName);
     	WebOffice.InsertImageByBookMark();
        WebOffice.ImageName = null;
        WebOffice.BookMark = null;
        StatusMsg("插入图片成功");
        return;
	} 
	StatusMsg("插入图片失败"); 
}
function OnRecvStart(nTotleBytes){
    nSendTotleBytes = nTotleBytes;nSendedSumBytes = 0;
}
function OnRecving(nRecvedBytes){
   nSendedSumBytes += nRecvedBytes;
}
//异步下载
function OnRecvEnd() {
}
function OnCommand(ID, Caption, bCancel){
   switch(ID){
	    case 1:WebOpenLocal();break;//打开本地文件
	    case 2:WebOffice.WebSaveLocal();break;//另存本地文件
		case 4:WebOffice.PrintPreview();break;//启用
		case 5:WebOffice.PrintPreviewExit();WebOffice.ShowField();break;//启用
		case 17:WebOffice.SaveEnabled(true);StatusMsg("启用保存");break;//启用保存
		case 18:WebOffice.SaveEnabled(false);StatusMsg("关闭保存");break;//关闭保存
		case 19:WebOffice.PrintEnabled(true);StatusMsg("启用打印");break;//启用打印
		case 20:WebOffice.PrintEnabled(false);StatusMsg("关闭打印");break;//关闭打印
		default:;return;  
  }   
}

     
</script>
<!--End以下是多浏览器的事件方法 -->



<!--End 为2015主要方法 -->


</head>
<body onresize="init()"  style="overflow-y:hidden;overflow-x:hidden" onUnload="WebOffice.WebClose()">

<div id='loading' name='loading' class='loading'><script>Matrix.showLoading();</script></div>

<script> var MiWebOfficeForm=isc.MatrixForm.create({
				ID:"MiWebOfficeForm",
				name:"MiWebOfficeForm",
				position:"absolute",
				action:"",
				fields:[
				{name:'iWebOfficeForm_hidden_text',width:0,height:0,displayId:'iWebOfficeForm_hidden_text_div'}
				]});
</script>
<div style="width:100%;height:100%;overflow:auto;position:relative;">
		<form id="iWebOfficeForm"   method="post" action="<%=request.getContextPath()%>/OfficeServer" enctype="multipart/form-data"  >
			<input type="hidden" name="RecordID" value="<%=mRecordID%>"/>
			<input type="hidden" name="Template" value="<%=mTemplate%>"/>
			<input type="hidden" id="FileType" name="FileType" value="<%=mFileType%>"/>
			<input type="hidden" name="EditType" value="<%=mEditType%>"/>
			<input type="hidden" name="HTMLPath" value="<%=mHTMLPath%>"/>
			<input type="hidden" id="Subject" name="Subject" value="<%=mSubject%>"/>
			<input type="hidden" id="Author" name="Author" value="<%=mAuthor%>"/> 
			<input type="hidden" name="FileDate" value="<%=mFileDate%>"/>
			<input type="hidden" name="initTemplateId" id="initTemplateId" value="${param.initTemplateId }"/>
			<input type="hidden" name="redTemplateId" id="redTemplateId" value="${param.redTemplateId }"/>
			<input type="hidden" name="recordId" id="recordId" value="${param.recordId }"/>
			<input type="hidden" name="isEdit" id="isEdit" value="${param.isEdit }"/>
			<input type="hidden" name="isCopy" id="isCopy" value="${param.isCopy }"/>
			<input type="hidden" name="isSave" id="isSave" value="${param.isSave }"/>
			<input type="hidden" name="isVBA" id="isVBA" value="${param.isVBA }"/>
			<input type="hidden" name="isPrint" id="isPrint" value="${param.isPrint }"/>
			<input type="hidden" name="entity" id="entity" value="${param.entity }"/>
			<input type="hidden" name="hide" id="hide" value="${param.hide }"/>
			<input type="hidden" name="content" id="content" />
			
<table id="maintable"  cellspacing='0' cellpadding='0'>
 
 <tr id="toolBarTr"><td height="32px" class="" width="80%">
 
 <div id="toolBar002_div"  style="width:100%;height:100%;overflow:hidden;top:0;"  >
 
		<script>
					isc.ToolStripButton.create({
						ID:"MtoolBarItem001",
						icon:"[skin]/images/matrix/actions/save.png",
						title: "保存",
						showDisabledIcon:false,
						showDownIcon:false 
					});
					MtoolBarItem001.click=function(){
						Matrix.showMask();
						var content = WebOffice.WebObject.ActiveDocument.content.text;
						WebOffice.content=content;
						Matrix.setFormItemValue('content',content);
						SaveDocument();
	     				//document.getElementById("form0").submit();
						Matrix.hideMask();
					};
				</script>
				<script>
					isc.ToolStripButton.create({
						ID:"MtoolBarItem002",
						icon:"[skin]/images/matrix/actions/add.png",
						title: "套红",
						showDisabledIcon:false,
						showDownIcon:false 
					});
					MtoolBarItem002.click=function(){
						Matrix.showMask();
						WebInsertVBA();
						Matrix.hideMask();
					}
				</script>
				
				<script>
					isc.ToolStripButton.create({
						ID:"MtoolBarItem003",
						icon:"[skin]/images/matrix/actions/exit.png",
						title: "打印",
						showDisabledIcon:false,
						showDownIcon:false 
					});
					MtoolBarItem003.click=function(){
						Matrix.showMask();
						Matrix.sendRequest("/moffice/SaveDocument",null,function(){});
						Matrix.hideMask();
					};
				</script>
				
				<script>
					isc.ToolStripButton.create({
						ID:"MtoolBarItem004",
						icon:"[skin]/images/matrix/actions/exit.png",
						title: "关闭",
						showDisabledIcon:false,
						showDownIcon:false 
					});
					MtoolBarItem004.click=function(){
						Matrix.showMask();
						window.close();
						Matrix.hideMask();
					};
				</script>
				
			<script>isc.ToolStrip.create({ID:"MtoolBar002",displayId:"toolBar002_div",width: "100%",height: "100%",position: "relative",
				members: [ 
				"separator",
				MtoolBarItem001,
				"separator",
				MtoolBarItem002,
				"separator",
				MtoolBarItem003,
				"separator",
				MtoolBarItem004
				
				] 
				});
				
				isc.Page.setEvent(isc.EH.RESIZE,function(){isc.Page.setEvent(isc.EH.RESIZE,"MtoolBar002.resizeTo(0,0);MtoolBar002.resizeTo('100%','34px');",null);},isc.Page.FIRE_ONCE);</script>
 </td>
 
 </tr> 
 <!-- end head -->
 
 <!-- showList -->
 <tr><td id="showtr" colspan="2"  valign="top">
 
		
			
  <table id="functionBox" border="0" style="width:100%;height:96%;">
			
        <tr>
		<td colspan="2" id="activeTd" style="width:100%;height:100%;"><script src="js/iWebOffice2015.js"></script></td>
	    </tr>
	    <tr id="foot">
			<td height="10px" style="bottom:30px;position:absolute;left:0px;" class="statue">状态：<span id="state"></span></td>
			<td  style="time;bottom:30px;position:absolute;right:0px;">时间：<%=mFileDate%></td>
		</tr>
  
  </table>
 </td></tr>
 <!-- end showList -->
  
 <!-- footer -->
 <tr id="foot">
 	  <td colspan="2" id="footTd" style="bottom:0px;postion:absolute;height:30px;width:100%;" class="footer">
 			<table><tr><td align="center">江西金格科技股份有限公司 版权所有</td></tr></table>
 	  </td>
 </tr>
 <!-- end footer --> 
</table>
	   </form>
	   </div>
</body> 
</html>
 <script language="javascript">
 self.moveTo(0,0);
 self.resizeTo(screen.availWidth,screen.availHeight);
 init();
//初始化
 function init(){
	/*****************************************************************************************/
   document.getElementById('WebOffice2015').height =document.documentElement.clientHeight- 160 +"px";
   var functionTableLength = getHeight('toolBar002_div');
   if(functionTableLength>34){
   		document.getElementById('toolBar002_div').style.eight='34px';
   		MtoolBar002.resizeTo('100%','34px');
   }
   /*******************************************************************************************/
   
   ///////////////////////////////////////////////////////////////////////////
   var isEdit = Matrix.getFormItemValue('isEdit');
   WebOffice.EditType=isEdit;//设置空间的编辑类型
   
   //  所有权限 isSave，isCopy，isPrint，isVBA    0  否 ;  1  是
   //---------------isSave--------------------
   var isSave = Matrix.getFormItemValue('isSave');
   if(isSave=='0'){//不可保存
   	  MtoolBarItem001.setCanEdit(false);
   	  WebOffice.SaveEnabled(false);
   }else{
   	  MtoolBarItem001.setCanEdit(true);
   	  WebOffice.SaveEnabled(true);
   }
  //---------------isEdit--------------------
   var isEdit = Matrix.getFormItemValue('isEdit');
   if(isEdit =='2'){//不可编辑
  	  MtoolBarItem001.setCanEdit(true);
  	  MtoolBarItem002.setCanEdit(true);
  	  MtoolBarItem003.setCanEdit(true);
  	  
   }else {
   	  MtoolBarItem001.setCanEdit(false);
  	  MtoolBarItem002.setCanEdit(false);
  	  MtoolBarItem003.setCanEdit(false);
   }
   //WebOffice.setEditType(isEdit);  //0 ：文档保护; 1：不可编辑; 2 :可编辑
   //---------------isPrint--------------------
   var isPrint = Matrix.getFormItemValue('isPrint');
   if(isPrint=='0'){ //不可打印
  	  WebOffice.PrintEnabled(false);
   	  MtoolBarItem003.setCanEdit(false);
   } else{
   	  WebOffice.PrintEnabled(true);
   	  MtoolBarItem003.setCanEdit(true);
   }
    //---------------isCopy--------------------
   var isCopy = Matrix.getFormItemValue('isCopy');
   if(isCopy=='0'){
   	   WebOffice.WebEnableCopy('1');//启用拷贝
   }else{
   	   WebOffice.WebEnableCopy('0');//禁用拷贝
   }
    //---------------isVBA--------------------
    var isVBA = Matrix.getFormItemValue('isVBA');
    if(isVBA=='0'){
    	MtoolBarItem002.setCanEdit(false);
    }else{
    	MtoolBarItem002.setCanEdit(true);
    }
  
   //先完成总体，然后再来完善这里
   var recordId = Matrix.getFormItemValue('recordId');
   var initTemplateId = Matrix.getFormItemValue('initTemplateId');
   var entity = Matrix.getFormItemValue('entity');
   WebOffice.RecordID=recordId;
   WebOffice.InitTemplateId = initTemplateId;
   WebOffice.Entity = entity;
   
   ///////////////////////////////////////////////////////////////////////////
   var isHide = Matrix.getFormItemValue('hide');
   if(isHide){//hide
   		//隐藏工具栏等
   		document.getElementById("toolBarTr").style.display="none";
   		document.getElementById("foot").style.display="none";
   		document.getElementById("showtr").style.height="100%";
   		document.getElementById("showtr").style.width="100%";
   		document.getElementById("foot").style.display="none";
   		document.getElementById("footTd").style.display="none";
   		
   		WebOffice.Disabled="disabled";
   		//隐藏word中的工具栏等
   		WebOffice.WebEnableCopy('0');//禁用拷贝
   		WebOffice.ShowToolBars(false);//隐藏工具栏
   		WebOffice.ShowTitleBar(false);//隐藏标题栏
   		WebOffice.ShowMenuBar(false);//隐藏菜单栏
   		WebOffice.ShowStatusBar(false)//隐藏状态栏
   		WebOffice.WebSetProtect(true,'1234');//保护文档
   		WebOffice.WebEnableCopy(false);//禁止拷贝
   		WebOffice.setEditType('0');//设置编辑类型  
   		
   		//WebOffice.obj.ActiveDocument.ProtectionType="-1";
   		//WebOffice.VBAProtectDocument(0,'1234');
   		//WebOffice.Activate(false);
   		WebOffice.WebObject.ActiveDocument.Application.Selection.Locked = true;
	    WebOffice.WebObject.ActiveDocument.Application.Selection.FormulaHidden = true;
   }
   
   
 }
  //获取id的高度
  function  getHeight(id){
    return document.getElementById(id).offsetHeight; 
  }
 </script>