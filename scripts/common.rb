require 'pathname'

def _say(msg)
  $stdout.puts "---> #{msg}"
end

def _error(msg)
  $stderr.puts "---> [31mError: #{msg} was not found in the system[0m"
end

def with(cmd)
  if command?(cmd)
    yield
  else
    _error cmd
    exit false
  end
end

def with_stow
  with "stow" do
    Pathname.glob("*/").map(&:to_s).each do |package|
      unless package =~ /scripts/
        yield package
      end
    end
  end
end

def command?(cmd)
  system("which #{cmd} &>/dev/null 2>&1")
end
