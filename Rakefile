# based on: http://github.com/ryanb/dotfiles
require 'rake'

# helpers

def identical(file)
  puts "identical ~/.#{file}"
end

def backup(file)
  puts "backup ~/.#{file}"
  system %Q{mv "$HOME/.#{file}" "$HOME/.#{file}.back"}
end

def linking(file)
  puts "linking ~/.#{file}"
  system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
end

def git(cmd)
  system %Q{git #{cmd}}
end

# tasks

desc "install the dot files into user's home directory"
task :install => 'git:submodules:init' do
  puts "Installing configuration files:"
  Dir['*'].each do |file|
    next if %w[Rakefile README.rdoc LICENSE lib].include?(file)

    home_file = File.join(ENV['HOME'], ".#{file}")
    skip = false
    if File.exist?(home_file)
      skip = File.identical?(file, home_file)
      skip ? identical(file) : backup(file)
    end

    linking file unless skip
  end
end

namespace :git do
  namespace :submodules do

    desc "initialize git submodules"
    task :init do
      puts "Initializing git submodules:"
      git "submodule init"
      git "submodule update"
    end

    desc "update git submodules"
    task :update do
      puts "Updating git submodules:"
      git "submodule foreach git pull origin master"
      puts "Committing changes:"
      git "add ."
      git "commit -m 'Updated git submodules'"
    end
  end
end
