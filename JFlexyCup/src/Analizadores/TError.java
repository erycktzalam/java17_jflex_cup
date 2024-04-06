/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Analizadores;

/**
 *
 * @author Eryyc
 */
public class TError {
    String lexema,tipo,descripcion;
    int linea,columna;
    
    public TError (String le, int li, int co, String t, String de){
        lexema = le;
        linea = li;
        columna = co;
        tipo = t;
        descripcion = de;
    }
}
