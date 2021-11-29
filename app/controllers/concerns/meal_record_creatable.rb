# frozen_string_literal: true

module MealRecordCreatable
  extend ActiveSupport::Concern
  include SuggestionsDestroyable

  def make_record_from_suggestion(user)
    return false if user.meal_records.for_today.present?

    @today = Time.zone.today
    suggestions = user.suggestions.for_today
    foods = user.suggested_foods
    return false if suggestions.blank? || foods.blank?

    params = get_intake_total(foods)

    begin
      Suggestion.transaction do
        record = create_meal_record(user, params)
        create_eaten_foods(record, foods)
        adding_health_savings(user, record)
        destroy_suggestions_all(suggestions)
        true
      end
    rescue StandardError => e
      # TODO: 例外処理を修正
      Rails.logger.warn "User#{user.id}: Failed to create meal record. Cause...'#{e}'"
      false
    end
  end

  private

    def adding_health_savings(user, record)
      user.health_savings += record.calorie.to_i
      user.save!
    end

    def create_meal_record(user, params)
      rec = user.meal_records.build(ate_at: @today)
      rec.assign_attributes(params)
      rec.save!
      rec
    end

    def create_eaten_foods(record, foods)
      foods.each do |f|
        ef = record.eaten_foods.build(food_id: f.id, amount: f.reference_amount)
        ef.save!
      end
    end

    def destroy_suggestions_all(suggestions)
      suggestions.each(&:destroy!)
    end

    def get_intake_total(foods)
      total = NutritionTotal.new
      total.calc_intake_total(foods)
    end
end
