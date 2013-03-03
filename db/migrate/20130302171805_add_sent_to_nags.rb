class AddSentToNags < ActiveRecord::Migration
  def change
    add_column :nags, :sent, :boolean, default: false
  end
end
