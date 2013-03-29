require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should have_many(:user_friendships)
  should have_many(:friends)


  test "a user should enter a first name" do
  	user = User.new
  	assert !user.save
  	assert !user.errors[:first_name].empty?
  end

  test "a user should enter a last name" do
  	user = User.new
  	assert !user.save
  	assert !user.errors[:last_name].empty?
  end
  	
  test "a user should enter a profile name" do
  	user = User.new
  	assert !user.save
  	assert !user.errors[:profile_name].empty? 	 	 	
  end

  test "a user should have a unique profile name" do
   	user = User.new
   	user.first_name = users(:ning).first_name
   	user.last_name = users(:ning).last_name
   	user.email = users(:ning).email
   	user.profile_name = users(:ning).profile_name
   	assert !user.save
   	assert !user.errors[:profile_name].empty?
  end

  test "a user should have a profile name without spaces" do
    user = User.new(first_name: 'Ningg', last_name: 'Yapp', email: 'ningyap2@gmail.com')
    user.password = user.password_confirmation = 'asdfasdf'
   	user.profile_name = "My Profile with Spaces"
   	assert !user.save
   	assert !user.errors[:profile_name].empty?
   	assert user.errors[:profile_name].include?("must be formatted correctly.")
  end

  test "a user can have a correctly formatted profile name" do
    user = User.new(first_name: 'Ningg', last_name: 'Yapp', email: 'ningyap2@gmail.com')
    user.password = user.password_confirmation = 'asdfasdf'
    user.profile_name = 'orangeyap_1'
    assert user.valid?
  end

  test "that no error is raised when trying to access a friend list" do
    assert_nothing_raised do
      users(:ning).friends
    end
  end

  test "that creating friendships on a user works" do
    users(:ning).friends << users(:jim)
    users(:ning).friends.reload
    assert users(:ning).friends.include?(users(:jim))
  end

end
