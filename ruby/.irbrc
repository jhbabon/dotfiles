# encoding: utf-8

# IRB configurition, borrowed from the follow links:
# * http://quotedprintable.com/2007/6/9/irb-history-and-completion
# * http://coderwall.com/p/6yqm-q
# * http://drnicwilliams.com/2006/10/12/my-irbrc-for-consoleirb/

require 'irb/completion'
require 'irb/ext/save-history'
require 'pp'
IRB.conf[:AUTO_INDENT] = true

ARGV.concat ["--readline", "--prompt-mode", "simple"]
IRB.conf[:SAVE_HISTORY] = 100
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"

def copy(*args)
  clip = args.map(&:inspect)
  IO.popen('pbcopy', 'r+') { |clipboard| clipboard.puts clip }

  $stdout.puts "#{clip.join} copied!"
end
