# frozen_string_literal: true

module Api
  module V1
    class TrialsController < Api::V1::BaseController
      skip_before_action :require_login

      include DriSetable

      def create
        age = params[:age].to_i
        gender = params[:gender]

        # BMR算出
        bmr = calc_bmr(age, gender)
        pfc = calc_amount_pfc(bmr)

        # DRI選出
        dri = set_dri(age, gender)

        # 提案作成
        meals = create_trial_suggstions
        # 達成度算出
        total = get_intake_total(meals)
        achv = get_achievement(total, bmr, pfc, dri)

        # 返り値
        render json: { bmr: bmr, dri: dri, meals: meals, total: total, achv: achv }
      end

      private

        def trial_params
          params.permit(:age, :gender)
        end

        def calc_age(birth)
          (Time.zone.today.strftime("%Y%m%d").to_i - birth.to_date.strftime("%Y%m%d").to_i) / 10_000
        end

        def calc_bmr(age, gender)
          # 計算式を用いず、日本人の食事摂取基準（2020年版）を参照したおおよその値
          if gender == 'female'
            calc_female_bmr(age)
          else
            calc_male_bmr(age)
          end
        end

        def calc_female_bmr(age)
          case age
          when 18..29
            1700
          when 30..49
            1750
          when 50..64
            1650
          end
        end

        def calc_male_bmr(age)
          case age
          when 18..29
            2300
          when 30..49
            2300
          when 50..64
            2200
          end
        end

        def calc_amount_pfc(bmr)
          { protein: calc_amount_protein(bmr).floor,
            fat: calc_amount_fat(bmr).floor,
            carbohydrate: calc_amount_carbo(bmr).floor }
        end

        def calc_amount_protein(bmr)
          bmr * 0.2 / 4
        end

        def calc_amount_fat(bmr)
          bmr * 0.2 / 9
        end

        def calc_amount_carbo(bmr)
          bmr * 0.6 / 4
        end

        def check_age_range(age, dri)
          case age
          when 18..29
            dri.for_eighteen_to_twentynine
          when 30..49
            dri.for_thirty_to_fortynine
          when 50..64
            dri.for_fifty_to_sixtyfour
          end
        end

        def get_intake_total(foods)
          total = NutritionTotal.new
          total.calc_intake_total(foods)
        end

        def get_achievement(total, bmr, pfc, dri)
          achv = IntakeAchievement.new
          achv.calc_intake_achievement(total, bmr, pfc, dri)
        end

        def set_dri(age, gender)
          by_gender = witch_gender?(gender)
          check_age_range(age, by_gender)
        end

        def witch_gender?(gender)
          if gender == 'female'
            DietaryReferenceIntake.for_female
          else
            DietaryReferenceIntake.for_male
          end
        end

        def create_trial_suggstions
          meal_menus = []

          # 食材を上限4種類にしぼり提案を作成する場合
          regular = Food.prio_h.order("RANDOM()").limit(1)
          main = Food.prio_m.maindish.order("RANDOM()").limit(1)
          side = Food.prio_rm.sidedish.order("RANDOM()").limit(2)

          meal_menus.concat(regular, main, side)
        end
    end
  end
end
