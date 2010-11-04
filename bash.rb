require 'cinch'
require 'open-uri'
require 'nokogiri'
require 'cgi'

class Bash
  include Cinch::Plugin
  plugin "bash"
  help "!b(ash) [number] <query> - search Bash Hackers Wiki\n  (max of 5 results by default; give a number for fewer results)"
  match /b(?:ash)? (?:(\d+) )?(.+)/

  def execute(m, number, query)
    number ||= 5
    query = query.split(/\s+/).join(" ")

    url = "http://wiki.bash-hackers.org/doku.php?do=search&id=#{CGI.escape(query)}"

    doc = Nokogiri::HTML(open(url))

    nothing = doc.at_css('div.nothing')

    if (! nothing.nil?)
      m.reply "Nothing found @ the Bash-Hackers Wiki for [#{query}]"
    else
      matches = doc.css('a.wikilink1')[0..(number.to_i - 1)]

      clean = []
      matches.each do |res|
        clean << res["href"].sub(/\?.*$/, "")
      end
      base = "http://wiki.bash-hackers.org"

      clean.uniq.each do |url|
        m.reply base + url
      end
    end
  end
end


