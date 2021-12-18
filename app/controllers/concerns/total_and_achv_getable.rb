# frozen_string_literal: true

module TotalAndAchvGetable
  extend ActiveSupport::Concern

  def intake_achievement(user, total)
    pfc = user.attributes_pfc[:amt]

    achv = IntakeAchievement.new
    achv.calc_intake_achievement(total, user.bmr, pfc, user.dietary_reference_intake)
  end

  def intake_total(foods)
    total = IntakeTotal.call(foods)
  end
end
