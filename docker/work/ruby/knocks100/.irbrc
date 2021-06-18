require 'irb/completion'
require 'irb/ext/save-history'

IRB.conf[:SAVE_HISTORY] = 100
IRB.conf[:HISTORY_FILE] = File.expand_path('~/.irb_history') 

if defined? Rails::Console
  if defined? Hirb
    Hirb.enable
  end
end
