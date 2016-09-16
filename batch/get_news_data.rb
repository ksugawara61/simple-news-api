require 'time'
require 'rss'
require 'nokogiri'
require 'open-uri'
require 'rubygems'
require './lib/news_tools'
require './lib/news_logger'

# ニュースのデータを取得するバッチ
module GetNewsData

  TAG = "GetNewsData:"

  module_function

  # 実行メソッド
  def execute
    target = ARGV.getopts('t:')["t"]

    case target
    when 'all'
      get_news_data('nation')
      get_news_data('world')
      get_news_data('politics')
      get_news_data('business')
      get_news_data('bizskills')
      get_news_data('life')
      get_news_data('entertainment')
      get_news_data('sports')
    when 'nation'
      get_news_data('nation')
    when 'world'
      get_news_data('world')
    when 'politics'
      get_news_data('politics')
    when 'business'
      get_news_data('business')
    when 'bizskills'
      get_news_data('bizskills')
    when 'life'
      get_news_data('life')
    when 'entertainment'
      get_news_data('entertainment')
    when 'sports'
      get_news_data('sports')
    else
      NewsLogger.err_logging "#{TAG} invalid input parameter"
    end
  end

  # ニュースのデータを取得
  # @param [String] genre ニュースのジャンル
  def get_news_data(genre)
    source = NEWS_SOURCE[genre]

    if source.nil?
      NewsLogger.err_logging "#{TAG} invalid genre parameter"
      return
    end

    NewsLogger.app_logging "#{TAG} ##### Start Read #{genre}"

    file = File.open(source[:FILE], 'w')

    rss = RSS::Parser.parse(source[:URL])
    rss.items.each{|item|
      # RSSのリンクのHTMLを取得
      charset = nil
      html = open(item.link) do |f|
        charset = f.charset
        f.read
      end

      # データとして保存する各要素を変数に格納
      # HTMLからニュースの要素をスクレイピング
      doc = Nokogiri::HTML.parse(html, nil, charset)
      tmp = doc.xpath('//div[@class="gn-topics"]/h2/a')
      title = tmp.nil? ? "" : tmp.text
      tmp = doc.xpath('//p[@class="topics-news-source margin-bottom15"]/a')
      site_name = tmp.nil? ? "" : tmp.text
      tmp = doc.xpath('//div[@class="topics-thumbs"]/p/a/img')
      thumbnail = tmp.empty? ? "" : tmp.attribute("src").value

      genre_name = source[:GENRE]
      link = item.link
      pubDate = item.pubDate.strftime("%Y-%m-%d %H:%M:%S")

      file.puts "#{title}\t#{genre_name}\t#{link}\t#{site_name}\t#{thumbnail}\t#{pubDate}"
      NewsLogger.app_logging "#{TAG} title => #{title}"
      NewsLogger.app_logging "#{TAG} genreName => #{genre_name}"
      NewsLogger.app_logging "#{TAG} link => #{link}"
      NewsLogger.app_logging "#{TAG} siteName => #{site_name}"
      NewsLogger.app_logging "#{TAG} thumbnail => #{thumbnail}"
      NewsLogger.app_logging "#{TAG} pubDate => #{pubDate}"
    }
    file.close

    NewsLogger.app_logging "#{TAG} Finish Read #{genre} ---------->>>>>>>>>>"

  end

end

GetNewsData.execute
