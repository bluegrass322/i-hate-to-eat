# frozen_string_literal: true

module SuggestionsDestroyable
  extend ActiveSupport::Concern

  def destroy_suggestions_all(user)
    # 要削除
    Rails.logger.debug "destroy_suggestions_allメソッドに突入"

    suggestions = user.suggestions.where(target_date: Time.zone.today)

    # 要削除
    Rails.logger.debug "suggestions.blank?: #{suggestions.blank?}"
    Rails.logger.debug "suggestions: #{suggestions}"

    return render404(nil, "Suggestionが存在しません") if suggestions.blank?

    begin
      # 要削除
      Rails.logger.debug "トランザクションに突入"

      Suggestion.transaction do
        suggestions.each(&:destroy!)
      end
      Rails.logger.debug "トランザクションが終了"
    rescue StandardError => e
      # TODO: 例外処理を修正
      Rails.logger.warn "User#{user.id}: Failed to create meal record. Cause...'#{e}'"
      false
    end
  end
end
