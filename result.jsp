<%@ include file="process/connect.jsp" %>
<body>
<table border="1px">
<tr>
<%
	//getParameter
	String Start=request.getParameter("Start");
	String End=request.getParameter("End");
	String Year=request.getParameter("Year");
	int Option= Integer.parseInt(request.getParameter("Option"));
	
	String query = "";
	if(Option==0)
		query = "select TrHeader.IDHeader,Karyawan,format(Tanggal, 'dd/mmm/yyyy') as Waktu, Barang, Qty "+
		"from TrHeader inner join TrDetail on TrHeader.IDHeader=TrDetail.IDHeader "+
		"where MONTH(Tanggal) >= "+Start+" And MONTH(Tanggal) <= "+End+" And YEAR(Tanggal) = "+Year;
	if(Option==1)
		query = "select TrHeader.IDHeader,Karyawan,format(Tanggal, 'dd/mmm/yyyy') as Waktu, SUM(Qty) as Total "+
		"from TrHeader inner join TrDetail on TrHeader.IDHeader=TrDetail.IDHeader "+
		"where MONTH(Tanggal) >= "+Start+" And MONTH(Tanggal) <= "+End+" And YEAR(Tanggal) = "+Year+
		" group by TrHeader.IDHeader,Karyawan,Tanggal";
	if(Option==2)
		query = "select TrHeader.IDHeader,Karyawan,format(Tanggal, 'dd/mmm/yyyy') as Waktu, AVG(Qty) as Total "+
		"from TrHeader inner join TrDetail on TrHeader.IDHeader=TrDetail.IDHeader "+
		"where MONTH(Tanggal) >= "+Start+" And MONTH(Tanggal) <= "+End+" And YEAR(Tanggal) = "+Year+
		" group by TrHeader.IDHeader,Karyawan,Tanggal";
	
	ResultSet rs = st.executeQuery(query);
	ResultSetMetaData meta = rs.getMetaData();
	int dColumn = meta.getColumnCount();
		for(int i=1;i<=dColumn;i++)
		{
		%>
		<td style="padding:0px 25px 0px 25px;"><%=meta.getColumnName(i)%></td>
		<%
		}
		%>
		</tr>
		<%
		/*
		here is the odd problem: *when i use query from option 1 and 2, rs.next() will return true one more time even there are no more row record.
		for example, using query from option 2:
		select TrHeader.IDHeader,Karyawan,format(Tanggal, 'dd/mmm/yyyy') as Waktu, AVG(Qty) as Total
		from TrHeader inner join TrDetail on TrHeader.IDHeader=TrDetail.IDHeader 
		where MONTH(Tanggal) >= 10 And MONTH(Tanggal) <=10 And YEAR(Tanggal) = 2013
		group by TrHeader.IDHeader,Karyawan,Tanggal
		
		It will return one record, but rs.next() will return true two times!
								*It's fine whenever I use query from option 0, i've googled it for about 2hour but found no answer.
		Solution: for now i'll use this trick (try catch) if I have more time and found the answer than I'll reupload the revision :)
		*/
		try {
		while(rs.next()){
		String firstColumn = rs.getString(1); //triger error so no extra <tr></tr> when error happen
			%>
		<tr>
		<td><%=firstColumn%></td>
		<%
		for(int i=2;i<=dColumn;i++) 
		{
		%>
		<td><%=rs.getString(i)%></td>
		<%
		}
		%>
		</tr>
		<%}
		}
		catch(Exception ex) {
		}
		rs.close();
		st.close();
		con.close();%>
</table>
</body>