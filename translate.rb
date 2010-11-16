# encoding: UTF-8
require 'cinch'
require 'open-uri'
require 'cgi'
require 'yajl'

# Use this:
# http://code.google.com/apis/language/translate/v1/using_rest_translate.html
class Translate
  include Cinch::Plugin
  plugin "translate"
  help "!t|tr|translate <from> <to> <msg> - translate <msg> from x to y via Google"
  match /t(?:r(?:anslate)?)? ([a-zA-Z-]{2,5}) ([a-zA-Z-]{2,5}) (.*)/u

  def execute(m, from, to, message)
    url = "https://ajax.googleapis.com/ajax/services/language/translate?v=1.0&q="
    url += "#{CGI.escape(message)}&langpair=#{CGI.escape(from)}%7c#{CGI.escape(to)}"

    begin
      json = open(url)
      response = Yajl::Parser.new.parse(json)

      if response["responseStatus"] != 200
        m.reply "Problem connecting or no results found."
      elsif response["responseData"]["translatedText"]
        m.reply response["responseData"]["translatedText"]
      else
        m.reply "Not sure what happened, but that didn't work."
      end
    rescue
      m.reply "Problem connecting: bailing out..."
    end
  end
end
