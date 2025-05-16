//package com.natalia.demo.dao;
//
//import com.natalia.demo.model.Coche;
//import com.natalia.demo.model.Usuario;
//
//import java.io.InputStream;
//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//import java.util.ArrayList;
//
//public class CocheDao {
//    private Connection connection;
//    public CocheDao(Connection connection) { this.connection = connection; }
//
//    // -----------------------------------
//    // --Recupero TODOS los coches--------
//    // -----------------------------------
//
//    public ArrayList<Coche> getAll() throws SQLException {
//        String sql = "select * from coches";
//
//        PreparedStatement stmt = connection.prepareStatement(sql);
//        ResultSet result = stmt.executeQuery();
//
//        ArrayList<Coche> coches = new ArrayList<>();
//
//        while (result.next()) {
//            Coche coche = new Coche();
//            coche.setId(result.getInt("id"));
//            coche.setNombre(result.getString("nombre"));
//            coche.setPrecio(result.getFloat("preciodia"));
//            coche.setPlazas(result.getInt("plazas"));
//            coche.setGrupo(result.getString("grupo"));
//            coche.setDescripcion(result.getString("descripcion"));
//            coche.setDisponibilidad(result.getBoolean("disponibilidad"));
//            coche.setFechaCompra(result.getDate("fechacompra"));
//
//            coches.add(coche);
//        }
//        return coches;
//    }
//
//    // -----------------------------------
//    // --Recupero la imagen de la BBDD----
//    // -----------------------------------
//
//    public InputStream getFoto(int id) throws SQLException {
//        String sql = "select foto from coches where id = ?";
//        PreparedStatement statement = null;
//        ResultSet result = null;
//        InputStream imagenStream = null;
//
//        try {
//            statement = connection.prepareStatement(sql);
//            statement.setInt(1, id);
//            result = statement.executeQuery();
//
//            if (result.next()) {
//                // Recupera el InputStream del campo ImagenFoto.
//                imagenStream = result.getBinaryStream("foto");
//            }
//        } finally {
//            if (statement != null) statement.close();
//            if (result != null) result.close();
//        }
//        return imagenStream;
//    }
//
//
//}

package com.natalia.demo.dao;

import com.natalia.demo.model.Coche;

import java.io.InputStream;
import java.sql.*;
import java.util.ArrayList;

public class CocheDao {
    private Connection connection;

    public CocheDao(Connection connection) {
        this.connection = connection;
    }

    // Obtener todos los coches
    public ArrayList<Coche> getAll() throws SQLException {
        String sql = "SELECT * FROM coches";
        PreparedStatement stmt = connection.prepareStatement(sql);
        ResultSet result = stmt.executeQuery();

        ArrayList<Coche> coches = new ArrayList<>();

        while (result.next()) {
            Coche coche = new Coche();
            coche.setId(result.getInt("id"));
            coche.setNombre(result.getString("nombre"));
            coche.setPrecio(result.getFloat("preciodia"));
            coche.setPlazas(result.getInt("plazas"));
            coche.setGrupo(result.getString("grupo"));
            coche.setDescripcion(result.getString("descripcion"));
            coche.setAlquiladopor(result.getString("alquiladopor"));
            coche.setDisponibilidad(result.getBoolean("disponibilidad"));
            coche.setFechaCompra(result.getDate("fechacompra"));

            coches.add(coche);
        }
        return coches;
    }

    // Obtener coche por ID
    public Coche getById(int id) throws SQLException {
        String sql = "SELECT * FROM coches WHERE id = ?";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setInt(1, id);
        ResultSet result = stmt.executeQuery();

        Coche coche = null;
        if (result.next()) {
            coche = new Coche();
            coche.setId(id);
            coche.setNombre(result.getString("nombre"));
            coche.setPrecio(result.getFloat("preciodia"));
            coche.setPlazas(result.getInt("plazas"));
            coche.setGrupo(result.getString("grupo"));
            coche.setDescripcion(result.getString("descripcion"));
            coche.setAlquiladopor(result.getString("alquiladopor"));
            coche.setDisponibilidad(result.getBoolean("disponibilidad"));
            coche.setFechaCompra(result.getDate("fechacompra"));
        }

        result.close();
        stmt.close();

        return coche;
    }

    // Obtener la foto del coche
    public InputStream getFoto(int id) throws SQLException {
        String sql = "SELECT foto FROM coches WHERE id = ?";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setInt(1, id);
        ResultSet result = stmt.executeQuery();

        InputStream imagenStream = null;
        if (result.next()) {
            imagenStream = result.getBinaryStream("foto");
        }

        result.close();
        stmt.close();

        return imagenStream;
    }

    // Insertar coche nuevo
    public void insert(Coche coche) throws SQLException {
        String sql = "INSERT INTO coches (nombre, preciodia, plazas, grupo, descripcion, alquiladopor, fechacompra, disponibilidad, foto) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?,?)";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setString(1, coche.getNombre());
        stmt.setFloat(2, coche.getPrecio());
        stmt.setInt(3, coche.getPlazas());
        stmt.setString(4, coche.getGrupo());
        stmt.setString(5, coche.getDescripcion());
        stmt.setString(6, coche.getAlquiladopor());
        stmt.setDate(7, coche.getFechaCompra());
        stmt.setBoolean(8, coche.isDisponibilidad());
        if (coche.getFoto() != null) {
            stmt.setBlob(9, coche.getFoto());
        } else {
            stmt.setNull(9, java.sql.Types.BLOB);
        }


        stmt.executeUpdate();
        stmt.close();
    }

    // Eliminar coche por ID
    public void deleteById(int id) throws SQLException {
        String sql = "DELETE FROM coches WHERE id = ?";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setInt(1, id);
        stmt.executeUpdate();
        stmt.close();
    }

    // Actualizar coche
    public void updateCoche(Coche coche) throws SQLException {
        StringBuilder query = new StringBuilder("UPDATE coches SET nombre = ?, preciodia = ?, plazas = ?, grupo = ?, descripcion = ?,  AlquiladoPor = ?, fechacompra = ?, disponibilidad = ?");

        boolean tieneFoto = coche.getFoto() != null;
        if (tieneFoto) {
            query.append(", foto = ?");
        }

        query.append(" WHERE id = ?");
        PreparedStatement stmt = connection.prepareStatement(query.toString());

        int index = 1;
        stmt.setString(index++, coche.getNombre());
        stmt.setFloat(index++, coche.getPrecio());
        stmt.setInt(index++, coche.getPlazas());
        stmt.setString(index++, coche.getGrupo());
        stmt.setString(index++, coche.getDescripcion());
        stmt.setString(index++, coche.getAlquiladopor());
        stmt.setDate(index++, coche.getFechaCompra());
        stmt.setBoolean(index++, coche.isDisponibilidad());


        if (tieneFoto) {
            stmt.setBlob(index++, coche.getFoto());
        }

        stmt.setInt(index, coche.getId());
        stmt.executeUpdate();
        stmt.close();
    }
}
