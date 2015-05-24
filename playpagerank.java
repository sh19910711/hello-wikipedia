import java.io.*;
import java.util.*;

class playpagerank {

  double[] pageranks;
  Map<String, Integer> idByTitle;
  Map<Integer, String> titleById;

  void initPageranks() throws IOException {
    File f = new File("./wikipedia-pageranks.raw");
    pageranks = new double[(int)(f.length() / 8)];
    DataInputStream in = new DataInputStream(new BufferedInputStream(new FileInputStream(f)));
    for ( int i = 0; i < pageranks.length; ++ i ) {
      pageranks[i] = in.readDouble();
    }
  }

  void initHash() throws IOException {
    File f = new File("./wikipedia-pagerank-page-id-title.raw");
    idByTitle = new HashMap<String, Integer>();
    titleById = new HashMap<Integer, String>();
    Scanner s = new Scanner(new BufferedInputStream(new FileInputStream(f)));
    while ( s.hasNext() ) {
      String title = s.next();
      Integer id = s.nextInt();
      idByTitle.put(title, id);
      titleById.put(id, title);
    }
  }

  double getPagerank(Integer id) {
    return -Math.log10(pageranks[id]);
  }

  Integer findIdByTitle(String title) {
    return idByTitle.get(title);
  }

  void showPagerank(String title) {
    Integer id = findIdByTitle(title);
    System.out.printf("%s(%d): %.3f\n", title, id, getPagerank(id));
  }

  playpagerank() throws IOException {
    initPageranks();
    initHash();

    int cnt = 0;
    for ( Map.Entry<Integer, String> e : titleById.entrySet() ) {
      if ( cnt >= 100 ) break;
      System.out.println(e.getValue());
      cnt ++;
    }
  }

  public static void main(String args[]) throws IOException {
    new playpagerank();
  }
  
}
