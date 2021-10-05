# frozen_string_literal: true

module Admin
  class DietaryReferenceIntakesController < Admin::BaseController
    before_action :set_dri, only: %i[show destroy]

    def index
      @dris = DietaryReferenceIntake.all.order(id: "DESC")
    end

    def show
      @columns = DietaryReferenceIntake.column_names.map(&:to_sym)
    end

    def destroy
      @dri.destroy!
      redirect_to admin_dietary_reference_intakes, notice: "DRIの削除に成功"
    end

    private

      def set_dri
        @dri = DietaryReferenceIntake.find(params[:id])
      end
  end
end
