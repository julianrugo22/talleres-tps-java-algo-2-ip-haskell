package aed;

class ArregloRedimensionableDeRecordatorios implements SecuenciaDeRecordatorios {
    private Recordatorio[] arreglo;
    private int longitud;

    public ArregloRedimensionableDeRecordatorios() {
        this.longitud = 0;
        this.arreglo = new Recordatorio[0];
    }

    public ArregloRedimensionableDeRecordatorios(ArregloRedimensionableDeRecordatorios vector) {
          for (int i = 0 ; i < vector.longitud; i++){
            if (vector.arreglo[i] != null){
                this.agregarAtras(new Recordatorio(vector.arreglo[i].mensaje(), vector.arreglo[i].fecha(), vector.arreglo[i].horario()));
            }
        }
    }

    public int longitud() {
        return longitud;
    }

    public void agregarAtras(Recordatorio i) {
        Recordatorio[] arreglo_n = new Recordatorio[this.longitud() + 1];
        for (int j = 0 ; j < this.longitud() ; j++){
            arreglo_n[j] = this.arreglo[j];
        }
        arreglo_n[this.longitud()] = new Recordatorio(i.mensaje(), i.fecha(), i.horario());
        this.arreglo = arreglo_n;
        this.longitud = longitud + 1;
    }

    public Recordatorio obtener(int i) {
        return arreglo[i];
    }

    public void quitarAtras() {
        Recordatorio[] arreglo_n = new Recordatorio[this.longitud() - 1];
        for (int j = 0 ; j < this.longitud() - 1 ; j++){
            arreglo_n[j] = this.arreglo [j];
        }
        this.arreglo = arreglo_n;
        this.longitud = longitud - 1;
    }

    public void modificarPosicion(int indice, Recordatorio valor) {
        this.arreglo[indice] = valor;
    }

    public ArregloRedimensionableDeRecordatorios copiar() {
        ArregloRedimensionableDeRecordatorios copia = new ArregloRedimensionableDeRecordatorios();
        copia.longitud = this.longitud();
        copia.arreglo = new Recordatorio[this.longitud];
        for (int j = 0 ; j < this.longitud() ; j++){
            copia.arreglo[j] = this.arreglo [j];
        }
        return copia;
    }

}
