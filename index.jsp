<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>GSLC WebProg</title>
<!--<script src="http://code.jquery.com/jquery-1.9.1.js"></script>-->
<script type="text/javascript">
	function reload(){
	var Start = document.getElementById('cboStartDay').value;
	var End = document.getElementById('cboEndDay').value;
	var Year = document.getElementById('cboYear').value;
	var Option = document.getElementById('cboTask').value;
    document.getElementById('result').src ="result.jsp?Start="+Start+"&End="+End+"&Year="+Year+"&Option="+Option;
}

	function iframeLoaded() {
      var iFrameID = document.getElementById('result');
      if(iFrameID) {
            // here you can make the height, I delete it first, then I make it again
            iFrameID.height = "";
            iFrameID.height = (iFrameID.contentWindow.document.body.scrollHeight+100) + "px";
      }   
  }
</script>
</head>

<body>
<CENTER><H3>Inquiry Transaction<H3></CENTER><br/>
<div ID="option" style="padding-left:30px">
<form method="post" action="index.jsp">
Start Date: <select id="cboStartDay" name="cboStartDay" style="width=30px;" onchange="this.form.submit()">
<% 
String[] index = {"01","02","03","04","05","06","07","08","09","10","11","12"};
String[] month = {"January","February","March","April","May","June","July","August","September","October","November","December"};
int startDay,options;
if(request.getParameter("cboStartDay").equals("null"))
	startDay=0;
else
	startDay=Integer.parseInt(request.getParameter("cboStartDay"));
for(int a=0;a<12;){
if(a+1==startDay) {
%>
<option value="<%=index[a]%>" selected><%=month[a++]%></option>
<%}
else {
%>
<option value="<%=index[a]%>"><%=month[a++]%></option>
<%}}%>
</select>
</form>
End Date: <select id="cboEndDay" name="cboEndDay" style="width=30px;margin-left:6px;">
<% 
for(int a=startDay-1;a<12;){
%>
<option value="<%=index[a]%>"><%=month[a++]%></option>
<%}%>
</select>
<select id="cboYear">
<option value="2013">2013</option>
<option value="2014">2014</option>
<option value="2015">2015</option>
</select>
<br />
<select id="cboTask" name="cboTask">
<option value="0">ALL</option>
<option value="1">SUM</option>
<option value="2">AVERAGE</option>
</select>
<input type="button" value="Process" id="process" onClick="reload()" />
</div>
<br />
<iframe id="result" onload="iframeLoaded()" style="margin-left:100px;width:800px;"frameBorder = "0px">
</iframe>
</body>
</html>