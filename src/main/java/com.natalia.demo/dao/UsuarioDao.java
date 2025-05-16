package com.natalia.demo.dao;
import com.natalia.demo.model.Usuario;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class UsuarioDao {
    private Connection connection;
    public UsuarioDao(Connection connection) { this.connection = connection; }

    // -----------------------------------
    // --Recupero TODOS los usuarios------
    // -----------------------------------

    public ArrayList<Usuario> getAll() throws SQLException {

        String sql = "select * from usuarios";

        PreparedStatement stmt = connection.prepareStatement(sql);
        ResultSet result = stmt.executeQuery();

        ArrayList<Usuario> usuarios = new ArrayList<>();

        while (result.next()) {
            Usuario usuario = new Usuario();
            usuario.setId(result.getInt("id"));
            usuario.setNombre(result.getString("nombre"));
            usuario.setApellido(result.getString("apellidos"));
            usuario.setEdad(result.getInt("edad"));
            usuario.setFechaNacimiento(result.getDate("nacimiento"));
            usuario.setFianza(result.getFloat("fianza"));
            usuario.setActivo(result.getBoolean("activos"));

            usuarios.add(usuario);
        }
        return usuarios;
    }

    // -----------------------------------
// --Obtener solo los apellidos------
// -----------------------------------
    public ArrayList<String> getAllApellidos() throws SQLException {
        String sql = "SELECT apellidos FROM usuarios";
        PreparedStatement stmt = connection.prepareStatement(sql);
        ResultSet result = stmt.executeQuery();

        ArrayList<String> apellidos = new ArrayList<>();
        while (result.next()) {
            apellidos.add(result.getString("apellidos"));
        }

        return apellidos;
    }

    // -----------------------------------------------------------
    // --Recupero TODOS los usuarios por nombre y apellidos ------
    // -----------------------------------------------------------

    public ArrayList<Usuario> buscarPorNombreYApellidos(String nombre, String apellidos) throws SQLException {
        ArrayList<Usuario> usuarios = new ArrayList<>();

        String sql = "SELECT * FROM usuarios WHERE 1=1";
        ArrayList<Object> params = new ArrayList<>();

        if (nombre != null && !nombre.trim().isEmpty()) {
            sql += " AND nombre LIKE ?";
            params.add("%" + nombre.trim() + "%");
        }

        if (apellidos != null && !apellidos.trim().isEmpty()) {
            sql += " AND apellidos LIKE ?";
            params.add("%" + apellidos.trim() + "%");
        }

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }

            ResultSet result = stmt.executeQuery();
            while (result.next()) {
                Usuario usuario = new Usuario();
                usuario.setId(result.getInt("id"));
                usuario.setNombre(result.getString("nombre"));
                usuario.setApellido(result.getString("apellidos"));
                usuario.setEdad(result.getInt("edad"));
                usuario.setFechaNacimiento(result.getDate("nacimiento"));
                usuario.setFianza(result.getFloat("fianza"));
                usuario.setActivo(result.getBoolean("activos"));

                usuarios.add(usuario);
            }
        }

        return usuarios;
    }






    // -----------------------------------
    // --Recupero Usuario por id----------
    // -----------------------------------
    public Usuario getById(int id) throws SQLException {
        String sql = "select * from usuarios where id = ?";
        PreparedStatement statement = null;
        ResultSet result = null;
        statement = connection.prepareStatement(sql);
        statement.setInt(1, id);
        result = statement.executeQuery();

        Usuario usuario = new Usuario();

        if (result.next()) {
            usuario.setNombre(result.getString("nombre"));
            usuario.setApellido(result.getString("apellidos"));
            usuario.setEdad(result.getInt("edad"));
            usuario.setFechaNacimiento(result.getDate("nacimiento"));
            usuario.setFianza(result.getFloat("fianza"));
        }

        statement.close();
        return usuario;

    }


    // -----------------------------------
    // --Recupero la imagen de la BBDD----
    // -----------------------------------

    public InputStream getFoto(int id) throws SQLException {
        String sql = "select foto from usuarios where id = ?";
        PreparedStatement statement = null;
        ResultSet result = null;
        InputStream imagenStream = null;

        try {
            statement = connection.prepareStatement(sql);
            statement.setInt(1, id);
            result = statement.executeQuery();

            if (result.next()) {
                // Recupera el InputStream del campo ImagenFoto.
                imagenStream = result.getBinaryStream("foto");
            }
        } finally {
            if (statement != null) statement.close();
            if (result != null) result.close();
        }
        return imagenStream;
    }



    // -----------------------------------
    // -----------Nuevo Registro----------
    // -----------------------------------

    public void insert(Usuario usuario) throws SQLException {
        String sql = "insert into usuarios (nombre, apellidos, nacimiento, fianza, foto) values (?, ?, ?, ?, ?)";

        try(PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, usuario.getNombre());
            stmt.setString(2, usuario.getApellido());
            stmt.setDate(3, usuario.getFechaNacimiento());
            stmt.setFloat(4, usuario.getFianza());
            stmt.setBlob(5, usuario.getFoto());

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // -----------------------------------
    // -----------Eliminar Registro----------
    // -----------------------------------

    public void deleteUsuarioById(int id) throws SQLException {
        String sql = "delete from usuarios where id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // -----------------------------------
    // -----------Modificar Registro------
    // -----------------------------------

    public void updateUsuario(Usuario usuario) throws SQLException {
        StringBuilder query = new StringBuilder("UPDATE usuarios SET nombre = ?, apellidos = ?, nacimiento = ?, fianza = ?");

        // Solo agregar la imagen si se proporciona
        boolean tieneFoto = usuario.getFoto() != null;
        if (tieneFoto) {
            query.append(", foto = ?");
        }

        query.append(" WHERE id = ?");

        PreparedStatement stmt = connection.prepareStatement(query.toString());

        int index = 1;

        stmt.setString(index++, usuario.getNombre());
        stmt.setString(index++, usuario.getApellido());
        stmt.setDate(index++, usuario.getFechaNacimiento());
        stmt.setFloat(index++, usuario.getFianza());

        if (tieneFoto) {
            stmt.setBlob(index++, usuario.getFoto());
        }

        stmt.setInt(index, usuario.getId());

        stmt.executeUpdate();
    }

}