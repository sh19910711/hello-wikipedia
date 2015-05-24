require "xmlrpc/client"

MAX_URL = 50

# "はてなブックマーク件数取得APIのXML-RPCをRubyで使う - maru source"
# http://blog.h13i32maru.jp/entry/20091225/1261750792
module XMLRPC::ParseContentType
  def parse_content_type(str)
    a, *b = str.split(";")
    a = "text/xml" if a == "application/xml"
    return a.strip.downcase, *b
  end
end

def hatebu(urls)
  res = {}
  until urls.empty?
    args = urls.shift(MAX_URL)
    client = XMLRPC::Client.new2("http://b.hatena.ne.jp/xmlrpc")
    res.merge! client.call("bookmark.getCount", *args)
    sleep 1.5
  end
  res
end

def url2word(url)
  url.inject(::Hash.new) do |hash, (url, v)|
    word = url.match(%r{^http://ja.wikipedia.org/wiki/(.*)$})[1]
    hash[::URI.decode(word)] = v
    hash
  end
end

ret = hatebu [
  "http://ja.wikipedia.org/wiki/%E6%97%A5%E6%9C%AC",
  "http://ja.wikipedia.org/wiki/%E3%82%A6%E3%82%A3%E3%82%AD%E3%83%9A%E3%83%87%E3%82%A3%E3%82%A2",
]

p url2word(ret)

