class CreateWorks < ActiveRecord::Migration[5.1]
  def change
    create_table :works do |t|
      t.timestamp :start
      t.timestamp :end
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :works, [:user_id, :created_at]
  end
end
