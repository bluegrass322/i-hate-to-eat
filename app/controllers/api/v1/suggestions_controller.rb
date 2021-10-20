module Api
  module V1
    class SuggestionsController < Api::V1::BaseController
      def show
        foods = current_user.suggested_foods
        amt_pfc = current_user.set_attributes_for_pfc[:amt]

        total = get_intake_total(foods)
        achv = get_achievement(total,
                               current_user.bmr,
                               current_user.dietary_reference_intake,
                               amt_pfc)

        render json: { meals: foods, total: total, achv: achv }
      end

      private

        def get_intake_total(foods)
          total = NutritionTotal.new
          total.calc_intake_total(foods)
        end

        def get_achievement(total, bmr, dri, pfc)
          achv = IntakeAchievement.new
          achv.calc_intake_achievement(total, bmr, dri, pfc)
        end
    end
  end
end
