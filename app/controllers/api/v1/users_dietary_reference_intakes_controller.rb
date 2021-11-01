# frozen_string_literal: true

module Api
  module V1
    class UsersDietaryReferenceIntakesController < Api::V1::BaseController
      include DriSetable
      before_action :set_user

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
    end
  end
end
