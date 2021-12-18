# frozen_string_literal: true

module TotalAndAchvGetable
  extend ActiveSupport::Concern

  def intake_achievement(user, total)
    pfc = user.attributes_pfc[:amt]

    achv = IntakeAchievement.call(total, user.bmr, pfc, user.dietary_reference_intake)
  end

  def intake_total(foods)
    IntakeTotal.call(foods)
  end
end
