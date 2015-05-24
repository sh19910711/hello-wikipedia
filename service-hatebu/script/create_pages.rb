require_relative "_mongo_setup"

if ARGV.empty?
  puts "Usage: command {path}"
  exit 1
end

f = File.open(ARGV[0], "r")
pages = []
while l = f.gets do
  page_id, rank = l.split
  pages.push(
    :page_id => page_id.to_i,
    :rank => rank.to_f,
  )
end

Page.create pages
