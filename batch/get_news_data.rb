require 'rss'
require 'nokogiri'
require 'open-uri'
require 'rubygems'

# ニュースのデータを取得するバッチ
module GetNewsData

  module_function

  # 実行メソッド
  def execute
    target = ARGV.getopts('t:')["t"]

    case target
    when 'all'
      get_news_data('sports')
    else
      puts 'please check target'
    end
  end

  # ニュースのデータを取得
  # @param [String] genre ニュースのジャンル
  def get_news_data(genre)
    filename = "http://news.goo.ne.jp/rss/topstories/#{genre}/index.rdf"

    rss = RSS::Parser.parse(filename)
    rss.items.each{|item|
      # RSSのリンクのHTMLを取得
      charset = nil
      html = open(item.link) do |f|
        charset = f.charset
        f.read
      end
      
      # HTMLからニュースの各要素をスクレイピング
      doc = Nokogiri::HTML.parse(html, nil, charset)
      tmp = doc.xpath('//div[@class="gn-topics"]/h2/a')
      title = tmp.nil? ? "" : tmp.text
      tmp = doc.xpath('//p[@class="topics-news-source margin-bottom15"]/a')
      siteName = tmp.nil? ? "" : tmp.text
      tmp = doc.xpath('//div[@class="topics-thumbs"]/p/a/img')
      thumbnail = tmp.empty? ? "" : tmp.attribute("src").value

      p title
      p item.link
      p siteName
      p thumbnail
      p item.pubDate
      puts
    }

  end

end

GetNewsData.execute
