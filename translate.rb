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
  help "!t|tr|translate <from> <to> <msg> - translate <msg> from x to y via Google\n<from> and <to> should be language codes like en, fr, de or es\nSee here for Google's list: http://xrl.us/bh729q"

  match /t(?:r(?:anslate)?)? ([a-zA-Z-]{2,5}) ([a-zA-Z-]{2,5}) (.*)/u

  def execute(m, from, to, message)
    url = "http://ajax.googleapis.com/ajax/services/language/translate?v=1.0&q="
    url += "#{CGI.escape(message)}&langpair=#{CGI.escape(from)}%7c#{CGI.escape(to)}"

    begin
      json = open(url)
    rescue
      m.reply "Problem connecting: bailing out..."
    end
    response = Yajl::Parser.new.parse(json)

    if response["responseStatus"] != 200
      m.reply "Problem connecting or no results found."
    elsif response["responseData"]["translatedText"]
      m.reply response["responseData"]["translatedText"]
    else
      m.reply "Not sure what happened, but that didn't work."
    end
  end
end
