require 'cinch'
require 'open-uri'
require 'nokogiri'
require 'cgi'

class UpDown
  include Cinch::Plugin
  plugin "updown"
  help "!(up|down) <site> - check if a site is up or down for everyone"
  match /(?:up|down) (.+)/

  def execute(m, query)
    url = "http://downforeveryoneorjustme.com/#{CGI.escape(query)}"

    doc = Nokogiri::HTML(open(url))
    result = doc.at('div#container').text.strip.split(/\n/).first

    m.reply result
  end
end


