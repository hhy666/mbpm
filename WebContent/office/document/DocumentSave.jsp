<%@ page contentType="text/html; charset=gb2312"%>
<%@ page
	import="java.io.*,java.text.*,java.util.*,java.sql.*,DBstep.iDBManager2000.*"%>
<%
	String mRecordID = request.getParameter("RecordID");
	if (mRecordID == null)
		mRecordID = "";
	String mTemplate = new String(request.getParameter("Template")
			.getBytes("8859_1"));
	String mSubject = new String(request.getParameter("Subject")
			.getBytes("8859_1"));
	String mAuthor = new String(request.getParameter("Author")
			.getBytes("8859_1"));
	String mFileDate = new String(request.getParameter("FileDate")
			.getBytes("8859_1"));
	String mFileType = new String(request.getParameter("FileType")
			.getBytes("8859_1"));
	String mHTMLPath = new String(request.getParameter("HTMLPath")
			.getBytes("8859_1"));
	String mStatus = "READ";
	String content = new String(request.getParameter("content")
			.getBytes("8859_1"));
	DBstep.iDBManager2000 DbaObj = new DBstep.iDBManager2000();
System.out.println("mSubject"+mSubject);

	
	
	out.println("<script language='javascript'>");
	out.println("window.opener.location.reload();");
	out.println("window.close(); ");
	out.println("</script>");
	//response.sendRedirect("DocumentList.jsp");
%>