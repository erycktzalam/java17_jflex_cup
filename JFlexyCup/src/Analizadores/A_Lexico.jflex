/*----------------------------------------------------------------------------
--------------------- 1ra. Area: Codigo de Usuario
----------------------------------------------------------------------------*/

//-------> Paquete, importaciones

package Analizadores;

import java_cup.runtime.*;
import java.util.ArrayList;

%%
/*----------------------------------------------------------------------------
--------------------- 2da. Area: Opciones y Declaraciones
----------------------------------------------------------------------------*/

%{
    String cadena="";
    public static LinkedList<AcepErr> TablaErr=new LinkedList<AcepErr>();
%}

//-------> Directivas
%public
%class ALexico
%cupsym Simbolos
%cup
%char
%column
%full
%ignorecase
%line
%unicode

//-------> Expresiones Regulares
digito = [0-9]
numero = {digito}+("." {digito}+)?
letra = [a-zA-ZñÑ]
id = {letra}+({letra}|{digito}|"_"|" ")*


//-------> Estados
%state COMENT_SIMPLE
%state COMENT_MULTI
%state RUTA

%%
/*-------------------------------------------------------------------
--------------------- 3ra. y ultima area: Reglas Lexicas
-------------------------------------------------------------------*/

//-------> Comentarios

<RUTA>{
[\"] {  String temporal=cadena; cadena=""; yybegin(YYINITIAL);
        return new Symbol(Simbolos.ruta, yychar,yyline,temporal);   }
[^\"] { cadena+=yytext(); }
}
<YYINITIAL> "/*"                {yybegin(COMENT_MULTI);}
<COMENT_MULTI> "*/"             {yybegin(YYINITIAL);}
<COMENT_MULTI> .                {}
<COMENT_MULTI> [ \t\r\n\f]      {}

<YYINITIAL> "//"                {yybegin(COMENT_SIMPLE);}
<COMENT_SIMPLE> [^"\n"]         {}
<COMENT_SIMPLE> "\n"            {yybegin(YYINITIAL);}


//-------> Simbolos

<YYINITIAL> ","         {   System.out.println("Reconocido: <<"+yytext()+">>, coma");
                            return new Symbol(Simbolos.coma, yycolumn, yyline, yytext());}

<YYINITIAL> ":"         {   System.out.println("Reconocido: <<"+yytext()+">>, dosp");
                            return new Symbol(Simbolos.dosp, yycolumn, yyline, yytext());}

<YYINITIAL> "("         {   System.out.println("Reconocido: <<"+yytext()+">>, apar");
                            return new Symbol(Simbolos.apar, yycolumn, yyline, yytext());}

<YYINITIAL> ")"         {   System.out.println("Reconocido: <<"+yytext()+">>, cpar");
                            return new Symbol(Simbolos.cpar, yycolumn, yyline, yytext());}

<YYINITIAL> "{"         {   System.out.println("Reconocido: <<"+yytext()+">>, alla");
                            return new Symbol(Simbolos.alla, yycolumn, yyline, yytext());}

<YYINITIAL> "}"         {   System.out.println("Reconocido: <<"+yytext()+">>, clla");
                            return new Symbol(Simbolos.clla, yycolumn, yyline, yytext());}

//-------> Operadores Aritmeticos

<YYINITIAL> "+"         {   System.out.println("Reconocido: <<"+yytext()+">>, mas");
                            return new Symbol(Simbolos.mas, yycolumn, yyline, yytext());}

<YYINITIAL> "-"         {   System.out.println("Reconocido: <<"+yytext()+">>, menos");
                            return new Symbol(Simbolos.menos, yycolumn, yyline, yytext());}

<YYINITIAL> "*"         {   System.out.println("Reconocido: <<"+yytext()+">>, por");
                            return new Symbol(Simbolos.por, yycolumn, yyline, yytext());}

<YYINITIAL> "/"         {   System.out.println("Reconocido: <<"+yytext()+">>, dividir");
                            return new Symbol(Simbolos.dividir, yycolumn, yyline, yytext());}


//-------> Reservadas, tipos de datos y del sistema

<YYINITIAL> "Escenario"             {   System.out.println("Reconocido: <<"+yytext()+">>, rvoid");
                                return new Symbol(Simbolos.rescenario, yycolumn, yyline, yytext());}

<YYINITIAL> "Nave"                  {   System.out.println("Reconocido: <<"+yytext()+">>, rint");
                                return new Symbol(Simbolos.rnave, yycolumn, yyline, yytext());}

<YYINITIAL> "Enemigos"              {   System.out.println("Reconocido: <<"+yytext()+">>, rdouble");
                                return new Symbol(Simbolos.renemigos, yycolumn, yyline, yytext());}

<YYINITIAL> "fondo"                 {   System.out.println("Reconocido: <<"+yytext()+">>, rstring");
                                return new Symbol(Simbolos.rfondo, yycolumn, yyline, yytext());}

<YYINITIAL> "sonido"                 {   System.out.println("Reconocido: <<"+yytext()+">>, rchar");
                                return new Symbol(Simbolos.rsonido, yycolumn, yyline, yytext());}

<YYINITIAL> "imagen_nave"            {   System.out.println("Reconocido: <<"+yytext()+">>, rbool");
                                return new Symbol(Simbolos.rimagen_nave, yycolumn, yyline, yytext());}

<YYINITIAL> "imagen_disparo"         {   System.out.println("Reconocido: <<"+yytext()+">>, rstack");
                                return new Symbol(Simbolos.rimagen_disparo, yycolumn, yyline, yytext());}

<YYINITIAL> "sonido_disparo"          {   System.out.println("Reconocido: <<"+yytext()+">>, rheap");
                                return new Symbol(Simbolos.rsonido_disparo, yycolumn, yyline, yytext());}

<YYINITIAL> "vida"                    {   System.out.println("Reconocido: <<"+yytext()+">>, rmain");
                                return new Symbol(Simbolos.rvida, yycolumn, yyline, yytext());}

<YYINITIAL> "ataque"                  {   System.out.println("Reconocido: <<"+yytext()+">>, rif");
                                return new Symbol(Simbolos.rataque, yycolumn, yyline, yytext());}

<YYINITIAL> "nombre"                  {   System.out.println("Reconocido: <<"+yytext()+">>, rgoto");
                                return new Symbol(Simbolos.rnombre, yycolumn, yyline, yytext());}

<YYINITIAL> "imagen_enemigo"          {   System.out.println("Reconocido: <<"+yytext()+">>, rgoto");
                                return new Symbol(Simbolos.rimagen_enemigo, yycolumn, yyline, yytext());}

<YYINITIAL> "frecuencia"              {   System.out.println("Reconocido: <<"+yytext()+">>, rcall");
                                return new Symbol(Simbolos.rfrecuencia, yycolumn, yyline, yytext());}

<YYINITIAL> "velocidad"               {   System.out.println("Reconocido: <<"+yytext()+">>, printf");
                                return new Symbol(Simbolos.rvelocidad, yycolumn, yyline, yytext());}

<YYINITIAL> "punteo"                  {   System.out.println("Reconocido: <<"+yytext()+">>, prints");
                                return new Symbol(Simbolos.rpunteo, yycolumn, yyline, yytext());}

"\"" {yybegin(RUTA);}

<YYINITIAL> {numero}                  {   System.out.println("Reconocido: <<"+yytext()+">>, numero ");
                                return new Symbol(Simbolos.numero, yycolumn, yyline, yytext());}

<YYINITIAL> {id}                      {   System.out.println("Reconocido: <<"+yytext()+">>, id ");
                                return new Symbol(Simbolos.id, yycolumn, yyline, yytext());}




[ \t\r\n\f]                 {/* ignore white space. */ }
 
.                           {   System.out.println("Error Lexico: <<"+yytext()+">> ["+yyline+" , "+yycolumn+"]");
                                AcepErr datos =new AcepErr(yytext(),"ERROR LEXICO",(yyline+1),(yycolumn+1), "Simbolo no existe en el lenguaje");
                                    TablaErr.add(datos);}
