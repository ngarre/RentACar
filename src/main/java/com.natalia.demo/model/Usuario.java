package com.natalia.demo.model;
import lombok.Data;

import java.io.InputStream;


@Data
public class Usuario {
   private int id;
   private String nombre;
   private String apellido;
   private int edad;
   private InputStream foto;
   private float fianza;
   private java.sql.Date fechaNacimiento;
   private boolean activo;
}

