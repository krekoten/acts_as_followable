require 'spec_helper'

module ActsAsFollowable
  
  describe 'model' do
    it 'should be followable' do
      @user1.should be_followable
    end
  end
  
  describe 'user' do
    it 'should not be able to follow unfollowable model' do
      lambda {@user1.follow @unfollowable}.should raise_exception(ActsAsFollowable::UnfollowableObjectError)
    end
  end

  describe 'when created' do
    describe 'user' do
      it 'should have 0 follows' do
        @user1.should have(0).follows
      end
      
      it 'should have 0 followers' do
        @user1.should have(0).followers
      end
    end
  end
  
  describe 'when user1 follows user2' do
    before :all do
      @user1.follow @user2
    end
    
    it 'user1 should have 1 followings' do
      @user1.should have(1).follows
    end
    
    it 'user2 should have 1 follwer' do
      @user2.should have(1).followers
    end
    
    it 'should not be able to unfollow user it is not following' do
      lambda {@user1.unfollow @user3}.should raise_exception(ActiveRecord::RecordNotFound)
    end
    
    describe 'when user1 unfollows user2' do
      before :all do
        @user1.unfollow @user2
      end

      it 'user1 should have 0 followings' do
        @user1.should have(0).follows
      end

      it 'user2 should have 0 followers' do
        @user2.should have(0).followers
      end
    end
  end
end