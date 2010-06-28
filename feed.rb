require 'rubygems'
require 'open-uri'
require 'feed-normalizer'
require 'erubis'
require 'mongrel'

class RSSHandler < Mongrel::HttpHandler
  def process(request, response)
    response.start(200) do |head,out|
      head["Content-Type"] = "text/html"
      
      stories = []
      File.open('feeds.txt', 'r').each_line { |f|
        feed = FeedNormalizer::FeedNormalizer.parse open(f.strip)
        stories.push(*feed.entries)
      }     
      
      eruby = Erubis::Eruby.new(File.read('news.eruby'))
      out.write(eruby.result(binding()))
    end
  end
end

h = Mongrel::HttpServer.new("0.0.0.0", "3002")
h.register("/", RSSHandler.new)
h.register("/files", Mongrel::DirHandler.new("files/"))
h.run.join
