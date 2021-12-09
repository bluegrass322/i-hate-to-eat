# frozen_string_literal: true

module Api
  module V1
    class SuggestionsController < Api::V1::BaseController
      include TotalAndAchvGetable
      include SuggestionsCreatable
      include SuggestionsDestroyable

      before_action :check_meal_record_exists?, only: :update

      def show
        meals = current_user.suggested_foods

        if meals.present?
          response = set_suggestions_response(current_user, meals)
          render json: response
        else
          head :not_found
        end
      end

      def destroy
        if destroy_suggestions_all(current_user)
          head :ok
        else
          render500(nil, "食事内容の削除に失敗しました")
        end
      end

      def update
        destroy_suggestions_all(current_user) if current_user.suggestions.present?
        meals = create_suggestions(current_user)
        response = set_suggestions_response(current_user, meals)

        if response.present?
          render json: response
        else
          render500(nil, "食事内容のリロードに失敗しました")
        end
      end

      private

        def check_meal_record_exists?
          render500(nil, "本日は既に食事をとっています") if current_user.meal_records.for_today.present?
        end

        def set_suggestions_response(user, meals)
          total = intake_total(meals)
          achv = intake_achievement(user, total)

          { meals: meals, total: total, achv: achv }
        end
    end
  end
end
