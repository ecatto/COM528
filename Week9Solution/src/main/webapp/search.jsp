<%-- 
    Document   : search
    Created on : 15 Dec 2022, 20:08:55
    Author     : nick
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.SQLException" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.PreparedStatement" %>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Search for student</h1>

        <%

            Connection conn = null;

            try {
                Class.forName("org.sqlite.JDBC");
                conn = DriverManager.getConnection("jdbc:sqlite:/home/nick/university.db");

                Statement stmt0 = conn.createStatement();
                stmt0.executeUpdate("create table if not exists student (id integer primary key autoincrement, name string, course string, mark integer, type string)");

                String name = request.getParameter("studentName");

                PreparedStatement stmt = conn.prepareStatement("select * from student where name=?");
                stmt.setString(1, name);
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    out.println(rs.getLong("id") + ": " + rs.getString("name") + " " + rs.getString("course") + " " + rs.getString("type") + " " + rs.getString("mark") + "%");
                }
            } catch (SQLException e) {
                out.println("<strong>Error with database: " + e + "</strong>");
            } finally {
                // Close the connection if it was made successfully
                if (conn != null) {
                    try {
                        conn.close();
                    } catch (SQLException closeException) {
                        out.println("<strong>Error with closing database: " + closeException + "</strong>");
                    }
                }
            }

        %>
    </body>
</html>

