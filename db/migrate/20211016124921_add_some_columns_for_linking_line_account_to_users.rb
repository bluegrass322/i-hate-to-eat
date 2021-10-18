class AddSomeColumnsForLinkingLineAccountToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :line_nonce, :string
    add_column :users, :line_user_id_ciphertext, :text
    add_column :users, :line_user_id_bidx, :string

    add_index :users, :line_user_id_bidx, unique: true
  end
end
