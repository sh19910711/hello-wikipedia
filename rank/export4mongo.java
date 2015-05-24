import java.io.*;
import java.util.*;

class export4mongo {

  double[] pageranks;
  Map<String, Integer> idByTitle;
  Map<Integer, String> titleById;

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

  double getPagerank(Integer id) {
    return -Math.log10(pageranks[id]);
  }

  export4mongo() throws IOException {
    readHash();
    readPageranks();

    ArrayList<entry> pages = new ArrayList<entry>();
    for ( String title : titleById.values() ) {
      int id = idByTitle.get(title);
      pages.add(new entry(id, getPagerank(id), title));
    }
    Collections.sort(pages);

    for ( entry page : pages.subList(0, 5000) ) {
      System.out.printf("pages.push(:page_id => %d, :rank => %.3f, :title => '%s')\n", page.pageId, page.pagerank, page.title);
    }
  }

  class entry implements Comparable<entry> {
    public final int pageId;
    public final double pagerank;
    public final String title;

    public entry(int pageId, double pagerank, String title) {
      this.pageId = pageId;
      this.pagerank = pagerank;
      this.title = title;
    }

    public int compareTo(entry e) {
      int ret = Double.compare(pagerank, e.pagerank);
      if ( ret != 0 ) {
        return ret;
      }
      return title.compareTo(e.title);
    }
  }

  public static void main(String[] args) throws IOException {
    new export4mongo();
  }

}
