module Api
  module V1
    class IdeasController < ApplicationController
      def index
        @category = Category.find_by(name: params[:category_name])

        if params[:category_name].present? && @category.present?
          ideas = Idea.where(category_id: @category.id)
        elsif params[:category_name].present? && @category.nil?
          render status: 404
          return
        else
          ideas = Idea.all
        end

        @idea_index = []
        ideas.each do |idea|
          idea = {
            "\"\"id\"\"": idea.id,
            "\"\"category\"\"": "\"#{idea.category.name}\"",
            "\"\"body\"\"": "\"#{idea.body}\""
          }
          @idea_index << idea
        end
        
        render json: { "\"\"data\"\"": @idea_index }
      end

      def create
        # リクエストのcategory_nameとbodyはnull:false
        # nullの場合、ステータスコード422を返す
        if params[:category_name].nil? || params[:body].nil?
          render status: 422
          return
        end

        idea = Idea.new

        if Category.find_by(name: params[:category_name]).present?
          category = Category.find_by(name: params[:category_name])
        else
          category = Category.new(name: params[:category_name])
          category.save
        end
        idea.category_id = category.id
        idea.body = params[:body]

        if idea.save
          render json: idea, status: 201 # 成功時、ステータスコード201を返す
        else
          render json: idea, status: 422 # 失敗時、ステータスコード422を返す
        end
      end

      private

      def idea_params
        params.require(:idea).permit(:category_name, :body)
      end
    end
  end
end
