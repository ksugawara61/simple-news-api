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
    category = params['category'].to_s
    data = {
      "updateAt" => Time.now.strftime("%Y-%m-%d %H:%M:%S"),
      "genre" => NewsAdapter.get_news_name(category),
      "element" => NewsAdapter.make_news(category)
    }

    "#{data.to_json}"
  end

end
