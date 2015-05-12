Dir['./lib/*.rb'].each {|i| require_relative(i)}
require 'optparse'
require 'zlib'


occurrence = ARGV[0]

names = %w()
ARGV.each_index do |i|
break if ARGV[i][0] == '-' 
names.push(ARGV[i]) if i != 0
end

options = {}
OptionParser.new do |opts|

  opts.on("-A NUMBERSTR") do |v|
    options[:A] = v
  end

  opts.on("-e") do |v|
  	options[:e] = v
  end	 

  opts.on("-R") do |v|
  	options[:r] = v
  end	

  opts.on("-z FILENAME") do |v|
  	options[:z] = v
  end
end.parse!

=begin
puts options[:A] if options[:A]
puts options[:e] if options[:e]
puts options[:r] if options[:r]
puts options[:z] if options[:z]
=end

strings = %w()

if options[:z]
    Zlib::GzipReader.open(options[:z]) {|gz| gz.read.each_line{|i| strings.push(i)}}
    strings.each_index do |i|
     if !options[:e]
       b = strings[i].partition(occurrence)[2] != ""
     else
       b = strings[i].match(occurrence)
     end   
      if b 
          (i - options[:A].to_i).upto(i + options[:A].to_i) do |j|
          puts strings[j] if (strings[j] && j >= 0)
        end
      end
   end
    #s = File.read()
    #s = Zlib::Inflate.inflate(s)
    #p s
    #s.each_line{|i| strings.push(i)}
  end

names.each do |j|

  if !options[:r]
    strings = FileParcer.new(j).get_file
  else 
    strings = FolderParcer.new(j).get_folder
  end   

   strings.each_index do |i|
     if !options[:e]
       b = strings[i].partition(occurrence)[2] != ""
     else
       b = strings[i].match(occurrence)
     end   
      if b 
          (i - options[:A].to_i).upto(i + options[:A].to_i) do |j|
          puts strings[j] if (strings[j] && j >= 0)
        end
      end
   end
end   
  

