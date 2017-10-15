class RemoveDetailsFromComments < ActiveRecord::Migration[5.1]

  def change
    remove_column :comments, :commenter, :string
    remove_reference :comments, :post, foreign_key: true
  end

end
