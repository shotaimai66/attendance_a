class AddDetailsToWork < ActiveRecord::Migration[5.1]
  def change
    add_column :works, :endtime_plan, :time
    add_column :works, :work_content, :text
    add_column :works, :checker, :name
  end
end
