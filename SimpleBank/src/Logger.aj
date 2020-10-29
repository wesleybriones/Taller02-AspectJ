import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;

public aspect Logger {

    pointcut success() : call(* create*(..) );
    after() : success() {
    //Aspecto ejemplo: solo muestra este mensaje despu�s de haber creado un usuario 
    	System.out.println("**** User created ****");
    }
    int hora, minutos, segs;
    
    File file = new File("log.txt");
    //Aspecto: Deben hacer los puntos de cortes (pointcut) para crear un log con los tipos de transacciones realizadas.
    pointcut Retirar() : call(* moneyWithdrawal(..) );
    after() : Retirar() {
    	Calendar cal = Calendar.getInstance();
    	hora=cal.get(Calendar.HOUR_OF_DAY);
    	minutos=cal.get(Calendar.MINUTE);
    	segs=cal.get(Calendar.SECOND);
		try {
			FileWriter fw = new FileWriter(file,true);	
			PrintWriter pw= new PrintWriter(fw);
			pw.append("Tipo de transaccion: Retiro de dinero, Hora: "+ hora+ ":"+ minutos+ ":" + segs+"\n");
			pw.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	System.out.println("Tipo de transaccion: Retiro de dinero, Hora: "+ hora+ ":"+ minutos+ ":" + segs);
    }
    pointcut Transaccion() : call(* moneyMakeTransaction(..) );
    after() : Transaccion() {
    	Calendar cal = Calendar.getInstance();
    	hora=cal.get(Calendar.HOUR_OF_DAY);
    	minutos=cal.get(Calendar.MINUTE);
    	segs=cal.get(Calendar.SECOND);
		try {
			FileWriter fw = new FileWriter(file,true);
			PrintWriter pw= new PrintWriter(fw);
			pw.append("Tipo de transaccion: Realizacion de transaccion, Hora: "+ hora+ ":"+ minutos+ ":" + segs+"\n");
			pw.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	System.out.println("Tipo de transaccion: Realizacion de transaccion, Hora: "+ hora+ ":"+ minutos+ ":" + segs);
    }
}
