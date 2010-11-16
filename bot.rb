Encoding.default_external = "UTF-8"
Encoding.default_internal = "UTF-8"
$:.unshift(Dir.pwd)
require 'cinch'
require 'identify'
require 'help'
require 'commands'
require 'memo'
require 'google'
require 'debian'
require 'dictionary'
require 'updown'
require 'bash'
require 'translate'

bot = Cinch::Bot.new do
  configure do |c|
    c.server = "irc.oftc.net"
    c.channels = ["#debian-forums"]
    c.nick = "antinoos"
    c.realname = "antinoos"
    c.plugins.plugins =
      [Bash, Commands, Identify, Memo, Google, Help, Debian, Dictionary, UpDown, Translate]
  end
end

File.open('tmp/antinoos.pid', 'w') do |fh|
  fh.puts Process.pid
end

bot.start
