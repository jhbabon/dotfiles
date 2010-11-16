module Git
  def self.submodule_init
    system %Q{git submodule init}
  end

  def self.submodule_update
    system %Q{git submodule update}
  end

  def self.extract_modules(file)
    gitmodules = File.open(file, "r")
    paths = []

    gitmodules.each_line do |line|
      if line.include?("=")
        key, value = line.split("=")
        if key.lstrip.rstrip == "path"
          paths << value.lstrip.rstrip
        end
      else
        next
      end
    end

    return paths
  end

  def self.update_module(submodule)
    root = Dir.getwd
    Dir.chdir("#{root}/#{submodule}")
    self.pull
    Dir.chdir(root)
  end

  def self.pull
    system %Q{git pull origin master}
  end

  def self.add(file)
    system %Q{git add #{file}}
  end

  def self.commit
    self.add(".")
    system %Q{git commit -m "Updated git modules"}
  end
end
