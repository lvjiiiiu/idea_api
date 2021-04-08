module Api
  module V1
    class CategoriesController < ApplicationController
      def index
      end
      
      def create
        category = Category.new(category_params)
        if category.save
          render json: { status: 201 } 
        else
          render json: { status: 422 }
        end
      end
      
      private
        def category_params
          params.require(:category).permit(:name)
        end
    end 
  end 
end
