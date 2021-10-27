class AddEmailCiphertextToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :email_ciphertext, :text, null: false
    add_column :users, :email_bidx, :string, null: false
    add_index :users, :email_bidx, unique: true

    remove_index :users, :email
    remove_column :users, :email, :string
  end
end
