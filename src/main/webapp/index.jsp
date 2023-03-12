<%@page import="java.io.File"%>
<%@page import="java.io.FileFilter"%>
<%@page import="java.util.List"%>
<%@page import="com.service.dmc.sql.QueryBean"%>
<%@page import="com.service.dmc.util.CssFileFilter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 	
    File[] css = new File(application.getRealPath("/css")).listFiles(new CssFileFilter());
    QueryBean bean = (QueryBean) request.getAttribute("bean"); 
    if(bean == null) {bean = new QueryBean();}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <title>db-view</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <link rel="stylesheet"
        href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/ui-lightness/jquery-ui.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>

    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
        href="https://fonts.googleapis.com/css2?family=Audiowide&family=Monoton&family=Montserrat:wght@700&display=swap"
        rel="stylesheet" />

    <link id="theme" rel="stylesheet" href="<%= application.getContextPath() %>/css/default.css">
    <script src="<%= application.getContextPath() %>/javascript/presets.js"></script>

    <script language="JavaScript" type="text/javascript">
        jQuery(function ($) {

            loadPresets()

            $("#query-buttons").hide();

            $('#login').click(function () {

                $("input[type='button']").prop("disabled", true);

                $.ajax({
                    url: "<%=application.getContextPath()%>/action",
                    type: "post",
                    data: {
                        event: "login",
                        driver: $('#driver').val(),
                        url: $('#url').val(),
                        user: $('#user').val(),
                        password: $('#password').val()
                    }
                }).done(function (data) {
                    $('#query-box').html(data);
                    if ($(data).filter('#error').size()) {
                        $('#query-box').addClass('error');
                    } else {
                        $('#query-box').removeClass('error');
                        $("#login-parameter").hide();
                        $("#query-buttons").show();
                    }
                }).always(function () {
                    $("input[type='button']").prop("disabled", false);
                });

            });

            $('#execute').click(function () {

                $("input[type='button']").prop("disabled", true);

                $.ajax({
                    url: "<%= application.getContextPath() %>/action",
                    type: "post",
                    data: {
                        event: "execute",
                        driver: $('#driver').val(),
                        url: $('#url').val(),
                        user: $('#user').val(),
                        password: $('#password').val(),
                        query: $('#sql').val(),
                    }
                }).done(function (data) {
                    $('#result').html(data);
                }).always(function () {
                    $("input[type='button']").prop("disabled", false);
                });
            });

            $('#history').click(function () {
                $.ajax({
                    url: "<%= application.getContextPath() %>/action",
                    type: "post",
                    data: {
                        event: "history",
                        driver: $('#driver').val(),
                        url: $('#url').val(),
                        user: $('#user').val(),
                        password: $('#password').val(),
                        query: $('#sql').val(),
                    }
                }).done(function (data) {
                    $('#dialog').html(data);
                    if ($('#dialog').dialog("instance")) {
                        $('#dialog').dialog();
                    } else {
                        $('#dialog').dialog({
                            width: 500
                        });
                    }
                });
            });

            $('#exit').click(function () {
                $("#login-parameter").show();
                $("#query-buttons").hide();
                $("#query-box").html("");
                $("#result").html("");
                if ($('#dialog').dialog("instance")) {
                    $("#dialog").html("");
                    $('#dialog').dialog("destroy");
                }
            });

        });

        function setParameter() {
            var value = $('#presets').val();
            $("#driver").val(presets[value][1]);
            $("#url").val(presets[value][2]);
            $("#user").val(presets[value][3]);
            $("#password").val(presets[value][4]);
        };

        function changeTheme() {
            $('#theme').attr("href", $("#css-list").val());
        };
    </script>

    <title>db-view</title>
</head>

<body>
    <div id="css-selector">
        <table>
            <tr>
                <td>theme</td>
                <td>
                    <select id="css-list" onchange="changeTheme()">
<%
for (File file : css) {	
    if("default.css".equals(file.getName())){
        out.print("<option selected='true' value= '" +  application.getContextPath() + "/css/" + file.getName() + "'>");
    } else {
        out.print("<option value= '" +  application.getContextPath() + "/css/" + file.getName() + "'>");
    }
    out.print(file.getName());
    out.println("</option>");
}
%>
                    </select>
                </td>
            </tr>
        </table>
        <hr />
    </div>


    <div id="header">
        <table cellpadding="" class="header">
            <tr>
                <td align="left">
                    <h1>db-view 3.2</h1>
                </td>
            </tr>
            <tr>
                <td align="right">rebuid on 9th Mar 2023.<br>developed by dmc system service.</td>
            </tr>
        </table>
        <hr />
    </div>

    <div id="login-parameter">
        <table>
            <tr>
                <td>database</td>
                <td>
                    <select id="presets" onchange="setParameter()">
                    </select>
                </td>
            </tr>
        </table>
        <table>
            <tr>
                <td>driver</td>
                <td><input id="driver" name="driver" type="text" size="40pix" value="<%= bean.getDriver() %>" /></td>
            </tr>
            <tr>
                <td>url</td>
                <td><input id="url" name="url" type="text" size="40pix" value="<%= bean.getUrl() %>" /></td>
            </tr>
            <tr>
                <td>user</td>
                <td><input id="user" name="user" type="text" size="40pix" value="<%= bean.getUser() %>" /></td>
            </tr>
            <tr>
                <td>password</td>
                <td><input id="password" name="password" type="text" size="40pix" value="<%= bean.getPassword() %>" />
                </td>
            </tr>
        </table>
        <input class="button" type="button" value="login" id="login" />
        <hr />
    </div>

    <div id="query-box">
    </div>
    <div id="query-buttons">
        <table>
            <tr>
                <td><input type="button" value="execute" id="execute" /></td>
                <td><input type="button" value="history" id="history" /></td>
                <td><input type="button" value="exit" id="exit" /></td>
            </tr>
        </table>
        <hr />
    </div>

    <div id="result">
    </div>

    <div id="dialog" title="history">
    </div>


</body>

</html>