class CommandParser

  def initialize
    @payback_service = PayBackService.new
  end

  def parse(buf)
    p "parsing command"
    if buf.start_with?('new')
      parse_new_command(buf)
    end
  end

  def parse_new_command(buf)
    cmd_array = buf.split(" ")
    p "parsed array"
    p cmd_array
    #We know the first element is already 'new'
    if cmd_array[1] == 'user'
      user = User.new(cmd_array[2], cmd_array[3], cmd_array[4].to_i)

      @payback_service.onboard_user(user)
      "#{user.name} (#{user.credit_limit})"
    end
  end
end