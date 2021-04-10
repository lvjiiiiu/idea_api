require 'rails_helper'

RSpec.describe "Categoryモデルテスト", type: :model do
  describe "validationのテスト" do
    let(:category) { create(:category) }
    context "nameカラム" do
      it "空欄でないこと" do
        category.name = " "
        expect(category.valid?).to eq false;
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Ideaモデルとの関係' do
      it '1:Nとなっている' do
        expect(Category.reflect_on_association(:ideas).macro).to eq :has_many
      end
    end
  end
end
