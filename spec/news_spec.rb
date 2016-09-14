# encoding: utf-8

require File.dirname(__FILE__) + '/spec_helper'

describe "NewsAPI" do
  def app
    APPS.first
  end

  before do
    get '/news', {'genre' => 'sports'}
  end

  it "正常なレスポンスが返ること" do
    expect(last_response).to be_ok
  end

  it "JSONの情報が取得できること" do
    result = JSON.parse(last_response.body)
    expect(result.has_key?("updateAt")).to eq(true)
    expect(result.has_key?("genre")).to eq(true)

    value = result["element"].first
    expect(value.has_key?("title")).to eq(true)
    expect(value.has_key?("link")).to eq(true)
    expect(value.has_key?("siteName")).to eq(true)
    expect(value.has_key?("thumbnail")).to eq(true)
    expect(value.has_key?("pubDate")).to eq(true)
  end

end
