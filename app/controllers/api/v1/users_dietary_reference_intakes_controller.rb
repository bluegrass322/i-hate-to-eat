# frozen_string_literal: true

module Api
  module V1
    class UsersDietaryReferenceIntakesController < Api::V1::BaseController
      before_action :set_user

      def show
        dri = @user.dietary_reference_intake
        json_string = DietaryReferenceIntakeSerializer
                      .new(dri)
                      .serialized_json

        render json: json_string
      end

      def update
        dri = set_reference_intake(@user)

        if @user.update(dietary_reference_intake_id: dri.id)
          json_string = DietaryReferenceIntakeSerializer
                        .new(@user.dietary_reference_intake)
                        .serialized_json
          render json: json_string
        else
          render400(nil, @user.errors.full_messages)
        end
      end

      private

        def set_user
          @user = User.find(current_user.id)
        end

        def set_reference_intake(user)
          dri = witch_gender?(user)
          check_age_range(user, dri)
        end

        def witch_gender?(user)
          if user.gender == 'female'
            DietaryReferenceIntake.for_female
          else
            DietaryReferenceIntake.for_maele
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
  end
end
