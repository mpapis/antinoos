require 'cinch'
require 'open-uri'
require 'nokogiri'
require 'cgi'

class Debian
  include Cinch::Plugin
  plugin "debian"
  help "!debian|debs|deb <query> - search for debs @ http://packages.debian.org/"
  match /deb(?:s|ian)? (.+)/

  def execute(m, query)
    url = "http://packages.debian.org/search?suite=all&searchon=names&keywords=#{CGI.escape(query)}"

    doc = Nokogiri::HTML(open(url))

    if doc.css('p[id = "psearchnoresult"]').text == "Sorry, your search gave no results"
      m.reply "Sorry. No results for #{query}"
    elsif
      doc.css('a.resultlink')[0..4].each do |result|
        m.reply "http://packages.debian.org#{result['href']}"
      end
    end
  end
end


