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

</body>
</html>
