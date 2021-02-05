require 'command_parser.rb'
describe CommandParser do
  before :each do
    @cmd_parser = CommandParser.new
  end
  context "parsing 'new' command'" do
    it "should be able to parse 'new user user1 u1@users.com 300'" do
      input = 'new user user1 u1@users.com 300'
      expect(@cmd_parser.parse_new_command(input)).to eql('user1 (300)')
    end
  end
end