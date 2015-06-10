<%@page import="com.service.dmc.sql.QueryBean"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% QueryBean bean = (QueryBean) request.getAttribute("bean"); %>
<% if (!bean.isSucces()) {
	out.print("<label id=\"error\" class=\"lead\">" + bean.getMessage() + "</label>");
} else { %>

<label class="lead">login database is <%= bean.getUrl() %></label>
<textarea class="form-control" rows="6" name="sql" id="sql"><%= bean.getQuery() %></textarea>

<% } %>
