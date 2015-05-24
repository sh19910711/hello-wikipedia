require "natto"
require "byebug"

$mecab = Natto::MeCab.new

def is人名?(word)
  res = $mecab.enum_parse(word).all? do |n|
    next true if /^BOS\/EOS,/ === n.feature
    /^名詞,/ === n.feature && /,人名,/ === n.feature
  end
end

f = File.open("tmp/rank.txt", "r")
while word = f.gets do
  word.strip!
  if is人名?(word)
    puts word
  end
end
