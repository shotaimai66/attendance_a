class AddDetailsToWork < ActiveRecord::Migration[5.1]
  def change
    add_column :works, :endtime_plan, :datetime
    add_column :works, :endtime_instruct, :datetime
    add_column :works, :work_content, :text
    add_column :works, :checker, :name
    add_column :works, :month_check, :name
  end
end
