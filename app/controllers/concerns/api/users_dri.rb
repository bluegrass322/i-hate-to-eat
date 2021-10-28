module Api::UsersDri
  extend ActiveSupport::Concern

  def set_reference_intake(user)
    by_gender = witch_gender?(user)
    check_age_range(user, by_gender)
  end

  private

    def witch_gender?(user)
      case user.gender
      when 'female'
        DietaryReferenceIntake.for_female
      when 'male'
        DietaryReferenceIntake.for_male
      end
    end

    def check_age_range(user, dri)
      age = user.calc_age

      case age
      when 18..29
        dri.for_eighteen_to_twentynine
      when 30..49
        dri.for_thirty_to_fortynine
      when 50..64
        dri.for_fifty_to_sixtyfour
      end
    end
end