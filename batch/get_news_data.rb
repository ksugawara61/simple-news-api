require 'rss'
require 'nokogiri'
require 'open-uri'
require 'rubygems'

# ニュースのデータを取得するバッチ
module GetNewsData

  NEWS_SOURCE = {
    "nation" => {
      :URL  => "http://news.goo.ne.jp/rss/topstories/nation/index.rdf",
      :FILE => "data/nation.tsv",
      :CATEGORY => "社会"
    },
    "world" => {
      :URL  => "http://news.goo.ne.jp/rss/topstories/world/index.rdf",
      :FILE => "data/world.tsv",
      :CATEGORY => "国際・科学"
    },
    "politics" => {
      :URL  => "http://news.goo.ne.jp/rss/topstories/politics/index.rdf",
      :FILE => "data/politics.tsv",
      :CATEGORY => "政治"
    },
    "business" => {
      :URL  => "http://news.goo.ne.jp/rss/topstories/business/index.rdf",
      :FILE => "data/business.tsv",
      :CATEGORY => "経済"
    },
    "bizskills" => {
      :URL  => "http://news.goo.ne.jp/rss/topstories/bizskills/index.rdf",
      :FILE => "data/bizskills.tsv",
      :CATEGORY => "仕事術"
    },
    "life" => {
      :URL  => "http://news.goo.ne.jp/rss/topstories/life/index.rdf",
      :FILE => "data/life.tsv",
      :CATEGORY => "生活術"
    },
    "entertainment" => {
      :URL  => "http://news.goo.ne.jp/rss/topstories/entertainment/index.rdf",
      :FILE => "data/entertainment.tsv",
      :CATEGORY => "エンタメ"
    },
    "sports" => {
      :URL  => "http://news.goo.ne.jp/rss/topstories/sports/index.rdf",
      :FILE => "data/sports.tsv",
      :CATEGORY => "スポーツ"
    }
  }

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
      puts 'please check target'
    end
  end

  # ニュースのデータを取得
  # @param [String] category ニュースのカテゴリ
  def get_news_data(category)
    source = NEWS_SOURCE[category]

    if source.nil?
      puts "get_news_data : invalid input parameter"
      return
    end

    file = File.open(source[:FILE], 'w')

    rss = RSS::Parser.parse(source[:URL])
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

      file.puts "#{title}\t#{item.link}\t#{siteName}\t#{thumbnail}\t#{item.pubDate}"
      puts "#{title} #{item.link} #{siteName} #{thumbnail} #{item.pubDate}"
    }

    file.close

  end

end

GetNewsData.execute
