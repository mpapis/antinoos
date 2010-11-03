class Identify
  include Cinch::Plugin

  listen_to :connect, method: :identify

  def identify(m)
    User("nickserv").send("identify SECRET")
  end
end
