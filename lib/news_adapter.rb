require './lib/news_tools'

module NewsAdapter

  module_function

  # ニュースのカテゴリ名を取得
  # @param  [String] category ニュースのカテゴリ
  # @param  [String] カテゴリ名
  def get_news_name(category)
    source = NEWS_SOURCE[category]
    return source.nil? ? '' : source[:CATEGORY]
  end

  # ニュースを生成
  # @param  [String] category ニュースのカテゴリ
  # @return [Array]  指定したジャンルのニュース
  def make_news(category)
    news = [
            {
              "title" => "G 沢村追いつかれ延長で競り負け",
              "link"  => "http://news.goo.ne.jp/topstories/sports/190/3f882faf88f8d827747054999af32881.html?fr=RSS",
              "siteName" => "gooニュース",
              "thumbnail" => "http://news.goo.ne.jp/picture/sports/sanspo-gia1609140004.html",
              "pubDate" => "2016-09-14 22:38:43"
            },
            {
              "title" => "G 沢村追いつかれ延長で競り負け",
              "link"  => "http://news.goo.ne.jp/topstories/sports/190/3f882faf88f8d827747054999af32881.html?fr=RSS",
              "siteName" => "gooニュース",
              "thumbnail" => "http://news.goo.ne.jp/picture/sports/sanspo-gia1609140004.html",
              "pubDate" => "2016-09-14 22:38:43"
            }
           ]

    return news
  end

end
