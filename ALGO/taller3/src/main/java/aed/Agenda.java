package aed;

public class Agenda {

    private Fecha fechaHoy;
    private ArregloRedimensionableDeRecordatorios recordatorioHoy;

    public Agenda(Fecha fechaActual) {
        this.fechaHoy = new Fecha(fechaActual.dia(), fechaActual.mes()) ;
        recordatorioHoy = new ArregloRedimensionableDeRecordatorios();
    }

    public void agregarRecordatorio(Recordatorio recordatorio) {
        recordatorioHoy.agregarAtras(recordatorio);
    }

    @Override
    public String toString() {
        String itinerario = "";
        for (int i = 0; i < recordatorioHoy.longitud(); i++) {
            if(fechaActual().equals(recordatorioHoy.obtener(i).fecha())){
                itinerario += (recordatorioHoy.obtener(i).toString());
                itinerario += "\n";
        }
    }
        return fechaHoy.dia() + "/" + fechaHoy.mes() + "\n=====\n" + itinerario;

    }

    public void incrementarDia() {
        fechaHoy.incrementarDia();;

    }

    public Fecha fechaActual() {
        return fechaHoy;
    }

}
