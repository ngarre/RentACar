
<%@ page import="com.natalia.demo.dao.UsuarioDao" %>
<%@ page import="com.natalia.demo.model.Usuario" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.natalia.demo.database.Database" %>
<%@ page import="java.util.Collections" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Customers</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/cus-list-styles.css">


</head>
<body>
<div class="nav">
    <div class="logo"> <img src="${pageContext.request.contextPath}/imagenes/ejemplo/image.png"></div>
</div>


<main>
    <h1 class="titulo">List of customers</h1>
    <!-- Campo HTML para las búsquedas -->
    <div class="search-container">
        <form method="get" action="customer-list.jsp">
            <div class="search-fields">
                <input type="text" name="criterioNombre" placeholder="Name" id="criterioNombre"
                       value="<%= request.getParameter("criterioNombre") != null ? request.getParameter("criterioNombre") : "" %>">
                <input type="text" name="criterioApellidos" placeholder="Last Name" id="criterioApellidos"
                       value="<%= request.getParameter("criterioApellidos") != null ? request.getParameter("criterioApellidos") : "" %>">
                <button type="submit">Search</button>
            </div>
        </form>

    </div>
    <!------------------------------------>


    <%

        ArrayList<Usuario> listaUsuarios = new ArrayList<>();
        try {
            Database database = new Database();
            database.connect();
            UsuarioDao usuarioDao = new UsuarioDao(database.getConnection());

            // Aquí es donde recupero, si existen, los criterios de búsqueda
            String criterioNombre = request.getParameter("criterioNombre");
            String criterioApellidos = request.getParameter("criterioApellidos");

            if ((criterioNombre != null && !criterioNombre.trim().isEmpty()) ||
                    (criterioApellidos != null && !criterioApellidos.trim().isEmpty())) {

                listaUsuarios = usuarioDao.buscarPorNombreYApellidos(criterioNombre, criterioApellidos);
            } else {
                listaUsuarios = usuarioDao.getAll();
            }


            // Ordenamos la lista alfabéticamente por el nombre de la criptomoneda
            Collections.sort(listaUsuarios, (u1, u2) -> u1.getNombre().compareToIgnoreCase(u2.getNombre()));




        } catch (Exception e) {
            e.printStackTrace();
        }

    %>







    <div class = "container">
        <div class="back-button">
            <button class="back-button" onclick="window.location.href='index.jsp'">← Back to Home</button>
        </div>
        <div class="boton-crear-container">
            <button class="create-button" onclick="window.location.href='create.jsp'">Create new profile</button>
        </div>
        <div class = "tabla">
            <%--            <div class = "header">Id</div>--%>
            <div class = "header">Profile Picture</div>
            <div class = "header">Id</div>
            <div class = "header">Name</div>
            <div class = "header">Last Name</div>

            <%--            <div class = "header">Fecha nacimiento</div>--%>
            <%--            <div class = "header">Saldo</div>--%>
            <%--            <div class = "header">¿Activo?</div>--%>

            <div class = "header">View More</div>
            <div class = "header">Edit</div>
            <div class = "header">Delete</div>

        </div>


        <% for (Usuario usuario : listaUsuarios) {  %>
        <div class="tabla">

            <div class="item"><img src="<%= request.getContextPath() %>/ControlerIMG?id=<%= usuario.getId() %>" alt="<%= usuario.getNombre() %>"></div>
            <div class="item"><%= usuario.getId() %></div>
            <div class="item"><%= usuario.getNombre() %></div>
            <div class="item"><%= usuario.getApellido() %></div>
            <%--            <div class="item"><%= usuario.getFechaNacimiento() %></div>--%>
            <%--            <div class="item"><%= usuario.getSaldo() %> €</div>--%>
            <%--            <div class="item"><%= usuario.isActivo() ? "Sí" : "No" %></div>--%>
            <%--        <div class="item"><img src = "imagenes/ejemplo/Captura.JPG" alt = "Ejemplo"></div>--%>

            <%--            <div class="item"><button class="edit-button" onclick="window.location.href='#'">Editar</button></div>--%>
            <div class="item">
                <button class="view-button" onclick="window.location.href='customer-detail.jsp?id=<%= usuario.getId() %>'">View More</button>
            </div>
            <div class="item">
                <button class="edit-button" onclick="window.location.href='create.jsp?id=<%= usuario.getId() %>'">Edit</button>
            </div>
            <div class="item">
                <form action="usuario" method="post" onsubmit="return confirm('¿Estás seguro que deseas eliminar a <%= usuario.getNombre() %>?');">
                    <input type="hidden" name="id" value="<%= usuario.getId() %>">
                    <input type="hidden" name="action" value="delete">
                    <button type="submit" class="delete-button">Delete</button>
                </form>
            </div>


        </div>
        <% } %>


    </div>
    <%--    <div class="container2">--%>
    <%--        <button class="create-button" onclick="window.location.href='create.jsp'">Crear</button>--%>
    <%--    </div>--%>


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
