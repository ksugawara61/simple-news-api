require 'bundler'
require 'sinatra'
require 'json'
Bundler.require

class MyApp < Sinatra::Base
  get '/' do
    "Hello World!\n"
  end

  # ニュースAPI
  get '/news' do
    genre = params['genre'].to_s
    data = {
      "updatedAt" => Time.now.strftime("%Y-%m-%d %H:%M:%S"),
      "genre" => genre,
      "element" => [
                    "title" => "G 沢村追いつかれ延長で競り負け",
                    "link"  => "http://news.goo.ne.jp/topstories/sports/190/3f882faf88f8d827747054999af32881.html?fr=RSS",
                    "siteName" => "gooニュース"
                    "thumbnail" => "http://news.goo.ne.jp/picture/sports/sanspo-gia1609140004.html"
                    "pubDate" => "2016-09-14 22:38:43"
                   ]
    }

    "#{data.to_json}"
  end

end
