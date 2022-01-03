# frozen_string_literal: true

module Api
  module V1
    class BmrsController < Api::V1::BaseController
      include DriSetable

      def update
        return render400 if params[:user].value?(nil)

        assign_params(current_user)
        dri = dietary_reference_intake_for(current_user)
        current_user.dietary_reference_intake_id = dri.id

        if current_user.save
          serialized_dri = DietaryReferenceIntakeSerializer.new(dri).serialized_json

          render json: { bmr: current_user.bmr, pfc_params: current_user.attributes_pfc, dri: serialized_dri }
        else
          render400(nil, current_user.errors.full_messages)
        end
      end

      private

        def bmr_params
          params.require(:user).permit(:gender, :birth, :height, :weight)
        end

        def assign_params(user)
          user.assign_attributes(bmr_params)
          user.bmr = user.calc_bmr.floor
        end
    end
  end
end
