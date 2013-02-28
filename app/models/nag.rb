class Nag < ActiveRecord::Base
  attr_accessible :description, :due_date, :item, :lendee_name, :lendee_uid, :user_id

  belongs_to :user
end
