<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Home</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/cus-list-styles.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css">
</head>
<body>
<div class="nav">
    <div class="logo"> <img src="${pageContext.request.contextPath}/imagenes/ejemplo/image.png"></div>
</div>
<main>
    <div class="tarjeta">
        <h1 class="titulo">Welcome to the management page</h1>
        <h2 class="subtitulo">Here you can manage customers and rented vehicles:</h2>

        <div class="button-group">
            <button class="customer-button" onclick="window.location.href='customer-list.jsp'">View Customers</button>
            <button class="vehicle-button" onclick="window.location.href='vehicles-list.jsp'">View Vehicles</button>
        </div>
    </div>
</main>
<div class="footer">
    <div class="footer-section">
        <h3>About RentCar</h3>
        <p>Drive the Future Find your perfect ride, wherever the road takes you. Competitive rates, top-tier service, and a seamless rental experience. Because the journey matters.</p>
    </div>

    <div class="footer-section">
        <h3>Links</h3>
        <ul>
            <li><a href="vehicles-list.jsp">Vehicles</a></li>
            <li><a href="customer-list.jsp">Customers</a></li>
        </ul>
    </div>

    <div class="footer-section">
        <h3>Contact</h3>
        <p>Email: soporte@rentcar.com</p>
        <p>Phone Number: +34 123 456 789</p>
        <p>Adress: Zaragoza, España</p>
    </div>

    <div class="footer-section">
        <h3>Follow Us</h3>
        <div class="social-media">
            <a href="#" class="redes"><img src="${pageContext.request.contextPath}/imagenes/ejemplo/facebook.png" alt="Facebook">Facebook</a>
            <a href="#" class="redes"><img src="${pageContext.request.contextPath}/imagenes/ejemplo/gorjeo.png" alt="Twitter">X</a>
            <a href="#" class="redes"><img src="${pageContext.request.contextPath}/imagenes/ejemplo/instagram.png" alt="Instagram">Instagram</a>
        </div>
    </div>
</div>
<div class="footer-bottom">
    <p>© 2025 RENTaCAR. Todos los derechos reservados. | © San Valero</p>
</div>
</body>
</html>
