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
      # サムネイル画像のパスを取得するためHTMLを取得
      charset = nil
      html = open(item.link) do |f|
        charset = f.charset
        f.read
      end
      
      doc = Nokogiri::HTML.parse(html, nil, charset)
      title = doc.xpath('//div[@class="gn-topics"]/h2/a').text
      siteName = doc.xpath('//p[@class="topics-news-source margin-bottom15"]/a').text
      thumbnail = doc.xpath('//div[@class="topics-thumbs"]/p/a/img').attribute("src")

      puts title
      puts item.link
      puts siteName
      puts thumbnail
      puts item.pubDate
      puts
    }

  end

end

GetNewsData.execute
