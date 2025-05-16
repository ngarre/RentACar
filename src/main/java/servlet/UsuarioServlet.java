package servlet;

import com.natalia.demo.dao.UsuarioDao;
import com.natalia.demo.database.Database;
import com.natalia.demo.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;


import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import java.sql.SQLException;


@MultipartConfig
@WebServlet("/usuario")
public class UsuarioServlet extends HttpServlet {


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action");

        // Compruebo si estoy ante una eliminación
        if ("delete".equals(action)) {
            // Lógica para eliminar el usuario
            String idParam = request.getParameter("id");
            if (idParam != null && !idParam.isEmpty()) {
                try {
                    int id = Integer.parseInt(idParam);
                    Database db = new Database();
                    db.connect();
                    UsuarioDao usuarioDao = new UsuarioDao(db.getConnection());
                    usuarioDao.deleteUsuarioById(id);
                    response.sendRedirect("customer-list.jsp");
                } catch (Exception e) {
                    e.printStackTrace();
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al eliminar el usuario");
                }
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID no proporcionado");
            }
            return; // Salir después de la eliminación
        }

// Si no es una eliminación, proceder con la creación del usuario

        // Obtengo los datos del formulario
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String fechaStr = request.getParameter("fecha");
        String fianzaStr = request.getParameter("fianza");

        Part part = request.getPart("foto");
        InputStream inputStream = null;
        if (part != null && part.getSize() > 0) {
            inputStream = part.getInputStream();
        }

        // Verificar si se trata de una modificación o alta
        String idParam = request.getParameter("id");
        int id = (idParam != null && !idParam.isEmpty()) ? Integer.parseInt(idParam) : 0;


        // Creo el objeto Usuario
        Usuario usuario = new Usuario();
        usuario.setNombre(nombre);
        usuario.setApellido(apellido);
        usuario.setFechaNacimiento(Date.valueOf(fechaStr));
        usuario.setFianza((int) Double.parseDouble(fianzaStr));


        if (inputStream != null) {
            usuario.setFoto(inputStream);
        }


        Database database = new Database();

        try{
            database.connect();
            UsuarioDao usuarioDao = new UsuarioDao(database.getConnection());

            if (id > 0) {
                usuario.setId(id);
                usuarioDao.updateUsuario(usuario);
            }else{
                usuarioDao.insert(usuario);
            }

            // Redirigir al index tras insertar
            response.sendRedirect("customer-list.jsp");

        }catch (ClassNotFoundException | SQLException s) { }

    }
}