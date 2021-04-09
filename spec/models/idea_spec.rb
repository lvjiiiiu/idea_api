require 'rails_helper'

RSpec.describe "Ideaモデルテスト", type: :model do
  describe "validationのテスト" do
    let(:idea) { create(:idea) }
    context "bodyカラム" do
      it "空欄でないこと" do
        idea.body = " "
        expect(idea.valid?).to eq false;
      end 
    end 
  end 
  
  
  describe 'アソシエーションのテスト' do
    context 'Categoryモデルとの関係' do
      it 'N:1となっている' do
        expect(Idea.reflect_on_association(:category).macro).to eq :belongs_to
      end
    end
  end 
end
