module NewsAdapter

  API_NEWS_GENRE = {
    "bizskills" => "仕事術",
    "business"  => "経済",
    "entame"    => "エンタメ",
    "life"      => "生活術",
    "nation"    => "社会",
    "politics"  => "政治",
    "sports"    => "スポーツ",
    "world"     => "国際・科学"
  }

  module_function

  # ニュースのジャンル名を取得
  # @param  [String] genre ニュースのジャンル
  # @param  [String] ジャンル名
  def get_news_name(genre)
    return API_NEWS_GENRE[genre]
  end

  # ニュースを生成
  # @param  [String] genre ニュースのジャンル
  # @return [Array]  指定したジャンルのニュース
  def make_news(genre)
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
