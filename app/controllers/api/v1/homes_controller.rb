module Api
  module V1
    class HomesController < Api::V1::BaseController
      def show
        records = current_user.meal_records
        render json: { records: records }
      end
    end
  end
end
