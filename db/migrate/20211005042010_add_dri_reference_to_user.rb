class AddDriReferenceToUser < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :dietary_reference_intake, foreign_key: true, null: false, default: 0
  end
end
