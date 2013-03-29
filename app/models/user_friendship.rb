class UserFriendship < ActiveRecord::Base
	belongs_to :user
	# use 'class_name' to specify that :friend belongs to a :user and the key will be 'friend_id'
	belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'

	attr_accessible :user, :friend, :user_id, :friend_id

end
