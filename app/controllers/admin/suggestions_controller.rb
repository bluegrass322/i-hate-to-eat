# frozen_string_literal: true

module Admin
  class Admin::SuggestionsController < Admin::BaseController
    def index
      @q = Suggestion.ransack(params[:q])
      @suggestions = @q.result.page(params[:page])
    end
  end
end
