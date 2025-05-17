<%@ page import="com.natalia.demo.database.Database" %>
<%@ page import="com.natalia.demo.dao.UsuarioDao" %>
<%@ page import="com.natalia.demo.model.Usuario" %>
<%@ page import="java.sql.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Customer Profile</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/crear.css">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<%
    String titulo = "Register new profile";
    boolean modificando = false;
    int id = 0;
    String idParam = request.getParameter("id");

    String nombre = "";
    String apellido = "";
    String nacimiento= "";
    String fianza= "";

    if (idParam != null) {
        modificando = true;
        titulo = "Modify customer profile";
    }
    try{
        id = Integer.parseInt(idParam);
    } catch (NumberFormatException e) {}

    try {
        if (modificando) {
            Database database = new Database();
            database.connect();
            UsuarioDao usuarioDao = new UsuarioDao(database.getConnection());

            Usuario usuario = usuarioDao.getById(id);

            nombre = usuario.getNombre();
            apellido = usuario.getApellido();
            nacimiento = String.valueOf(usuario.getFechaNacimiento());
            fianza = String.valueOf(usuario.getFianza());
        }
    } catch (Exception e) {}
%>
<main>
    <h1 class="titulo"><%= titulo %></h1>
    <div class="form-container">
        <form class="formulario" method="post" enctype="multipart/form-data">
            <label for="foto">Profile Picture</label>
            <input type="file" name="foto" id="foto">

            <% if (modificando) { %>
            <input type="hidden" name="id" value="<%= id %>">
            <% } %>

            <label for="nombre">Name</label>
            <input type="text" name="nombre" id="nombre" value="<%= nombre %>">

            <label for="apellido">Last Name</label>
            <input type="text" name="apellido" id="apellido" value="<%= apellido %>">

            <label for="fecha">Birthday</label>
            <input type="date" name="fecha" id="fecha" value="<%= nacimiento %>">

            <label for="fianza">Deposit</label>
            <input type="number" name="fianza" id="fianza" value="<%= fianza %>">

            <div class="button-group">
                <button class="btn enviar" type="submit"><%= modificando ? "Modify" : "Create" %></button>
                <button class="btn back-button" type="button" onclick="window.history.back()">Back</button>
            </div>
        </form>
    </div>
</main>

<!-- Modal éxito -->
<div class="modal fade" id="successModal" tabindex="-1" aria-labelledby="successModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">successful operation</h5>
            </div>
            <div class="modal-body" id="modalSuccessMessage">
                ¡Great!
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" id="btnAcceptSuccess">Accept</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal error -->
<div class="modal fade" id="errorModal" tabindex="-1" aria-labelledby="errorModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Error</h5>
            </div>
            <div class="modal-body" id="modalErrorMessage">
                There was an error in the operation
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" id="btnAcceptError">Accept</button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function () {
        $('#btnAcceptSuccess').on('click', function () {
            $('#successModal').modal('hide');
            window.location.href = "customer-list.jsp";
        });

        $('#btnAcceptError').on('click', function () {
            $('#errorModal').modal('hide');
        });

        $("form").on("submit", function (event) {
            event.preventDefault();
            const form = $("form")[0];
            const formData = new FormData(form);

            $.ajax({
                url: "usuario",
                type: "POST",
                enctype: "multipart/form-data",
                data: formData,
                processData: false,
                contentType: false,
                cache: false,
                timeout: 10000,
                statusCode: {
                    200: function (response) {
                        if (response === "ok") {
                            $("#modalSuccessMessage").text("¡Successful operation! Accept to continue");
                            $("#successModal").modal('show');
                        } else {
                            $("#modalErrorMessage").text(response);
                            $("#errorModal").modal('show');
                        }
                    },
                    500: function () {
                        $("#modalErrorMessage").text("Damn it, there was an error in the operation");
                        $("#errorModal").modal('show');
                    }
                }
            });
        });
    });
</script>

</body>
</html>
