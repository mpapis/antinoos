class Help
  include Cinch::Plugin

  plugin "help"
  help "!help [name] - Get information about a command (or all commands with no name)"

  match "help"

  def execute(m)
    @bot.plugins.each do |plugin|
      help_message = plugin.class.instance_variable_get(:@__cinch_help_message)
      if help_message
        name = plugin.class.instance_variable_get(:@__cinch_name)
        m.reply "#{name}: #{help_message}"
      end
    end
  end
end
