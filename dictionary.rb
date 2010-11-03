require 'wordnet'

class Dictionary
  include Cinch::Plugin
  plugin "dictionary"
  help "!dict(ionary) <query> - Look up a word via the WordNet database"
  match /dict(?:ionary)? (.+)/

  def execute(m, query)
    stop = 2

    lemmas = WordNet::WordNetDB.find(query)
    synsets = lemmas.map {|l| l.synsets}
    words = synsets.flatten
    words[0..stop].each do |word|
      m.reply "#{query}: (#{word.ss_type}) #{word.gloss.sub(/;.*/, '')}"
    end
  end
end

