package aed;

public class Horario {
    private int hora;
    private int minutos;

    public Horario(int hora, int minutos) {
        this.hora = hora;
        this.minutos = minutos;
    }

    public int hora() {
        return hora;
    }

    public int minutos() {
        return minutos;
    }

    @Override
    public String toString() {
        return hora + ":" + minutos;
    }

    @Override
    public boolean equals(Object otro) {
        boolean esnulo = (otro == null);
        boolean esdistinto = (otro.getClass() != this.getClass());
        if (esnulo || esdistinto){
            return false;
        } else {
            Horario otroHorario = (Horario) otro;
            return 
            this.hora() == otroHorario.hora() && this.minutos() == otroHorario.minutos();
        }
        }

}
