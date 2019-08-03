
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Email Verification Status</title>
</head>
<body>
<div style="width: 700px; margin: auto;">
    <div class="jumbotron">
        <p>
            <%
                String message = (String)request.getAttribute("message");
            %>
            <%=message %>
        </p>
    </div>
</div>
</body>
</html>
