class Commands
  include Cinch::Plugin

  plugin "commands"
  help "!commands - Get a list of defined commands to ask about"

  match "commands"

  def execute(m)
    @helpful = @bot.plugins.select do |plugin|
      plugin.class.instance_variable_get(:@__cinch_help_message)
    end

    @helpful.collect! do |plugin|
      plugin.class.instance_variable_get(:@__cinch_name)
    end

    m.reply "Commands: #{@helpful.join(', ')}"
  end
end

