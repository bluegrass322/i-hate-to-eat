# frozen_string_literal: true

Dir.glob(Rails.root.join('db/seeds/*.rb')).each do |file|
  desc "db/seeds/#{File.basename(file)}を実行"
  task "db:seed:#{File.basename(file).gsub(/\.rb/, '')}": :environment do
    load(file)
  end
end
