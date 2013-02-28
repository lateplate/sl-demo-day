class CreateNags < ActiveRecord::Migration
  def change
    create_table :nags do |t|
      t.integer :user_id
      t.string :lendee_name
      t.string :lendee_uid
      t.string :item
      t.string :description
      t.date :due_date

      t.timestamps
    end
  end
end
