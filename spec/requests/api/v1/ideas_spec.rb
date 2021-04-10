require 'rails_helper'

RSpec.describe "ideas_controller", type: :request do
  # アイデア取得API
  describe "GETリクエストのテスト" do

    context "category_nameが指定されている" do
      before do 
        create_list(:idea, 10)
        category = create(:category, id: 100, name: "category_name_hoge")
        create(:idea, category_id: category.id, body: "new_idea_body")
        @valid_params = { category_name: category.name }
        @invalid_params =  { category_name: "not_exist_vategory_name" }
      end 
      context "& 登録されているcategoryの場合" do
        it "該当するcategoryのideasの一覧を返却する" do
          get api_v1_ideas_path, params: @valid_params 
          json = JSON.parse(response.body)
          expect(json['data'][0]["category"]).to eq "category_name_hoge"
        end
      end

      context "& 登録されていないcategoryの場合" do
        it "ステータスコード404を返す" do
          get api_v1_ideas_path, params: @invalid_params 
          expect(response.status).to eq(404)
        end
      end
    end

    context "category_nameが指定されていない場合" do
      it "すべてのideasを返却する" do
        create_list(:idea, 10)
        get api_v1_ideas_path
        json = JSON.parse(response.body)

        expect(response.status).to eq(200)
        expect(json['data'].length).to eq(10)
      end
    end
  end


  # アイデア登録API
  describe "POSTリクエストのテスト" do

    context "category_nameが既存のものでない場合" do
      it "categoriesテーブルに新規追加される" do
        valid_params = { category_name: "new_category_name", body: "body" }
        expect { post api_v1_ideas_path, params: valid_params }.to change(Category, :count).by(+1)
        .and change(Idea, :count).by(+1)
      end
    end

    context "category_nameが既存のものである場合" do
      it "既存のcategory_idを使用する" do
        category = create(:category, id: 200, name: "name")
        valid_params = { category_name: category.name, body: "body" }
        expect { post api_v1_ideas_path, params: valid_params }.to change(Category, :count).by(0)
        .and change(Idea, :count).by(+1)
      end
    end

    context "登録に成功した場合" do 
      it "ステータスコード201が返る" do
        valid_params = { category_name: "name", body: "body" }
        expect { post api_v1_ideas_path, params: valid_params }.to change(Idea, :count).by(+1)
        expect(response.status).to eq(201)
      end
    end

    context "登録に失敗した場合" do
      it "ステータスコード422が返る" do
        valid_params = { category_name: "name" }
        expect { post api_v1_ideas_path, params: valid_params }.to change(Idea, :count).by(0)
        expect(response.status).to eq(422)
      end
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
