# frozen_string_literal: true

module Api
  module V1
    class FoodsController < Api::V1::BaseController
      def show
        food = Food.find_by(id: params[:id])
        json_string = FoodSerializer.new(food).serialized_json

        render json: json_string
      end
    end
  end
end
