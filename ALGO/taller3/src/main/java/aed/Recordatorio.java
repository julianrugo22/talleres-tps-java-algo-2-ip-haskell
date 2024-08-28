package aed;

public class Recordatorio {
    private String mensaje;
    private Fecha fecha;
    private Horario horario;

    public Recordatorio(String mensaje, Fecha fechaB, Horario horario) {
        Fecha fechaCopia = new Fecha(fechaB);
        this.fecha = fechaCopia;
        this.horario = horario;
        this.mensaje = mensaje;
    }

    public Horario horario() {
        return horario;
    }

    public Fecha fecha() {
        Fecha fechaCopia = new Fecha(fecha);
        return fechaCopia;
    }

    public String mensaje() {
        return mensaje;
    }

    @Override
    public String toString() {
        return mensaje + " @ " + fecha + " " + horario;
    }

    @Override
    public boolean equals(Object otro) {
        boolean esnulo = (otro == null);
            boolean esdistinto = (otro.getClass() != this.getClass());
            if (esnulo || esdistinto){
                return false;
            } else {
                Recordatorio otroRecordatorio = (Recordatorio) otro;
                return
                this.mensaje().equals(otroRecordatorio.mensaje()) && this.fecha().equals(otroRecordatorio.fecha()) && this.horario().equals(otroRecordatorio.horario());
            }
            }
    }


