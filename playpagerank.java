import java.io.*;
import java.util.*;

class playpagerank {
  public static void main(String args[]) throws IOException {
    File filePageranks = new File("./wikipedia-pageranks.raw");
    double[] pageranks = new double[(int)(filePageranks.length() / 8)];
    DataInputStream in = new DataInputStream(new BufferedInputStream(new FileInputStream(filePageranks)));
    for ( int i = 0; i < pageranks.length; ++ i ) {
      pageranks[i] = in.readDouble();
    }
    System.out.printf("日本: " + 1864744 + ": %.3f\n", -Math.log10(pageranks[1864744]));
    System.out.printf("東京都: " + 774362 + ": %.3f\n", -Math.log10(pageranks[774362]));
    System.out.printf("アメリカ合衆国: " +1698838 + ": %.3f\n", -Math.log10(pageranks[1698838]));
    System.out.printf("英語: " + 3377 + ": %.3f\n", -Math.log10(pageranks[3377]));
    
  }
  
}
