require 'rails_helper'

RSpec.describe "ideas_controller", type: :request do
  describe "GETリクエストのテスト" do
    
    it "category_nameが指定されている場合、該当するcategoryのideasの一覧を返却する" do
      create_list(:idea, 10)
      get api_v1_ideas_path
      expect(response).to have_http_status(200)
      expect(json['data'].length).to eq(10)
    end
  end
end




# アイデア登録API
  # category_nameが既存のものでなければcategoriesテーブルに新規追加される。
  # category_nameが既存のものであれば、既存のcategory_idを使用する。
  # 登録が成功したらステータスコード201が返る。
  # 登録が失敗したらステータスコード422が返る。
  
# アイデア取得API
  # アイデア一覧を返却する
  # category_nameが指定されている場合、該当するcategoryのideasの一覧を返却する。
  # category_nameが指定されていない場合はすべてのideasを返却する。
  # 登録されていないカテゴリーのリクエストの場合はステータスコード404を返す。
