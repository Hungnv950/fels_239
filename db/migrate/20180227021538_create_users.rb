class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email, limit: 80
      t.string :name, limit: 20
      t.string :avatar
      t.string :adress, limit: 120
      t.boolean :is_admin, default: false
      t.string :password_digest, limit: 120
      t.string :remember_digest, limit: 120
      t.string :activation_digest, limit: 120
      t.boolean :activated, defalut: false
      t.datetime :activated_at
      t.string :reset_digest, limit: 120
      t.datetime :reset_sent_at
      t.timestamps
    end
  end
end
