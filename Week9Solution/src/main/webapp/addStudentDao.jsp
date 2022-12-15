<%-- 
    Document   : addStudent
    Created on : 15 Dec 2022, 20:08:55
    Author     : nick
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.SQLException" %>
<%@page import="java.sql.Statement" %>
<%@page import="com.example.week9solution.StudentDao" %>
<%@page import="com.example.week9solution.Student" %>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Add student</h1>
        
        <%
            
        Connection conn = null;
        
        try 
        {
            Class.forName("org.sqlite.JDBC");
            conn = DriverManager.getConnection("jdbc:sqlite:/home/nick/university.db");
            
            
            Statement stmt0 = conn.createStatement();
            stmt0.executeUpdate("create table if not exists student (id integer primary key autoincrement, name string, course string, mark integer, type string)");
        
            StudentDao dao = new StudentDao(conn, "student");
            
            
            
            String name = request.getParameter("studentName"),
                    course = request.getParameter("studentCourse"),
                    mark = request.getParameter("studentMark"),
                    type = request.getParameter("studentType");
                    
            Student s = new Student(0, name, course, type);
            s.setMark(Double.parseDouble(mark));
            
            long id = dao.addStudent(s);
                    
            if (id > 0) 
            {
                out.println("Successfully created with ID " + id);
            }
            else
            {
                out.println("Could not create student");
            }
        }
        catch(SQLException e)    
        {
            out.println("<strong>Error with database: " + e + "</strong>");
        }    
        finally
        {
            // Close the connection if it was made successfully
            if(conn != null)
            {
                try
                {
                    conn.close();
                }
                catch(SQLException closeException)
                {
                    out.println("<strong>Error with closing database: " + closeException + "</strong>");
                }
            }
        }
            
        %>
    </body>
</html>

