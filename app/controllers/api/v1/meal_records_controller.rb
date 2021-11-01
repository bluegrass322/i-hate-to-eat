# frozen_string_literal: true

module Api
  module V1
    class MealRecordsController < Api::V1::BaseController
      include MealRecordCreatable

      def index; end

      def show; end

      def create
        if make_record_from_suggestion(current_user)
          head :ok
        else
          render400(nil, "食事の記録に失敗しました")
        end
      end
    end
  end
end
