#inspect all work claims
=begin
WorkClaim.find(:all).each do |claim|

puts claim.web_id

end
=end

#Go through all claims and set web_id equal to user_id, THIS SHOULD BE UNCOMMENTED

WorkClaim.find(:all).each do |claim|

	if claim.user_id != nil && claim.web_id == nil
		claim.web_id = claim.user_id
		claim.save
	end

end



#set all claims web_id = nil (USE WITH EXTREME CAUTION)

=begin
WorkClaim.find(:all).each do |claim|

claim.web_id = nil
puts claim.id
claim.save

end
=end
