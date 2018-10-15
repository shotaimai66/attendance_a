class CreateAdmins < ActiveRecord::Migration[5.1]
  def change
    create_table :admins do |t|
      t.string :name
      t.string :email
      t.string :password
      t.datetime :basic_work_time
      t.string :password_confirmation
      t.string :remember_digest

      t.timestamps
    end
  end
end
