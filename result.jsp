<%@ include file="process/connect.jsp" %>

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
		query = "select TrHeader.IDHeader,Karyawan,format(Tanggal, 'dd/mmm/yyyy') as Waktu, SUM(Qty) as Total "+
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
		if(rs.next())
		{
			rs.first();
			//do{%>
		<tr>
		<%for(int i=1;i<=dColumn;i++) {%>
		<td><%= rs.getString(i) %></td>
		<%}%>
		</tr>
		<%//}while(rs.next());
		}
		rs.close();
		st.close();
		con.close();%>
</table>