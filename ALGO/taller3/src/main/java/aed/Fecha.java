package aed;

public class Fecha {
    private int dia, mes;
    public Fecha(int dia, int mes) {
        this.dia = dia;
        this.mes = mes;
    }

    public Fecha(Fecha fecha) {
        Fecha copia = new Fecha(0,0);
        copia.dia = fecha.dia;
        copia.mes = fecha.mes;
        this.dia = copia.dia;
        this.mes = copia.mes;
    }

    public Integer dia() {
        return dia;
    }

    public Integer mes() {
        return mes;
    }

    @Override
    public String toString() {
        return dia + "/" + mes;
    }

    @Override
    public boolean equals(Object otra) {
        boolean esnulo = (otra == null);
        boolean esdistinto = (otra.getClass() != this.getClass());
        if (esnulo || esdistinto){
            return false;
        } else {
            Fecha otraFecha = (Fecha) otra;
            return
            this.dia().equals(otraFecha.dia()) && this.mes().equals(otraFecha.mes());
        }
        }
    

    public void incrementarDia() {
        if ((this.mes == 2) && (this.dia == 28)) {
            this.dia = 1;
            this.mes = 3;
        } else if (((this.mes == 4) || (this.mes == 6) || (this.mes == 9) || (this.mes == 11)) && (this.dia == 30)){
            this.dia = 1;
            this.mes = this.mes + 1;
        } else if ((this.dia == 31)&&(this.mes == 12)){
            this.dia = 1;
            this.mes = 1;
        }else if ((this.dia == 31)){
            this.dia = 1;
            this.mes = this.mes + 1;
        } else {
            this.dia = this.dia + 1;
        }
    }

    private int diasEnMes(int mes) {
        int dias[] = {
                // ene, feb, mar, abr, may, jun
                31, 28, 31, 30, 31, 30,
                // jul, ago, sep, oct, nov, dic
                31, 31, 30, 31, 30, 31
        };
        return dias[mes - 1];
    }

}
