<%@ page import="com.natalia.demo.database.Database" %>
<%@ page import="com.natalia.demo.dao.CocheDao" %>
<%@ page import="com.natalia.demo.dao.UsuarioDao" %>
<%@ page import="com.natalia.demo.model.Coche" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Car form</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/crear.css">
</head>
<body>

<%
    String titulo = "Register New Vehicle";
    boolean modificando = false;
    int id = 0;
    String idParam = request.getParameter("id");

    String nombre = "";
    String precio = "";
    String plazas = "";
    String grupo = "";
    String descripcion = "";
    String fechaCompra = "";
    String disponibilidad = "true";
    String alquiladopor = "";

    ArrayList<String> listaApellidos = new ArrayList<>();

    try {
        Database database = new Database();
        database.connect();
        UsuarioDao usuarioDao = new UsuarioDao(database.getConnection());
        listaApellidos = usuarioDao.getAllApellidos();

        if (idParam != null) {
            modificando = true;
            titulo = "Modify Vehicle Data";
            id = Integer.parseInt(idParam);
            CocheDao cocheDao = new CocheDao(database.getConnection());

            Coche coche = cocheDao.getById(id);
            nombre = coche.getNombre();
            precio = String.valueOf(coche.getPrecio());
            plazas = String.valueOf(coche.getPlazas());
            grupo = coche.getGrupo();
            descripcion = coche.getDescripcion();
            alquiladopor = coche.getAlquiladopor();
            if (alquiladopor == null) {
                alquiladopor = "";
            }
            fechaCompra = String.valueOf(coche.getFechaCompra());
            disponibilidad = String.valueOf(coche.isDisponibilidad());
        }

    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<main>
    <h1 class="titulo"><%= titulo %></h1>
    <div class="form-container">
        <form class="formulario" action="coche" method="post" enctype="multipart/form-data">

            <label for="foto">Imagen</label>
            <input type="file" name="foto" id="foto">

            <% if (modificando) { %>
            <input type="hidden" name="id" value="<%= id %>">
            <% } %>

            <label for="nombre">Name and Brand</label>
            <input type="text" name="nombre" id="nombre" value="<%= nombre %>" required>

            <label for="precio">Price Per Day (€)</label>
            <input type="number" step="0.01" name="precio" id="precio" value="<%= precio %>" required>

            <label for="plazas">Seats</label>
            <input type="number" name="plazas" id="plazas" value="<%= plazas %>" required>

            <label for="grupo">Group</label>
            <input type="text" name="grupo" id="grupo" value="<%= grupo %>" required>

            <label for="descripcion">Description</label>
            <input type="text" name="descripcion" id="descripcion" value="<%= descripcion %>">

            <label for="alquiladopor">Rented by</label>
            <input type="text" name="alquiladopor" id="alquiladopor" list="lista-apellidos" value="<%= alquiladopor %>">
            <datalist id="lista-apellidos">
                <% for (String apellido : listaApellidos) { %>
                <option value="<%= apellido %>">
                        <% } %>
            </datalist>

            <label for="fechaCompra">Date of Acquisition</label>
            <input type="date" name="fechaCompra" id="fechaCompra" value="<%= fechaCompra %>" required>

            <label for="disponibilidad">Availability?</label>
            <select name="disponibilidad" id="disponibilidad">
                <option value="true" <%= "true".equals(disponibilidad) ? "selected" : "" %>>Yes</option>
                <option value="false" <%= "false".equals(disponibilidad) ? "selected" : "" %>>No</option>
            </select>

            <div class="button-group">
                <button class="btn enviar" type="submit"><%= modificando ? "Modify" : "Create" %></button>
                <button class="btn back-button" type="button" onclick="window.history.back()">Back</button>
            </div>

        </form>
    </div>
</main>

</body>
</html>
