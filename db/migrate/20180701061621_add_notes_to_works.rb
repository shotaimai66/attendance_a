class AddNotesToWorks < ActiveRecord::Migration[5.1]
  def change
    add_column :works, :note, :text
  end
end
