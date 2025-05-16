<%@ page import="com.natalia.demo.dao.CocheDao" %>
<%@ page import="com.natalia.demo.model.Coche" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.natalia.demo.database.Database" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Vehicles</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/cus-list-styles.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/carlist-styles.css">
</head>
<body>
<header>
    <!--De momento sin barra de navegación-->
</header>

<%
    ArrayList<Coche> listaCoches = new ArrayList<>();
    try {
        Database database = new Database();
        database.connect();
        CocheDao cocheDao = new CocheDao(database.getConnection());
        listaCoches = cocheDao.getAll();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<main>
    <h1 class="titulo">List of Vehicles</h1>
    <div class="container">
        <div class="back-button">
                <button class="back-button" onclick="window.location.href='index.jsp'">← Back to Home</button>
            </div>
        <div class="boton-crear-container">
            <button class="create-button" onclick="window.location.href='car-form.jsp'">Add New Car</button>
        </div>
        <div class="tabla">
            <div class="header">Photo</div>
            <div class="header">ID</div>
            <div class="header">Name</div>
            <div class="header">Type</div>
            <div class="header">View More</div>
            <div class="header">Edit</div>
            <div class="header">Delete</div>
        </div>

        <% for (Coche coche : listaCoches) { %>
        <div class="tabla">
            <div class="item">
                <img src="<%= request.getContextPath() %>/ControlerIMGCoche?id=<%= coche.getId() %>" alt="<%= coche.getNombre() %>">
            </div>
            <div class="item"><%= coche.getId() %></div>
            <div class="item"><%= coche.getNombre() %></div>
            <div class="item"><%= coche.getGrupo() %></div>
            <div class="item">
                <button class="view-button" onclick="window.location.href='coche-detail.jsp?id=<%= coche.getId() %>'">View More</button>
            </div>
            <div class="item">
                <button class="edit-button" onclick="window.location.href='car-form.jsp?id=<%= coche.getId() %>'">Edit</button>
            </div>
            <div class="item">
                <form action="coche" method="post" onsubmit="return confirm('Are you sure you want to delete <%= coche.getNombre() %>?');">
                    <input type="hidden" name="id" value="<%= coche.getId() %>">
                    <input type="hidden" name="action" value="delete">
                    <button type="submit" class="delete-button">Delete</button>
                </form>
            </div>
        </div>
        <% } %>
    </div>
</main>
</body>
</html>
