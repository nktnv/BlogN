class RemoveNameFromImages < ActiveRecord::Migration[5.1]
  def change
    remove_column :images, :name, :string
  end
end
