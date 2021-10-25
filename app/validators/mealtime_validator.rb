# frozen_string_literal: true

class MealtimeValidator < ActiveModel::EachValidator
  def validate_each(record, _attribute, value)
    return unless value

    time = value.strftime('%R')

    record.errors.add(:mealtime_first, "通知の時間は7:00 - 23:00の間で設定してください") if time < "07:00" || time > "23:00"
  end
end
