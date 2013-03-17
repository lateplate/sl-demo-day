desc "send nags for all items which are overdue and have a valid token."
task :check_and_send_nags => :environment do
	nags = Nag.where(["due_date <= ?", Time.now]).where(sent: false, completed: false)
	nags_with_bad_tokens = 0
	messages_sent = 0
	nags.each do |nag|
		message = "Hi #{nag.lendee_name.split(" ").first}!\n\nI'm using a new app called Nag to keep track of things I've loaned out. Any chance you could get me this stuff back?\n\n* #{nag.item}\n\nAs a thank you, I'm sending you this awesome video of Maru the Cat. You can bet there's more where that came from.\n\nhttp://www.youtube.com/watch?v=8uDuls5TyNE\n\nYou're the best,\n\n #{nag.user.name.split(" ").first}"
		if nag.user.has_valid_token?
			nag.send_fb_message(nag.user.oauth_token, message)
			messages_sent += 1
		else
			# Would like to get an App access token to send these from another facebook account. TODO
			#nag.send_fb_message(token , message)
			nags_with_bad_tokens += 1
		end
	end
	# Would like to log this information somewhere on Heroku TODO
	# puts "==========================================================="
	# puts "Sent #{messages_sent} message/s. Also, tried to send #{nags_with_bad_tokens} nag/s that did not send due to expired tokens."
	# puts "==========================================================="
end