class AddCompletedToNags < ActiveRecord::Migration
  def change
    add_column :nags, :completed, :boolean, default: false
  end
end
