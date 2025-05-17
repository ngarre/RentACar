<%@ page import="com.natalia.demo.dao.UsuarioDao" %>
<%@ page import="com.natalia.demo.model.Usuario" %>
<%@ page import="com.natalia.demo.database.Database" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Customer Detail</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/cus-detail-styles.css">
</head>
<body>
<header>
    <!-- Barra de navegación opcional -->
</header>

<%
    // Recuperar ID desde parámetro
    int id = 0;
    try {
        id = Integer.parseInt(request.getParameter("id"));
    } catch (NumberFormatException e) {
        // manejar error: redirigir o mensaje
    }

    Usuario usuario = null;
    try {
        Database db = new Database();
        db.connect();
        UsuarioDao dao = new UsuarioDao(db.getConnection());
        usuario = dao.getById(id);
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<main class="detail-container">
    <h1 class="detail-title">Customer Detail</h1>

    <div class="detail-card">
        <!-- Foto del cliente -->
        <div class="photo-container">
            <img src="<%= request.getContextPath() %>/ControlerIMG?id=<%= id %>"
                 alt="Foto de <%= usuario.getNombre() %>" class="detail-photo">
        </div>

        <!-- Información del cliente -->
        <div class="info-list">
            <div class="info-item"><strong>ID:</strong> <%= id %></div>
            <div class="info-item"><strong>Name:</strong> <%= usuario.getNombre() %></div>
            <div class="info-item"><strong>Last Name:</strong> <%= usuario.getApellido() %></div>
            <div class="info-item"><strong>Age:</strong> <%= usuario.getEdad() %></div>
            <div class="info-item"><strong>Birthday:</strong> <%= usuario.getFechaNacimiento() %></div>
            <div class="info-item"><strong>Deposit:</strong> <%= usuario.getFianza() %> €</div>
            <div class="button-group">
                <button class="back-button" onclick="window.history.back()">Back</button>
                <button class="edit-button" onclick="window.location.href='create.jsp?id=<%= id %>'">Edit</button>
            </div>
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
