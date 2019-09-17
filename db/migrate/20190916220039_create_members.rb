class CreateMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :members do |t|
      t.string :guid
      t.string :user_guid
      t.string :institution_code

      t.timestamps
    end
  end
end
