class AddConnectionStatusToMembers < ActiveRecord::Migration[6.0]
  def change
    add_column :members, :connection_status, :string
  end
end
