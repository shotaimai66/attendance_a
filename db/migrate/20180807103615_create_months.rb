class CreateMonths < ActiveRecord::Migration[5.1]
  def change
    create_table :months do |t|
      t.date :month
      t.string :checker
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
