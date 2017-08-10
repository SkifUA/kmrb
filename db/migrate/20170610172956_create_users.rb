class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.string :remember_digest
      t.string :activation_digest
      t.string :reset_digest
      t.boolean :activated, default: false
      t.datetime :activated_at
      t.datetime :reset_sent_at
      t.timestamps
      t.index ["email"], name: "index_users_on_email", unique: true
    end
  end
end
