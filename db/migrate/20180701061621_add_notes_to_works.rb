class AddNotesToWorks < ActiveRecord::Migration[5.1]
  def change
    add_column :works, :note, :text
    add_column :works, :check_box, :boolean
  end
end
