<%@page import="com.service.dmc.util.CssFileFilter"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileFilter"%>
<%@page import="com.service.dmc.sql.QueryBean"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 	
	QueryBean bean = (QueryBean) request.getAttribute("bean"); 
	if(bean == null) {bean = new QueryBean();}
%>
   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" language="javascript" src="<%= application.getContextPath() %>/javascript/jquery.js"></script>
<script type="text/javascript" language="javascript" src="<%= application.getContextPath() %>/javascript/jquery-ui.js"></script>
<script type="text/javascript" language="javascript" src="<%= application.getContextPath() %>/javascript/bootstrap.js"></script>
<script type="text/javascript" language="javascript" src="<%= application.getContextPath() %>/javascript/npm.js"></script>
<link rel="stylesheet" href="<%= application.getContextPath() %>/css/bootstrap-theme.css">
<link rel="stylesheet" href="<%= application.getContextPath() %>/css/bootstrap.css">


<script language="JavaScript" type="text/javascript">

var presets = [ 
["","","","",""], 
["postgres-template","org.postgresql.Driver","jdbc:postgresql://localhost/db","user","password"], 
["mysql-template","com.mysql.jdbc.Driver","jdbc:mysql://localhost/mysql","user","password"],
["oracle-template","oracle.jdbc.driver.OracleDriver","jdbc:oracle:thin:@host:port:db","user","password"]
 ]; 

jQuery(function ($) {

	for (var i = 0; i < presets.length; i++) {
		$("#preset").append($('<option>').html(presets[i][0]).val(i));
	}

	$("#query-buttons").hide();

	$('#login').click(function() {
	
    	$.ajax({
    		  url: "<%=application.getContextPath()%>/action",
    		  type: "post",
    		  data: {event: "login",driver: $('#driver').val(),url: $('#url').val(),user: $('#user').val(),password: $('#password').val()}
    		  }).done(function(data) {
            	$('#query-box').html(data);	
    			if ($(data).filter('#error').size()){
    				$('#query-box').html(data);	
              	} else {
                    $("#login-parameter").hide();
                  	$("#query-buttons").show();
              	} 
              }).always(function() {
    		  });
    	
       });

    $('#execute').click(function() {

    	var $btn = $(this).button('loading');

    	$.ajax({
    		  url: "<%= application.getContextPath() %>/action",
    		  type: "post",
    		  data: {event: "execute",driver: $('#driver').val(),url: $('#url').val(),user: $('#user').val(),password: $('#password').val(),query: $('#sql').val(),}
    		}).done(function(data) {
    			$('#result').html(data);
    		});
    	
    	$btn.button('reset');
    });

	$('#history').click(function() {
    	$.ajax({
  		  url: "<%= application.getContextPath() %>/action",
  		  type: "post",
  		  data: {event: "history",driver: $('#driver').val(),url: $('#url').val(),user: $('#user').val(),password: $('#password').val(),query: $('#sql').val(),}
  		}).done(function(data) {
  			$('#dialog').html(data);
  			if($('#dialog').dialog("instance")){
  				$('#dialog').dialog();
  			}else {
  	  			$('#dialog').dialog({width: 500});
  			}    
  		});
	});

	$('#exit').click(function() {
        $("#login-parameter").show();
      	$("#query-buttons").hide();
        $("#query-box").html("");
      	$("#result").html("");
		if($('#dialog').dialog("instance")){
	        $("#dialog").html("");
			$('#dialog').dialog("destroy");
		}
	});

});

function setParameter() {
	var value = $('#preset').val();
	$("#driver").val(presets[value][1]);
	$("#url").val(presets[value][2]);
	$("#user").val(presets[value][3]);
	$("#password").val(presets[value][4]);
};


</script>

<title>db-view</title>
</head>
<body>
<div class="container">
 
<div id="header">
<label class="lead">db-view 3.0 with Bootstrap</label>
</div>
 
<div class="navbar-form navbar-left" id="login-parameter">
<table class="table">
<tr>
<td><label class="col-sm-1 control-label">database</label></td>
<td>
<select class="form-control" id="preset" onchange="setParameter()">
</select>
</td>
</tr>
</table>
<table class="table">
<tr>
<td><label class="col-sm-1 control-label">driver</label></td>
<td><input class="form-control" id="driver" name="driver" type="text" value="<%= bean.getDriver() %>"/></td>
</tr>
<tr>
<td><label class="col-sm-1 control-label">url</label></td>
<td><input class="form-control" id="url" name="url" type="text" value="<%= bean.getUrl() %>"/></td>
</tr>
<tr>
<td><label class="col-sm-1 control-label">user</label></td>
<td><input class="form-control" id="user" name="user" type="text" value="<%= bean.getUser() %>"/></td>
</tr>
<tr>
<td><label class="col-sm-1 control-label">password</label></td>
<td><input class="form-control" id="password" name="password" type="text" value="<%= bean.getPassword() %>"/></td>
</tr>
</table>
<input class="btn btn-primary" type="button" value="login" id="login"/>
<hr/>
</div>

<div id="query-box">
</div>
<div id="query-buttons">
<table>
<tr>
<td><input class="btn btn-primary" type="button" value="execute" id="execute"/></td>
<td><input class="btn btn-primary" type="button" value="history" id="history"/></td>
<td><input class="btn btn-primary" type="button" value="exit" id="exit"/></td>
</tr>
</table>
<hr/>
</div>

<div id="result">
</div>

<div id="dialog" title="history">
</div>
</div>

</body>
</html>