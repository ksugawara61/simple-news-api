require './lib/news_tools'
require './lib/news_logger'

module NewsAdapter

  TAG = "NewsAdapter:"
  JSON_KEYS = ["title", "genreName", "link", "siteName", "thumbnail", "pubDate"]

  module_function

  # ニュースを生成
  # @param  [String] genre ニュースのジャンル
  # @return [Array]  指定したジャンルのニュース
  def make_news(genre)
    source = NEWS_SOURCE[genre]
    news = Array.new

    # カテゴリに誤りがある場合空の配列を返却
    if source.nil?
      NewsLogger.err_logging "#{TAG} invalid genre parameter"
      return news
    end

    # データからカテゴリのニュースを取得
    begin
      File.open(source[:FILE], 'r') do |file|
        file.each_line do |line|
          param = Hash.new
          line.split("\t").each_with_index do |item, i|
            param[JSON_KEYS[i]] = item.chomp
          end
          news.push(param)
        end
      end
    rescue SystemCallError => e
      NewsLogger.err_logging e
    rescue IOError => e
      NewsLogger.err_logging e
    end

    # news = [
    #         {
    #           "title" => "G 沢村追いつかれ延長で競り負け",
    #           "link"  => "http://news.goo.ne.jp/topstories/sports/190/3f882faf88f8d827747054999af32881.html?fr=RSS",
    #           "siteName" => "gooニュース",
    #           "thumbnail" => "http://news.goo.ne.jp/picture/sports/sanspo-gia1609140004.html",
    #           "pubDate" => "2016-09-14 22:38:43"
    #         },
    #         {
    #           "title" => "G 沢村追いつかれ延長で競り負け",
    #           "link"  => "http://news.goo.ne.jp/topstories/sports/190/3f882faf88f8d827747054999af32881.html?fr=RSS",
    #           "siteName" => "gooニュース",
    #           "thumbnail" => "http://news.goo.ne.jp/picture/sports/sanspo-gia1609140004.html",
    #           "pubDate" => "2016-09-14 22:38:43"
    #         }
    #        ]

    return news
  end

end
