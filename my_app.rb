require 'bundler'
require 'sinatra'
require 'json'
require './lib/news_adapter'
Bundler.require

class MyApp < Sinatra::Base
  get '/' do
    "Hello World!\n"
  end

  # ニュースAPI
  get '/news' do
    genre = params['genre'].to_s
    data = {
      "generated_at" => Time.now.strftime("%Y-%m-%d %H:%M:%S"),
      "item" => NewsAdapter.make_news(genre)
    }

    "#{data.to_json}"
  end

end
