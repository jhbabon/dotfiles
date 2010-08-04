# based on: http://github.com/ryanb/dotfiles

require 'rake'

desc "install the dot files into user's home directory"
task :install do
  Dir['*'].each do |file|
    next if %w[Rakefile README.rdoc LICENSE].include? file
    if File.exist?(File.join(ENV['HOME'], ".#{file}"))
      if File.identical? file, File.join(ENV['HOME'], ".#{file}")
        puts "identical ~/.#{file}"
        skip = true
      else
        puts "backup ~/.#{file}"
        system %Q{mv "$HOME/.#{file}" "$HOME/.#{file}.back"}
        skip = false
      end
    end
    link_file(file) unless skip
  end
end

def link_file(file)
  puts "linking ~/.#{file}"
  system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
end
