class Nag < ActiveRecord::Base
  attr_accessible :description, :due_date, :item, :lendee_name, :lendee_uid, :user_id

  belongs_to :user

  # def user
  # 	return User.where(uid: :user_id)
  # end

  def send_fb_message(token)
  	   unless sent?
	      sender_chat_id = "-#{user_id}@chat.facebook.com"
	      receiver_chat_id = "-#{lendee_uid}@chat.facebook.com"
	      message_body = "What's up #{lendee_name}? \n We're The Nag Team. We're here to Nag you. #{user.name} thinks you owe them their #{item}. Please return it as soon as possible. kthxbai :)"
	      message_subject = "#{item}"

	      jabber_message = Jabber::Message.new(receiver_chat_id, message_body)
	      jabber_message.subject = message_subject

	      client = Jabber::Client.new(Jabber::JID.new(sender_chat_id))
	      client.connect
	      client.auth_sasl(Jabber::SASL::XFacebookPlatform.new(client,
	         '521194684598530', token,
	         'a58fbed7c39dc194038dab093c81e7ae'), nil)
	      client.send(jabber_message)
	      client.close
    	end
      sent = true
      save
  end
end
