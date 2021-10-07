# frozen_string_literal: true

module Admin
  class FoodCategoriesController < Admin::BaseController
    before_action :set_category, only: %i[edit update destroy]

    def index
      @categories = FoodCategory.all.order(id: "DESC")
    end

    def edit; end

    def update
      if @category.update(category_params)
        redirect_to admin_food_categories_path, notice: "食品カテゴリー情報の更新に成功"
      else
        flash.now[:danger] = "食品カテゴリーの更新に失敗"
        render :edit
      end
    end

    def destroy
      @category.destroy!
      redirect_to admin_food_categories_path, notice: "食品カテゴリーの削除に成功"
    end

    private

      def set_category
        @category = FoodCategory.find(params[:id])
      end

      def category_params
        params.require(:food_category).permit(:name)
      end
  end
end
