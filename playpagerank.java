import java.io.*;
import java.util.*;

class playpagerank {

  double[] pageranks;
  Map<String, Integer> idByTitle;
  Map<Integer, String> titleById;
  int links[];

  void readPageranks() throws IOException {
    File f = new File("./wikipedia-pageranks.raw");
    pageranks = new double[(int)(f.length() / 8)];
    DataInputStream in = new DataInputStream(new BufferedInputStream(new FileInputStream(f)));
    for ( int i = 0; i < pageranks.length; ++ i ) {
      pageranks[i] = in.readDouble();
    }
  }

  void readHash() throws IOException {
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

  void readLinks() throws IOException {
    File f = new File("./wikipedia-pagerank-page-links.raw");
    links = PageLinksList.readRawFile(f);
  }

  Set<Integer> childrens(Integer from) {
    Set<Integer> res = new TreeSet<Integer>();
    for ( int i = 0; i < links.length; ) {
      int dest = links[i];
      int n = links[i + 1];
      for ( int j = 0; j < n; ++ j ) {
        int src = links[i + 2 + j];
        if ( src == from ) {
          res.add(Integer.valueOf(dest));
          break;
        }
      }
      i += n + 2;
    }
    return res;
  }

  Set<Integer> findBySet(Set<Integer> s) {
    Set<Integer> res = new TreeSet<Integer>();
    for ( int i = 0; i < links.length; ) {
      int dest = links[i];
      int n = links[i + 1];
      for ( int j = 0; j < n; ++ j ) {
        int src = links[i + 2 + j];
        if ( s.contains(src) ) {
          res.add(dest);
          break;
        }
      }
      i += n + 2;
    }
    return res;
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
    readLinks();
    readPageranks();
    readHash();

    Integer personListListId = 2093;
    Set<Integer> personListIds = childrens(personListListId); // OK
    Set<Integer> personIds = findBySet(personListIds);

    // 日本（id = 1864744）

    ArrayList<entry> entries = new ArrayList<entry>();
    for ( Integer personId : personIds ) {
      entries.add(new entry(getPagerank(personId), titleById.get(personId)));
    }
    Collections.sort(entries);
    for ( entry e : entries ) {
      System.out.println(e.title + "\t" + e.pagerank);
    }
  }

  class entry implements Comparable<entry> {
    public final double pagerank;
    public final String title;

    entry(double pagerank, String title) {
      this.pagerank = pagerank;
      this.title = title;
    }

    public int compareTo(entry r) {
      int temp = Double.compare(pagerank, r.pagerank);
      if ( temp != 0 ) {
        return temp;
      }
      return title.compareTo(r.title);
    }
  }

  public static void main(String args[]) throws IOException {
    new playpagerank();
  }

}
