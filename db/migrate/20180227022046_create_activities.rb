class CreateActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :activities do |t|
      t.references :user, foreign_key: true
      t.integer :target_id
      t.string :action_type
      t.string :integer

      t.timestamps
    end
  end
end
