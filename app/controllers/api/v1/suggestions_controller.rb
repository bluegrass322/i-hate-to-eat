# frozen_string_literal: true

module Api
  module V1
    class SuggestionsController < Api::V1::BaseController
      include SuggestionsCreatable
      include SuggestionsDestroyable

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
          render400(nil, '食事内容の削除に失敗しました')
        end
      end

      def update
        return render400(nil, '本日は既に食事をとっています') if current_user.meal_records.for_today.present?

        begin
          Suggestion.transaction do
            destroy_suggestions_all(current_user) if current_user.suggestions.present?
            meals = create_suggestions(current_user)
            response = set_suggestions_response(current_user, meals)

            render json: response and return
          end
        rescue StandardError
          render400(nil, '食事内容のリロードに失敗しました') and return
        end
      end

      private

        def get_intake_total(foods)
          total = NutritionTotal.new
          total.calc_intake_total(foods)
        end

        def get_achievement(total, bmr, pfc, dri)
          achv = IntakeAchievement.new
          achv.calc_intake_achievement(total, bmr, pfc, dri)
        end

        def set_suggestions_response(user, meals)
          amt_pfc = user.set_attributes_for_pfc[:amt]

          total = get_intake_total(meals)
          achv = get_achievement(total, user.bmr, amt_pfc, user.dietary_reference_intake)

          { meals: meals, total: total, achv: achv }
        end
    end
  end
end
