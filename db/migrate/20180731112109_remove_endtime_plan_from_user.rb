class RemoveEndtimePlanFromUser < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :endtime_plan, :time
  end
  def change
    remove_column :users, :work_content, :text
  end
  def change
    remove_column :users, :checker, :name
  end
end
