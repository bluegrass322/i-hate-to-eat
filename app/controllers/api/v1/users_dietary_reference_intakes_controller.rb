# frozen_string_literal: true

module Api
  module V1
    class UsersDietaryReferenceIntakesController < Api::V1::BaseController
      include DriSetable

      def update
        dri = set_reference_intake(current_user)

        if current_user.update(dietary_reference_intake_id: dri.id)
          json_string = DietaryReferenceIntakeSerializer
                        .new(current_user.dietary_reference_intake)
                        .serialized_json
          binding.pry
          render json: json_string
        else
          render400(nil, current_user.errors.full_messages)
        end
      end
    end
  end
end
