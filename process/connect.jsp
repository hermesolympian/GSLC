<%@ page import="java.sql.*" %>

<%
	Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
	Connection con = DriverManager.getConnection("jdbc:odbc:Driver={Microsoft Access Driver (*.mdb, *.accdb)};DBQ=" + application.getRealPath("WEB-INF/Database1.accdb"));
	Statement st = con.createStatement(1004,1008);
%>

