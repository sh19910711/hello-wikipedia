import java.io.*;
import java.util.*;

class readlinks {

  int links[];

  readlinks() throws IOException {
    File f = new File("./wikipedia-pagerank-page-links.raw");
    links = PageLinksList.readRawFile(f);
    int cnt = 0;
    for ( int i = 0; i < links.length; ) {
      int dest = links[i];
      int n = links[i + 1];
      for ( int j = 0; j < n; ++ j ) {
        int src = links[i + 2 + j];
        if ( src == 2093 ) {
          System.out.println(src + " -> " + dest);
          cnt ++;
        }
      }
      i += n + 2;
    }
    System.out.println("cnt = " + cnt);
  }

  public static void main(String[] args) throws IOException {
    new readlinks();
  }

}

