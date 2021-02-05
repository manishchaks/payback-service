require 'readline'
require_relative 'lib/command_parser'
command_parser = CommandParser.new
while buf = Readline.readline("> ", true)
  if (buf == 'exit')
    p "Exiting..."
    exit
  else
    puts command_parser.parse(buf)
  end
end



