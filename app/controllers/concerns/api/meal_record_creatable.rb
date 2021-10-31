# frozen_string_literal: true

module Api
  module MealRecordCreatable
    extend ActiveSupport::Concern

    def make_record_from_suggestion(user)
      @today = Time.zone.today
      
      suggestions = user.suggestions.where(target_date: @today)
      foods = user.suggested_foods
      return false if suggestions.blank? || foods.blank?

      params = get_intake_total(foods)

      begin
        Suggestion.transaction do
          record = create_meal_record(user, params)
          create_eaten_foods(record, foods)
          destroy_suggestions_all(suggestions)
        end
      rescue => e
        # TODO: 例外処理を修正
        Rails.logger.warn "User#{user.id}: Failed to create meal record. Cause...'#{e}'"
        false
      end
    end

    private

      def create_meal_record(user, params)
        rec = user.meal_records.new(ate_at: @today)
        rec.assign_attributes(params)
        rec.save!
        rec
      end

      def create_eaten_foods(record, foods)
        foods.each do |f|
          ef = record.eaten_foods.new(food_id: f.id, amount: f.reference_amount)
          ef.save!
        end
      end

      def destroy_suggestions_all(suggestions)
        suggestions.each do |s|
          s.destroy!
        end
      end

      def get_intake_total(foods)
        total = NutritionTotal.new
        total.calc_intake_total(foods)
      end
  end
end