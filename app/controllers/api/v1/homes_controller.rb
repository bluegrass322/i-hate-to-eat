# frozen_string_literal: true

module Api
  module V1
    class HomesController < Api::V1::BaseController
      def show
        record = current_user.meal_records.for_today.take

        if record.present?
          savings = current_user.health_savings
          foods = record.recorded_foods.pluck(:name, :subname, :reference_amount)

          amt_pfc = current_user.set_attributes_for_pfc[:amt]
          achv = get_achievement(record, current_user.bmr, amt_pfc,
                                 current_user.dietary_reference_intake)

          macro = get_radarchart_data(achv)
          vitamin = get_barchart_data(vitamins_label, achv)
          mineral = get_barchart_data(minerals_label, achv)

          render json: { savings: savings,foods: foods, macros: macro, vitamins: vitamin, minerals: mineral }
        else
          render404(nil, "本日の食事メニューは存在しません")
        end
      end

      private

        def get_achievement(total, bmr, pfc, dri)
          achv = IntakeAchievement.new
          achv.calc_intake_achievement(total, bmr, pfc, dri)
        end

        def get_radarchart_data(achv)
          data = %w[calorie protein fat carbohydrate]
          data.map do |d|
            achv[d]
          end
        end

        # TODO: 要リファクタリング
        def get_barchart_data(labels, achv)
          achieve = labels.map { |l| achv[l] }
          unachieve = achieve.map do |a|
            result = 100 - a
            if result.negative?
              0
            else
              result
            end
          end

          { achv: achieve, unachv: unachieve }
        end

        def vitamins_label
          %w[vitamin_a vitamin_d vitamin_e vitamin_k
             vitamin_b1 vitamin_b2 niacin vitamin_b6
             vitamin_b12 folate pantothenic_acid
             biotin vitamin_c]
        end

        def minerals_label
          %w[potassium calcium magnesium phosphorus
             iron zinc copper manganese iodine
             selenium chromium molybdenum]
        end
    end
  end
end
