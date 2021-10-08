require 'csv'

csv_data = CSV.read('db/seeds/standards_tables_of_food_composition.csv', headers: true)
csv_data.each do |data|
  Food.create!(data.to_hash)
end
