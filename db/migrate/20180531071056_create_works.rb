class CreateWorks < ActiveRecord::Migration[5.1]
  def change
    create_table :works do |t|
      t.date :day
      t.time :start_time
      t.time :end_time
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
