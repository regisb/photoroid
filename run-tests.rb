

max = (ARGV[0] || "-1").to_i
num = 1
while (max == -1 || num <= max)
  result =`ruby -Itest test/unit/*.rb`
  puts `clear`
  puts "-------------- #{Time.now}\n#{result}"
  num += 1
end
