# helpers
# prepend _ to function names to prevent name collisions

def _identical(file)
  puts "identical ~/.#{file}"
end

def _backup(file)
  puts "backup ~/.#{file}"

  system %Q(mv "$HOME/.#{file}" "$HOME/.#{file}.back")
end

def _recover(file)
  backup_file = "#{file}.back"
  if File.exist?(backup_file)
    puts "recovering #{backup_file}"

    system %Q(mv #{backup_file} #{file})
  end
end

def _linking(file, options = {})
  to_file = options[:to] || file
  puts "linking ~/.#{to_file}"

  system %Q(ln -s "$PWD/#{file}" "$HOME/.#{to_file}")
end

def _remove(file)
  puts "removing #{file}"

  system %Q(rm #{file})
end

def _skipping(file)
  puts "skipping: #{file} is not installed."
end

def _git(cmd)
  system %Q(git #{cmd})
end

def _continue?(msg = '')
  STDOUT.puts msg
  answer = STDIN.gets.chomp.downcase

  ['y', 'yes'].include?(answer)
end

def _install_lib(file, options = {})
  to_file   = options[:to] || file
  home_file = File.join(ENV['HOME'], ".#{to_file}")
  skip      = false
  if File.exist?(home_file)
    skip = File.identical?(file, home_file)
    skip ? _identical(file) : _backup(file)
  end

  _linking file, :to => to_file unless skip
end

def _remove_lib(file, options = {})
  from_file  = options[:from] || file
  home_file  = File.join(ENV['HOME'], ".#{from_file}")

  if File.exist?(home_file) && File.identical?(file, home_file)
     _remove home_file
    _recover home_file
  else
    _skipping file
  end
end

def _rbenv(action = :install)
  case action
  when :remove
    _remove_lib 'rbenv/plugins/rbenv-gemset'
    _remove_lib 'rbenv/core', :from => 'rbenv'
  when :install
    _install_lib 'rbenv/core', :to => 'rbenv'
    system %Q(mkdir -p "$HOME"/.rbenv/plugins)
    _install_lib 'rbenv/plugins/rbenv-gemset'
  else
    puts "WTF!!"
  end
end

def _excluded?(file)
  %w(Rakefile README.rdoc LICENSE lib rbenv).include? file
end
