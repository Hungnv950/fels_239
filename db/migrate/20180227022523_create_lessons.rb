class CreateLessons < ActiveRecord::Migration[5.1]
  def change
    create_table :lessons do |t|
      t.references :user, foreign_key: true
      t.references :category_id, foreign_key: true
      t.boolean :is_finished

      t.timestamps
    end
  end
end
