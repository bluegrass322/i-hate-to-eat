# frozen_string_literal: true

module Api
  module V1
    class HomesController < Api::V1::BaseController
      include TotalAndAchvGetable

      def show
        savings = current_user.health_savings
        response = { savings: savings }

        record = current_user.meal_records.for_today.take
        if record.present?
          foods = record.recorded_foods.pluck(:id, :name, :subname, :reference_amount)
          record_data = { foods: foods }

          achv = intake_achievement(current_user, record)
          chart_data = get_chart_data(achv)
          record_data = record_data.merge(chart_data)

          response["record"] = record_data
        end
        render json: response
      end

      private

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
