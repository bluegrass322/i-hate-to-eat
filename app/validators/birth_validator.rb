# frozen_string_literal: true

class BirthValidator < ActiveModel::EachValidator
  def validate_each(record, _attribute, value)
    return unless value

    record.errors.add(:birth, "未来の日付は入力できません") if value.future?

    age = record.calc_age
    record.errors.add(:birth, "本サービスは18歳以上60歳未満の方が対象です") if age < 18 || age >= 60
  end
end
