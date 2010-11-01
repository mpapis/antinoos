require 'cinch'
require 'open-uri'
require 'nokogiri'
require 'cgi'

class Google
  include Cinch::Plugin
  plugin "google"
  help "!google <query> - run a search through Google"
  match /google (.+)/

  def search(query)
    url = "http://www.google.com/search?q=#{CGI.escape(query)}&safe=active"

    doc = Nokogiri::HTML(open(url))

    link = doc.css('h3.r a.l').first
    if !link.nil?
      link.content
    else
      "No results found"
    end
  end

  def execute(m, query)
    m.reply(search(query))
  end
end

