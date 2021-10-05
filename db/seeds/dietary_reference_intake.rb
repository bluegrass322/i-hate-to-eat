require 'csv'

csv_data = CSV.read('db/seeds/extracted_dietary_reference_intake_with_header.csv', headers: true)
csv_data.each do |data|
  DietaryReferenceIntake.create!(data.to_hash)
end