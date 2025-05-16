package servlet;

import com.natalia.demo.dao.UsuarioDao;
import com.natalia.demo.database.Database;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/ControlerIMG")
public class ControlerIMG extends HttpServlet {

    private UsuarioDao usuarioDao;
    private Connection connection;

    @Override
    public void init() throws ServletException {
        try {
            Database database = new Database();
            database.connect();
            connection = database.getConnection();
            usuarioDao = new UsuarioDao(connection);
        } catch (SQLException | ClassNotFoundException e) {
            throw new ServletException("Error al conectar con la base de datos", e);
        }
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID no proporcionado");
            return;
        }

        try {
            int id = Integer.parseInt(idParam);

            InputStream imageStream = usuarioDao.getFoto(id);
            if (imageStream != null) {
                response.setContentType("image/jpeg");

                try (BufferedInputStream in = new BufferedInputStream(imageStream);
                     BufferedOutputStream out = new BufferedOutputStream(response.getOutputStream())) {
                    byte[] buffer = new byte[1024];
                    int bytesRead;
                    while ((bytesRead = in.read(buffer)) != -1) {

                        out.write(buffer, 0, bytesRead);
                    }

                } catch (IOException e) {
                    throw new RuntimeException(e);
                }
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Imagen no encontrada");
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID inválido");
        } catch (SQLException e) {
            throw new ServletException("Error al obtener la imagen de la base de datos", e);
        }
    }

    @Override
    public void destroy() {

        // Cierra la conexión cuando el servlet se destruye
        try {
            if (connection != null) {
                connection.close();  // Cierra la conexión a la base de datos
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}