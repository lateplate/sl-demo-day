class AddNotifiedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :notified, :boolean, default: false
  end
end
