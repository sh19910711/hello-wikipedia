require_relative "_mongo_setup"
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
    ret = client.call("bookmark.getCount", *args)
    res.merge! ret
    p ret
    sleep 1
  end
  url2word res
end

def url2word(url)
  url.inject(::Hash.new) do |hash, (url, v)|
    word = url.match(%r{^http://ja.wikipedia.org/wiki/(.*)$})[1]
    hash[::URI.decode(word)] = v
    hash
  end
end

urls = Page.all.map do |page|
  "http://ja.wikipedia.org/wiki/#{URI.encode page.title}"
end
cnt = hatebu(urls)
Page.all.each do |page|
  puts "#{page.title} = #{cnt[page.title]}"
  page.update_attributes :hatebu => cnt[page.title]
end

# p hatebu [
#   "http://ja.wikipedia.org/wiki/%E6%97%A5%E6%9C%AC",
#   "http://ja.wikipedia.org/wiki/%E3%82%A6%E3%82%A3%E3%82%AD%E3%83%9A%E3%83%87%E3%82%A3%E3%82%A2",
# ]


