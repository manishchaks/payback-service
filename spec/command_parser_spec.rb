require 'command_parser.rb'
describe CommandParser do
  before :each do
    @cmd_parser = CommandParser.new
  end
  context "creating new users and merchants 'new' command" do
    it "should be able to onboard new user by parsing 'new user user1 u1@users.com 300'" do
      input = 'new user user1 u1@users.com 300'
      expect(@cmd_parser.parse_new_command(input)).to eql('user1 (300)')
    end
    it "should be able to onboard new merchant by parsing 'new merchant m1 m1@merchants.com 0.5%'" do
      input = 'new merchant m1 m1@merchants.com 0.5%'
      expect(@cmd_parser.parse_new_command(input)).to eql('m1 (0.5%)')
    end
  end
  context "parsing command line with state" do
    it "Parse and report transactions, users-at-credit-limit, discounts and payback with state management" do
      # The example pointed out in the PDF is used as the input here
      input = 'new user user1 u1@users.com 300'
      expect(@cmd_parser.parse(input)).to eql('user1 (300)')

      input = 'new user user2 u2@users.com 400'
      expect(@cmd_parser.parse(input)).to eql('user2 (400)')

      input = 'new user user3 u3@users.com 500'
      expect(@cmd_parser.parse(input)).to eql('user3 (500)')

      input = 'new merchant m1 m1@merchants.com 0.5%'
      expect(@cmd_parser.parse(input)).to eql('m1 (0.5%)')

      input = 'new merchant m2 m2@merchants.com 1.5%'
      expect(@cmd_parser.parse(input)).to eql('m2 (1.5%)')

      input = 'new merchant m3 m3@merchants.com 1.25%'
      expect(@cmd_parser.parse(input)).to eql('m3 (1.25%)')

      input = 'new txn user2 m1 500'
      expect(@cmd_parser.parse(input)).to eql('rejected! (reason: credit limit)')
    end
  end
end