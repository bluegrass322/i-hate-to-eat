# frozen_string_literal: true

module Admin
  class FoodsController < Admin::BaseController
    before_action :set_food, only: %i[show edit update destroy]

    def index
      @foods = Food.all.includes(:food_category).order(id: "ASC").page(params[:page])
    end

    def show; end

    def edit; end

    def update
      if @food.update(food_params)
        redirect_to admin_food_path(@food), notice: "食品情報の更新に成功"
      else
        flash.now[:danger] = "食品情報の更新に失敗"
        render :edit
      end
    end

    def destroy
      @food.destroy!
      redirect_to admin_foods_path, notice: "食品の削除に成功"
    end

    private

      def set_food
        @food = Food.find(params[:id])
      end

      def foos_params
        params.require(:food).permit(:name, :subname, :priority, :reference_amount, :description,
                                     :biotin, :calcium, :calorie, :carbohydrate, :chromium,
                                     :copper, :fat, :folate, :iodine, :iron, :magnesium,
                                     :manganese, :molybdenum, :niacin, :pantothenic_acid,
                                     :phosphorus, :potassium, :protein, :selenium,
                                     :vitamin_a, :vitamin_b1, :vitamin_b12, :vitamin_b2,
                                     :vitamin_b6, :vitamin_c, :vitamin_d, :vitamin_e,
                                     :vitamin_k, :zinc)
      end
  end
end
