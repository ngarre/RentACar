package com.natalia.demo.model;
import lombok.Data;

import java.io.InputStream;

@Data
public class Coche {
    private int id;
    private String nombre;
    private float precio;
    private int plazas;
    private String grupo;
    private String descripcion;
    private String alquiladopor;
    private java.sql.Date fechaCompra;
    private boolean disponibilidad;
    private InputStream foto;
}
