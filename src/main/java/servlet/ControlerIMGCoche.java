package servlet;

import com.natalia.demo.dao.CocheDao;
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

@WebServlet("/ControlerIMGCoche")
public class ControlerIMGCoche extends HttpServlet {

    private CocheDao cocheDao;
    private Connection connection;

    @Override
    public void init() throws ServletException {
        try {
            Database database = new Database();
            database.connect();
            connection = database.getConnection();
            cocheDao = new CocheDao(connection);
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

            InputStream imageStream = cocheDao.getFoto(id);
            if (imageStream != null) {
                response.setContentType("image/jpeg");

                try (BufferedInputStream in = new BufferedInputStream(imageStream);
                     BufferedOutputStream out = new BufferedOutputStream(response.getOutputStream())) {

                    byte[] buffer = new byte[1024];
                    int bytesRead;
                    while ((bytesRead = in.read(buffer)) != -1) {
                        out.write(buffer, 0, bytesRead);
                    }

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
        try {
            if (connection != null) {
                connection.close();  // Cierra la conexión a la base de datos
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}