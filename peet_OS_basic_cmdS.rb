#OS?

def self.windows?
  return File.exist? "c:/WINDOWS" if RUBY_PLATFORM == 'java'
  RUBY_PLATFORM =~ /mingw32/ || RUBY_PLATFORM =~ /mswin32/
end

def self.linux?
  return File.exist? "/usr" if RUBY_PLATFORM == 'java'
  RUBY_PLATFORM =~ /linux/
end

def self.os
  return :linux if self.linux?
  return :windows if self.windows?
  nil
end

puts self.os

#Run a win cmd command

if self.os.to_s == 'windows'
        puts `net user`
elsif self.os.to_s == 'linux'
        puts   `ls`
else
        puts 'OS is neither recognized as win nor *nix'
end
