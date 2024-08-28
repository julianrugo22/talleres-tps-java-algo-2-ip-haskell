package aed;

import java.util.*;

public class ListaEnlazada<T> implements Secuencia<T> {
    private Nodo primero;
    private Nodo ultimo;
    private Nodo base1;
    private Nodo base2;
    private int size = 0;

    private class Nodo {
        Nodo siguiente;
        Nodo anterior;
        T valor;
        public Nodo(T v){
            anterior = null;
            siguiente = null;
            valor = v;
        }
    }

    public ListaEnlazada() {
        this.primero = new Nodo(null);
        this.ultimo = new Nodo(null);
        this.base1 = new Nodo (null);
        this.base2 = new Nodo (null);
    }

    public int longitud() {
        return size;
    }

    public void agregarAdelante(T elem) {
        Nodo alfa = new Nodo(elem);
        this.base1.siguiente = primero;
        this.base2.siguiente = ultimo;
        if (longitud() >= 2){
            Nodo beta = new Nodo(primero.valor);
            primero.siguiente.anterior = beta;
            beta.siguiente = primero.siguiente;
            beta.anterior = alfa;
            alfa.siguiente = beta;
            alfa.anterior = null;
            primero.valor = alfa.valor;
            primero.siguiente = alfa.siguiente;         
        } else if (longitud() == 1){
            Nodo beta = new Nodo(primero.valor);
            primero.valor = alfa.valor;
            ultimo.valor = beta.valor;
            primero.siguiente = ultimo;
            ultimo.anterior = primero;
        } else {
            primero.valor = alfa.valor;
        }
        size += 1;
    }

    public void agregarAtras(T elem) {
        Nodo alfa = new Nodo(elem);
        if (longitud() >= 2){
            Nodo beta = new Nodo(ultimo.valor);
            ultimo.anterior.siguiente = beta;
            beta.anterior = ultimo.anterior;
            beta.siguiente = alfa;
            alfa.anterior = beta;
            ultimo.valor = alfa.valor;
            ultimo.anterior = alfa.anterior;
        } else if (longitud() == 1){
            ultimo.valor = alfa.valor;
            ultimo.anterior = primero;
            primero.siguiente = ultimo;
        } 
        else {
            primero.valor = alfa.valor; 
            ultimo.valor = alfa.valor;      
        }     
        size += 1;  
    }

    public T obtener(int i) {
        int x = 0;
        ListaIterador itr = new ListaIterador();
        while (x != i){
            x ++;
            itr.siguiente();
        }
        return itr.actual.valor;
    }

    public void eliminar(int i) {
        int x = 0;
        ListaIterador itr1 = new ListaIterador();
        while (x != i){
            x ++;
            itr1.siguiente();
        }
        if (longitud() == 1){
            primero.valor = null;
        } else if (i == 0){
            primero = primero.siguiente;
            primero.anterior = null;
        } else if(i == longitud() - 1){
            ultimo = ultimo.anterior;
            ultimo.siguiente = null;
        } else {
            ListaIterador itr2 = new ListaIterador();
            itr2.actual = itr1.actual;
            itr2.siguiente();
            itr1.anterior();
            itr1.actual.siguiente = itr2.actual;
            itr2.actual.anterior = itr1.actual;
        }
        size -= 1;
    }

    public void modificarPosicion(int indice, T elem) {
        int x = 0;
        ListaIterador itr1 = new ListaIterador();
        while (x != indice){
            x ++;
            itr1.siguiente();
        }
        itr1.actual.valor = elem;
    }

    public ListaEnlazada<T> copiar() {
        ListaEnlazada copia = new ListaEnlazada();
        ListaIterador itr = new ListaIterador();
        int x = 0;
        while (x < longitud()){
            copia.agregarAtras(itr.actual.valor);
            x ++;
            if (itr.haySiguiente()){
                itr.siguiente();
            } else { break; }
        }
        return copia;
    }



    public ListaEnlazada(ListaEnlazada<T> lista) {
        ListaEnlazada<T> copia = lista.copiar();
        this.primero = copia.primero;
        this.ultimo = copia.ultimo;
        this.size = copia.size;
    }
    


    @Override
    public String toString() {
        ListaIterador itr = new ListaIterador();
        String s = "[" + itr.actual.valor;
        while (itr.pos < size - 1){
            s += ", ";
            itr.siguiente();
            s += itr.actual.valor;
        }
        s += "]";
        return s;
    }

    private class ListaIterador implements Iterador<T> {
        
        private Nodo actual;
        private int pos;

        public ListaIterador (){
            actual = primero;
        }

        public boolean haySiguiente() {
	        return (pos < size) ;
        }
        
        public boolean hayAnterior() {
	        return ((pos != 0));
        }

        public T siguiente() {
            T v;
            v = actual.valor;
            if (pos < size - 1){
                actual = actual.siguiente;
                pos += 1;
            } else if (pos == size - 1){ 
                pos += 1;
                return v;
            } else {}
            return v;
        }
        
        public T anterior() {
            if (pos == size){ return actual.valor;}
            
            actual = actual.anterior;
            pos -= 1;
            return actual.valor;

        }        
    }

    public Iterador<T> iterador() {
	    ListaIterador itr = new ListaIterador();
        return itr;
    }

}
