class AddDetailsToWork < ActiveRecord::Migration[5.1]
  def change
    add_column :works, :endtime_plan, :datetime
    add_column :works, :starttime_change, :datetime
    add_column :works, :endtime_change, :datetime
    add_column :works, :work_content, :text
    add_column :works, :over_check, :name
    add_column :works, :month_check, :name
    add_column :works, :work_check, :name
  end
end
