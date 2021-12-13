# frozen_string_literal: true

module MealRecordCreatable
  extend ActiveSupport::Concern

  include Common::NotificatableToAdmin
  include SuggestionsDestroyable
  include TotalAndAchvGetable

  def make_record_from_suggestion(user)
    return false if user.meal_records.for_today.present?

    foods = user.suggested_foods
    return false if foods.blank?

    # if文の条件式に使いたいので戻り値は真偽値
    begin
      Suggestion.transaction do
        record = create_meal_record(user, foods)
        create_eaten_foods(record, foods)

        adding_health_savings(user, record)
        destroy_suggestions_all(user)

        true
      end
    rescue StandardError => e
      Rails.logger.warn "User#{user.id}: Failed to create meal record. Cause...'#{e}'"
      notice_to_admin("MealRecordの作成に失敗")

      false
    end
  end

  private

    def adding_health_savings(user, record)
      user.health_savings += record.calorie.to_i
      user.save!
    end

    def create_meal_record(user, foods)
      params = intake_total(foods)

      rec = user.meal_records.build(ate_at: Time.current)
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
end
