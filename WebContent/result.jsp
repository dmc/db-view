<%@page import="com.service.dmc.sql.QueryBean"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% QueryBean bean = (QueryBean) request.getAttribute("bean"); 
String message = bean.getMessage();
if(message.length() > 0){

	if(bean.isSucces()) {
		out.print("<label class='form-control'>" + bean.getMessage() + "</label>");
	} else {
		out.print("<label class='warning' >" + bean.getMessage() + "</label>");
	}

} else {

	out.println("<table class=\"table table-bordered table-striped\">");
	String[] columns = bean.getColumns();
	List<Object[]> data =bean.getData();
	if(columns != null) {
		for (String column : columns) {
			out.print("<th>" + column + "</th>");
		}
		
		for (Object[] row : data) {	
			out.print("<tr>");
			for (Object o : row) {
				out.print("<td class=\"text-nowrap\" scope=\"row\">" + o + "</td>");
			}
			out.print("</tr>");
		}
	}
	out.println("</table>");
}


%>
