# ニュースのデータを取得するバッチ
module GetNewsData

  module_function

  # 実行メソッド
  def execute
    target = ARGV.getopts('t:')["t"]

    case target
    when 'all'
      puts 'all'
    else
      puts 'please check target'
    end
  end

end

GetNewsData.execute
