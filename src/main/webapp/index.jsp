<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Home</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/cus-list-styles.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css">
</head>
<body>
<main>
    <h1 class="titulo">Welcome to the management page</h1>
    <h2 class="subtitulo">Here you can manage customers and rented vehicles:</h2>

    <div class="button-group">
        <button class="customer-button" onclick="window.location.href='customer-list.jsp'">View Customers</button>
        <button class="vehicle-button" onclick="window.location.href='vehicles-list.jsp'">View Vehicles</button>
    </div>
</main>
</body>
</html>
