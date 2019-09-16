class AddGuidToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :guid, :string
  end
end
