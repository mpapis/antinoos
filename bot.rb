$:.unshift(Dir.pwd)
require 'cinch'
require 'help'
require 'commands'
require 'memo'

bot = Cinch::Bot.new do
  configure do |c|
    c.server = "irc.oftc.net"
    c.channels = ["#debian-forums"]
    c.nick = "name_here"
    c.password = "secret_here"
    c.plugins.prefix = ""
    c.plugins.plugins = [Help, Commands, Memo]
  end
end

bot.start
