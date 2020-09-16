<%@ page contentType="text/html; charset=gb2312"%>
<%@ page
	import="java.util.*,java.sql.*,java.text.SimpleDateFormat,java.text.DateFormat,java.util.Date,DBstep.iDBManager2000.*"%>
<%!DBstep.iDBManager2000 DbaObj = new DBstep.iDBManager2000();

	//列出所有模版
	public String GetTemplateList(String ObjType, String FileType) {
		String mTemplateList, mstr = "";
		mTemplateList = "<select name=" + ObjType + " >";
		mTemplateList = mTemplateList
				+ "<option value=''>--------不用模版--------</option>";
		String Sql = "select RecordID,Descript from Template_File where FileType='"
				+ FileType + "'"; //打开数据库
		try {
			if (DbaObj.OpenConnection()) {
				try {
					ResultSet result = DbaObj.ExecuteQuery(Sql);
					mstr = "selected";
					while (result.next()) {
						mTemplateList = mTemplateList + "<option value='"
								+ result.getString("RecordID") + "'" + mstr
								+ ">" + result.getString("Descript")
								+ "</option>";
					}
					result.close();
				} catch (SQLException sqlex) {
					System.out.println(sqlex.toString());
				}
			} else {
				System.out.println("GetTemplateList: OpenDatabase Error");
			}
		} finally {
			DbaObj.CloseConnection();
		}
		mTemplateList = mTemplateList + "</select>";
		return (mTemplateList);
	}
	/**
   * 功能或作用：格式化日期时间
   * @param DateValue 输入日期或时间
   * @param DateType 格式化 EEEE是星期, yyyy是年, MM是月, dd是日, HH是小时, mm是分钟,  ss是秒
   * @return 输出字符串
   */
  public String FormatDate(String DateValue,String DateType)
  {
    String Result;
    SimpleDateFormat formatter = new SimpleDateFormat(DateType);
    try{
      Date mDateTime = formatter.parse(DateValue);
      Result = formatter.format(mDateTime);
    }catch(Exception ex){
      Result = ex.getMessage();
    }
    if (Result.equalsIgnoreCase("1900-01-01")){
      Result = "";
    }
    return Result;
  }
	%>
<%
  SimpleDateFormat f1 = new SimpleDateFormat("yyyyMMddHHmm");
  SimpleDateFormat f2 = new SimpleDateFormat("ss");
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>金格科技-iWebOffice2015智能文档中间件示例程序</title>
		<meta http-equiv="X-UA-Compatible" content="IE=8" />
		<link rel='stylesheet' type='text/css' href='css/iWebProduct.css' />
		<script language="javascript">
		
  function CheckActiveX(){ 
    var mObject=true;
    try{
      var newAct =   new ActiveXObject("Kinggrid.iWebOffice");
     
      if(newAct == undefined ){
       mObject=false;
      }
    }catch(e){
      mObject=false;
    }
    newAct = null;
    if(!(window.ActiveXObject||"ActiveXObject" in window)){
    activex_install.innerHTML ="多浏览器如果没有正常加载，查看说明"
    return true;
    }
	    if(mObject){
		  activex_install.innerHTML = "已经安装iWebOffice2015中间件！";
		  activex_install.style.color="#FFFFFF";
	    }else{
	      //控件无法加载
	      activex_install.innerHTML = "请注意，未检测到iWebOffice2015中间件！请查看说明，并按说明的要求检查您使用的环境。";
		  activex_install.style.color="#FF0000";
	    }
   
    return mObject; 
  }

  function init(){
	  var mhtml = document.documentElement.clientHeight;
	  var mhead = document.getElementById("mhead").offsetHeight; 
	  var mtitle = document.getElementById("mtitle").offsetHeight;
	  var mfooter = document.getElementById("mfooter").offsetHeight; 
	  document.getElementById('mbody').style.height = mhtml- mhead-mtitle-mfooter+"px";
	  
	  document.getElementById('showlist').style.height = mhtml- mhead-mtitle-mfooter-160+"px";
	  document.getElementById('showlist').style.width = document.getElementById('titleTable').offsetWidth;
  }
	  
	  
  //获取id的高度
  function  getHeight(id){
    return document.getElementById(id).offsetHeight; 
  }
  
  function ShowExplain(){
 	 window.open("UserExplain.html", 'newwindow','height=300px,width=780px,top=150,left=300,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');  

  }
  
  
  function OpenNewPage(value){
  	var mhtmlHeight = window.screen.availHeight;//获得窗口的垂直位置;
	var mhtmlWidth = window.screen.availWidth; //获得窗口的水平位置; 
	var iTop = 0; //获得窗口的垂直位置;
	var iLeft = 0; //获得窗口的水平位置;
    var values = new Array;
    values = value.split(",");    
    FileType = values[0];
    FileVal  = values[1];
    var title = document.getElementById("title").value;
    var subTitle = document.getElementById("subTitle").value;
    var sign = document.getElementById("sign").value;
    var templateId = document.getElementById("templateId").value;
    //var recordId = document.getElementById("recordId").value;
    var recordId = "123";
    if(FileType != -1){

     var aa =  window.open('documentEdit.jsp?FileType='+FileType+'&UserName='+ encodeURI(encodeURI(username.value))+'&EditType=2&title='+title+'&subTitle='+subTitle+'&sign='+sign+'&templateId='+templateId+"&recordId="+recordId,'iWebOffice2015智能文档中间件示例程序','top='+iTop+',left='+iLeft+',toolbar=yes,menubar=yes,scrollbars=no,resizable=yes, location=yes,status=yes');  
    }
    document.getElementById("selectID").options[0].selected = true;
    
  }
  


  function openfile(medittype,RecordID){
  	var mhtmlHeight = window.screen.availHeight;//获得窗口的垂直位置;
	var mhtmlWidth = window.screen.availWidth; //获得窗口的水平位置; 
	var iTop = 0; //获得窗口的垂直位置;
	var iLeft = 0; //获得窗口的水平位置;
    window.open("documentEdit.jsp?RecordID="+RecordID+"&EditType="+medittype+"&UserName="+encodeURI(encodeURI(username.value)),'iWebOffice2015智能文档中间件示例程序','height='+mhtmlHeight+',width='+mhtmlWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=yes,scrollbars=no,resizable=yes, location=no,status=no');  
  }
  function down(){
  	
  }
  
 </script>
	</head>
	<body onload="init()" onresize="init()"
		style="overflow-y: hidden; overflow-x: hidden">
		<input type="hidden" id="title" name="title" value="huachuangpower"/>
		<input type="hidden" id="subTitle" name="subTitle" value="hcp:">
		<input type="hidden" id="sign" name="sign" value="signhere"/>
		<input type="hidden" id="templateId" name="templateId" value="fawen001"/>
		<div id="mhead" class="mhead">
			<table id="header">
				<tr>
					<td>
						<img src="css/logo.jpg" />
					</td>
					<td>
						<span> iWebOffice2015</span> 智能文档中间件示例程序
					</td>
				</tr>
			</table>
		</div>

		<div id="mtitle" style="height: 34px;" class="title">
			<table>
				<tr>
					<td height="34px">
					   <div width="0px" height="0px" style="display:none" > <script src="js/iWebOffice2015.js"></script></div>
						<span id="activex_install" style="color: #FF0000">请注意，未检测到iWebOffice2015中间件！请查看说明，并按说明的要求检查您使用的环境。</span>
						<a href="#" onclick="ShowExplain()">[说明]</a><a href="#" onclick="down()">[下载]</a>
						<div id="obj">					
						</div>
					</td>
				</tr>
			</table>
		</div>
		<div id="mbody" style="text-align: center;">
			<img id="loading" src="css/load.gif" alt="" />
			<div id="loaded"
				style="margin: 30px; border: 1px solid #C3ADC3; text-align: center; display: none;">

				<table id="innerTable" border=0 cellspacing='0' cellpadding='0'
					style="height:40px;">
					<tr>
						<td align="left">
							<span style="padding-right: 14px;">当前编辑用户：<input type=text
									name='username' id='username' size=20  onblur="if(this.value.length>8){alert('用户名不能超过8个字');this.focus()}"  value="体验用户<%=f2.format(new Date())%>"
									class="InputLine" /> </span>
						</td>
						<td align="right" colspan="3">
                            <span style="padding-right: 25px;">　新建文档：
                            <select  id="selectID" onchange="OpenNewPage(this.value)">
                              <option value="-1" selected="selected">　选择文档    ↓</option>
                              <option value=".doc,1">　新建WORD文档</option>
                              <option value=".xls,2">　新建EXECL文档</option>

                              <option value=".wps,1">　新建WPS文档</option>
                              <option value=".et,2">　新建ET文档</option>
                            </select>
                            </span>　　　
						</td>
					</tr>


				</table>
				<table id="titleTable" cellspacing='0' cellpadding='0'
					align="center" style="height: 42px;">
					<tr>
						<td width="60px">
							编号
						</td>
						<td>
							主题
						</td>
						<td width="120px">
							作者
						</td>
						<td width="115px">
							类型
						</td>
						<td width="190px">
							保存时间
						</td>
						<td width="380px">
							操作
						</td>

					</tr>
				</table>

				<div id="showlist"
					style="vertical-align: top; height: 300px; margin-right: auto; margin-left: auto;">
					<table align="center" cellspacing='0' cellpadding='0'
						style="height: 50px;">
						<%
							try {
								if (DbaObj.OpenConnection()) {
									try {
										ResultSet result = DbaObj
												.ExecuteQuery("select Status,RecordID,HtmlPath,DocumentID,Subject,Author,FileType,FileDate from Document order by DocumentID desc");
										int i = 1;
										while (result.next()) {
											String RecordID = result.getString("RecordID");
											String HTMLPath = result.getString("HtmlPath");
											if (HTMLPath == null)
												HTMLPath = "";
						%>


						<tr>
							<td width="60px"  class="TD<%=(i+1)%2 %>"><%=i++%></td>
			  <td class="TD<%=(i)%2%>"><%=result.getString("Subject")%></td>
			  <td width="100px" class="TD<%=(i)%2 %>"><%=result.getString("Author")%></td>
			  
			  <td width="190px" class="TD<%=(i)%2 %>"><%=FormatDate(result.getString("FileDate"),"yyyy-MM-dd HH:mm:ss")%></td>
							<td width="380px" align=center class="TD<%=(i) % 2%>">
								<a href="#"
									onclick="openfile('0','<%=RecordID%>')">阅读</a>
								<a href="#"
									onclick="openfile('1','<%=RecordID%>')">修改[无痕迹]</a>
								<a href="#"
									onclick="openfile('2','<%=RecordID%>')">修改[有痕迹]</a>
							</td>
						</tr>
						<%
							}
										result.close();
									} catch (SQLException sqlex) {
										System.out.println(sqlex.toString());
									}
								} else {
									out.println("OpenDatabase Error");
								}
							} finally {
								DbaObj.CloseConnection();
							}
						%>
						<tr>
							<td style='border: none;'></td>
						</tr>
					</table>

				</div>
			</div>
		</div>

		<div id="mfooter">
			<table class="footer">
				<tr>
					<td align="center">
						江西金格科技股份有限公司 版权所有
					</td>
				</tr>
			</table>
		</div>
	</body>
</html>
<script language="javascript" type="text/javascript">
 var checkActiveX  = CheckActiveX();
 if(checkActiveX){
 document.getElementById('loading').style.display = "none";
 document.getElementById('loaded').style.display = "";
 }else{
  document.getElementById('loading').style.display = "none";
  document.getElementById('loaded').style.display = "";
 }

</script>