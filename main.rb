require 'readline'
require './lib/command_parser'

command_parser = CommandParser.new
while buf = Readline.readline("> ", true)
  if (buf == 'exit')
    p "Exiting..."
    exit
  else
    command_parser.parse(buf)
  end
end



