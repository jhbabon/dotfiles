# based on: http://github.com/ryanb/dotfiles
require 'rake'
require File.join(File.dirname(__FILE__), 'lib', 'helpers')

# tasks

desc "install the dot files into user's home directory"
task :install => 'bundles:init' do
  puts "Installing configuration files:"
  # basic files
  _basic_files { |f| _install_lib f }

  # special libs
  _rbenv
end

desc "removes the dot files from user's home directory"
task :remove do
  puts "Uninstalling configuration files:"
  # basic files
  _basic_files { |f| _remove_lib f }

  # special libs
  _rbenv :remove
end

namespace :bundles do

  desc "initialize bundle (all git submodules)"
  task :init do
    puts "Initializing git submodules:"
    _git "submodule init"
    _git "submodule update"
  end

  desc "update bundles (git submodules)"
  task :update do
    puts "Updating git submodules:"
    _git "submodule foreach git pull origin master"
    if _continue? 'Do you want to commit the changes (if any)? [N/y]: '
      puts "Committing changes:"
      _git "add ."
      _git "commit -m 'Updated git submodules'"
    end
  end
end
