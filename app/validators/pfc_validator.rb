class PfcValidator < ActiveModel::Validator
  def validate(record)
    sum = record.percentage_protein +
          record.percentage_fat +
          record.percentage_carbohydrate

    unless sum == 1
      record.errors.add(
        :base,
        "PFCは合計で100%になるよう設定してください"
      )
    end
  end
end