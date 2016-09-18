# Simple News API

## How to Install

```
bundle install --path vendor/bundle
```

## How to create DB

```
$ cp config/database.yml.sample config/database.yml
// DBのUSER,PASSWORDを確認。また、開発テスト環境のDB名を他開発者とわけておく
$ bundle exec rake db:drop    // dbの削除
$ bundle exec rake db:create  // dbの作成
$ bundle exec rake db:migrate
```

## How to create Data

```
$ bundle exec ruby batch/get_news_data.rb
```

## How to Test

```
$ bundle exec rspec spec 
```

## How to Run

```
$ bundle exec rackup -o 0.0.0.0 -p 8080
```

## References
1. Sinatra, http://www.sinatrarb.com/, Online; accessed 19-July-2016. 
2. rbenvを用いたruby環境構築手順（CentOS7.1） - Qiita, http://qiita.com/ksugawara61/items/e3bb87d5e0dd49d20c8f, Online; accessed 14-September-2016.
3. ruby+rbenv+sinatraの環境構築 - Qiita, http://qiita.com/ksugawara61/items/c1a0572353668c58e87a, Online; accessed 14-September-2016.

