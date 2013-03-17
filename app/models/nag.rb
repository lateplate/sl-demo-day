class Nag < ActiveRecord::Base
  attr_accessible :description, :due_date, :item, :lendee_name, :lendee_uid, :user_id, :completed

  belongs_to :user

  validates_presence_of :lendee_name
  validates_presence_of :item
  validates_presence_of :due_date
  validates_presence_of :user_id

  scope :by_date, order('due_date asc')
  scope :outstanding, where(completed: false).by_date

  # def user
  # 	return User.where(uid: :user_id)
  # end
	def self.filter(type=nil)
		case type
			when nil then outstanding
			when 'outstanding' then outstanding
			when 'overdue' then where(["due_date <= ?", Time.now]).outstanding
			when 'soon' then where(["due_date >= ? AND due_date <= ?", Time.now, Time.now + 2.weeks]).outstanding
			when 'completed' then where(completed: true).by_date
		end
	end

  def send_fb_message(token, message)
  	   unless self.lendee_name.include?('@')
	      sender_chat_id = "-#{user_id}@chat.facebook.com"
	      receiver_chat_id = "-#{lendee_uid}@chat.facebook.com"
	      message_body = message
	      message_subject = "#{item}"

	      jabber_message = Jabber::Message.new(receiver_chat_id, message_body)
	      jabber_message.subject = message_subject

	      client = Jabber::Client.new(Jabber::JID.new(sender_chat_id))
	      client.connect
	      client.auth_sasl(Jabber::SASL::XFacebookPlatform.new(client,
          ENV["FACEBOOK_APP_ID"], token,
          ENV["FACEBOOK_SECRET_KEY"]), nil)
	      client.send(jabber_message)
	      client.close
    	end
      self.sent = true
      self.save!
  end

end
