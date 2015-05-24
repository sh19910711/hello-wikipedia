import java.util.*;
import java.io.*;

class pageranks2txt {

  double getPagerank(double x) {
    return -Math.log10(x);
  }

  pageranks2txt() throws IOException {
    // read title - id
		Map<String,Integer> idByTitle = PageIdTitleMap.readRawFile(new File("./wikipedia-pagerank-page-id-title.raw"));

    // read pageranks
    File f = new File("./wikipedia-pageranks.raw");
    double[] pageranks = new double[(int)(f.length() / 8)];
    DataInputStream in = new DataInputStream(new BufferedInputStream(new FileInputStream(f)));
    int n = pageranks.length;

    for ( int i = 0; i < n; ++ i ) {
      pageranks[i] = in.readDouble();
    }
    for ( Integer id : idByTitle.values() ) {
      System.out.printf("%d\t%.3f\n", id, getPagerank(pageranks[id]));
    }
  }

  public static void main(String[] args) throws IOException {
    new pageranks2txt();
  }

}
