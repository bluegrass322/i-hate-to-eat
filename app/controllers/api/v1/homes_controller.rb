# frozen_string_literal: true

module Api
  module V1
    class HomesController < Api::V1::BaseController
      def show
        record = current_user.meal_records.for_today.take

        if record.present?
          savings = current_user.health_savings
          foods = record.recorded_foods.pluck(:id, :name, :subname, :reference_amount)
          response = { savings: savings, foods: foods }

          achv = get_achievement(record, current_user)
          chart_data = get_chart_data(achv)

          response.merge(chart_data)
          render json: response
        else
          render404(nil, "本日の食事メニューは存在しません")
        end
      end

      private

        def get_achievement(record, user)
          amt_pfc = user.set_attributes_for_pfc[:amt]

          achv = IntakeAchievement.new
          achv.calc_intake_achievement(record, user.bmr, amt_pfc,
                                       user.dietary_reference_intake)
        end

        def get_chart_data(achv)
          macro = get_radarchart_data(achv)
          vitamin = get_barchart_data(vitamins_label, achv)
          mineral = get_barchart_data(minerals_label, achv)

          { macros: macro, vitamins: vitamin, minerals: mineral }
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
