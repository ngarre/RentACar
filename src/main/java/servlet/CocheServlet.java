package servlet;

import com.natalia.demo.dao.CocheDao;
import com.natalia.demo.database.Database;
import com.natalia.demo.model.Coche;
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
@WebServlet("/coche")
public class CocheServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action");

        // Eliminación
        if ("delete".equals(action)) {
            String idParam = request.getParameter("id");
            if (idParam != null && !idParam.isEmpty()) {
                try {
                    int id = Integer.parseInt(idParam);
                    Database db = new Database();
                    db.connect();
                    CocheDao cocheDao = new CocheDao(db.getConnection());
                    cocheDao.deleteById(id);
                    response.sendRedirect("vehicles-list.jsp");
                } catch (Exception e) {
                    e.printStackTrace();
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al eliminar el coche");
                }
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID no proporcionado");
            }
            return;
        }

        // Si no es eliminación, proceder con la inserción o modificación
        String nombre = request.getParameter("nombre");
        String precioStr = request.getParameter("precio");
        String plazasStr = request.getParameter("plazas");
        String grupo = request.getParameter("grupo");
        String descripcion = request.getParameter("descripcion");
        String alquiladopor = request.getParameter("alquiladopor");
        String fechaStr = request.getParameter("fechaCompra");
        String disponibilidadStr = request.getParameter("disponibilidad");

        // Leer imagen
        Part part = request.getPart("foto");
        InputStream inputStream = null;
        if (part != null && part.getSize() > 0) {
            inputStream = part.getInputStream();
        }

        // Verificar si es actualización o nuevo
        String idParam = request.getParameter("id");
        int id = (idParam != null && !idParam.isEmpty()) ? Integer.parseInt(idParam) : 0;

        // Crear objeto Coche
        Coche coche = new Coche();
        coche.setNombre(nombre);
        coche.setPrecio(Float.parseFloat(precioStr));
        coche.setPlazas(Integer.parseInt(plazasStr));
        coche.setGrupo(grupo);
        coche.setDescripcion(descripcion);
        coche.setAlquiladopor(alquiladopor);
        coche.setFechaCompra(Date.valueOf(fechaStr));
        coche.setDisponibilidad(Boolean.parseBoolean(disponibilidadStr));
        if (inputStream != null) {
            coche.setFoto(inputStream);
        }

        Database db = new Database();
        response.setContentType("text/plain; charset=UTF-8");

        try {
            db.connect();
            CocheDao cocheDao = new CocheDao(db.getConnection());

            if (id > 0) {
                coche.setId(id);
                cocheDao.updateCoche(coche);
            } else {
                cocheDao.insert(coche);
            }



            response.sendRedirect("vehicles-list.jsp");

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al procesar el coche");

        }
    }
}