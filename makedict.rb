require 'uri'

unless ARGV.size == 1
  STDERR.puts "Usage: ruby #{__FILE__} $RBENV_ROOT/versions/#{RUBY_VERSION}"
  exit
end

ri_files = Dir.glob(File.expand_path(ARGV[0]) + '/**/*.ri')

methods = ri_files.map do |file|
  method = URI.decode(File.basename(file))
  method.match(/\A(.*)-\w*\.ri\Z/) { |match| match[1] }
end

methods.compact.uniq.sort.each do |method|
  puts method unless method.size == 1
end
