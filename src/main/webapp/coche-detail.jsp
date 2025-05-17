<%@ page import="com.natalia.demo.dao.CocheDao" %>
<%@ page import="com.natalia.demo.model.Coche" %>
<%@ page import="com.natalia.demo.database.Database" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Car Detail</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/car-detail-styles.css">
</head>
<body>

<%
    int id = 0;
    try {
        id = Integer.parseInt(request.getParameter("id"));
    } catch (NumberFormatException e) {
        // manejar error
    }

    Coche coche = null;
    try {
        Database db = new Database();
        db.connect();
        CocheDao dao = new CocheDao(db.getConnection());
        for (Coche c : dao.getAll()) {
            if (c.getId() == id) {
                coche = c;
                break;
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<main class="detail-container">
    <h1 class="detail-title">Car Detail</h1>

    <div class="detail-card">
        <div class="photo-container">
            <img src="<%= request.getContextPath() %>/ControlerIMGCoche?id=<%= id %>"
                 alt="Foto de coche" class="detail-photo">
        </div>

        <div class="info-list">
            <div class="info-item"><strong>ID:</strong> <%= id %></div>
            <div class="info-item"><strong>Name:</strong> <%= coche.getNombre() %></div>
            <div class="info-item"><strong>Group:</strong> <%= coche.getGrupo() %></div>
            <div class="info-item"><strong>Price:</strong> <%= coche.getPrecio() %> €</div>
            <div class="info-item"><strong>Seats:</strong> <%= coche.getPlazas() %></div>
            <div class="info-item"><strong>Description:</strong> <%= coche.getDescripcion() %></div>
            <div class="info-item"><strong>Rented by:</strong> <%= coche.getAlquiladopor() %></div>
            <div class="info-item"><strong>Available:</strong> <%= coche.isDisponibilidad() ? "Yes" : "No" %></div>
            <div class="info-item"><strong>Purchase Date:</strong> <%= coche.getFechaCompra() %></div>
            <div class="button-group">
                <button class="back-button" onclick="window.history.back()">Back</button>
                <button class="edit-button" onclick="window.location.href='car-form.jsp?id=<%= id %>'">Edit</button>
            </div>
        </div>
    </div>
</main>

</body>
</html>