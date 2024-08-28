package aed;

import java.util.*;

// Todos los tipos de datos "Comparables" tienen el método compareTo()
// elem1.compareTo(elem2) devuelve un entero. Si es mayor a 0, entonces elem1 > elem2
public class ABB<T extends Comparable<T>> implements Conjunto<T> {
    private Nodo raiz;
    private int cardinal;
    private Nodo minimo;
    private Nodo maximo;

    private class Nodo {
        private T valor;
        private Nodo padre;
        private Nodo hmayor;
        private Nodo hmenor;

        public Nodo (T v){
            hmayor = null;
            hmenor = null;
            padre = null;
            valor = v;
        }
    }

    public ABB() {
        this.raiz = new Nodo(null);
    }

    public int cardinal() {
        return cardinal;
    }

    public T minimo(){
        minimo = new Nodo(null);
        minimo = raiz;
        while (minimo.hmenor != null){
            minimo = minimo.hmenor;
        }
        return minimo.valor;
    }

    public Nodo minimonodo(){
        minimo = new Nodo(null);
        minimo = raiz;
        while (minimo.hmenor != null){
            minimo = minimo.hmenor;
        }
        return minimo;
    }

    public T maximo(){
        maximo = new Nodo(null);
        maximo = raiz;
        while (maximo.hmayor != null){
            maximo = maximo.hmayor;
        }
        return maximo.valor;
    }

    public Nodo maximonodo(){
        maximo = new Nodo(null);
        maximo = raiz;
        while (maximo.hmayor != null){
            maximo = maximo.hmayor;
        }
        return maximo;
    }

    public void insertar(T elem){
        Nodo n = new Nodo(elem);
        if (pertenece(elem)){
        } else {
            if (cardinal == 0){
                raiz = n;
                cardinal += 1;
            } else {               
                ABB_Iterador itr = new ABB_Iterador();
                while ((elem.compareTo(itr.actual.valor) > 0) && (itr.haySiguiente())){
                    itr.siguiente();    
                }
                if ((elem.compareTo(itr.actual.valor) < 0) && (itr.haySiguiente())){
                    if (itr.actual.hmenor != null){
                        itr.actual.hmenor.padre = n;
                        n.hmenor = itr.actual.hmenor;
                    }
                    n.padre = itr.actual;
                    itr.actual.hmenor = n;  
                    cardinal += 1;
                } else {
                    if ((elem.compareTo(itr.actual.valor) > 0)){
                        n.padre = itr.actual;
                        itr.actual.hmayor = n;
                        cardinal += 1;
                    } else {
                        if (itr.actual.hmenor != null){
                            itr.actual.hmenor.padre = n;
                            n.hmenor = itr.actual.hmenor;
                        }
                        n.padre = itr.actual;
                        itr.actual.hmenor = n;
                        cardinal += 1;
                    } 
                }
            }
        }       
    }
        

    public boolean pertenece(T elem){
        if (cardinal == 0){
            return false;
        } else {ABB_Iterador itr = new ABB_Iterador();
                while ((elem.compareTo(itr.actual.valor) != 0) && (itr.haySiguiente())){
                    itr.siguiente();
                }
                if (elem.compareTo(itr.actual.valor) == 0){
                    return true;
                }
                else {
                    return false;
                }
            }
        
    }

    public void eliminar(T elem){
        if (!pertenece(elem)){
        } else {
            cardinal -= 1;
            int c = 0;
            ABB_Iterador itr = new ABB_Iterador();
            while (elem.compareTo(itr.actual.valor) != 0){
                itr.siguiente();
                c += 1;
            }
            Nodo n = new Nodo(null);
            n.padre = itr.actual.padre;
            n.hmayor = itr.actual.hmayor;
            n.hmenor = itr.actual.hmenor;
            n.valor = itr.actual.valor;
            if ((n.hmenor == null)&&(n.hmayor == null)){
                itr.actual = null;
            } else if ((n.hmenor != null)&&(n.hmayor == null)){
                n.hmenor.padre = n.padre;
                itr.actual = n.hmenor;
            } else if ((n.hmenor == null)&&(n.hmayor != null)){
                n.hmayor.padre = n.padre;
                if (n.padre != null ){n.padre.hmayor = n.hmayor;}
                itr.actual = n.hmayor;
                
            } else {
                ABB_Iterador itr2 = new ABB_Iterador(); 
                while (c != -1){
                    itr2.siguiente();
                    c -= 1;
                }
                itr2.actual.padre.hmenor = itr2.actual.hmayor;
                if (itr2.actual.hmayor != null){itr2.actual.hmayor.padre = itr.actual.padre;}
                itr.actual.valor = itr2.actual.valor;  
             }
     }
    }

    public String toString(){
        String s = "{";
        ABB_Iterador itr = new ABB_Iterador();
        while (itr.haySiguiente()){
            s += itr.actual.valor + ",";
            itr.siguiente();
        }
        s += itr.actual.valor;
        s += "}";
        return s;
    }

    private class ABB_Iterador implements Iterador<T> {
        private Nodo actual = minimonodo();
        private Nodo fin = maximonodo();

        public boolean haySiguiente() {            
            return (actual != fin);
        }
    
        public T siguiente() {
            T v = actual.valor;
            if (actual.hmayor != null){
                actual = actual.hmayor;
                while (actual.hmenor != null){
                    actual = actual.hmenor;
                }        
            } else {
                while ((actual.padre != null)&&(actual.valor.compareTo(actual.padre.valor)) > 0){
                    actual = actual.padre;
                }
                actual = actual.padre;
            }
            return v;
        }

    }

    public Iterador<T> iterador() {
        return new ABB_Iterador();
    }

}
