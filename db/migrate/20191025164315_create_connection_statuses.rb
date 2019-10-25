class CreateConnectionStatuses < ActiveRecord::Migration[6.0]
  def change
    create_table :connection_statuses do |t|
      t.string :name
      t.string :message

      t.timestamps
    end
  end
end
