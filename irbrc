require "irb/completion"
require "irb/ext/save-history"
require "pp"
IRB.conf[:AUTO_INDENT] = true

ARGV.concat ["--readline", "--prompt-mode", "simple"]
IRB.conf[:SAVE_HISTORY] = 100
IRB.conf[:HISTORY_FILE] = "#{ENV["HOME"]}/.irb_history"
