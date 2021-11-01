# frozen_string_literal: true

module SuggestionsDestroyable
  extend ActiveSupport::Concern

  def destroy_suggestions_all(user)
    suggestions = user.suggestions.where(target_date: Time.zone.today)
    return render404(nil, "Suggestionが存在しません") if suggestions.blank?

    begin
      Suggestion.transaction do  
        suggestions.each do |s|
          s.destroy!
        end
      end
    rescue => e
      # TODO: 例外処理を修正
      Rails.logger.warn "User#{user.id}: Failed to create meal record. Cause...'#{e}'"
      false
    end
  end
end
