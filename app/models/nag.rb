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
			when nil
				return outstanding
			when 'outstanding'
				return outstanding
			when 'overdue'
				return where(["due_date <= ?", Time.now]).outstanding
			when 'soon'
				return where(["due_date >= ? AND due_date <= ?", Time.now, Time.now + 2.weeks]).outstanding
			when 'completed'
				return where(completed: true).by_date
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
	         # '521194684598530', token,
	         # 'a58fbed7c39dc194038dab093c81e7ae'), nil)
          
          # dan localhost settings
          # '436592866423465', token,
          #  'd8e0bf02966a46740a7674d947d3d8e7'), nil)

          #heroku settings
          '224676817673489', token,
           'dee566d81462e87246a361ef7be382a3'), nil)
	      client.send(jabber_message)
	      client.close
    	end
      self.sent = true
      self.save!
  end

end
