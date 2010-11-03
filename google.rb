require 'cinch'
require 'open-uri'
require 'nokogiri'
require 'cgi'

class Google
  include Cinch::Plugin
  plugin "google"
  help "!g(oogle) [number] <query> - search Google (5 default results; give number for less)"
  match /g(?:oogle)? (?:(\d+) )?(.+)/

  def execute(m, number, query)
    number ||= 5
    query = query.split(/\s+/).join(" ")

    url = "http://www.google.com/search?q=#{CGI.escape(query)}"

    doc = Nokogiri::HTML(open(url))
    results = doc.css('h3.r a.l')[0..(number.to_i - 1)]

    if results[0].nil?
      m.reply "No results found."
    else
      results.each do |result|
        if result.nil?
          m.reply "No more results."
          break
        else
          m.reply "#{result.text} (#{result['href']})"
        end
      end
    end
  end
end

