require 'spec_helper'

describe Relationship do

  before(:each) do
   @follower = Factory(:user)
   @followed = Factory(:user, :email => Factory.next(:email))
   
   @relationship = @follower.relationships.build(:followed_id => @followed.id)
 end

   it "should create a new instance given valid attributes" do

   @relationship.save!
  end

 describe "follow methods" do

  before(:each) do
  @relationship.save
 end
 
  it "should have a follower attribute" do
  @relationship.should respond_to(:follower)
 end

 it "should have the right follower" do
 @relationship.follower.should == @follower
 end

 it "should have a followed attribute" do
 @relationship.should respond_to(:followed)
 end

 it "should have the right followed user" do
 @relationship.followed.should == @followed

end

it "should destroy associated relationships" do

@relationship.save

Relationship.find_by_id(@relationship.id) == @relationship.id

@relationship.destroy

Relationship.find_by_id(@relationship.id).should be_nil
end
end

describe "validations" do

 it "should require a follower_id" do
 @relationship.follower_id = nil
 @relationship.should_not be_valid
end

 it "should require a followed_id" do
 @relationship.followed_id = nil
 @relationship.should_not be_valid

end 
end
end
# == Schema Information
#
# Table name: relationships
#
#  id          :integer         not null, primary key
#  follower_id :integer
#  followed_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

