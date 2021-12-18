# frozen_string_literal: true

class IntakeTotal
  include ActiveModel::Model
  include ActiveModel::Attributes

  # Attributes
  attribute :calorie, :float, default: 0.0
  attribute :protein, :float, default: 0.0
  attribute :fat, :float, default: 0.0
  attribute :carbohydrate, :float, default: 0.0
  attribute :biotin, :float, default: 0.0
  attribute :calcium, :float, default: 0.0
  attribute :chromium, :float, default: 0.0
  attribute :copper, :float, default: 0.0
  attribute :folate, :float, default: 0.0
  attribute :iodine, :float, default: 0.0
  attribute :iron, :float, default: 0.0
  attribute :magnesium, :float, default: 0.0
  attribute :manganese, :float, default: 0.0
  attribute :molybdenum, :float, default: 0.0
  attribute :niacin, :float, default: 0.0
  attribute :pantothenic_acid, :float, default: 0.0
  attribute :phosphorus, :float, default: 0.0
  attribute :potassium, :float, default: 0.0
  attribute :selenium, :float, default: 0.0
  attribute :vitamin_a, :float, default: 0.0
  attribute :vitamin_b1, :float, default: 0.0
  attribute :vitamin_b12, :float, default: 0.0
  attribute :vitamin_b2, :float, default: 0.0
  attribute :vitamin_b6, :float, default: 0.0
  attribute :vitamin_c, :float, default: 0.0
  attribute :vitamin_d, :float, default: 0.0
  attribute :vitamin_e, :float, default: 0.0
  attribute :vitamin_k, :float, default: 0.0
  attribute :zinc, :float, default: 0.0

  # Callback
  define_model_callbacks :save
  before_save :attr_validation

  # Validation
  with_options presence: true, numericality: true do
    validates :biotin
    validates :calcium
    validates :calorie
    validates :carbohydrate
    validates :chromium
    validates :copper
    validates :fat
    validates :folate
    validates :iodine
    validates :iron
    validates :magnesium
    validates :manganese
    validates :molybdenum
    validates :niacin
    validates :pantothenic_acid
    validates :phosphorus
    validates :potassium
    validates :protein
    validates :selenium
    validates :vitamin_a
    validates :vitamin_b1
    validates :vitamin_b12
    validates :vitamin_b2
    validates :vitamin_b6
    validates :vitamin_c
    validates :vitamin_d
    validates :vitamin_e
    validates :vitamin_k
    validates :zinc
  end


  # Class method
  def self.call(foods)
    new.calc_intake_total(foods)
  end

  # Instance method
  def calc_intake_total(foods)
    params = attributes

    params.each_key do |k|
      sum = 0
      foods.each do |f|
        sum += f[k] * f.reference_amount
      end
      params[k] = sum.floor(4)
    end

    self.attributes = params
    # self
  end

  private

    def attr_validation
      valid?
    end
end
