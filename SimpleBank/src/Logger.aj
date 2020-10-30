import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;

public aspect Logger {
	
	File file = new File("log.txt");
    Calendar cal = Calendar.getInstance();
    int hora, minutos, segs;
    
    pointcut success() : call(* money*(..) );
    after() : success() {
    	hora=cal.get(Calendar.HOUR_OF_DAY);
    	minutos=cal.get(Calendar.MINUTE);
    	segs=cal.get(Calendar.SECOND);
    	
    	try {
    		FileWriter fw = new FileWriter(file, true);
    		PrintWriter pw = new PrintWriter(fw);
    		pw.append("Type Transaction: "+thisJoinPointStaticPart.getSignature().getName()
    				+" Time: "+hora+":"+minutos+":"+segs+"\n");
    		pw.close();
    	} catch (IOException e) {
    		e.printStackTrace();
    	}
    	System.out.println("**** Transaction Successful ****\n"
    			+"Type Transaction: "+thisJoinPointStaticPart.getSignature().getName()
    			+" Time: "+hora+":"+minutos+":"+segs+"\n");
    	
    }
}