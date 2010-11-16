# based on: http://github.com/ryanb/dotfiles

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }
require 'rake'

desc "install the dot files into user's home directory"
task :install => 'git:modules:init' do
  puts "Installing configuration files:"
  Dir['*'].each do |file|
    next if %w[Rakefile README.rdoc LICENSE lib].include? file
    if File.exist?(File.join(ENV['HOME'], ".#{file}"))
      if File.identical?(file, File.join(ENV['HOME'], ".#{file}"))
        puts "identical ~/.#{file}"
        skip = true
      else
        puts "backup ~/.#{file}"
        system %Q{mv "$HOME/.#{file}" "$HOME/.#{file}.back"}
        skip = false
      end
    end
    unless skip
      puts "linking ~/.#{file}"
      system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
    end
  end
end

namespace :git do
  namespace :modules do

    desc "initialize git modules"
    task :init do
      puts "Initializing git modules:"
      Git.submodule_init
      Git.submodule_update
    end

    desc "update git modules"
    task :update do
      puts "Git modules:"
      file = ".gitmodules"
      if File.exist?(file)
        paths = Git.extract_modules(file)

        paths.each do |path|
          puts "Updating #{path}:"
          Git.update_module(path)
          puts ""
        end

        puts "Committing changes:"
        Git.commit
      else
        puts "There is no .gitmodules file"
      end
    end
  end
end
