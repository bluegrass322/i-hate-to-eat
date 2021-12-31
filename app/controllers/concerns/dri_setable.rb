# frozen_string_literal: true

module DriSetable
  extend ActiveSupport::Concern

  def dietary_reference_intake_for(user)
    by_gender = witch_gender(user)
    which_age_group(user, by_gender)
  end

  private

    def witch_gender(user)
      case user.gender
      when 'female'
        DietaryReferenceIntake.for_female
      when 'male'
        DietaryReferenceIntake.for_male
      end
    end

    def which_age_group(user, dri)
      age = user.calc_age

      case age
      when 18..29
        dri.for_eighteen_to_twentynine
      when 30..49
        dri.for_thirty_to_fortynine
      when 50..64
        dri.for_fifty_to_sixtyfour
      else
        dri.first
      end
    end
end
